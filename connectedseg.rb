T = gets.to_i

matrices = (1..T).inject([]) do |s, i|
  n = gets.to_i
  matrix = (1..n).inject([]) do |ss, ii|
    row = gets.split(' ').map { |i| i.to_i }
    ss.push row
  end 
  s.push matrix
end 

def n(x, y); [x, y - 1]; end;
def s(x, y); [x, y + 1]; end;
def e(x, y); [x + 1, y]; end;
def w(x, y); [x - 1, y]; end;
def ne(x, y); n(*e(x, y)); end;
def nw(x, y); n(*w(x, y)); end;
def sw(x, y); s(*w(x, y)); end;
def se(x, y); s(*e(x, y)); end;

def scan_list(i, x, y)
  case
  when i == 0
    [n(x, y), nw(x, y), nil, nil, nil, nil, nil, ne(x, y)]
  when i == 1
    [n(x, y), nw(x, y), w(x, y), sw(x, y), nil, nil, nil, ne(x, y)]
  when i == 2
    [nil, nw(x, y), w(x, y), sw(x, y), nil, nil, nil, nil]
  when i == 3
    [nil, nw(x, y), w(x, y), sw(x, y), s(x, y), se(x, y), nil, nil]
  when i == 4
    [nil, nil, nil, sw(x, y), s(x, y), se(x, y), nil ,nil]
  when i == 5
    [nil, nil, nil, sw(x, y), s(x, y), se(x, y), e(x, y), ne(x, y)]
  when i == 6
    [nil, nil, nil, nil, nil, se(x, y), e(x, y), ne(x, y)]
  when i == 7
    [n(x, y), nw(x, y), nil, nil, nil, se(x, y), e(x, y), ne(x, y)]
  end 
end 

=begin
data = 
'0 0 1 0 1
1 0 1 0 1
0 1 0 0 1
0 1 0 0 1
0 0 0 0 0'

data = '0 0 1 0 0 1 0 0
1 0 0 0 0 0 0 1
0 0 1 0 0 1 0 1
0 1 0 0 0 1 0 0
1 0 0 0 0 0 0 0
0 0 1 1 0 1 1 0
1 0 1 1 0 1 1 0
0 0 0 0 0 0 0 0'

data = '1 0 0 1 1
0 0 1 0 0
0 0 0 0 0
1 1 1 1 1
0 0 0 0 0'
end 

data = 
'1 0 1 0 1 0 1 0 1 0 
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1 0'
=end 

def seg(matrix)
  #matrix = data.split("\n").map { |i| i.split(' ').map{ |ii| ii.to_i } }
  # in an array of directions, the order goes:
  # 0  1   2  3   4  5   6  7
  # n, nw, w, sw, s, se, e, ne
  order = [1,3,5,7,0,2,4,6]
  queue = []
  count = 0
  (0...matrix.size).each do |y|
    (0...matrix.size).each do |x|
      #debugger
      if matrix[y][x] == 1  
        queue.push([nil, nil, w(x, y), sw(x, y), s(x, y), se(x, y), e(x, y), nil])
        matrix[y][x] = nil
        count += 1
        until queue.empty?
          search = queue.shift
          order.each do |i|
            coordinates = search[i]
            if coordinates && !coordinates.include?(-1)
              if !matrix[coordinates[1]].nil? && matrix[coordinates[1]][coordinates[0]] == 1
                queue.push scan_list(i, coordinates[0], coordinates[1])
                matrix[coordinates[1]][coordinates[0]] = nil
              end 
            end 
          end 
        end 
      end 
    end 
  end 
  puts count
end 

matrices.each do |i|
  seg(i)
end 
