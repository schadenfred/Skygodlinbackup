module ApplicationHelper

  def title
    base_title = "Skygodlin"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title} "
    end
  end

  def logo
    logo = image_tag("logo.png", :alt => "Skygodlin", :class => "round")
  end

end

