# frozen_string_literal: true

class Components::Layouts::Application < Components::Base
  include Phlex::Rails::Layout

  def view_template(&)
    doctype

    html do
      head do
        title { "Your Application" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        csrf_meta_tags
        csp_meta_tag

        stylesheet_link_tag "application", "data-turbo-track": "reload"
        javascript_include_tag "application", "data-turbo-track": "reload", defer: true
      end

      body do
        yield
      end
    end
  end
end
