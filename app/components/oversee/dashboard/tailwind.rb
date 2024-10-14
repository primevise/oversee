class Oversee::Dashboard::Tailwind < Phlex::HTML
  def view_template
    script(src: "https://cdn.tailwindcss.com?plugins=typography")
    style(type:"text/tailwindcss") do
      raw pagy_css.html_safe
    end
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
