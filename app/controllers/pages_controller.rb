class PagesController < ApplicationController

  layout 'admin'
  
  def index
    @pages = Page.sorted
  end

  def create
    @page = Page.new(pages_params)
    if @page.save
      flash[:notice] = 'Page created successfully.'
      redirect_to(page_path(@page))
    else
      @page_count = Page.count + 1
      @subjects = Subject.sorted
      render :new
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed successfully."
    redirect_to(pages_path)
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(pages_params)
      flash[:notice] = 'Page updated successfully.'
      redirect_to(page_path(@page))
    else
      @page_count = Page.count
      @subjects = Subject.sorted
      render :edit
    end
  end

  def new
    @page = Page.new
    @page_count = Page.count + 1
    @subjects = Subject.sorted
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  private

  def pages_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end
end
