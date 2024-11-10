# frozen_string_literal: true

class Components::Example::Accordion < Components::Base
  def view_template
    div class: "flex flex-col gap-4" do
      span(class: "text-sm font-medium") { "Accordion" }
      render Default::Accordion.new(class: "rounded-lg overflow-hidden shadow bg-white") do |accordion|
        sample_items.each do |item_data|
          build_accordion_item(accordion, item_data)
        end
      end
    end
  end

  private

  def build_accordion_item(accordion, item_data)
    accordion.item(class: "w-[350px] bg-zinc-50") do |item|
      build_trigger(item, item_data[:title])
      build_content(item, item_data[:content])
    end
  end

  def build_trigger(item, title)
    item.trigger(class: "p-3 group flex items-center justify-between") do
      span(class: "text-left") { title }
      chevron_icon
    end
  end

  def build_content(item, content)
    item.content(class: "px-3 py-3 font-light bg-zinc-100") do
      p { content }
    end
  end

  def chevron_icon
    svg(
      class: "ml-3 group-data-[state=open]:rotate-180 transition-transform duration-100",
      width: 15,
      height: 15,
      viewBox: "0 0 15 15",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg"
    ) do |s|
      s.path(
        d: "M3.13523 6.15803C3.3241 5.95657 3.64052 5.94637 3.84197 6.13523L7.5 9.56464L11.158 6.13523C11.3595 5.94637 11.6759 5.95657 11.8648 6.15803C12.0536 6.35949 12.0434 6.67591 11.842 6.86477L7.84197 10.6148C7.64964 10.7951 7.35036 10.7951 7.15803 10.6148L3.15803 6.86477C2.95657 6.67591 2.94637 6.35949 3.13523 6.15803Z",
        fill: "currentColor",
        fill_rule: "evenodd",
        clip_rule: "evenodd"
      )
    end
  end

  def sample_items
    [
      {
        title: "What is the purpose of a collapsible?",
        content: "The main benefit of a collapsible container is its ability to be folded up and put away when not in use."
      },
      {
        title: "What is a word for collapsible?",
        content: "foldable, foldaway, folding. capable of being folded up and stored. telescopic."
      },
      {
        title: "What object is collapsible?",
        content: "A collapsible object is one that can be folded up and stored when not in use."
      }
    ]
  end
end
