require_relative './models/conway.rb'

conway = Conway.new(40, 0.7)

loop do
  conway.show
  conway.tally_neighbors!
  conway.update_cells!
  sleep(0.0420)
end