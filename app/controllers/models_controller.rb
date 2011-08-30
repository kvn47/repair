class ModelsController < ApplicationController
  before_filter :authenticate
  
  # GET /models
  # GET /models.xml
  def index
    @title = t :model_index_title
    
    @models = Model.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @models }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @title = t :new_model_title
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/1/edit
  def edit
    @title = t :editing_model
    @model = Model.find(params[:id])
  end

  # POST /models
  # POST /models.xml
  def create
    @model = Model.new(params[:model])

    respond_to do |format|
      if @model.save
        format.html { redirect_to(models_path, :notice => t(:model_created)) }
        format.xml  { render :xml => @model, :status => :created, :location => @model }
      else
        @title = t :new_model_title
        format.html { render :action => "new" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /models/1
  # PUT /models/1.xml
  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to(models_path, :notice => t(:model_updated)) }
        format.xml  { head :ok }
      else
        @title = t :editing_model
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    # if Job.find_by_model_id(params[:id])
    if Job.exists?(:model_id => params[:id])
      flash[:notice] = t(:model_used)
      redirect_to models_path
    else
      @model = Model.find(params[:id])
      @model.destroy
      flash[:notice] = t(:model_deleted)
      respond_to do |format|
        format.html { redirect_to(models_url) }
        format.xml  { head :ok }
      end
    end
  end
end
