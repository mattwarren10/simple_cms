class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirmed_logged_in
  before_action :find_pages, :only => [:new, :create, :edit, :update]
  before_action :find_section, :except => [:index, :new, :create]
  
  def index
    @sections = Section.sorted
  end

  def show
    
  end

  def new
    @section = Section.new()
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def edit    
    @section_count = Section.count
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section successfully created."
      redirect_to section_path(@section)
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render :new
    end
  end

  def update
    if @section.update_attributes(section_params)
      flash[:notice] = "Section successfully updated."
      redirect_to section_path(@section)
    else
      @section_count = Section.count
      @pages = Page.sorted
      render :edit
    end
  end

  def delete
    
  end

  def destroy    
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' successfully deleted."
    redirect_to(sections_path)
  end

  private
  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content, :content_type)
  end

  def find_pages
    @page = Page.sorted
  end

  def find_section
    @section = Section.find(params[:id])
  end

end
