module.exports = {
  content: [
    './app/views/**/*.rb', // Phlex views
    './app/components/**/*.rb', // Phlex components
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  theme: {
    extend: {
      boxShadow: {
        outline: '0 2px 10px rgba(0, 0, 0, 0.25)',
        'outline-black': '0 0 0 2px rgba(0, 0, 0, 0.9)',
      },
      keyframes: {
        slideDownAndFade: {
          from: { opacity: '0', transform: 'translateY(-2px)' },
          to: { opacity: '1', transform: 'translateY(0)' },
        },
        slideLeftAndFade: {
          from: { opacity: '0', transform: 'translateX(2px)' },
          to: { opacity: '1', transform: 'translateX(0)' },
        },
        slideUpAndFade: {
          from: { opacity: '0', transform: 'translateY(2px)' },
          to: { opacity: '1', transform: 'translateY(0)' },
        },
        slideRightAndFade: {
          from: { opacity: '0', transform: 'translateX(-2px)' },
          to: { opacity: '1', transform: 'translateX(0)' },
        },
      },
      animation: {
        slideDownAndFade: 'slideDownAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)',
        slideLeftAndFade: 'slideLeftAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)',
        slideUpAndFade: 'slideUpAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)',
        slideRightAndFade: 'slideRightAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)',
      },
    },
  },
  // add custom class hidden scrollbars
  plugins: [
    // plugin(function ({ addUtilities }) {
    //   addUtilities({
    //     '.scrollbar-hide': {
    //       /* IE and Edge */
    //       '-ms-overflow-style': 'none',
    //       /* Firefox */
    //       'scrollbar-width': 'none',
    //       /* Safari and Chrome */
    //       '&::-webkit-scrollbar': {
    //         display: 'none'
    //       }
    //     }
    //   }
    //   )
    // })
  ],
}
