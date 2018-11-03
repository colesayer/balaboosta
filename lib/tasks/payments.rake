namespace :calculate do
  namespace :tourguide :environment do
    desc 'Calculates TourGuide Payments'
    task :payments do
      puts Tour.all
    end
  end

  namespace :booking do
    desc 'Calculates Booking Payments'
    task :payments do
      puts "calculating booking payments"
    end
  end
end
