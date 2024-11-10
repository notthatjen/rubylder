# frozen_string_literal: true

class Components::Example::DropdownMenu < Components::Base
  def view_template
    div class: "p-8 grid gap-8" do
      # Basic Dropdown Example
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Basic Dropdown" }
        render Default::DropdownMenu.new do |menu|
          menu.trigger(class: "text-sm px-4 py-2 bg-zinc-900 text-white hover:bg-zinc-800 focus-visible:ring-zinc-950 data-[state=open]:bg-zinc-800 rounded-md") do
            div(class: "flex items-center gap-2") do
              plain "Options"
              # Chevron down icon
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.polyline points: "6 9 12 15 18 9"
              end
            end
          end

          menu.content do
            menu.label { "My Account" }
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "Profile" }
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "Billing" }
            menu.item(data: { disabled: true }) { "Team (disabled)" }
            menu.separator
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "Settings" }
            menu.item(class: "text-red-500 focus:bg-zinc-100 focus:outline-none") { "Delete Account" }
          end
        end
      end

      # Checkbox Items Example
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Checkbox Items" }
        render Default::DropdownMenu.new do |menu|
          menu.trigger(class: "text-sm px-4 py-2 bg-white border shadow-sm hover:bg-zinc-50 data-[state=open]:bg-zinc-50 rounded-md") do
            div(class: "flex items-center gap-2") do
              plain "Preferences"
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.polyline points: "6 9 12 15 18 9"
              end
            end
          end

          menu.content do
            menu.label { "Appearance" }
            menu.checkbox_item(checked: true, class: "focus:bg-zinc-100 focus:outline-none") do
              div(class: "flex items-center gap-2") do
                plain "Show Full Names"
              end
            end
            menu.checkbox_item(class: "focus:bg-zinc-100 focus:outline-none") do
              div(class: "flex items-center gap-2") do
                plain "Show Status"
              end
            end
            menu.checkbox_item(class: "focus:bg-zinc-100 focus:outline-none") do
              div(class: "flex items-center gap-2") do
                plain "Show Avatars"
              end
            end
          end
        end
      end

      # Radio Group Example
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Radio Items" }
        render Default::DropdownMenu.new do |menu|
          menu.trigger(class: "text-sm px-4 py-2 bg-white border shadow-sm hover:bg-zinc-50 data-[state=open]:bg-zinc-50 rounded-md") do
            div(class: "flex items-center gap-2") do
              plain "Sort By"
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.polyline points: "6 9 12 15 18 9"
              end
            end
          end

          menu.content do
            menu.radio_group do
              menu.radio_item(checked: true, class: "focus:bg-zinc-100 focus:outline-none") do
                div(class: "flex items-center gap-2") do
                  plain "Name"
                end
              end
              menu.radio_item(class: "focus:bg-zinc-100 focus:outline-none") do
                div(class: "flex items-center gap-2") do
                  plain "Date Modified"
                end
              end
              menu.radio_item(class: "focus:bg-zinc-100 focus:outline-none") do
                div(class: "flex items-center gap-2") do
                  plain "Size"
                end
              end
            end
          end
        end
      end

      # Sub Menu Example
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Sub Menus" }
        render Default::DropdownMenu.new do |menu|
          menu.trigger(class: "text-sm px-4 py-2 bg-white border shadow-sm hover:bg-zinc-50 rounded-md") do
            "More Actions"
          end

          menu.content do
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "New File" }
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "Copy Link" }
            menu.separator

            menu.sub do
              menu.sub_trigger(class: "focus:bg-zinc-100 focus:outline-none") do
                div(class: "flex items-center justify-between w-full") do
                  plain "Share"
                  # Chevron right icon
                  svg(class: "size-4 ml-2", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                    s.polyline points: "9 6 15 12 9 18"
                  end
                end
              end

              menu.sub_content do
                menu.item(class: "focus:bg-zinc-100 focus:outline-none") do
                  div(class: "flex items-center gap-2") do
                    # Message icon
                    svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                      s.path d: "M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"
                    end
                    plain "Message"
                  end
                end
                menu.item(class: "focus:bg-zinc-100 focus:outline-none") do
                  div(class: "flex items-center gap-2") do
                    # Mail icon
                    svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewbox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                      s.path d: "M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"
                      s.polyline points: "22,6 12,13 2,6"
                    end
                    plain "Email"
                  end
                end
              end
            end

            menu.separator
            menu.item(class: "focus:bg-zinc-100 focus:outline-none") { "Move to Folder" }
            menu.item(class: "text-red-500 focus:bg-zinc-100 focus:outline-none") { "Delete" }
          end
        end
      end
    end
  end
end
