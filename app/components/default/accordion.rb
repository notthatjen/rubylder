# frozen_string_literal: true

class Components::Default::Accordion < Components::Base
  def initialize(**attrs)
    super
    @ids = []
  end

  def view_template(&)
    default_attrs = { class: "relative" }
    accordion_id = generate_id("accordion")

    div(**mix(default_attrs, attrs), id: accordion_id, data: { accordion: true }, &)
  end

  def item(**attrs, &)
    item_id = generate_id("accordion-item")
    @ids << item_id
    div data: { accordion_item: true } do
      render Default::Collapsible.new(**attrs, id: item_id, change_callback: "accordionCallback") do |collapsible|
        yield(collapsible)
      end
    end
  end

  def self.script_template
    <<~JS
      function accordionCallback(event) {
        const target = event.target
        const itemContainer = target.closest("[data-accordion-item]")
        const accordionContainer = target.closest("[data-accordion]")
        // force close all other collapsible items
        accordionContainer.querySelectorAll("[data-accordion-item]").forEach(item => {
          if (item !== itemContainer) {
            const collapsibleContainer = item.querySelector("[data-collapsible]")
            controlCollapsible(collapsibleContainer, "close")
          }
        })
      }
    JS
  end
end
