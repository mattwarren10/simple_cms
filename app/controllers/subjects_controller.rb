class SubjectsController < ApplicationController

  layout 'admin'

  before_action :confirmed_logged_in
  before_action :find_subjects, :except => [:index, :new, :create]
  
  def index    
    @subjects = Subject.sorted    
  end

  def show    
  end

  def new
    @subject = Subject.new({:name => 'Test'} )
    @subject_count = Subject.count + 1
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
      @subject_count = Subject.count + 1
      render :new
    end
  end

  def edit    
    @subject_count = Subject.count
  end

  def update
    # Find a new object using form parameters    
    # Update the object
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject updated sucessfully."
      redirect_to(subject_path(@subject))
    else
      # If save fails, redisplay the form so user can fix problem
      @subject_count = Subject.count
      render :edit
    end
  end

  def delete   
    @subject = Subject.find(params[:id]) 
  end

  def destroy
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed sucessfully."
    redirect_to(subjects_path)
  end

  private
   def find_subjects
    @subject = Subject.find(params[:id])
   end

   def subject_params
      params.require(:subject).permit(:name, :position, :visible, :created_at)
   end
end
