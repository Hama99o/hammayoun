import '@mdi/font/css/materialdesignicons.css';
// import 'vuetify/styles';

// Vuetify
import { createVuetify } from "vuetify";
import { VuetifyDateAdapter } from 'vuetify/lib/composables/date/adapters/vuetify.mjs'
import * as components from 'vuetify/components'
import * as labs from "vuetify/labs/components";
import { aliases, mdi } from 'vuetify/iconsets/mdi'

const studio = {
  dark: false,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: "#FDCF79",
    primaryHover: "#FDD994",
    primaryActive: "#FFC452",
    tooltipBackground: "#787878",
    tooltipText: "#FFFFFF",
    workshopBlue: '#167FFB',
    accent: "#000000",
    secondary: "#656565",
    success: "#86AF3F",
    info: "#EED055",
    warning: "#FB8C00",
    grey: '#CDCDCD',
    error: "#FF5252",
    neutral: "#333333",
    fakeBlack: "#333333",
    darkGrey: "#787878",
    middleGrey: "#CDCDCD",
    lightGrey: "#ECECEC",
    veryLightGrey: "#F6F6F6",
    positiveGreen: "#7BC079",
    positiveGreenDarken: "#3C9739",
    mediumOrange: "#FFC85C",
    negativeRed: "#FF5656",
    limeGreen: "FFC447",
    negativeRedLighten: '#F99E9F',
    mediumOrangeOpacity: "#FFFAEF",
    negativeRedOpacity: "#FFEFEF",
    positiveGreenOpacity: "#F2F9F2",
    transparentPositiveGreen: "#D8EDD7",
    transparentMediumOrange: "#FFF3DB",
    transparentNegativeRed: "#FAD4D4"
  }
}

const neutral = {
  dark: false,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: "#333333",
    primaryHover: "#8c8c8c",
    primaryActive: "#151515",
    tooltipBackground: "#787878",
    tooltipText: "#FFFFFF",
    accent: "#000000",
    secondary: "#656565",
    success: "#86af3f",
    info: "#eed055",
    warning: "#FB8C00",
    grey: '#CDCDCD',
    error: "#FF5252",
    neutral: "#333333",
    fakeBlack: "#333333",
    darkGrey: "#787878",
    middleGrey: "#CDCDCD",
    lightGrey: "#ECECEC",
    veryLightGrey: "#F6F6F6",
    positiveGreen: "#7BC079",
    mediumOrange: "#FFC85C",
    negativeRed: "#FF5656",
    mediumOrangeOpacity: "#FFFAEF",
    negativeRedOpacity: "#FFEFEF",
    positiveGreenOpacity: "#F2F9F2",
    transparentPositiveGreen: "#D8EDD7",
    transparentMediumOrange: "#fff3db",
    transparentNegativeRed: "#FAD4D4"
  }
}

export default createVuetify(
  // https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
  {
    date: {
      adapter: VuetifyDateAdapter,
    },
    icons: {
      defaultSet: 'mdi',
      aliases,
      sets: {
        mdi,
      },
    },
    theme: {
      defaultTheme: 'studio',
      themes: {
        studio,
        neutral,
      },
      variations: {
        colors: [
          'primary',
          'primaryHover',
          'secondary',
          'fakeBlack',
          'darkGrey',
          'middleGrey',
          'lightGrey',
          'veryLightGrey',
          'positiveGreen',
          'mediumOrange',
          'negativeRed',
          'limeGreen',
        ],
        lighten: 5,
        darken: 5,
      },
    },
    components: {
      ...components,
      ...labs,
    },
  }
)
