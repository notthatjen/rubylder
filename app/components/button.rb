# frozen_string_literal: true

class Components::Button < Components::Base
  def view_template(&)
    case variant
    when "Link"
      render Buttons::Link.new(**attrs, &)
    else
      render Buttons::Button.new(**attrs, &)
    end
  end
end
