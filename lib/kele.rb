require 'httparty'
require 'pry'

class Kele
	include HTTParty
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

	def get_mentor_availability(mentor_id)
		retrieve_auth_token
		response = self.class.get(BASE_URI + "/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token })
		JSON.parse(response.body, :array_class => true)
		binding.pry
	end

	private

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