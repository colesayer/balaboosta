namespace :calculate do
  namespace :tourguide do
    desc 'Calculates TourGuide Payments'
    task payments: :environment do
      Tour.past.find_each do |tour|
        calculate = CalculateTourguidePayments.new(tour)
        amount = calculate.calculate_payment
        user_id = calculate.get_user_id

        payment = Payment.new(amount: amount, user_id: user_id[0], tour_id: tour.id)
        if payment.save
          #update tour to show invoice created
          puts "Created payment."
        else
          puts "Error creating payment."
        end
      end
    end
  end

  namespace :booking do
    desc 'Calculates Booking Payments'
    task :payments do
      puts "calculating booking payments"
    end
  end
end
