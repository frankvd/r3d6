import merge from 'deepmerge';
import replace from '@rollup/plugin-replace';
// use createSpaConfig for bundling a Single Page App
import { createSpaConfig } from '@open-wc/building-rollup';

// use createBasicConfig to do regular JS to JS bundling
// import { createBasicConfig } from '@open-wc/building-rollup';

const baseConfig = createSpaConfig({
  // use the outputdir option to modify where files are output
  // outputDir: 'dist',

  // if you need to support older browsers, such as IE11, set the legacyBuild
  // option to generate an additional build just for this browser
  // legacyBuild: true,

  // development mode creates a non-minified build for debugging or development
  developmentMode: process.env.ROLLUP_WATCH === 'true',

  // set to true to inject the service worker registration into your index.html
  injectServiceWorker: false,

  html: {
    transform: [
      html => html.replace(/<link rel="preload" href="[^"]+" as="script" crossorigin="anonymous">/, '')
    ]
  }
});

export default [
  merge(baseConfig, {
    input: './pages/index.html',
    plugins: [
      replace({
        __API_BASE_URL__: 'http://134.209.94.221:28564/'
      })
    ]
  }),
  merge(baseConfig, {
    output: {dir: './dist/repl'},
    input: './pages/repl/index.html'
  })
];
