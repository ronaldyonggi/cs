# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  Extra = [rotations([[0, 0], [1, 0], [0, 1]]), # Mini 3-pieces L
               [[[0, 0], [-1, 0], [-2, 0], [1, 0], [2, 0]], # Long 5 piece, horizontal
               [[0, 0], [0, -1], [0, -2], [0, 1], [0, 2]]], # Long 5 piece, vertical
               rotations([[0, 0], [-1, 0], [-1, -1], [0, -1], [1, 0]])] # Square with 1 extra piece
  
  Cheat_Piece = [[[0, 0]]]

  All_My_Pieces = All_Pieces + Extra

  # your enhancements here

  # Override the next_piece method
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
  
  # This method will only be used when cheat flag is true
  def self.next_piece_cheat (board)
    MyPiece.new(Cheat_Piece, board)
  end

end

class MyBoard < Board
  # your enhancements here

  # Need to override initialize to set @current_block to use
  # MyPiece.next_piece instead of Piece.next_piece
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat = false # add an instance variable 'cheat'
  end

  # Enhancement: rotate 180 degree
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  # Enhancement: cheat
  def cheat
    if !game_over? and @game.is_running? and @score >= 100 and not @cheat
      @score -= 100
      @cheat = true
    end
  end

  # Override next_piece method
  def next_piece
    # If cheat is true, call MyPiece's next_piece_cheat, then reset 'cheat' to false
    if @cheat == true
      @current_block = MyPiece.next_piece_cheat(self)
      @cheat = false
    # Otherwise call MyPiece's next_piece method
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # The superclass's store_current method assumes that all pieces have 4 pieces.
  # Need to override it.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size-1)).each{|index| # change from 3 to [locations.size-1]
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
      

end

class MyTetris < Tetris
  # your enhancements here

  # Need to override set_board because @board should use MyBoard.new instead of Board.new
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # Add new keybindings for rotate_180 and cheat
  def key_bindings  
    super
    @root.bind('u', proc {@board.rotate_180}) 
    @root.bind('c', proc {@board.cheat})
  end

end


