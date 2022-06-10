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
