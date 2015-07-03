class Warmup
 
  # This is a user input and command-line-output
  # test.  You need to stub out `gets` to make it work
  # And can stub out `puts` just for fun
  def gets_shout
    shout = gets.chomp.upcase

    # This is a side effect. Test for fun!
    puts shout

    return shout
  end
  

  # for your spec for this one, pass in a plain old double
  # that can accept a #size method and return something
  def double_size(array)
    return array.size * 2
  end

  
  # for this method, you want separate tests to show
  # that the string you pass in receives the #upcase!
  # method call, the #reverse! method call,
  # and that your method still returns a totally 
  # different thing
  def calls_some_methods(string)
    loud_string = string.upcase!
    loud_string.reverse!
    return "hahahaha this is a terrible method"
  end

 end
