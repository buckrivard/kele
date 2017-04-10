require 'httparty'
require 'pry'
require './lib/roadmap.rb'

class Kele
	include HTTParty
	include Roadmap
	BASE_URI = 'https://www.bloc.io/api/v1'

	def initialize(email, password)
		@email = email
		@password = password
		retrieve_auth_token
	end

	def get_me
		retrieve_auth_token
		response = self.class.get(BASE_URI + '/users/me', headers: {"authorization" => @auth_token })
		JSON.parse(response.body)
	end

	def get_mentor_availability
		mentor_id = get_mentor_id
		response = self.class.get(BASE_URI + "/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token })
		JSON.parse(response.body).each { |slot| puts slot }
	end

	private

	def get_mentor_id
		get_me["current_enrollment"]["mentor_id"].to_i
	end

	def retrieve_auth_token
		options = {
			body: {
				email: @email,
				password: @password
			}
		}

		response = self.class.post(BASE_URI + '/sessions', options)
		@auth_token = response['auth_token']
	end
end