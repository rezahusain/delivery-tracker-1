desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  User.destroy_all
  Package.destroy_all

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save

    10.times do
      packages = Package.new
      packages.user_id = user.id
      packages.description = Faker::Commerce.product_name
      packages.details = "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}" if rand < 0.5
      packages.arrives_on = Faker::Date.between(from: 1.month.ago, to: 2.weeks.from_now)

      if packages.arrives_on < Time.now
        packages.is_received = [true, false].sample
      else
        packages.is_received = false
      end

      packages.save
    end
  end
end
