# frozen_string_literal: true

class Components::Example::Select < Components::Base
  def view_template
    div class: "p-8 grid gap-8" do
      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Basic Select" }
        render Default::Select.new(class: "w-[200px]") do |select|
          select.item(value: "apple") { "Apple" }
          select.item(value: "banana") { "Banana" }
          select.item(value: "blueberry") { "Blueberry" }
          select.item(value: "grapes") { "Grapes" }
          select.item(value: "pineapple") { "Pineapple" }
        end
      end

      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Select with Custom Placeholder" }
        render Default::Select.new(class: "w-[200px]", placeholder: "Choose a framework...") do |select|
          select.item(value: "rails") { "Ruby on Rails" }
          select.item(value: "laravel") { "Laravel" }
          select.item(value: "django") { "Django" }
          select.item(value: "phoenix") { "Phoenix" }
        end
      end

      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Select with Many Options" }
        render Default::Select.new(class: "w-[200px]", placeholder: "Select a country...") do |select|
          countries.each do |country|
            select.item(value: country.downcase) { country }
          end
        end
      end

      div class: "space-y-2" do
        h3(class: "text-sm font-medium") { "Select with Icons" }
        render Default::Select.new(class: "w-[200px]", placeholder: "Choose a browser...") do |select|
          select.item(value: "chrome", class: "flex items-center gap-2") do
            render_chrome_icon
            span { "Chrome" }
          end

          select.item(value: "firefox", class: "flex items-center gap-2") do
            render_firefox_icon
            span { "Firefox" }
          end

          select.item(value: "safari", class: "flex items-center gap-2") do
            render_safari_icon
            span { "Safari" }
          end

          select.item(value: "edge", class: "flex items-center gap-2") do
            render_edge_icon
            span { "Edge" }
          end
        end
      end
    end
  end

  private

  def countries
    [
      "United States",
      "United Kingdom",
      "Canada",
      "France",
      "Germany",
      "Italy",
      "Spain",
      "Australia",
      "Japan",
      "Brazil",
      "India",
      "China",
      "Russia",
      "Mexico",
      "South Korea",
      "Indonesia",
      "Netherlands",
      "Switzerland",
      "Sweden",
      "Norway"
    ]
  end

  def render_chrome_icon
    svg(class: "size-4", viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.circle(cx: "12", cy: "12", r: "10", stroke: "currentColor", stroke_width: "1.5")
      s.circle(cx: "12", cy: "12", r: "4", stroke: "currentColor", stroke_width: "1.5")
      s.path(d: "M12 8L21.17 11.5", stroke: "currentColor", stroke_width: "1.5")
      s.path(d: "M12 8L2.83 11.5", stroke: "currentColor", stroke_width: "1.5")
    end
  end

  def render_firefox_icon
    svg(class: "size-4", viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.path(
        d: "M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z",
        stroke: "currentColor",
        stroke_width: "1.5"
      )
      s.path(
        d: "M16 8C14.9 6.9 13.5 6 12 6C9.2 6 7 8.2 7 11C7 13.8 9.2 16 12 16C14.8 16 17 13.8 17 11",
        stroke: "currentColor",
        stroke_width: "1.5"
      )
    end
  end

  def render_safari_icon
    svg(class: "size-4", viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.circle(cx: "12", cy: "12", r: "10", stroke: "currentColor", stroke_width: "1.5")
      s.path(
        d: "M12 12L17 7M12 12L7 17",
        stroke: "currentColor",
        stroke_width: "1.5"
      )
    end
  end

  def render_edge_icon
    svg(class: "size-4", viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg") do |s|
      s.path(
        d: "M12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3Z",
        stroke: "currentColor",
        stroke_width: "1.5"
      )
      s.path(
        d: "M12 16C14.2091 16 16 14.2091 16 12C16 9.79086 14.2091 8 12 8",
        stroke: "currentColor",
        stroke_width: "1.5"
      )
    end
  end
end
