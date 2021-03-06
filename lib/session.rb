require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    our_cookie = req.cookies["_rails_lite_app"]
    if our_cookie.nil?
      @deserialized_cookie = {}
    else
      @deserialized_cookie = JSON.parse(our_cookie)
    end
  end

  def [](key)
    @deserialized_cookie[ key ]
  end

  def []=(key, val)
    @deserialized_cookie[ key ] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app',{path: "/", value: @deserialized_cookie.to_json})
  end
end
