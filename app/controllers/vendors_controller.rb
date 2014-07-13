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

  private
    def vendor_params
      params.require(:vendor).permit(:name)
    end
end
