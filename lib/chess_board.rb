class ChessBoard
  attr_reader :board

  def initialize(m, n)
    @board = create_board(m, n)
  end

  # TODO: make #knight_moves, and #get_predecessors more clear
  def knight_moves(first, last)
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