# frozen_string_literal: true

class Components::Default::Collapsible < Components::Base
  props default_open: false,
        disabled: false,
        change_callback: nil,
        animate: true

  attr_accessor :button_id, :content_id

  def view_template(&)
    generate_ids
    default_attrs = { class: "", data: { collapsible: true, state: props.default_open ? "open" : "closed" } }
    div(**mix(default_attrs, attrs), &)
  end

  # anatomy trigger
  def trigger(**attrs, &)
    default_attrs = { class: "w-full", id: button_id, "aria-controls": content_id, "aria-expanded": props.default_open, data: { change_callback: props.change_callback, collapsible_trigger: true, state: props.default_open ? "open" : "closed" } }
    render Buttons::Button.new(**mix(default_attrs, attrs), &)
  end

  # anatomy content
  def content(**attrs, &)
    wrapper_attrs = {
      class: "overflow-hidden #{props.animate ? 'transition-[max-height] duration-100 ease-in' : ''}",
      data: {
        state: props.default_open ? "open" : "closed",
        collapsible_content_wrapper: true
      },
      style: props.default_open ? nil : "max-height: 0px;"
    }

    default_attrs = {
      id: content_id,
      "aria-labelledby": button_id,
      data: {
        collapsible_content: true,
        state: props.default_open ? "open" : "closed"
      }
    }

    div(**wrapper_attrs) do
      div(**mix(default_attrs, attrs), &)
    end
  end

  private
    def generate_ids
      self.button_id = generate_id("collapsible-button")
      self.content_id = generate_id("collapsible-content")
    end

  class << self
    def script_template
      <<-JS
        function controlCollapsible(container, action = 'open') {
          const trigger = container.querySelector('[data-collapsible-trigger]')
          const contentWrapper = container.querySelector('[data-collapsible-content-wrapper]')
          const content = container.querySelector('[data-collapsible-content]')

          container.setAttribute('data-state', action)
          trigger.setAttribute('aria-expanded', action === 'open')
          trigger.setAttribute('data-state', action)
          contentWrapper.setAttribute('data-state', action)
          content.setAttribute('data-state', action)

          if (action === 'open') {
            contentWrapper.style.maxHeight = `${content.scrollHeight}px`
          } else {
            contentWrapper.style.maxHeight = '0px'
          }
        }

        document.addEventListener('DOMContentLoaded', () => {
          const collapsibles = document.querySelectorAll('[data-collapsible]');
          collapsibles.forEach(collapsible => {
            const trigger = collapsible.querySelector('[data-collapsible-trigger]');

            trigger.addEventListener('click', (event) => {
              const action = trigger.dataset.state === 'open' ? 'close' : 'open'
              controlCollapsible(collapsible, action);

              if (trigger.dataset.changeCallback) {
                const callback = trigger.dataset.changeCallback
                eval(`${callback}(event)`)
              }
            });
          });
        });
      JS
    end
  end
end
