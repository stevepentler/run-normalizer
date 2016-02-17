class User < ActiveRecord::Base

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], user_id: auth['info']['id'])
    user.email = auth['info']['email']
    user.token = auth['credentials']['token']
    user.username = auth['info']['username']
    user.display_name = auth['info']['display_name']
    user.state = auth['info']['location']['region']
    user.height = auth['info']['height']
    user.weight = auth['info']['weight']
    user.gender = auth['info']['gender']
    user.birthday = auth['info']['birthdate']

    user.save
    return user 
  end
end
