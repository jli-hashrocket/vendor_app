class VendorsController < ApplicationController
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
    @vendor = Vendor.create(vendor_params)
    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vendor }
      else
        render action: 'new'
      end
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
     @vendor = Vender.find(params[:id])
     if @vendor.update(vendor_params)
        format.html { redirect_to @vendor, notice: 'Vendor was saved successfully' }
        format.json { render action: 'show', status: :created, location: @vendor }
      else
        render action: 'edit'
      end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    if @vendor.destroy
      redirect_to vendors_url, notice: 'Vendor was successfully deleted'
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
    redirect_to vendors_url, notice: 'Your Quickbooks account has been linked.'
  end

  private
    def vendor_params
      params.require(:vendor).permit(:name)
    end
end
