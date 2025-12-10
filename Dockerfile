# 使用するベースイメージ (Ruby 3.2.2 を推奨)
FROM ruby:3.2.2

# 必要なシステムパッケージのインストール
# Node.js, Yarn (アセットパイプライン用) に加え、
# PostgreSQLクライアント (`libpq-dev`) とビルドツールをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn postgresql-client libpq-dev build-essential libvips

# 作業ディレクトリの設定
WORKDIR /usr/src/app

# ホストのGemfileとGemfile.lockを作業ディレクトリにコピー
COPY Gemfile Gemfile.lock ./

# Bundlerを使用してRubyGemsをインストール
RUN bundle install

# ホストのアプリケーションコード全体を作業ディレクトリにコピー
COPY . .

# サーバー起動時のデフォルトコマンド
# Dockerコンテナ外からアクセスできるよう、バインドアドレスを0.0.0.0に設定
CMD ["rails", "server", "-b", "0.0.0.0"]