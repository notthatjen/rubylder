# frozen_string_literal: true

class Components::Buttons::Button < Components::Base
  def view_template(&)
    button **attrs, &
  end
end
