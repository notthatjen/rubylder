# frozen_string_literal: true

class Components::Buttons::Link < Components::Base
  def view_template(&)
    a **attrs do
      yield
    end
  end
end
