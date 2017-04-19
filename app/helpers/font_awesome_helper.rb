module FontAwesomeHelper

  def icon(name)
    "<i class='fa fa-#{name}'></i>".html_safe
  end

end
