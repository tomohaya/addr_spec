require 'test/unit'
require 'stringio'

class ValidateAddr
  
  @@num_list

  
  def input
    @@num_list = $stdin.readlines.map(&:chomp).map(&:to_f)
  end
  
  def cut_by_at(val)
    val.split("@")
  end

end


class TestValidateAddr < Test::Unit::TestCase
    
  def setup
    @obj = ValidateAddr.new
  end
  
  def test_input
    $stdin = StringIO.new("abc\n")
    assert_equal 0, @obj.input[0]
    $stdin = STDIN
  end
  
  def test_cut_by_at
    assert_equal "abc", @obj.cut_by_at("abc@aaa")[0]
  end
  
  
end

