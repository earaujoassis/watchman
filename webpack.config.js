const path = require('path');

module.exports = {
  entry: './web/src/index.js',
  output: {
    path: path.resolve(__dirname, './public/assets/'),
    publicPath: '/public/assets/',
    filename: 'app.js'
  },
  devtool: 'cheap-module-source-map',
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
        use: [{ loader: 'style-loader' }, { loader: 'css-loader' }]
      }
    ]
  }
};
