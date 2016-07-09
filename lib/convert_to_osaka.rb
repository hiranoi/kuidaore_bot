require 'yaml'

class ConvertToOsaka
  def initialize(tm)
    @tm = tm
  end

  def convert
    d = YAML.load_file("#{Rails.root}/lib/osaka.yml")
    # 文章にhashのキーが含まれているかを確認する
    d.each do |k, v|
      # 一致すればvalueに置換する
      @tm.gsub!(k, v)
    end
    @tm
  end
end

tm = "無料"
o = ConvertToOsaka.new(tm)
p o.convert