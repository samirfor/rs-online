class AboutsController < ApplicationController

  layout 'default'

  # GET /abouts
  # GET /abouts.xml
  def index
    atilacamurca = About.new(
      "Átila Camurça Alves",
      "· Web developer<br/>
      · Linguagens preferidas: Java, Ruby<br/>
      · Frameworks preferidas: Grails, Rails (era de se esperar :-)<br/>
      · Trabalho na Fidias Software",
      "camurca_DOT_home_AT_gmail_DOT_com",
      "atilacamurca",
      "http://mad3linux.blogspot.com",
      "about/atilacamurca.png"
    )

    samirfor = About.new(
      "Samir Coutinho",
      "developer",
      "samirfor_AT_gmail_DOT_com",
      "samirfor",
      "http://www.samirfor.com/",
      "about/samirfor.png"
    )
    @abouts = []
    @abouts.push(atilacamurca, samirfor)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @abouts }
    end
  end
  
end
