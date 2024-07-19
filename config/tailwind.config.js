const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        blue: {
          200: "#A5D8F1",
          500: "#4BB0E3",
          800: "#1F559E",
        },
        orange: {
          200: "#F3B68A",
          500: "#E66C15",
        },
        yellow: {
          200: "#F6DB8F",
          500: "#EEB71E",
          800: "#B98B37",
        },
        "off-white": "#ECF3F6",
        "dark-gray": "#282725",
        "light-gray": "#767979",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
