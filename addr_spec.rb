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

  def count_at(addr)
    cut_by_at("abc@aaa").length - 1
  end
    
  def contain_only_alphabet(addr)
    addr == addr.match(/^[[:alpha:]]+$/).to_s
  end
    
  def contain_only_digit(addr)
    addr == addr.match(/[0-9]+/).to_s
  end
    
  def contain_only_alphabet_and_digit_and_symbol(addr)
    addr == addr.match(/^[\w\/!#\$%&'\*\+\-?=^`\{\|\}~]+$/).to_s
  end

  def contain_only_alphabet_and_digit_and_symbol_and_special(addr)
    addr == addr.match(/^[\w\/!#\$%&'\*\+\-?=^`\{\|\}~]+[\"[\(\)\<\>\[\]\:\;\@\\\,\.]\"]+$/).to_s
  end

  def split_by_dot(addr)
    addr.split(".")
  end

  def is_dot_atom(addr)
    cutted = self.cut_by_at(addr)
    if cutted.count != 2
      return false
    end

    splited = self.split_by_dot(cutted[0])
    splited.each { |s|
      if s == ""
        return false
      end
      if self.contain_only_alphabet_and_digit_and_symbol(s) == false
        return false
      end
    }
    return true
  end

  def answer(addr)
    if is_dot_atom(addr) == true
      p "ok"
    else
      p "ng"
    end
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
    assert_equal true, @obj.contain_only_alphabet(@obj.cut_by_at("Abc@example.com")[0])
  end
    
  def test_contain_only_digit
    assert_not_equal nil, @obj.contain_only_digit(@obj.cut_by_at("123")[0])
  end
    
  def test_contain_only_alphabet_and_digit
    assert_equal true, @obj.contain_only_alphabet_and_digit_and_symbol("Abc123")
    assert_equal true, @obj.contain_only_alphabet_and_digit_and_symbol("!#$%&'*+-=?^_`{|}~")
    assert_not_equal true, @obj.contain_only_alphabet_and_digit_and_symbol("Abc.123")
  end

  def test_contain_only_alphabet_and_digit_and_symbol_and_special
    assert_equal true, @obj.contain_only_alphabet_and_digit_and_symbol_and_special("\"Abc@def\"")
  end
    
  def test_split_by_dot
    assert_equal ["1", "2", "3"], @obj.split_by_dot("1.2.3")
  end

  def test_email_only_alphabet
    assert_equal true, @obj.is_dot_atom("Abc@example.com")
  end

  def test_email_alphabet_and_digit
    assert_equal true, @obj.is_dot_atom("Abc.123@example.com")
  end

  def test_email_alphabet_and_digit_and_symbol
    assert_equal true, @obj.is_dot_atom("user+mailbox/department=shipping@example.com")
  end

  def test_email_only_symbol
    assert_equal true, @obj.is_dot_atom("!#$%&'*+-/=?^_`.{|}~@example.com")
  end

  def test_email_dot_dot
    assert_not_equal true, @obj.is_dot_atom("Abc..123@example.com")
  end
end
