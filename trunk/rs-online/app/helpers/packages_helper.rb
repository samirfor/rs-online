module PackagesHelper

  def format_megabytes size
    unless size == nil
      sprintf "%.2f MB", size/1024.0
    else
      "0 MB"
    end
  end

end
