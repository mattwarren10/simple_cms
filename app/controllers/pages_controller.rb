class PagesController < ApplicationController

  layout 'admin'

  before_action :find_subjects, :only => [:new, :create, :edit, :update]
  before_action :set_page_count, :only => [:new, :create, :edit, :update]
  
  def index
    @pages = Page.sorted
  end

  def create
    @page = Page.new(pages_params)
    if @page.save
      flash[:notice] = 'Page created successfully.'
      redirect_to(page_path(@page))
    else          
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
      render :edit
    end
  end

  def new
    @page = Page.new      
  end

  def edit
    @page = Page.find(params[:id])   
  end

  private

  def pages_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count 
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end
end
