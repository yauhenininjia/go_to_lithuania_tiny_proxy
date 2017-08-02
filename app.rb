#! /usr/bin/env ruby

require 'sinatra'
require 'json'
require 'rest-client'
require 'pry'

EVAS_URL = 'https://evas2.urm.lt/calendar/json'
DEFAULT_EMBASSY = 3
DEFAULT_VISITORS_COUNT = 2
DEFAULT_VISIT_TYPE = 6

get '/' do
  'Go to Lithuania!'
end

get '/get_dates' do
  embassy = params[:_aby] || DEFAULT_EMBASSY
  visitors_count = params[:_c] || DEFAULT_VISITORS_COUNT
  visit_type = params[:_cry] || DEFAULT_VISIT_TYPE

  request_params = {
    _d: '',
    _aby: embassy,
    _cry: visit_type,
    _c: visitors_count,
    _t: ''
  }
  headers = {
    accept: 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
    params: request_params
  }
  result = RestClient::Request.execute(method: :get, url: EVAS_URL, headers: headers).body
  result.sub!(/^\n/, '')

  result
end
