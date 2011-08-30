class JobsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => [:destroy]
  
  # GET /jobs
  # GET /jobs.xml
  
  def index
    @title = t :jobs_index_title
    
    @jobs = Job.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end
  
  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @title = t :new_job
    @job = Job.new
    @job.master_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @title = t :editing_job
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
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
  
  # PUT /jobs/1
  # PUT /jobs/1.xml
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
    redirect_to root_path
#    respond_to do |format|
#      format.html do
#        render :update do |page|
#          page.redirect_to :action => 'index'
#        end
#      end
#    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = t(:job_deleted)
    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
