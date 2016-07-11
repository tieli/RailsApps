# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

Article.delete_all()

delimit_str = "----------------"

def fetch_block
	open('http://textfiles.com/internet/zines5.txt') { |f| 
		start = false
		block = ""
		f.each_line do |line| 
			if not start and line.start_with?("----------------")
				start = true
				next
			end
			if start
				if line.start_with?("--------------------")
					yield block
					block = ""
				else 
					block = block + line
				end
			end
		end
	}
end

fetch_block do |block|
	lines = block.split("\n")
	# first line should be empty line
	# if not continue
	if lines[0] =~ /\w+/
		next
	end
	title = lines[1]
	content = block
	if rand() > 0.2
		hidden = true
	else
		hidden = false
	end
	Article.create! title: title, content: content, published_at: rand_time(10.years.ago), hidden: hidden
end

