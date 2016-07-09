require 'yaml'

class ConvertToOsaka
  def initialize(tm)
    @tm = tm
  end

  def convert
    d = YAML.load_file('./osaka.yml')
    # 文章にhashのキーが含まれているかを確認する
    d.each do |k, v|
      # 一致すればvalueに置換する
      @tm.gsub!(k, v)
    end
    @tm
  end
end
