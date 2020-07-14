require './lib/ship'
require './lib/cell'

class VariableBoard

  attr_reader :cells, :rows, :columns
  def initialize
    @cells = {}
    @rows = []
    @columns = []
  end

 def generate_columns
   puts "Please choose your board size:"
   print ">"
   size = gets.chomp.to_i
   size_array = [size]
   until size == 1
     size_array << size -= 1
   end
   @columns << size_array.reverse!
   @columns.flatten!
 end

 def generate_rows
   ord = 65
   row_ords = [ord]
   until row_ords.count == @columns.count
     row_ords << ord += 1
   end
   @rows << row_ords
   @rows.flatten!
   @rows.map! {|ord| ord.chr}
 end

 def generate_cells
   row_num = 0
   column_num = 0
   until column_num == @columns.count
     column_number = @columns[column_num].to_s
     row_letter = @rows[row_num]
     cell = row_letter + column_number
     @cells[cell] = Cell.new(cell)
     row_num += 1
     if row_num == @columns.count
       row_num = 0
       column_num += 1
     end
   end
 end

 def render
   puts "  #{@columns[0..@columns.last - 1].join(' ')}"
   @columns.count.times do |num|
     puts "#{@cells.keys[num][0]} #{@cells[@cells.keys[num]].render}"
   end


 end

end
board = VariableBoard.new
board.generate_columns
board.generate_rows
board.generate_cells
require "pry"; binding.pry
