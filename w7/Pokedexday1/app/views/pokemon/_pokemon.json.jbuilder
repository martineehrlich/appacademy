json.extract!(pokemon, :id, :attack, :defense, :image_url, :moves, :name, :poke_type)

toys ||= nil

unless toys.nil?
  json.toys(toys) do |toy|
    json.partial!("toys/toy", toy: toy)
  end
end
