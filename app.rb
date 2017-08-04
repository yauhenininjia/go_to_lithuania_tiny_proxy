#! /usr/bin/env ruby

require 'sinatra'
require 'json'
require 'rest-client'
require 'pry'

EVAS_URL = 'https://evas2.urm.lt/calendar/json'
DEFAULT_EMBASSY = 3
DEFAULT_VISITORS_COUNT = 2
DEFAULT_VISIT_TYPE = 6
USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'

RestClient.log = 'stdout'

get '/' do
  'Go to Lithuania!'
end

get '/free_dates' do
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
    params: request_params,
    user_agent: USER_AGENT
  }
  result = RestClient::Request.execute(method: :get, url: EVAS_URL, headers: headers).body
  result.sub!(/^\n/, '')

  result
end
