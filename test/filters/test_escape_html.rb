require 'helper'

describe Temple::Filters::EscapeHTML do
  before do
    @filter = Temple::Filters::EscapeHTML.new
  end

  it 'should handle escape expressions' do
    @filter.compile([:multi,
      [:escape, :static, "a < b"],
      [:escape, :dynamic, "ruby_method"]
    ]).should.equal [:multi,
      [:static, "a &lt; b"],
      [:dynamic, "Temple::Utils.escape_html((ruby_method))"],
    ]
  end

  it 'should keep blocks intact' do
    exp = [:multi, [:block, 'foo']]
    @filter.compile(exp).should.equal exp
  end

  it 'should keep statics intact' do
    exp = [:multi, [:static, '<']]
    @filter.compile(exp).should.equal exp
  end

  it 'should keep dynamic intact' do
    exp = [:multi, [:dynamic, 'foo']]
    @filter.compile(exp).should.equal exp
  end
end
