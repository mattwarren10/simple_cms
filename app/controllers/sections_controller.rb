class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirmed_logged_in
  
  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new()
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def edit
    @section = Section.find(params[:id])
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
    @section = Section.find(params[:id])
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
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' successfully deleted."
    redirect_to(sections_path)
  end

  private
  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content)
  end

end
