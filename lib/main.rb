# Knight's travails


# Classes needed
# 1 - Square - initializes a square based on a 2x1 vector eg. [3,5]
#     Then the square will have an associated adjacency list with all neigbors that
#     can be visited by knight's move. 

# 2 - Board - Creates a nxn board (default is 8x8) and populates with the squares from
#     class Square.

# Now that we have a board filledwith squares and their adjacency lists, we can use
# breadth-first-search to find the shortest path between two given squares on the board.

# Steps:

# 1 - Make a list where all squares are initialized so: {distance: nil, predecessor: nil}
# 2 - Set the goal squares distance to 
# 3 - Iterate over neighbors; if they have not been visited, update its list with predecessor and
#     set distance as one more than that of the predecessor.
# 4 - When the algorithm reaches the start square, terminate and print distance and all the predecessors.

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
    @@MOVES.each { |move| list << add_v(move) }
    list.select {|a,b| a.between?(0, x_dim - 1) && b.between?(0, y_dim - 1) }
  end

  def add_v(knight_move)
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
    @board.each { |square| hash[square] = {distance: nil, predecessor:nil} }
    hash
  end

  def find_shortest(start, finish)
    # for each node make hash:
    # {distance: nil, predecessor: nil}
    # perhaps in a new class
    # set finish.distance to 0
    # enqueue finish, and visit its neighbors in order
    # dequeue finish
    # set their distances to 1 and predecessor to finish
    # enqueue neighbors if predecessor.nil?
    # continue until start is found
    # then print the length and path
  end
end
  
b = ChessBoard.new(8, 8)
b.board.each { |square| p square.neighbors }
