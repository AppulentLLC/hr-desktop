/* eslint-env node */
'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
  let app = new EmberApp(defaults, {
    // Add options here
  });

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.
    
  app.import('bower_components/bootstrap-sass/assets/javascripts/bootstrap.js');
  
  app.import('bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker3.min.css');
  
  app.import('bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js');
  
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js');
  
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');

  app.import('bower_components/bootstrap-validator/js/validator.js');
  
  app.import('bower_components/bootstrap-sass/assets/fonts/bootstrap/glyphicons-halflings-regular.woff', {
    destDir: 'fonts/bootstrap'
  });
  
  app.import('bower_components/bootstrap-sass/assets/fonts/bootstrap/glyphicons-halflings-regular.woff2', {
    destDir: 'fonts/bootstrap'
  });
  app.import('bower_components/bootstrap-sass/assets/fonts/bootstrap/glyphicons-halflings-regular.ttf', {
    destDir: 'fonts/bootstrap'
  });
  
  app.import('bower_components/jquery.inputmask/dist/jquery.inputmask.bundle.js');
  
  app.import('bower_components/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js');
  app.import('bower_components/seiyria-bootstrap-slider/dist/css/bootstrap-slider.min.css');
  
  app.import('bower_components/papaparse/papaparse.min.js');
  
  return app.toTree();
};
