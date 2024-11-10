# frozen_string_literal: true

class Components::Default::DropdownMenu < Components::Base
  props default_open: false,
        disabled: false,
        modal: true,
        dir: "ltr",
        on_open_change: nil

  attr_accessor :trigger_id, :content_id

  def view_template(&)
    generate_ids
    default_attrs = {
      class: "relative inline-block",
      data: {
        dropdown_menu: true,
        state: props.default_open ? "open" : "closed",
        dir: props.dir
      }
    }

    div(**mix(default_attrs, attrs), &)
  end

  def trigger(**attrs, &)
    default_attrs = {
      id: trigger_id,
      class: "inline-flex items-center justify-between rounded px-3 py-2 gap-2 bg-white border shadow-sm hover:bg-zinc-50 data-[state=open]:bg-zinc-50 data-[disabled]:opacity-50 data-[disabled]:cursor-not-allowed focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-zinc-950 focus-visible:ring-offset-2",
      data: {
        dropdown_menu_trigger: true,
        state: props.default_open ? "open" : "closed",
        disabled: props.disabled
      },
      disabled: props.disabled,
      "aria-controls": content_id,
      "aria-expanded": props.default_open,
      "aria-haspopup": "menu"
    }

    button(**mix(default_attrs, attrs), &)
  end

  def portal(**attrs, &)
    div(**attrs, &)
  end

  def content(**attrs, &)
    wrapper_attrs = {
      class: "fixed z-[100] data-[state=closed]:hidden data-[state=open]:block animate-slideDownAndFade",
      data: {
        dropdown_menu_content: true,
        state: props.default_open ? "open" : "closed"
      },
      id: content_id,
      "aria-labelledby": trigger_id,
      role: "menu"
    }

    div(**mix(wrapper_attrs, attrs)) do
      div(class: "relative w-[220px] rounded-md bg-white p-1 shadow-lg border") do
        render Default::ScrollArea.new(class: "max-h-[var(--radix-dropdown-menu-content-available-height)]") do
          div(class: "py-1", &)
        end
      end
    end
  end

  def group(**attrs, &)
    div(role: "group", **attrs, &)
  end

  def item(**attrs, &)
    default_attrs = {
      class: "relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors hover:bg-zinc-100 data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      role: "menuitem",
      tabindex: -1,
      data: {
        dropdown_menu_item: true
      }
    }

    div(**mix(default_attrs, attrs), &)
  end

  def checkbox_item(checked: false, **attrs, &)
    default_attrs = {
      class: "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors hover:bg-zinc-100 data-[disabled]:pointer-events-none data-[disabled]:opacity-50 focus:bg-zinc-100",
      role: "menuitemcheckbox",
      "aria-checked": checked,
      tabindex: -1,
      data: {
        dropdown_menu_checkbox_item: true,
        state: checked ? "checked" : "unchecked"
      }
    }

    div(**mix(default_attrs, attrs)) do
      div(class: "absolute left-2 flex h-3.5 w-3.5 items-center justify-center") do
        div(class: "h-3.5 w-3.5 rounded border border-zinc-400 data-[state=checked]:bg-zinc-900 data-[state=checked]:border-zinc-900", data: { state: checked ? "checked" : "unchecked" }) do
          svg(class: "h-2.5 w-2.5 stroke-white data-[state=unchecked]:hidden", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "4", data: { state: checked ? "checked" : "unchecked" }) do |s|
            s.polyline points: "20 6 9 17 4 12"
          end
        end
      end
      yield
    end
  end

  def radio_group(**attrs, &)
    div(role: "group", **attrs, &)
  end

  def radio_item(checked: false, **attrs, &)
    default_attrs = {
      class: "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors hover:bg-zinc-100 data-[disabled]:pointer-events-none data-[disabled]:opacity-50 focus:bg-zinc-100",
      role: "menuitemradio",
      "aria-checked": checked,
      tabindex: -1,
      data: {
        dropdown_menu_radio_item: true,
        state: checked ? "checked" : "unchecked"
      }
    }

    div(**mix(default_attrs, attrs)) do
      div(class: "absolute left-2 flex h-3.5 w-3.5 items-center justify-center") do
        div(class: "h-3.5 w-3.5 rounded-full border border-zinc-400 data-[state=checked]:border-zinc-900", data: { state: checked ? "checked" : "unchecked" }) do
          div(class: "h-1.5 w-1.5 rounded-full bg-zinc-900 data-[state=unchecked]:hidden", data: { state: checked ? "checked" : "unchecked" })
        end
      end
      yield
    end
  end

  def separator(**attrs)
    default_attrs = {
      class: "my-1 h-px bg-zinc-200",
      role: "separator",
      "aria-orientation": "horizontal"
    }

    div(**mix(default_attrs, attrs))
  end

  def label(**attrs, &)
    default_attrs = {
      class: "px-2 py-1.5 text-sm font-semibold text-zinc-500",
      role: "presentation"
    }

    div(**mix(default_attrs, attrs), &)
  end

  def sub(&)
    div(data: { dropdown_menu_sub: true }, &)
  end

  def sub_trigger(**attrs, &)
    default_attrs = {
      id: generate_id("dropdown-menu-sub-trigger"),
      class: "flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-zinc-100 data-[state=open]:bg-zinc-100",
      data: {
        dropdown_menu_sub_trigger: true,
        dropdown_menu_item: true  # Add this to make it part of the keyboard navigation
      },
      tabindex: -1,  # Add this to make it focusable
      role: "menuitem",  # Add this for accessibility
      "aria-haspopup": "menu"  # Add this for accessibility
    }

    div(**mix(default_attrs, attrs), &)
  end

  def sub_content(**attrs, &)
    default_attrs = {
      class: "fixed z-[100] data-[state=closed]:hidden data-[state=open]:block animate-slideRightAndFade",
      data: {
        dropdown_menu_sub_content: true,
        state: "closed"
      },
      role: "menu"
    }

    div(**mix(default_attrs, attrs)) do
      div(class: "w-[220px] rounded-md bg-white p-1 shadow-lg border") do
        render Default::ScrollArea.new(class: "max-h-[var(--radix-dropdown-menu-content-available-height)]") do
          div(class: "py-1", &)
        end
      end
    end
  end

  private

  def generate_ids
    self.trigger_id = generate_id("dropdown-menu-trigger")
    self.content_id = generate_id("dropdown-menu-content")
  end

  # script is in dropdown_menu.js
end
