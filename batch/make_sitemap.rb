# encoding: utf-8
require 'builder'
class MakeSitemap

  # 1つのサイトマップに記述するURLの数
  MAX_URL_SIZE = 20000
  HOST_NAME = "https://yoshikimi.com"

  def run
    start_time = Time.now
    begin
      puts "process start"
      main
      puts "process succeed"
    rescue Exception => e
      puts "process failed: #{e.message}"
    ensure
      past = Time.now - start_time
      puts "process end(#{past}sec)"
    end
  end

  private

  def main
    urls = get_urls

    # URLを分割して複数のサイトマップに保存
    total_pages = (urls.size.to_f / MAX_URL_SIZE.to_f).ceil
    total_pages.times.each do |n|
      # 分割してサイトマップを保存
      page = n + 1
      offset = (page-1) * MAX_URL_SIZE
      sitemap_urls = urls[offset, MAX_URL_SIZE]
      path = "#{Rails.root}/public/sitemap#{page}.xml"
      if page == 1
        path = "#{Rails.root}/public/sitemap.xml"
      end
      save_sitemap(path, sitemap_urls)
    end

    # インデックスファイルを作成
    save_index_file(total_pages)
  end

  # サイトマップインデックスファイルを生成して保存する
  #
  #+total_pages+:: 全ページ数(分割数)
  def save_index_file(total_pages)
    sitemap_xml_urls = []
    total_pages.times.each do |n|
      page = n + 1
      if page == 1
        sitemap_xml_urls << "#{HOST_NAME}/sitemap.xml"
      else
        sitemap_xml_urls << "#{HOST_NAME}/sitemap#{page}.xml"
      end
    end

    xml = Builder::XmlMarkup.new(:encoding => "UTF-8", :indent => 2)
    xml.instruct!(:xml)
    xml.sitemapindex(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
      sitemap_xml_urls.each do |url|
        xml.sitemap do
          xml.loc url
          xml.lastmod w3c_time(Time.now)
        end
      end
    end

    xml_str = xml.target!
    path = "#{Rails.root}/public/sitemap_index.xml"
    FileUtils.mkdir_p(File.dirname(path), :mode => 0711)
    File.open(path, "w:utf-8"){|f| f.print xml_str}
    puts "save to #{path}"
  end

  def w3c_time(time)
    time.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end

  def save_sitemap(path, urls)
    xml_str = generate_sitemap_xml(urls)
    FileUtils.mkdir_p(File.dirname(path), :mode => 0711)
    File.open(path, "w:utf-8"){|f| f.print xml_str}
    puts "save to #{path}, urls=#{urls.size}"
  end

  # サイトマップXMLを生成する
  def generate_sitemap_xml(urls)
    # XML生成
    xml = Builder::XmlMarkup.new(:encoding => "UTF-8", :indent => 2)
    xml.instruct!(:xml)
    xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:xhtml" => "http://www.w3.org/1999/xhtml") do
      urls.each do |url|
        xml.url do
          xml.loc url
          xml.lastmod Date.today.strftime("%Y-%m-%d")
          xml.changefreq "daily"
        end
      end
    end

    return xml.target!
  end

  def get_urls
    urls = []
    urls << "#{HOST_NAME}/"
    Category.order(created_at: :asc).each do |category|
      urls << "#{HOST_NAME}/#{category.en_name}"
    end

    SubCategory.order(created_at: :asc).each do |sub_category|
      urls << "#{HOST_NAME}/#{sub_category.category.en_name}/#{sub_category.en_name}"
    end

    Tag.order(created_at: :asc).each do |tag|
      urls << "#{HOST_NAME}/tag/#{tag.name}"
    end

    Report.order(created_at: :asc).each do |report|
      urls << "#{HOST_NAME}/#{report.sub_category.category.en_name}/#{report.sub_category.en_name}/#{report.code}"
    end

    return urls
  end

end

MakeSitemap.new.run