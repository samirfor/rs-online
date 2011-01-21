# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # encurta uma string. Ex.: ruby on rails is the best framework => ruby on rails i...amework
  def shorten(value, max_len=40, abbrev_len=15, chop_start_end=:start)
    return value if value.size <= max_len
    abbrev_len = 0 if abbrev_len < 0
    abbrev_len = (max_len - 3) if abbrev_len > (max_len - 3)
    chop_size = value.size - max_len
    case chop_start_end
    when :start
      chop_start_index = 0 + abbrev_len;
      chop_end_index = chop_size + 2 # 2 accounts for "..." as well as index access
    when :end
      chop_start_index = value.size - (abbrev_len + chop_size + 2)
      chop_end_index = value.size - abbrev_len
    end
    value[chop_start_index,chop_end_index]="..."
    value
  end

end
