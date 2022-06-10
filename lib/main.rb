class Square
  attr_reader :pos, :neighbors

  @@MOVES = [[-2, -1],
             [-2,  1],
             [-1, -2],
             [-1,  2],
             [ 1, -2],
             [ 1,  2],
             [ 2, -1],
             [ 2,  1]]

  def initialize(x_pos, y_pos, x_dim, y_dim)
    @pos = [x_pos, y_pos]
    @neighbors = adj_list(x_dim, y_dim)
  end

  private

  def adj_list(x_dim, y_dim)
    list = []
    @@MOVES.each { |move| list << add_vectors(move) }
    list.select {|a,b| a.between?(0, x_dim - 1) && b.between?(0, y_dim - 1) }
  end

  def add_vectors(knight_move)
    @pos.zip(knight_move).map { |a, b| a + b }
  end
end

class ChessBoard
  attr_reader :board

  def initialize(m, n)
    @board = create_board(m, n)
  end

  # TODO: make #find_shortest, and #get_predecessors more clear
  def find_shortest(first, last)
    start = find_square(first)
    goal = find_square(last)
    info = bfs_info
    info[goal][:distance] = 0
    queue = []
    queue << goal
    until info[start][:distance]
      sqr = queue.shift
      sqr.neighbors.each do |neighbor|
        adj_sqr = find_square(neighbor)
        if info[adj_sqr][:distance].nil?
          info[adj_sqr][:distance] = 1 + info[sqr][:distance]
          info[adj_sqr][:predecessor] = sqr
          queue << adj_sqr
        end
      end
    end
    path = get_predecessors(start, info[start][:predecessor], info)
    print_result(info[start][:distance], path)
  end

  private

  def create_board(m, n)
    board_hash = {}
    n.times do |i|
      m.times { |j| board_hash[[j,i]] = Square.new(j, i, m, n) }
    end
    board_hash
  end

  def bfs_info
    hash = {}
    @board.each { |_key, val| hash[val] = {distance: nil, predecessor: nil} }
    hash
  end

  def find_square(coord)
    @board[coord]
  end

  def get_predecessors(start, pre, info, list = [])
    list << start.pos
    return list if pre.nil?
    
    get_predecessors(pre, info[pre][:predecessor], info, list)
  end

  def print_result(distance, predecessors)
    puts "You made it in #{distance} moves! Here's your path:\n"
    predecessors.each { |predecessor| puts "#{predecessor}\n"}
  end
end
  
b = ChessBoard.new(8, 8)
b.board.each { |square| p square.neighbors }
