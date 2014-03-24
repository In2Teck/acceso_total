#!/usr/bin/env ruby
require_relative "../config/environment"
entrada = File.open(ARGV[0])

entrada.each_line{|codigo|
	botella = Bottle.new
	botella.code = codigo[0, 8]
	botella.created_at=Date.today
	botella.updated_at=Date.today
	botella.save
}

entrada.close