# frozen_string_literal: true

class Components::Example::ScrollArea < Components::Base
  def view_template
    render Default::ScrollArea.new(class: "max-h-[400px] w-[230px] shadow rounded-lg overflow-hidden") do
      div class: "p-3 rounded bg-white grid grid-colse-1 divide-y" do
        div class: "text-sm font-medium px-2 pb-2" do
          "Tags"
        end
        tags
      end
    end
  end

  private
  def tags
    50.times do |i|
      div class: "py-3 px-2 text-sm font-light" do
        span { "v1.2.0.beta.#{50 - i}" }
      end
    end
  end
end
