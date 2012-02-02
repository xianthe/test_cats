require 'new_relic/agent/method_tracer'
class CatsController < ApplicationController
  include NewRelic::Agent::MethodTracer

  # GET /cats
  # GET /cats.json
  def index
    @cats = Cat.all

    stat = NewRelic::Agent.agent.stats_engine.get_stats_no_scope('Custom/cat/newmetric')
    stat.record_data_point(333.4)
    stat.record_data_point(32.3)
    stat.record_data_point(2225.0)
    stat.record_data_point(34.0)
    stat.record_data_point(900.3)
    sleep 5
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cats }
    end
  end

  # GET /cats/1
  # GET /cats/1.json
  def show
    @cat = Cat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cat }
    end
  end

  # GET /cats/new
  # GET /cats/new.json
  def new
    @cat = Cat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cat }
    end
  end

  # GET /cats/1/edit
  def edit
    @cat = Cat.find(params[:id])
  end

  # POST /cats
  # POST /cats.json
  def create
    @cat = Cat.new(params[:cat])

    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: 'Cat was successfully created.' }
        format.json { render json: @cat, status: :created, location: @cat }
      else
        format.html { render action: "new" }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cats/1
  # PUT /cats/1.json
  def update
    @cat = Cat.find(params[:id])

    respond_to do |format|
      if @cat.update_attributes(params[:cat])
        format.html { redirect_to @cat, notice: 'Cat was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cats/1
  # DELETE /cats/1.json
  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to cats_url }
      format.json { head :ok }
    end
  end

  add_method_tracer :index, 'Custom/cats/index'
end
