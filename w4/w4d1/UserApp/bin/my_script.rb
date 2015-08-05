require 'addressable/uri'
require 'rest-client'

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users?var1=val2'
# ).to_s

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1',
# ).to_s
#
# puts RestClient.get(url)

def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/3'
  ).to_s

  puts RestClient.patch(
    url, {contact: {name: "Josh", email: "josh@gmail.com"}} )
end

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts'
  ).to_s

  puts RestClient.post(
    url, {contact: {name: "Abe", email: "abe@gmail.com", user_id: 4}} )
end

def delete_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/2'
  ).to_s

  puts RestClient.delete(
    url)
end

def show_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/3'
  ).to_s

  puts RestClient.get(
    url)
end

def index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1/contacts'
  ).to_s

  puts RestClient.get(
    url)
end

def create_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares'
  ).to_s

  puts RestClient.post(
    url, {contact_share: {contact_id: 3, user_id: 1}} )
end

def delete_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares/1'
  ).to_s

  puts RestClient.delete(
    url)
end

# update_contact
# delete_contact
# create_contact
# show_contact
index
# create_contact_share
delete_contact_share
