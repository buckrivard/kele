module Roadmap
	BASE_URI = 'https://www.bloc.io/api/v1'

	def get_roadmap(roadmap_id)
		response = self.class.get(BASE_URI + "/roadmaps/#{roadmap_id}", headers: {"authorization" => @auth_token })
		JSON.parse(response.body)
	end

	def get_checkpoint(checkpoint_id)
		response = self.class.get(BASE_URI + "/checkpoints/#{checkpoint_id}", headers: {"authorization" => @auth_token })
		JSON.parse(response.body)["body"]
	end

end