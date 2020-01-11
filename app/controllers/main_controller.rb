class MainController < ApplicationController
  before_action :set_categories

  def index
    @reports = Report.order(updated_at: "desc")

    @title = "#{@site_title}"
    @meta_description = "このブログは、プログラミング言語の使い方や環境構築のセットアップ、エラーの対処方法などのノウハウの記録を書き留めていきます。時間が経つと忘れてしまうものを記録していくためのブログです。"
    @meta_keywords = "#{@site_title}, プログラミング, ノウハウ, IT, ブログ"
  end

  def category
    @category = Category.find_by(en_name: params[:category_name])
    unless @category
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end

    @title = "#{@category.name} | #{@site_title}"
    @meta_description = "#{@category.name}に関する記事を紹介しています。このブログは、プログラミング言語の使い方や環境構築のセットアップ、エラーの対処方法などのノウハウの記録を書き留めていきます。"
    @meta_keywords = "#{@category.name}, #{@site_title}, プログラミング, ノウハウ, IT, ブログ"
  end

  def sub_category   
    @category = Category.find_by(en_name: params[:category_name])
    unless @category
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end

    @sub_category = SubCategory.find_by(en_name: params[:sub_category_name])
    unless @sub_category
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end

    @title = "#{@sub_category.name} | #{@site_title}"
    @meta_description = "#{@sub_category.name}に関する記事を紹介しています。このブログは、プログラミング言語の使い方や環境構築のセットアップ、エラーの対処方法などのノウハウの記録を書き留めていきます。"
    @meta_keywords = "#{@sub_category.name}, #{@category.name}, #{@site_title}, プログラミング, ノウハウ, IT, ブログ"
  end

  def report
    @category = Category.find_by(en_name: params[:category_name])
    unless @category
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end
    
    @sub_category = SubCategory.find_by(en_name: params[:sub_category_name])
    unless @sub_category
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end

    @report = Report.find_by(code: params[:code])
    unless @report
      render template: "main/page_not_found", status: 404, content_type: "text/html"
      return
    end

    @title = "#{@report.title} | #{@site_title}"
    @meta_description = "#{@report.description}"
    @meta_keywords = "#{@sub_category.name}, #{@category.name}, #{@site_title}, プログラミング, ノウハウ, IT, ブログ"
  end

  def page_not_found
    @title = "Page Not Found | #{@site_title}"
    @meta_description = "ページが見つかりません。このブログは、プログラミング言語の使い方や環境構築のセットアップ、エラーの対処方法などのノウハウの記録を書き留めていきます。時間が経つと忘れてしまうものを記録していくためのブログです。"
    @meta_keywords = "#{@site_title}, プログラミング, ノウハウ, IT, ブログ"
  end

  private

    def set_categories
      @categories = Category.all
    end

end
