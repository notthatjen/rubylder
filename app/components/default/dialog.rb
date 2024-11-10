# frozen_string_literal: true

class Components::Default::Dialog < Components::Base
  props open: false,
        default_open: false,
        on_open_change: nil,
        modal: true

  attr_accessor :trigger_id, :content_id, :title_id, :description_id

  def view_template(&)
    generate_ids
    default_attrs = {
      data: {
        dialog: true,
        state: props.default_open ? "open" : "closed"
      }
    }

    div(**mix(default_attrs, attrs), &)
  end

  def trigger(**attrs, &)
    default_attrs = {
      id: trigger_id,
      class: "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50",
      data: {
        dialog_trigger: true,
        state: props.default_open ? "open" : "closed"
      },
      "aria-haspopup": "dialog",
      "aria-expanded": props.default_open,
      "aria-controls": content_id
    }

    button(**mix(default_attrs, attrs), &)
  end

  def content(**attrs, &)
    wrapper_attrs = {
      class: "fixed inset-0 z-50 bg-black/50 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 hidden data-[state=open]:block",
      data: {
        dialog_overlay: true,
        state: props.default_open ? "open" : "closed"
      },
      "aria-hidden": true
    }

    content_attrs = {
      id: content_id,
      class: "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-white p-6 shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg hidden data-[state=open]:block",
      role: "dialog",
      "aria-modal": props.modal,
      "aria-labelledby": title_id,
      "aria-describedby": description_id,
      data: {
        dialog_content: true,
        state: props.default_open ? "open" : "closed"
      }
    }

    div(**wrapper_attrs) do
      div(**mix(content_attrs, attrs), &)
    end
  end

  def title(**attrs, &)
    default_attrs = {
      id: title_id,
      class: "text-lg font-semibold",
      data: { dialog_title: true }
    }

    h2(**mix(default_attrs, attrs), &)
  end

  def description(**attrs, &)
    default_attrs = {
      id: description_id,
      class: "text-sm text-zinc-500",
      data: { dialog_description: true }
    }

    p(**mix(default_attrs, attrs), &)
  end

  def close(**attrs, &)
    default_attrs = {
      class: "absolute right-4 top-4 rounded-sm opacity-70 ring-offset-white transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-zinc-400 focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-zinc-100 data-[state=open]:text-zinc-500",
      data: { dialog_close: true }
    }

    button(**mix(default_attrs, attrs), &)
  end

  private

  def generate_ids
    self.trigger_id = generate_id("dialog-trigger")
    self.content_id = generate_id("dialog-content")
    self.title_id = generate_id("dialog-title")
    self.description_id = generate_id("dialog-description")
  end

  def self.script_template
    <<~JS
      document.addEventListener('DOMContentLoaded', () => {
        const initDialog = (dialog) => {
          const trigger = dialog.querySelector('[data-dialog-trigger]')
          const overlay = dialog.querySelector('[data-dialog-overlay]')
          const content = dialog.querySelector('[data-dialog-content]')
          const closeButtons = dialog.querySelectorAll('[data-dialog-close]')

          const openDialog = () => {
            dialog.dataset.state = 'open'
            trigger.dataset.state = 'open'
            overlay.dataset.state = 'open'
            content.dataset.state = 'open'
            trigger.setAttribute('aria-expanded', 'true')
            document.body.style.overflow = 'hidden'
          }

          const closeDialog = () => {
            dialog.dataset.state = 'closed'
            trigger.dataset.state = 'closed'
            overlay.dataset.state = 'closed'
            content.dataset.state = 'closed'
            trigger.setAttribute('aria-expanded', 'false')
            document.body.style.overflow = ''
          }

          trigger.addEventListener('click', () => {
            const isOpen = dialog.dataset.state === 'open'
            if (isOpen) {
              closeDialog()
            } else {
              openDialog()
            }
          })

          closeButtons.forEach(button => {
            button.addEventListener('click', () => {
              closeDialog()
            })
          })

          overlay.addEventListener('click', (event) => {
            if (event.target === overlay) {
              closeDialog()
            }
          })

          document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && dialog.dataset.state === 'open') {
              closeDialog()
            }
          })
        }

        const dialogs = document.querySelectorAll('[data-dialog]')
        dialogs.forEach(initDialog)
      })
    JS
  end
end
