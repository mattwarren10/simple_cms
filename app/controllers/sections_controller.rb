class SectionsController < ApplicationController
  def index
    @section = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new()
  end

  def edit
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section successfully created."
      redirect_to section_path(@section)
    else
      render :edit
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section = Section.update_attributes(section_params)
      flash[:notice] = "Section successfully updated."
      redirect_to section_path(@section)
    else
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
