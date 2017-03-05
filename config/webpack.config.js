// Example webpack configuration with asset fingerprinting in production.
'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');

// must match config.webpack.dev_server.port
var devServerPort = 3808;

// set NODE_ENV=production on the environment to add asset fingerprints
var production = process.env.NODE_ENV === 'production';

var config = {
  entry: {
    application: 'application.js',
    admin_media: 'admin/media.js',
    'init-lightbox': 'init-lightbox.js',
    albums: 'admin/albums.js',
    types: 'admin/types.js',
    'init-lazy-loading': 'admin/init-lazy-loading.js',
    uploads: 'admin/uploads.js',
    reports: 'reports.js',
    admin :'admin/admin.js',
    users: 'users.js'
  },

  output: {
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

  resolve: {
    root: path.join(__dirname, '..', 'app/assets/javascripts'),
    extensions: ['', '.js', '.json', '.coffee', '.css', '.vue'],
    modulesDirectories: ['node_modules'],
    alias: {
      'jquery': path.join(__dirname, '../node_modules/jquery/dist/jquery.js'),
      'vue$': 'vue/dist/vue.common.js',
      'eventEmitter/EventEmitter': 'wolfy87-eventemitter',
      "matches-selector/matches-selector": "desandro-matches-selector",
      "get-style-property/get-style-property": "desandro-get-style-property"
    }
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      },
      {
          test: /\.scss$/,
          loader: 'style!css!sass'
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            'scss': 'vue-style-loader!css-loader!sass-loader',
            'sass': 'vue-style-loader!css-loader!sass-loader?indentedSyntax'
          }
        }
      },
      {
          test: /\.css$/,
          loader: 'style-loader!css-loader'
      },
      {
          test: /^jquery\..*\.js$/,
          loader: "imports-loader?$=jquery,jQuery=jquery"
      },
      {
          test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader:"url?limit=10000&mimetype=application/font-woff"
      },
      {
          test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader: 'file'
      },
      {
          test: /\.(png|jpg|gif|svg)$/,
          loader: 'file-loader',
          options: {
            name: '[name].[ext]?[hash]'
          }
      }
    ]
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    }),
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        'window.$': 'jquery',
        'window.jQuery': 'jquery',
        Materialize: 'materialize-css',
        "window.Materialize": 'materialize-css',
        'Vel': 'velocity-animate'
    })
 ]
}

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'cheap-module-eval-source-map';
}

module.exports = config;
