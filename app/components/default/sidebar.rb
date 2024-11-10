# frozen_string_literal: true

class Components::Default::Sidebar < Components::Base
  def view_template(&)
    default_attrs = {
      class: "flex h-full flex-col border-r bg-zinc-50",
      data: { sidebar: true }
    }

    aside(**mix(default_attrs, attrs), &)
  end

  def header(**attrs, &)
    div(class: "sticky top-0 z-10 bg-zinc-50 px-2 py-4", &)
  end

  def footer(**attrs, &)
    div(class: "sticky bottom-0 z-10 mt-auto border-t bg-zinc-50 px-2 py-4", &)
  end

  def content(**attrs, &)
    # TODO: add attrs and mix with default attributes
    div(class: "flex-1 overflow-auto px-2") do
      nav(class: "space-y-1", &)
    end
  end

  def nav_item(href:, active: false, icon: nil, &)
    link_class = "flex items-center gap-3 rounded-lg px-3 py-2 text-zinc-500 transition-all hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-100"
    link_class += " bg-zinc-100 text-zinc-900" if active

    a(href: href, class: link_class) do
      icon if icon
      span(class: "text-sm font-medium", &)
    end
  end

  def nav_group(title:, icon: nil, &)
    render Default::Collapsible.new(class: "w-full", animate: false) do |collapsible|
      collapsible.trigger(class: "flex w-full items-center justify-between rounded-lg px-3 py-2 text-zinc-500 hover:text-zinc-900") do
        div(class: "flex items-center gap-3") do
          icon if icon
          span(class: "text-sm font-medium") { title }
        end
        svg(class: "size-4 transition-transform duration-200", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
          s.polyline points: "6 9 12 15 18 9"
        end
      end

      collapsible.content(class: "px-3 pb-2") do
        div(class: "space-y-1 pl-6", &)
      end
    end
  end

  private

  def footer_content
    # Override this method in your view to customize the footer
    div(class: "text-sm text-zinc-500") { "Footer content" }
  end
end
