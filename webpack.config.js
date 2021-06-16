const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const commitHash = process.env.COMMIT_HASH || require('child_process').execSync('git describe --always').toString().trim();

module.exports = {
  entry: './web/index.js',
  output: {
    path: path.resolve(__dirname, './apps/web/assets/'),
    publicPath: '/public/assets/',
    filename: 'app.js'
  },
  resolve: {
    alias: {
      '@components': path.resolve(__dirname, 'web/components')
    }
  },
  devtool: 'cheap-module-source-map',
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'app.css',
      chunkFilename: '[id].css'
    }),
    new webpack.DefinePlugin({
      __COMMIT_HASH__: JSON.stringify(commitHash)
    })
  ],
  optimization: {
    minimizer: [new TerserPlugin({ extractComments: false })]
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader
          },
          'css-loader'
        ]
      }
    ]
  }
};
