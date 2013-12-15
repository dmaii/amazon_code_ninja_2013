M, K = gets.split(' ').map { |i| i.to_i }
data = (1..M).inject('') { |s, i| s + gets }

$schedule = (0...24*60).inject([]) { |s, i| s << true }

def min_to_time(min)
  if min == 1440
    hours = '00'
    min = '00'
  else 
    hours = (hours = (min / 60).to_s).size < 2 ? '0' + hours : hours
    min = (min = (min % 60).to_s).size < 2 ? '0' + min : min
  end 
  hours + ' ' + min
end 

def busy_range(times)
  arr = times.split(' ').map { |i| i.to_i }
  start = arr[0] * 60 + arr[1]
  ending = (ending = arr[2] * 60 + arr[3]) == 0 ? 24*60 : ending
  [start, ending] 
end 

data.split("\n").each do |i|
  range = busy_range(i)
  (range[0]...range[1]).each { |i| $schedule[i] = false }
end 

free_slots = []
head = 0
until head >= $schedule.size - 1
  if $schedule[head]
    tail = head
    tail += 1 until !$schedule[tail+1] 
    free_slots << [head, tail + 1] if tail - head + 1 >= K
    head = tail
  end 
  head += 1
end 

free_slots.each { |i| puts min_to_time(i[0]) + ' ' + min_to_time(i[1]) }
