module UserActivityHelper

  def action_to_s(action)
    case action
      when 0
        "Viewed Item"
      when 1
        "Favourited Item"
      when 2
        "Unfavourited Item"
      else
        "Unknown action"
    end
  end
end
