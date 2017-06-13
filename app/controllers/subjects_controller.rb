class SubjectsController < ApplicationController
  
  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Test'} )
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the show action
      flash[:notice] = "Subject created sucessfully."
      redirect_to(subject_path(@subject))
    else
      # If save fails, redisplay the form so user can fix problem
      render :edit
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find a new object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject updated sucessfully."
      redirect_to(subject_path(@subject))
    else
      # If save fails, redisplay the form so user can fix problem
      render :edit
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed sucessfully."
    redirect_to(subjects_path)
  end

  private
   def subject_params
      params.require(:subject).permit(:name, :position, :visible)
   end
end