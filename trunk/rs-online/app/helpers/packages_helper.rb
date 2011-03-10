module PackagesHelper

  def format_megabytes(size)
    unless size == nil
      sprintf "%.2f MB", size/1024.0
    else
      "0 MB"
    end
  end

  def to_raw_links(links)
    a_links = []
    links.each do |link|
      a_links.push(link.url)
    end
    a_links.join("\n")
  end

  def format_timestamp time
    begin
      time.strftime("%Y/%m/%d %H:%M:%S")
    rescue Exception => e
      " --- "
    end
  end

  def format_interval date_ini, date_end
    begin
      time = Time.local(0) + (date_end - date_ini)
      time.strftime("%H:%M:%S")
    rescue Exception => e
      " --- "
    end
  end

  def status_ico status
    if status == "downloading"
      "links/#{status}.gif"
    else
      "links/#{status}.png"
    end
  end

  def completed? completed
    if completed
      "Yep."
    else
      "Nope."
    end
  end

end
