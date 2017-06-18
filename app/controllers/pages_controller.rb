class PagesController < ApplicationController

  layout 'admin'

  before_action :confirmed_logged_in
  before_action :find_subject
  before_action :find_page, :except => [:index, :new, :create]
  before_action :set_page_count, :only => [:new, :create, :edit, :update]
  
  def index
    @pages = @subject.pages.sorted
  end

  def create
    @page = Page.new(pages_params)
    @page.subject = @subject
    if @page.save
      flash[:notice] = 'Page created successfully.'
      redirect_to(pages_path(:subject_id => @subject.id))
    else          
      render :new
    end
  end

  def show
    
  end

  def delete

  end

  def destroy
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed successfully."
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  def update
    if @page.update_attributes(pages_params)
      flash[:notice] = 'Page updated successfully.'
      redirect_to(page_path(@page, :subject_id => @subject.id))
    else           
      render :edit
    end
  end

  def new
     @page = Page.new(:subject_id => @subject.id)
  end

  def edit

  end

  private

  def pages_params
    params.require(:page).permit(:name, :permalink, :position, :visible)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def find_page
    @page = Page.find(params[:id])
  end

  def set_page_count 
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end
end
