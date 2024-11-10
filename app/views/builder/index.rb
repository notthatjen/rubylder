# frozen_string_literal: true

class Views::Builder::Index < Views::Base
  def view_template
    div(class: "bg-zinc-100 h-screen w-screen flex") do
      div class: "flex-1 h-full flex flex-col" do
        # Top Bar
        render Builder::Topbar.new

        main style: "padding-block: 100px", class: "flex items-center justify-center w-full max-w-[90%] mx-auto flex items-center justify-center" do
          render Components::Example::DropdownMenu.new
          render Components::Example::Select.new
          render Components::Example::Dialog.new
          render Components::Example::Accordion.new
        end
      end
    end
  end

  def components
    [
      "Accordion",
      "Alert Dialog",
      "Aspect Ratio",
      "Avatar",
      "Checkbox",
      "Collapsible",
      "Context Menu",
      "Dialog",
      "Dropdown Menu",
      "Hover Card",
      "Menubar",
      "Navigation Menu",
      "Popover",
      "Progress",
      "Radio Group",
      "Scroll Area",
      "Select",
      "Separator",
      "Slider",
      "Switch",
      "Tabs",
      "Toast",
      "Toggle",
      "Toggle Group",
      "Toolbar",
      "Tooltip"
    ]
  end
end
