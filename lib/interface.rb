# Gift array element example:
# {
#   name: 'Puzzle',
#   bought: false
# }
#
# === Pseudocode ===
# Welcome the user
# Set gift list as empty array
# Ask user to choose an action
# Get user input and store it as user action
# Loop until user action is 'quit':
#   If user action is 'add':
#     Ask user to input a new gift
#     Get user input
#     Add it to the gift list
#   Else if user action is 'list':
#     For each item in the gift list:
#       Display it
#   Else if user action is 'delete':
#     List all gifts (with index)
#     Ask the user which item to delete (index!)
#     Get user input (index)
#     Delete the gift at the chosen index
#   Else if user action is 'mark':
#     List all gifts (with index)
#     Ask the user which item to mark (index!)
#     Get user input (index)
#     Mark the item as bought
#   Else if user action is 'idea':
#     Ask user what to search for
#     Get user input and store it as search term
#     Search Etsy for the search term
#     Prepare an array of item names
#     Display all items with index (iterate)
#     Ask user to choose an index
#     Get index and store it
#     Get gift from item list, by user's chosen index
#     Add item to the gift list
#     Display message saying what was added
#   Ask user to choose an action
#   Get user input and store it as user action
# End
# Say goodbye

require_relative './scraper'

def user_choice
  puts "\n----------------------"
  puts 'Please choose your action:'
  puts '(add | list | delete | mark | idea | quit)'
  gets.chomp
end

def list(gifts)
  gifts.each_with_index do |gift, index|
    bought_string = gift[:bought] ? 'X' : ' '
    puts "#{index + 1}. [#{bought_string}] #{gift[:name]}"
  end
end

def user_index(gifts)
  list(gifts)
  puts "Please enter the number of the gift:"
  gets.chomp.to_i - 1
end

def add(gifts)
  puts "Please enter your gift"
  gift = gets.chomp
  gifts << { name: gift, bought: false }
end

def delete(gifts)
  index = user_index(gifts)
  gifts.delete_at(index)
end

def mark(gifts)
  index = user_index(gifts)
  # in one line:
  # gifts[index][:bought] = true

  # in two lines:
  gift = gifts[index] # a hash!
  gift[:bought] = true unless gift.nil?
end

def idea(gifts)
  puts 'What would you like to search Etsy for?'
  search_term = gets.chomp
  # results: an array of hashes! (the search results from Etsy)
  results = search_etsy(search_term)
  index = user_index(results)
  new_gift = results[index]
  gifts << new_gift
  puts "Added #{new_gift[:name]} to your gift list"
end

gifts = [
  {
    name: 'wine',
    bought: false
  },
  {
    name: 'dress',
    bought: false
  },
  {
    name: 'laptop',
    bought: true
  }
]

puts 'Welcome to your shopping list'
user_action = user_choice
until user_action == 'quit'
  case user_action
  when 'add' then add(gifts)
  when 'list' then list(gifts)
  when 'delete' then delete(gifts)
  when 'mark' then mark(gifts)
  when 'idea' then idea(gifts)
  else puts 'Please try again'
  end
  user_action = user_choice
end

puts 'Bye!'
