require_relative './conway.rb'

conway = Conway.new(60, 0.7)

loop do
  conway.show
  conway.tally_neighbors!
  conway.update_cells!
  sleep(0.03)
end