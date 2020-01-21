const path = require("path");
const webpack = require("webpack");
const env = process.env.NODE_ENV !== 'production'  ? 'development' : 'production';

module.exports = {
  mode: env,
  entry: {
    bundle: "./src/index.ts",
  },
  output: {
    path: path.resolve(__dirname, "./public"),
    filename: "[name].js",
    chunkFilename: "[name].bundle.js",
    publicPath: "/",
  },
  resolve: {
    extensions: [".js", ".ts", ".tsx"],
  },
  devServer: {
    contentBase: "public",
    port: 8080,
    host: "0.0.0.0",
    historyApiFallback: true,
    inline: true,
    hot: true,
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: "ts-loader",
        options: {
          transpileOnly: true
        }
      }
    ],
  }
}
