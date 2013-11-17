text = gets.gsub(/[^A-Za-z\s]/, '').split(' ')
num_words = gets.to_i
words = (1..num_words).inject([]) { |s, i|
  s + [gets.gsub(/[^A-Za-z]/, '').downcase]
}.uniq.sort


downcased = text.map { |i| i.downcase }

segment_found = (words - downcased).empty?
if segment_found && words.size > 1
  cut_off = 0
  until words.include?(downcased[0])
    downcased.shift 
    cut_off += 1
  end 

  head = 0
  next_head = 0
  tail = 0
  smallest = 0, text.size
  catch :break do
    loop do
      if tail > 0
        prev_head = head
        until (included = words.include?(downcased[next_head])) && 
          !(words - downcased[next_head..tail]).empty?

          if included
            if tail - next_head < smallest[1] - smallest[0] 
              smallest = next_head, tail 
            end 
            prev_head = next_head
          end 
          next_head += 1 
        end 
        unfound = [downcased[prev_head]]
      else 
        unfound = words.dup - [downcased[next_head]]
      end 
      head = next_head
      next_head = head + 1
      until unfound.empty?   
        tail += 1  
        if downcased[tail].nil?
          throw :break
        elsif unfound.include? downcased[tail]
          unfound.delete(downcased[tail])
        end 
      end 
      smallest = head, tail if tail - head < smallest[1] - smallest[0]
    end 
  end 
  puts text[smallest[0] + cut_off..smallest[1] + cut_off].join(' ')
elsif segment_found
  puts words[0]
else 
  puts 'NO SUBSEGMENT FOUND' 
end 
