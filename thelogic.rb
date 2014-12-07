# The final ruleset must be built.

group=Group.find(group_id)

gifters=group.santa.map(&:id)
recipients=group.santa(&:id)



# Perhaps I should just re-create the matrix then add up the value of the rows,
# starting with the lowest one first. That would enable me to keep this "cool".
# I would need to build a new matrix each time, so I will create two arrays,
# then build the matrix from these:
finalset=Hash.new {|h,k| h[k]=[]}
dimensions=gifters.length
gift_matrix=Matrix.build(dimensions, dimensions) do |row,col|
  if row == col
    0
  elsif (group.rules.where gifter: group.santa.find(gifters[row]).name, recipient: group.santa.find(recipients[col]).name).any?
    0
  else
    1
  end
end

for i in 0..gift_matrix.row_count-1 do
  gift_matrix.row[i].inject(:+)
end

# This would give me all the row option amounts:, with the row index at the end
for i in 0..a.row_count-1 do
  b << [a.row(i).inject(:+),i]
end

# Then, I can sort by the row amount, after shuffling:
b=b.shuffle.sort_by(&:first)
# This gives me the current gifter:
current_gifter=b.first.last

# It's also possible, but not necessary to check if I need to shuffle:
b.map(&:first)==b.map(&:first).uniq ? no : yes

# I can then take this, and take a row of the gift_matrix:
gift_matrix.row(current_gifter)

# That's useful, because I can push it in to an array to get randomness:

ones=Array.new
gift_matrix.row(b.first.last).each_with_index do |recipient,index|
  ones << index if recipient==1
end

# Then I choose a random one of these:
curent_recipient=ones[rand(0..ones.length-1)]
finalset[current_gifter]=current_recipient
# Now I delete and repeat:
gifters.slice!(current_gifter)
recipients.slice!(current_recipient)
# Repeat until the arrays are nil!

# Finds the target group
group=Group.find(group_id)
# Makes an array of gifters
gifters=group.santa.map(&:id)
# Makes an identical array of recipients
recipients=group.santa.map(&:id)
# Makes a hash to associate recipients with gifters
finalset=Hash.new
# This array shrinks, when it's gone, stop.
while !gifters.empty?
  # Matrix dimensions match remaining gifters
  dimensions=gifters.length
  # Only build a matrix if there are two or more remaining
  if dimensions > 1
    # Build the matrix with the dimensions of remaining members
    gift_matrix=Matrix.build(dimensions, dimensions) do |row,col|
      # Can't gift yourself
      if row == col
        0
      # Check rules
      elsif (group.rules.where gifter: group.santa.find(gifters[row]).name, recipient: group.santa.find(recipients[col]).name).any?
        0
      # If no rule, and not self, allow it
      else
        1
      end
    end
    # This will hold the indices for each gifter as well as how many options the gifter has
    row_options=Array.new
    # Run through the matrix
    for i in 0..gift_matrix.row_count-1 do
      # Add up each matrix row. This is the number of options, stored next to the index
      row_options << [gift_matrix.row(i).inject(:+),i]
    end
    # Shuffle the array, then sort by options in ascending order
    row_options=row_options.shuffle.sort_by(&:first)
    # Pick the first index of the array
    current_gifter=row_options.first.last
    # This will store the available recipients
    ones=Array.new
    # Run through the row of the selected gifter
    gift_matrix.row(current_gifter).each_with_index do |recipient,index|
      # Figure out the candidate recipients, save the row index
      ones << index if recipient==1
    end
    # Randomly pick the recipient
    current_recipient=ones[rand(0..ones.length-1)]
    # Assign the values into the hash
    finalset[gifters[current_gifter]]=recipients[current_recipient]
  else
    # If there's only one option left, choose it
    finalset[gifters.first]=recipients.first
  end
  # Remove the array elements for the already-selected
  gifters.slice!(current_gifter)
  recipients.slice!(current_recipient)
end

#THIS IS IT!
group=Group.find(group_id)
gifters=group.santa.map(&:id)
recipients=group.santa.map(&:id)
finalset=Hash.new
flag=false
until flag
  dimensions=gifters.length
  if dimensions > 1
    gift_matrix=Matrix.build(dimensions, dimensions) do |row,col|
      if gifters[row]==recipients[col]
        0
      elsif (group.rules.where gifter: group.santa.find(gifters[row]).name, recipient: group.santa.find(recipients[col]).name).any?
        0
      else
        1
      end
    end
    row_options=Array.new
    for i in 0..gift_matrix.row_count-1 do
      row_options << [gift_matrix.row(i).inject(:+),i]
    end
    row_options=row_options.shuffle.sort_by(&:first)
    current_gifter=row_options.first.last
    ones=Array.new
    gift_matrix.row(current_gifter).each_with_index do |recipient,index|
      ones << index if recipient==1
    end
    current_recipient=ones[rand(0..ones.length-1)]
    finalset[gifters[current_gifter]]=recipients[current_recipient]
    gifters.slice!(current_gifter)
    recipients.slice!(current_recipient)
  else
    finalset[gifters.first]=recipients.first
    flag=true
  end
end

