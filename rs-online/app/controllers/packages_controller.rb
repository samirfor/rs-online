class PackagesController < ApplicationController

  layout 'default'

  # GET /packages
  # GET /packages.xml
  def index
    @packages = Package.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @packages }
    end
  end

  # GET /packages/1
  # GET /packages/1.xml
  def show
    @package = Package.find(params[:id])
    @links = Link.find(:all, :conditions => ["package_id = ?", @package.id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @package }
    end
  end

  # GET /packages/new
  # GET /packages/new.xml
  def new
    @package = Package.new
    @priority = Priority.find(:all)
    #logger.debug @priority[0]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @package }
    end
  end

  # GET /packages/1/edit
  def edit
    @package = Package.find(params[:id], :joins => :priority)
    @priority = Priority.find(:all)
  end

  # POST /packages
  # POST /packages.xml
  def create
    @package = Package.new(params[:package])
    @package.show = true
    @package.completed = false
    @package.problem = false
    
    @package.priority = Priority.find(params[:package_priority].to_i)
    # logger.debug @package
    links = []
    @package.s_links.each { |linha| links.push linha.chomp }
    respond_to do |format|
      if @package.save
        # _TODO_: verificar se todos os links foram salvos corretamente, se não mostrar erro!
        links.each do |url|
          Link.create(:package => @package, :url => url)
        end
        flash[:notice] = 'Package was successfully created.'
        format.html { redirect_to(@package) }
        format.xml  { render :xml => @package, :status => :created, :location => @package }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /packages/1
  # PUT /packages/1.xml
  def update
    @package = Package.find(params[:id])

    respond_to do |format|
      if @package.update_attributes(params[:package])
        flash[:notice] = 'Package was successfully updated.'
        format.html { redirect_to(@package) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.xml
  def destroy
    @package = Package.find(params[:id])
    @package.destroy

    respond_to do |format|
      format.html { redirect_to(packages_url) }
      format.xml  { head :ok }
    end
  end

  # append link to a package
  def append_link
    url = params[:link]
    @link = Link.new()
    @link.url = url[:url]
    @link.package = Package.find(params[:package_id])
    @link.save()
    # renova a busca para atualizar lista de links.
    @links = Link.find(:all, :conditions => ["package_id = ?", params[:package_id]])

    flash[:notice] = "Link was successfully appended.<br/>" + url[:url]
    redirect_to :action => 'show', :id => params[:package_id]
  end
end
