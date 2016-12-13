require 'ruboty/flexible_alias'

class Ruboty::FlexibleAlias::Alias
  def initialize(original, transformed)
    @original = original
    @transformed = transformed

    compile!
  end

  def compile!
    @compiled = []

    @original.gsub(/([^\)]*)\((digit|alnum|graph)\)([^\(]*)/) do |match|
      match = Regexp.last_match
      left = match[1]
      keyword = match[2]
      right = match[3]
      @compiled += [Regexp.escape(left), '([[:', keyword, ':]]+)', Regexp.escape(right)]
    end

    @compiled += [Regexp.escape(@original)] if @compiled.empty?

    @compiled = Regexp.compile(@compiled.join(''))
  end

  def tranfrom(original)
    match = original.match(@compiled)

    if match
      @transformed.gsub(/\$([0-9]+)/) do |*|
        match[Regexp.last_match[1].to_i]
      end
    end
  end
end
