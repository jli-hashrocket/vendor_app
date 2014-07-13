class VendorsController < ApplicationController
  before_action :set_qb_service, only: [:create, :edit, :update, :destroy]
  def index
    @vendors = Vendor.all
  end

  def new
    @vendor = Vendor.new
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def create
    @vendor = Vendor.new(vendor_params)
    vendor = Quickbooks::Model::Vendor.new
    vendor.given_name = vendor_params[:name]
    vendor.email_address = vendor_params[:email]
    @vendor_service.create(vendor)

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vendor }
      else
        format.html { render action: 'new' }
        format.json { render json: @vendor.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
     @vendor = Vender.find(params[:id])
     respond_to do |format|
       if @vendor.update(vendor_params)
          format.html { redirect_to @vendor, notice: "Vendor was saved successfully" }
          format.json { render action: 'show', status: :created, location: @vendor }
        else
          render action: 'edit'
        end
      end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    if @vendor.destroy
      redirect_to vendors_url, notice: "Vendor was successfully deleted"
    end
  end

  def authenticate
    callback = oauth_callback_vendors_url
    token = $qb_oauth_consumer.get_request_token(oauth_callback: callback)
    session[:qb_request_token] = token
    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  end

  def oauth_callback
    at = session[:qb_request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
    session[:token] = at.token
    session[:secret] = at.secret
    session[:realm_id] = params['realmId']
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Your Quickbooks account has been linked." }
    end
  end

  private
    def set_qb_service
      oauth_client = OAuth::AccessToken.new($qb_oauth_consumer, session[:token], session[:secret])
      @vendor_service = Quickbooks::Service::Vendor.new
      @vendor_service.access_token = oauth_client
      @vendor_service.company_id = session[:realm_id]
    end

    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit(:name, :email)
    end
end
