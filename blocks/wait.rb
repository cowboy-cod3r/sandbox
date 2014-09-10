#!/opt/apps/ruby/ruby/bin/ruby

def wait_until(timeout)
  max, attempt = 10, 1

  while max >= attempt do
    #puts attempt
    puts yield
    if yield
      break
    end
    attempt += 1
  end
end

def element_exists?()
  return true
end

wait_until(10) do
  element_exists?
end

