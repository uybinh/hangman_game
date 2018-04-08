class Keyword
  attr_reader :content

  def initialize(content)
    @content = content
  end

  class << self
    def generate_keyword
      Keyword.new(get_keyword_from_file)
    end

    protected

    def get_keyword_from_file
      file = File.open("keywords.txt", 'r').readlines
      keyword = ''
      loop do
        keyword = file[rand(0...(file.size))].strip
        break if keyword.length.between?(5,12)
      end
      keyword
    end
  end
end


