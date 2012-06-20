class JobsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, only: [:destroy]
  helper_method :sort_column, :sort_direction
  
  def index
    @title = t :jobs_index_title
    
    @jobs = Job.filter(params).order(sort_column + ' ' + sort_direction).page(params[:page]).per(params[:paginate_per])
    jobs_ids = (current_user.is_admin?) ? @jobs.collect{|j|j.id} : @jobs.where(master_id: current_user.id).collect{|j|j.id}
    @jobs_sum = Job.where(id: jobs_ids).sum(:price)
    @jobs_count = Job.where(id: jobs_ids).count
    @jobs_total_sum = (current_user.is_admin?) ? Job.sum(:price) : Job.where(master_id: current_user.id).sum(:price)
    @jobs_total_count = (current_user.is_admin?) ? Job.count : Job.where(master_id: current_user.id).count
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @jobs }
    end
  end
  
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  def new
    @title = t :new_job
    @job = Job.new
    @job.master_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  def edit
    @title = t :editing_job
    @job = Job.find(params[:id])
  end

  def create
    if params[:job] != nil
      if params[:job][:model_name] != ""
        params[:job][:model_id] = Model.create!(:name => params[:job][:model_name]).id
      end
    end
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to(root_path, :notice => t(:job_created)) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        @title = t :new_job
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @job = Job.find(params[:id])
    if params[:job][:model_name] != ""
      params[:job][:model_id] = Model.create!(:name => params[:job][:model_name]).id
    end

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to(root_path, :notice => t(:job_updated)) }
        format.xml  { head :ok }
      else
        @title = t :editing_job
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def save_statuses
    params.each do |param|
      if param[0][0..2] == 'jb_'
        jb_id = param[0][3..-1]
        jb_stat = param[1]
        @job = Job.find(jb_id)
        @job.update_attribute(:status, jb_stat)
      end
    end
#    redirect_to root_path
    respond_to do |format|
      format.html do
        render :update do |page|
          page.redirect_to :action => 'index'
        end
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = t(:job_deleted)
    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    
  def sort_column
    Job.column_names.include?(params[:sort]) ? params[:sort] : "income_date"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
end
