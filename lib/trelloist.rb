require 'active_support'
require 'dotenv'
require 'thor'
require 'trello'

module Trelloist
  class Tasks < Thor
    desc 'create', 'Create checklist item on Trello'

    option :card_id, aliases: '-c', desc: 'trello card id', required: true
    option :name, aliases: '-n', desc: 'name of the checklist', required: true

    def create(names)
      card_id = options[:card_id]
      card    = Trello::Card.find(card_id)

      checklist      = ActiveSupport::JSON.decode(card.create_new_checklist options[:name])
      real_checklist = Trello::Checklist.find checklist['id']

      new_items = names.split("\n")
      new_items.each do |item_name|
        begin
          p "ADDING #{item_name.strip}"
          real_checklist.add_item item_name.strip
        rescue Trello::Error
          next
        end
      end

      p "Added new checklist #{options[:name]} to card #{card.name} with #{new_items.count} items"
    end

    desc 'boards', 'list boards'
    def boards
      Trello::Board.all
        .select { |board| !board.closed }
        .each   { |board| p [board.name, board.id] }
    end

    option :board_id, aliases: '-b', desc: 'trello board id', required: true

    desc 'cards', 'List cards of the specified board'
    def cards
      board = Trello::Board.find(options[:board_id])
      board.cards.each { |card| p [card.name, card.id] }
    end

    desc 'reset', 'reset checklists on a given card'

    option :card_id, aliases: '-c', desc: 'trello card id', required: true
    option :except, aliases: '-e', desc: 'card ids to skip', required: false, type: :array

    def reset
      card_id = options[:card_id]
      card    = Trello::Card.find(card_id)

      card.checklists.each do |checklist|
        # p "#{checklist.name} : #{checklist.id}"
        next if options[:except].to_a.include?(checklist.id)

        checklist.items.each do |item|
          checklist.update_item_state(item.id, 'incomplete')
        end
      end
    end
  end
end
