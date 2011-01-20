class Link < ActiveRecord::Base

  attr_accessor :interval

  # relationships
  belongs_to :package
  belongs_to :status

  def interval
    # TODO: retorna o intervalo entre os downloads
    1
  end
end
