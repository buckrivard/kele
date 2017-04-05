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