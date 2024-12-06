class Oversee::Dashboard::Tailwind < Phlex::HTML
  def view_template
    script(src: "https://cdn.tailwindcss.com/3.4.15?plugins=typography@0.5.15")
    style(type:"text/tailwindcss") do
      raw pagy_css.html_safe
      raw trix_css.html_safe
    end
  end

  def trix_css
    <<~CSS
      trix-editor {
        @apply rounded-b rounded-t-none border border-t-0 border-gray-200 !ring-0;
      }

      .trix-active {
        @apply !bg-gray-100 !text-blue-500;
      }

      .trix-button-row {
        @apply overflow-hidden rounded-t border;
      }

      .trix-button {
        @apply !relative !inline-flex !h-7 !items-center !justify-center border-0 !border-b-0 !border-l-0 !px-7 !py-4;
      }

      .trix-button::before {
        @apply !top-1.5 !h-5;
      }

      .trix-button-group {
        @apply !mb-0 rounded-b-none !border-0 border-gray-200;
      }
    CSS
  end

  def pagy_css
    <<~CSS
      .pagy {
        @apply flex gap-2 items-center text-sm text-gray-500;
        a:not(.gap) {
          @apply inline-flex items-center justify-center h-8 min-w-8 font-normal;
          &:hover { @apply bg-gray-100; }
          &:not([href]) { /* disabled links */
            @apply text-gray-300 cursor-not-allowed;
          }
          &.current {
            @apply font-semibold bg-gray-100 text-gray-900;
          }
        }

        label {
          @apply inline-block whitespace-nowrap bg-gray-200 px-3 py-0.5;
          input {
            @apply bg-gray-100 border-none rounded-md;
          }
        }
      }
    CSS
  end
end
