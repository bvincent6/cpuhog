#!/usr/bin/ruby

require 'fileutils'
require 'json'
require 'sinatra'
require 'socket'

require './pidigits.rb'


appdir = File.dirname(File.expand_path('.', __FILE__))

configs = JSON.parse(File.open("#{appdir}/config.json").read)

# Get IP address

version = configs['version']


message = ENV["CPUHOG_MESSAGE"] || message = configs['message']
pidigits_num = ENV["CPUHOG_PIDIGITS"] || pidigits_num = configs['number_of_digits']
listen_port = ENV["CPUHOG_SINATRA_PORT"] || sinatra_port = configs['sinatra_port']

set :bind, '0.0.0.0'
set :lock, true
set :port, sinatra_port

get '/calc' do
  getout = {
      "digits" => pidigits_num,
      "version" => version,
      "message" => message,
      "ip_addresses" => []
  }

  Socket.ip_address_list.each do |addr_info|
    getout['ip_addresses'].push(addr_info.ip_address)
  end

  t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  PiRun::run(pidigits_num)
  t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  time = ((t2 - t1) * 1000).round(3)

  getout['report'] = "Calculated #{pidigits_num} digits of Pi in #{time} " +
      "milliseconds!"

  JSON.pretty_generate(getout)
end

get '/status' do
  "UP"
end