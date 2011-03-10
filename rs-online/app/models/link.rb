class Link < ActiveRecord::Base

  attr_accessor :interval

  # relationships
  belongs_to :package
  belongs_to :status

  def interval
    # TODO: retorna o intervalo entre os downloads
    begin
      time = Time.local(0) + (date_finished - date_started)
      time.strftime("%H:%M:%S")
    rescue Exception => e
      " --- "
    end
  end
  
end
