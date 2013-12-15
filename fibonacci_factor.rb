def smallest_divisor(a, b)
  return 2 if a.even? && b.even?
  current, smaller = 1, [a,b].min
  until current == smaller
    current += 1
    return current if b % current == 0 && a % current == 0
  end
  1
end

def answer(input)
  current, prev, sum = 1, 1, 0
  until (answer = smallest_divisor(current, input)) > 1
    sum += current if current.even?
    prev, current = current, prev + current
  end
  [current, answer]
end

testcases = gets.to_i
answers = (1..testcases).inject([]) { |s, i| s << answer(gets.to_i) }
answers.each { |i| puts i[0].to_s + ' ' + i[1].to_s }
