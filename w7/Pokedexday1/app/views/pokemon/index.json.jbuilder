json.array!(@pokemon) do |poke|
  json.partial!("pokemon", pokemon: poke)
end
