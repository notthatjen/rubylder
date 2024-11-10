# frozen_string_literal: true

class Components::ScrollArea < Components::Base
  def view_template(&)
    div **attrs do
      div(
        class:
          "scroll-area-viewport overflow-y-scroll w-full h-full rounded scrollbar-hide"
      ) do
        div(class: "container", &)
      end
      div(
        class:
          "data-[state=visible]:animate-slideLeftAndFade data-[state=hidden]:opacity-0 transition-opacity h-full absolute top-0 right-0 scroll-area-scrollbar flex select-none touch-none p-0.5 bg-blackA3 transition-colors duration-[160ms] ease-out hover:bg-blackA5",
        data_orientation: "vertical",
        data_state: "hidden"
      ) do
        div(
          class: "scroll-area-thumb flex-1 bg-mauve10 rounded-[10px] relative"
        )
      end
    end
  end
end
