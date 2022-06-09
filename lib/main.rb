class Square
  include Comparable
  attr_reader :pos, :neighbors

  @@MOVES = [[1, 2],
            [1, -2],
            [-1, 2],
           [-1, -2],
             [2, 1],
            [2, -1],
            [-2, 1],
           [-2, -1]]

  def initialize(x_pos, y_pos, x_dim, y_dim)
    @pos = [x_pos, y_pos]
    @neighbors = adj_list(x_dim, y_dim)
  end

  def adj_list(x_dim, y_dim)
    list = []
    @@MOVES.each { |move| list << add_vectors(move) }
    list.select {|a,b| a.between?(0, x_dim - 1) && b.between?(0, y_dim - 1) }
  end

  def add_vectors(knight_move)
    @pos.zip(knight_move).map { |a, b| a + b }
  end

  def <=>(other)
    pos.first + 10 * pos.last <=> other.pos.first + 10 * other.pos.last
  end

  def to_s
    "#{@pos}"
  end
end

class ChessBoard
  attr_reader :board
  def initialize(m, n)
    @board = create_board(m, n)
  end

  def create_board(m, n)
    board = []
    n.times do |i|
      m.times { |j| board << Square.new(j, i, m, n) }
    end
    board
  end

  def bfs_info
    hash = {}
    @board.each { |square| hash[square] = {distance: nil, predecessor: nil} }
    hash
  end

  def find_square(coord)
    @board.find { |square| square.pos == coord }
  end

  # TODO: make #find_shortest, and #get_predecessors more clear
  def find_shortest(start, finish)
    start_square = find_square(start)
    end_square = find_square(finish)
    info = bfs_info
    info[end_square][:distance] = 0
    queue = []
    queue.push(end_square)
    until info[start_square][:distance]
      sqr = queue.shift
      sqr.neighbors.each_index do |i|
        adj_sqr = find_square(sqr.neighbors[i])
        if info[adj_sqr][:distance].nil?
          info[adj_sqr][:distance] = 1 + info[sqr][:distance]
          info[adj_sqr][:predecessor] = sqr
          queue.push(adj_sqr)
        end
      end
    end
    path = get_predecessors(start_square, info[start_square][:predecessor], info)
    print_result(info[start_square][:distance], path)
  end

  def get_predecessors(start, predec, info, list = [])
    list << start.pos
    return list if predec.nil?
    
    get_predecessors(predec, info[predec][:predecessor], info, list)
  end

  def print_result(distance, predecessors)
    puts "You made it in #{distance} squares! Here's your path:\n"
    predecessors.each { |predecessor| puts "#{predecessor}\n"}
  end
end
  
b = ChessBoard.new(8, 8)
b.board.each { |square| p square.neighbors }
