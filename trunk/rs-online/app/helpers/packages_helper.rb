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

end
