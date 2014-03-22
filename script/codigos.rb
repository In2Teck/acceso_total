#!/usr/bin/env ruby
require_relative "../config/environment"
entrada = File.open(ARGV[0])
id = 0

entrada.each_line{|codigo|
	botella = Bottle.new
	botella.id = id+1
	botella.code = codigo
	botella.created_at=Date.today
	botella.updated_at=Date.today
	botella.save
}

entrada.close