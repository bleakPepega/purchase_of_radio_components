const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },

	colors: {
	    transparent: 'transparent',
	    current: 'currentColor',
	    'white': '#ffffff',
	    'purple': '#3f3cbb',
	    'midnight': '#121063',
	    'metal': '#565584',
	    'tahiti': '#3ab7bf',
	    'silver': '#ecebff',
	    'bubble-gum': '#ff77e9',
	    'bermuda': '#78dcca',
	    'dark-green': '#2D422D',
	    'brown': '#423926',
	    'dark-red': '#382121',
	    'blue-green':'#264241',
	},
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
