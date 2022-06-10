

# lib/main.rb

require_relative 'chess_board'
require_relative 'square'
  
b = ChessBoard.new(8, 8)
b.find_shortest([3,3],[4,3])
