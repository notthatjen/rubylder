# frozen_string_literal: true

# TODO: Finish this
class Components::Example::Sidebar < Components::Base
  def view_template(&)
    div class: "grid gap-8" do
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Sidebar with Sections" }
        render Default::Sidebar.new(class: "w-[250px] h-[600px] border rounded-lg") do |sidebar|
          # Header Content
          sidebar.header do
            div(class: "flex items-center gap-2") do
              div(class: "size-8 rounded-lg bg-zinc-200")
              h3(class: "font-semibold") { "Dashboard" }
            end
          end

          sidebar.content do
            # Navigation Content (automatically goes in the scrollable area)
            sidebar.nav_item(href: "#", icon: "home", active: true) { "Home" }
            sidebar.nav_item(href: "#", icon: "users") { "Users" }

            sidebar.nav_group(title: "Settings", icon: "folder") do
              sidebar.nav_item(href: "#") { "General" }
              sidebar.nav_item(href: "#") { "Security" }
              sidebar.nav_item(href: "#") { "Notifications" }
            end
          end

          sidebar.footer do
            footer_content
          end
        end
      end
    end
  end

  # Override the footer content
  def footer_content
    div(class: "flex items-center gap-3 px-3") do
      div(class: "size-8 rounded-full bg-zinc-200")
      div(class: "flex flex-col") do
        span(class: "text-sm font-medium") { "John Doe" }
        span(class: "text-xs text-zinc-500") { "john@example.com" }
      end
    end
  end
end
