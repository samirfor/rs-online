class HistoriesController < ApplicationController
  
  layout 'default'

  # GET /histories
  # GET /histories.xml
  def index
    #@histories = History.all
    @histories = History.find( :all, :limit => 100, :order => "id DESC" )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @histories }
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.xml
  def destroy
    @history = History.find(params[:id])
    @history.destroy

    respond_to do |format|
      format.html { redirect_to(histories_url) }
      format.xml  { head :ok }
    end
  end
end
