namespace :urls do
  desc "TODO"
  task prune: :environment do |minutes|
    ShortenedUrl.prune(minutes || 5)
  end

end
