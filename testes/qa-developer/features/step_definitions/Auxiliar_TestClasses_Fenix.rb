module Dictionary
  # Language Options
  PORTUGUESE = 0
  ENGLISH = 1
  SPANISH = 2

  # Trip Options
  ONE_WAY = 0
  ROUNDTRIP = 1
  CONNECTION = 2
  ONE_STOP = 3

  # Buyer Types
  INDIVIDUAL = 0
  COMPANY = 1
  FOREIGNER = 2

  # Payment Types
  CREDIT = 0
  DEBIT = 1
  PAYPAL = 2
  BANKSLIP = 3
end

module TestSettingsFenix
  class RobotTesterFenix
    attr_accessor :language
    attr_accessor :buyerType
    attr_accessor :passengerQuantity
    attr_accessor :trip
    attr_accessor :paymentType
    attr_accessor :paymentMethod
    attr_accessor :installments
    attr_accessor :randomRoute
    attr_accessor :origin
    attr_accessor :destination
    attr_accessor :departure
    attr_accessor :return_
    attr_accessor :insurance
    attr_accessor :mock
    attr_accessor :debug
    attr_accessor :voucher

    def readSettings
      settings = ENV['SETTINGS'] || 'testSettings'
      parameters = settings
      settings += '.json'

      filepath = "./features/step_definitions/data/#{settings}"

      if File.exist?(filepath)
        file = File.read(filepath)
      else
        file = createSettings(parameters)
      end
      data_hash = JSON.parse(file)
    end

    def readEnv
      env = ENV['ENV']

      filepath = './features/step_definitions/data/environment.json'
      file = File.read(filepath)
      data_hash = JSON.parse(file)
      $url = data_hash[env.upcase]['URL']
      $environment = env
    end

    def setDepartureDate(departureDate)
      regexValidator = %r{(([0])([1-9])|([1-2])([0-9])|([3])([0-1]))/(([0])([1-9])|([1])([0-2]))/20(1([5-9])|2([0-9]))}
      departureDayRegexValidator = /^([0])([0-9])|([1-8])([0-9])|([9])([0])$/
      if regexValidator.match(departureDate)
        validDate = true
        dateArray = departureDate.split('/')

        day = dateArray[0].to_i
        month = dateArray[1].to_i
        year = dateArray[2].to_i

        case month
        when 1, 3, 5, 7, 8, 10, 12
          validDate = false if day > 31
        when 4, 6, 9, 11
          validDate = false if day > 30
        when 2
          if Date.gregorian_leap?(year)
            validDate = false if day > 29
          else
            validDate = false if day > 28
          end
        else
          raise "Wait, did you just break my super sophisticated safety measures? I'm at a loss for what to do!"
        end

        if validDate
          @departureDate = departureDate
        else
          raise "Date format is correct, but the Date itself doesn't exist!"
        end
      elsif departureDayRegexValidator.match(departureDate)
        numericDepartureDate = Date.today + departureDate.to_i
        @departureDate = "#{numericDepartureDate.mday}/#{numericDepartureDate.month}/#{numericDepartureDate.year}"
      else
        raise "Enter a valid date in the format DD/MM/YYYY or an integer number of days to be added to today's date."
      end
    end

    def setReturnDate(returnDate)
      settings = readSettings

      dateRegexValidator = %r{^(([0])([1-9])|([1-2])([0-9])|([3])([0-1]))/(([0])([1-9])|([1])([0-2]))/20(1([5-9])|2([0-9]))$}
      returnDayRegexValidator = /^([0])([0-9])|([1-8])([0-9])|([9])([0])$/

      departureDateArray = setDepartureDate(settings['departure']).split('/')
      departureDay = departureDateArray[0].to_i
      departureMonth = departureDateArray[1].to_i
      departureYear = departureDateArray[2].to_i

      if dateRegexValidator.match(returnDate)
        validDate = true
        dateArray = returnDate.split('/')

        day = dateArray[0].to_i
        month = dateArray[1].to_i
        year = dateArray[2].to_i

        case month
        when 1, 3, 5, 7, 8, 10, 12
          validDate = false if day > 31
        when 4, 6, 9, 11
          validDate = false if day > 30
        when 2
          if Date.gregorian_leap?(year)
            validDate = false if day > 29
          else
            validDate = false if day > 28
          end
        else
          raise "Wait, did you just break my super sophisticated safety measures? I'm at a loss for what to do!"
        end

        if departureYear > year
          raise 'Departure date year is later then return date year!'
        elsif departureYear == year
          if departureMonth > month
            raise 'Departure date month is later then return date month!'
          elsif departureMonth == month
            if departureDay > day
              raise 'Departure date day is later then return date day!'
            end
          end
        end

        if validDate
          @returnDate = returnDate
        else
          raise "Date format is correct, but the Date itself doesn't exist!"
        end
      elsif returnDayRegexValidator.match(returnDate)
        numericReturnDate = Date.new(departureYear, departureMonth, departureDay) + returnDate.to_i
        @returnDate = "#{numericReturnDate.mday}/#{numericReturnDate.month}/#{numericReturnDate.year}"
      else
        raise 'Enter a date in the format DD/MM/YYYY or an integer number of days to be added to the departure date.'
      end
    end
  end
end
