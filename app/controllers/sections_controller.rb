class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirmed_logged_in
  before_action :find_page
  before_action :find_section, :except => [:index, :new, :create]
  
  def index
    @sections = @page.sections.sorted
  end

  def show
    
  end

  def new
    @section = Section.new(:page_id => @page.id)
    @section_count = Section.count + 1
  end

  def edit    
    @section_count = Section.count
  end

  def create
    @section = Section.new(section_params)
    @section.page = @page
    if @section.save
      flash[:notice] = "Section successfully created."
      redirect_to section_path(:page_id => @page.id)
    else
      @section_count = Section.count + 1

      render :new
    end
  end

  def update
    if @section.update_attributes(section_params)
      flash[:notice] = "Section successfully updated."
      redirect_to section_path(@section, :page_id => @page.id)
    else
      @section_count = Section.count

      render :edit
    end
  end

  def delete
    
  end

  def destroy    
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' successfully deleted."
    redirect_to(sections_path(:page_id => @page.id))
  end

  private
  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content, :content_type)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end
  

  def find_section
    @section = Section.find(params[:id])
  end

end
