# frozen_string_literal: true

class Components::Default::ScrollArea < Components::Base
  # inspo: https://github.com/radix-ui/primitives/tree/main/packages/react/scroll-area/src

  props direction: :vertical,
        visibility: "default" # "default" | "always" | "hidden"

  def view_template(&)
    default_attrs = {
      class: "h-full overflow-hidden relative group",
      data: {
        scroll_area: true,
        direction: props.direction.to_s
      }
    }

    div(**mix(default_attrs, attrs)) do
      div(class: "h-full overflow-scroll scrollbar-none", data: { scroll_viewport: true }) do
        div(class: "h-full", data: { scroll_content: true }, &)
      end
      render_scrollbar
    end
  end

  private

  def render_scrollbar
    default_attrs = {
      data: {
        orientation: props.direction.to_s,
        state: get_default_state,
        visibility: props.visibility,
        scroll_bar: true
      },
      class: "absolute top-0 right-0 bottom-0 opacity-0 group-hover:opacity-100 transition-opacity data-[state=visible]:block data-[state=hidden]:hidden bg-zinc-50 min-w-[5px] z-50"
    }

    div(**default_attrs) do
      div(
        data: { scroll_thumb: true },
        class: "relative block min-w-[5px] cursor-pointer rounded-lg bg-zinc-300 hover:bg-zinc-400 transition-all duration-150 ease-out"
      )
    end
  end

  def get_default_state
    props.visibility == "always" ? "visible" : "hidden"
  end

  def self.script_template
    <<~JS
      document.addEventListener('DOMContentLoaded', () => {
        const initScrollArea = (scrollArea) => {
          const viewport = scrollArea.querySelector('[data-scroll-viewport]');
          const scrollbar = scrollArea.querySelector('[data-scroll-bar]');
          const thumb = scrollArea.querySelector('[data-scroll-thumb]');
          let isDragging = false;
          let startPos = 0;

          // hide browser default scrollbar
          viewport.style.scrollbarWidth = 'none';

          const updateScrollbarVisibility = () => {
            // Check if content is scrollable
            const isScrollable = viewport.scrollHeight > viewport.clientHeight;
            scrollbar.style.display = isScrollable ? 'block' : 'none';
          };

          const updateThumbSize = () => {
            // Use the minimum width we set in CSS
            thumb.style.width = '5px';

            // Calculate the thumb height
            const viewportRatio = viewport.clientHeight / viewport.scrollHeight;
            const thumbHeight = Math.max(viewportRatio * viewport.clientHeight, 20);
            thumb.style.height = `${thumbHeight}px`;

            // Update scrollbar visibility
            updateScrollbarVisibility();
          };

          updateThumbSize();

          thumb.addEventListener('pointerdown', (event) => {
            isDragging = true;
            startPos = event.clientY;
            document.body.style.userSelect = 'none';
            thumb.setPointerCapture(event.pointerId);
          });

          thumb.addEventListener('pointerup', (event) => {
            isDragging = false;
            document.body.style.userSelect = '';
            thumb.releasePointerCapture(event.pointerId);
          });

          thumb.addEventListener('pointermove', (event) => {
            if (isDragging) {
              const currentPos = event.clientY;
              const delta = currentPos - startPos;
              const viewportScrollPos = viewport.scrollTop;
              const maxScrollPos = viewport.scrollHeight - viewport.clientHeight;
              const thumbSize = thumb.clientHeight;
              const trackSize = scrollbar.clientHeight;
              const scrollRatio = maxScrollPos / (trackSize - thumbSize);
              viewport.scrollTop = viewportScrollPos + delta * scrollRatio;
              startPos = currentPos;
            }
          });

          viewport.addEventListener('scroll', () => {
            const maxScrollPos = viewport.scrollHeight - viewport.clientHeight;
            const scrollPos = viewport.scrollTop;
            const thumbSize = thumb.clientHeight;
            const trackSize = scrollbar.clientHeight;
            const thumbOffset = (scrollPos / maxScrollPos) * (trackSize - thumbSize);
            thumb.style.transition = isDragging ? 'none' : 'transform 150ms ease-out';
            thumb.style.transform = `translateY(${thumbOffset}px)`;
          });

          viewport.addEventListener('mouseenter', () => {
            if (viewport.scrollHeight > viewport.clientHeight) {
              scrollbar.dataset.state = 'visible';
            }
          });

          viewport.addEventListener('mouseleave', () => {
            scrollbar.dataset.state = 'hidden';
          });

          // Update on resize
          new ResizeObserver(() => {
            updateThumbSize();
            viewport.dispatchEvent(new Event('scroll'));
          }).observe(viewport);

          // Update on content changes
          new MutationObserver(() => {
            updateThumbSize();
            viewport.dispatchEvent(new Event('scroll'));
          }).observe(viewport, {
            childList: true,
            subtree: true,
            characterData: true
          });
        };

        const scrollAreas = document.querySelectorAll('[data-scroll-area]');
        scrollAreas.forEach(initScrollArea);
      });
    JS
  end
end
