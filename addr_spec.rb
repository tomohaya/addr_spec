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
    
  def cut_by_dot(val)
    val.split(".")
  end
    
  def count_at(addr)
      cut_by_at("abc@aaa").length - 1
  end
    
#  def answer(addr)
#      if count_at(addr) == 1
#        p "ok"
#      else
#        p "ng"
#      end
#  end
    
  def contain_only_alphabet(addr)
      addr.match(/^[[:alpha:]]+$/).to_s
  end
    
  def contain_only_digit(addr)
      addr.match(/[0-9]+/).to_s
  end
    
  def contain_only_alphabet_and_digit(addr)
      addr.match(/^[\w\/!#\$%&'\*\+\-?=^`\{\|\}~]+$/).to_s
      #addr.match(/^[\w!#\$%&'\*\+-?=^`\{\|\}~]+$/).to_s
      # p addr.match(/^[\w!#\$%&'\*\+-?=^`\{\|\}~]+$/)[0]
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
    
  def test_count_at
      assert_equal 1, @obj.count_at("abc@aaa")
  end
    
  def test_contain_only_alphabet
      assert_equal "Abc", @obj.contain_only_alphabet(@obj.cut_by_at("Abc@example.com")[0])
  end
    
  def test_contain_only_digit
      assert_not_equal nil, @obj.contain_only_digit(@obj.cut_by_at("123")[0])
  end
    
  def test_contain_only_alphabet_and_digit
    
           assert_equal "Abc123", @obj.contain_only_alphabet_and_digit(@obj.cut_by_at("Abc123@example.com")[0])
      
      assert_equal "!#$%&'*+-=?^_`{|}~", @obj.contain_only_alphabet_and_digit(@obj.cut_by_at("!#$%&'*+-=?^_`{|}~@example.com")[0])
      
      assert_equal "Abc.123", @obj.contain_only_alphabet_and_digit(@obj.cut_by_at("Abc.123@example.com")[0])
      
      assert_equal "!#$%&'*+-=?^_`{|}~", @obj.contain_only_alphabet_and_digit(@obj.cut_by_at("!#$%&'*+-=?^_`{|}~@example.com")[0])
      
      
  end
    
    
end
    
#tri = ValidateAddr.new
#tri.answer("a")
    