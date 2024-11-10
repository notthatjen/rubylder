# frozen_string_literal: true

class Components::Default::Select < Components::Base
  props placeholder: "Select an option...",
        default_value: nil,
        disabled: false

  attr_accessor :trigger_id, :content_id, :value_id

  def view_template(&)
    generate_ids
    default_attrs = {
      class: "relative inline-flex",
      data: {
        select: true,
        state: "closed"
      }
    }

    div(**mix(default_attrs, attrs)) do
      trigger
      content(&)
    end
  end

  def trigger(**attrs, &)
    default_attrs = {
      id: trigger_id,
      class: "inline-flex items-center justify-between rounded px-3 py-2 gap-2 bg-white border shadow-sm hover:bg-zinc-50 data-[state=open]:bg-zinc-50",
      data: {
        select_trigger: true,
        state: "closed"
      },
      "aria-controls": content_id,
      "aria-expanded": false
    }

    button(**mix(default_attrs, attrs)) do
      span(id: value_id,
           class: "text-sm",
           data: { select_value: true }) { props.placeholder }
      render_chevron
    end
  end

  def content(**attrs, &)
    wrapper_attrs = {
      class: "absolute w-full top-[110%] rounded-md bg-white p-1 shadow-lg border z-[100] data-[state=closed]:hidden data-[state=open]:block",
      data: {
        select_content: true,
        state: "closed"
      },
      id: content_id,
      "aria-labelledby": trigger_id
    }

    div(**mix(wrapper_attrs, attrs)) do
      render Default::ScrollArea.new(class: "max-h-[240px]") do
        div(class: "py-1 [&>*]:py-2", data: { select_items_container: true }, &)
      end
    end
  end

  def item(value:, **attrs, &)
    default_attrs = {
      class: "group relative flex items-center h-[40px] px-6 text-sm rounded hover:bg-zinc-100 cursor-pointer data-[state=selected]:bg-zinc-100",
      role: "option",
      data: {
        select_item: true,
        value: value,
        state: "unselected"
      }
    }

    div(**mix(default_attrs, attrs)) do
      # span(class: "absolute left-2 hidden group-data-[state=selected]:block", data: { select_item_indicator: true }) do
      #   render_check
      # end # This should be added by user
      yield
    end
  end

  private

  def generate_ids
    self.trigger_id = generate_id("select-trigger")
    self.content_id = generate_id("select-content")
    self.value_id = generate_id("select-value")
  end

  def render_chevron
    svg(class: "size-4 opacity-50", viewBox: "0 0 15 15", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.path(d: "M3.13523 6.15803C3.3241 5.95657 3.64052 5.94637 3.84197 6.13523L7.5 9.56464L11.158 6.13523C11.3595 5.94637 11.6759 5.95657 11.8648 6.15803C12.0536 6.35949 12.0434 6.67591 11.842 6.86477L7.84197 10.6148C7.64964 10.7951 7.35036 10.7951 7.15803 10.6148L3.15803 6.86477C2.95657 6.67591 2.94637 6.35949 3.13523 6.15803Z", fill: "currentColor")
    end
  end

  def render_check
    svg(class: "size-4", viewBox: "0 0 15 15", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.path(d: "M11.4669 3.72684C11.7558 3.91574 11.8369 4.30308 11.648 4.59198L7.39799 11.092C7.29783 11.2452 7.13556 11.3467 6.95402 11.3699C6.77247 11.3931 6.58989 11.3355 6.45446 11.2124L3.70446 8.71241C3.44905 8.48022 3.43023 8.08494 3.66242 7.82953C3.89461 7.57412 4.28989 7.55529 4.5453 7.78749L6.75292 9.79441L10.6018 3.90792C10.7907 3.61902 11.178 3.53795 11.4669 3.72684Z", fill: "currentColor")
    end
  end

  def self.script_template
    <<~JS
      document.addEventListener('DOMContentLoaded', () => {
        const initSelect = (select) => {
          const trigger = select.querySelector('[data-select-trigger]')
          const content = select.querySelector('[data-select-content]')
          const scrollArea = content.querySelector('[data-scroll-area]')
          const items = select.querySelectorAll('[data-select-item]')
          const valueDisplay = select.querySelector('[data-select-value]')

          const adjustHeight = () => {
            const itemsContainer = content.querySelector('[data-select-items-container]')
            const itemCount = items.length
            const firstItem = items[0]
            const itemHeight = firstItem ? firstItem.offsetHeight : 0
            const maxVisibleItems = 5
            const contentHeight = Math.min(itemCount * itemHeight, maxVisibleItems * itemHeight)
            scrollArea.style.height = contentHeight + 'px'
          }

          const close = () => {
            select.dataset.state = 'closed'
            trigger.dataset.state = 'closed'
            content.dataset.state = 'closed'
            trigger.setAttribute('aria-expanded', 'false')
          }

          const open = () => {
            select.dataset.state = 'open'
            trigger.dataset.state = 'open'
            content.dataset.state = 'open'
            trigger.setAttribute('aria-expanded', 'true')
            adjustHeight()
          }

          trigger.addEventListener('click', () => {
            const isOpen = select.dataset.state === 'open'
            if (isOpen) {
              close()
            } else {
              open()
            }
          })

          items.forEach(item => {
            item.addEventListener('click', () => {
              const value = item.dataset.value
              const text = item.textContent.trim()

              // Update selected state
              items.forEach(i => {
                i.dataset.state = i === item ? 'selected' : 'unselected'
              })

              // Update value display
              valueDisplay.textContent = text

              // Close dropdown
              close()
            })
          })

          // Close when clicking outside
          document.addEventListener('click', (event) => {
            if (!select.contains(event.target)) {
              close()
            }
          })
        }

        const selects = document.querySelectorAll('[data-select]')
        selects.forEach(initSelect)
      })
    JS
  end
end
