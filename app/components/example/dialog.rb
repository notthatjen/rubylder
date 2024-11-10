# frozen_string_literal: true

class Components::Example::Dialog < Components::Base
  def view_template
    div class: "p-8 grid gap-8" do
      # Basic Dialog Example
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Basic Dialog" }
        render Default::Dialog.new do |dialog|
          dialog.trigger(class: "px-4 py-2 bg-zinc-900 text-white hover:bg-zinc-700 rounded-md") do
            "Open Dialog"
          end

          dialog.content do
            # Close button in the top-right corner
            dialog.close(class: "absolute right-4 top-4 rounded-sm opacity-70 ring-offset-white transition-opacity hover:opacity-100") do
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
              end
            end

            dialog.title { "Are you absolutely sure?" }
            dialog.description { "This action cannot be undone. This will permanently delete your account and remove your data from our servers." }

            # Dialog Actions
            div(class: "mt-6 flex justify-end gap-4") do
              button(class: "px-4 py-2 bg-zinc-100 hover:bg-zinc-200 rounded-md", data: { dialog_close: true }) do
                "Cancel"
              end
              button(class: "px-4 py-2 bg-red-600 text-white hover:bg-red-700 rounded-md") do
                "Delete Account"
              end
            end
          end
        end
      end

      # Dialog with Form
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Dialog with Form" }
        render Default::Dialog.new do |dialog|
          dialog.trigger(class: "px-4 py-2 bg-zinc-900 text-white hover:bg-zinc-700 rounded-md") do
            "Edit Profile"
          end

          dialog.content(class: "sm:max-w-[425px]") do
            # Close button in the top-right corner
            dialog.close(class: "absolute right-4 top-4 rounded-sm opacity-70 ring-offset-white transition-opacity hover:opacity-100") do
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
              end
            end

            dialog.title { "Edit Profile" }
            dialog.description { "Make changes to your profile here. Click save when you're done." }

            # Form Fields
            div(class: "mt-6 grid gap-4 py-4") do
              div(class: "grid gap-2") do
                label(class: "text-sm font-medium", for: "name") { "Name" }
                input type: "text", id: "name", class: "w-full px-3 py-2 border rounded-md"
              end

              div(class: "grid gap-2") do
                label(class: "text-sm font-medium", for: "username") { "Username" }
                input type: "text", id: "username", class: "w-full px-3 py-2 border rounded-md"
              end
            end

            # Dialog Actions
            div(class: "mt-6 flex justify-end gap-4") do
              button(class: "px-4 py-2 bg-zinc-100 hover:bg-zinc-200 rounded-md", data: { dialog_close: true }) do
                "Cancel"
              end
              button(class: "px-4 py-2 bg-zinc-900 text-white hover:bg-zinc-700 rounded-md") do
                "Save Changes"
              end
            end
          end
        end
      end

      # Alert Dialog (this one was already correct)
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Alert Dialog" }
        render Default::Dialog.new do |dialog|
          dialog.trigger(class: "px-4 py-2 bg-red-600 text-white hover:bg-red-700 rounded-md") do
            "Show Alert"
          end

          dialog.content(class: "max-w-[400px]") do
            # Close button in the top-right corner
            dialog.close(class: "absolute right-4 top-4 rounded-sm opacity-70 ring-offset-white transition-opacity hover:opacity-100") do
              svg(class: "size-4", xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
              end
            end

            div(class: "flex flex-col items-center gap-4 text-center") do
              # Alert Icon
              div(class: "rounded-full bg-red-100 p-3") do
                svg(class: "size-6 text-red-600", xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: "2") do |s|
                  s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z")
                end
              end

              dialog.title(class: "text-lg font-semibold text-red-600") { "Critical Error" }
              dialog.description { "The application has encountered a critical error and needs to restart. Please save any unsaved work before continuing." }

              button(class: "mt-4 w-full px-4 py-2 bg-red-600 text-white hover:bg-red-700 rounded-md") do
                "Restart Application"
              end
            end
          end
        end
      end
    end
  end
end
