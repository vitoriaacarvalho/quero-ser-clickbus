class Desktop
  include Capybara::DSL

  def initialize
    @logged = false
  end

  def fill_search()
      
    # Aqui você deverá implementar a função para preencher os dados de origem e destino da viagem

  end

  def CheckHeaderSearch(siteName)
    siteName = siteName.split(' ')[0].downcase
    within 'header' do
      logo = find('a.col.l2')
      logo_href = logo['href'].include? '/'
      logo = find('img')
      logo_title = logo['src'].downcase.include? siteName
      raise 'Logo' unless logo_href && logo_title
      raise 'Search Button' if first('button.search-btn.btn-secondary.btn-small').nil?
    end
  rescue Exception => e
    raise 'Header Search Error: ' + e.to_s
  end

  def CheckResults(siteName)
    numGen = Random.new
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    within(search_results_list) do
      searchResults = all('.search-item', minimum: 1)
      within(searchResults[numGen.rand(searchResults.length)]) do
        within('div.bus-stations') do
          departure_site = find('span.station-departure').text
          departue_place = $place1.split(',')[0]
          raise 'Wrong Departure' unless departure_site.include? departue_place
          destination_site = find('span.station-arrival').text
          destination_place = $place2.split(',')[0]
          raise 'Wrong Destination' unless destination_site.include? destination_place
        end
      end
    end
  rescue Exception => e
    raise 'Results Error: ' + e.to_s
  end

  def SelectCompanybyslug(siteName)
    numGen = Random.new
    results_item = '.search-item'
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    within(search_results_list) do
        position = numGen.rand(results_item.length)
        puts position
        @company = all('div.company')[position]['data-name']
        puts @company
        data = all(results_item)[position]['data-content']
        @companySelected =  data.split('companySlug":"')[1].split('","departureDate"')[0]
        puts @companySelected
        puts current_url 
        filteredURL = current_url + '/' + @companySelected
        puts filteredURL
        visit filteredURL
        sleep 2
    end
  end

  def CheckFilterbyCompany(siteName)
    results_item = '.search-item'
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    within(search_results_list) do 
      searchResults = all(results_item, minimum: 1)
      for i in 0..all(results_item).length - 1
          filteredCompany = all('div.company')[i]['data-name']
          puts filteredCompany
          puts @company
          raise if filteredCompany != @company 
      end
    end
  end

  def CheckDateSearch(siteName)
    puts "Departure Date: #{$dateGlobal}"
    date_itens = $dateGlobal.split('/')
    date = ''
    date = date + date_itens[2] + '-'
    date += '0' if date_itens[1].to_i < 10
    date = date + date_itens[1] + '-'
    date += '0' if date_itens[0].to_i < 10
    date += date_itens[0]
    ticket_dep_date = all('time.departure-time')
    ticket_dep_date.each do |item|
      raise 'Ticket Date Error' if item['data-date'] != date
    end
  end

  def CheckFiltersSearch(siteName)
    class_div = 'div.filter-result-unit.unit-service-class'
    departure_station_div = 'div.filter-result-unit.unit-station-departure'
    arrival_station_div = 'div.filter-result-unit.unit-station-arrival'
    filter_options = 'div.search-filter-item'
    begin
      # Filtro Horario Saida
      within('#departureTime') do
        @filter_item = all('small')
      end
      for i in 0...(@filter_item.length)
        puts 'Filtrado Horario Saida: ' + @filter_item[i].text
        @filter_item[i].click
        time = @filter_item[i].text.tr('h', ':')
        time = time.delete! '()'
        time1 = Time.parse(time.split(' ')[0])
        time2 = Time.parse(time.split(' ')[2])
        ticket_item = all('time.departure-time')
        ticket_item.each do |item|
          tick_dep_time = Time.parse(item['data-time'])
          puts tick_dep_time
          if tick_dep_time < time1 || tick_dep_time > time2
            puts "#{tick_dep_time} is not between #{time1} and #{time2}"
            raise 'Departure Time Filter'
          end
        end
        @filter_item[i].click
      end
      # Filtro Classe
      within class_div do
        @filter_item = all(filter_options)
      end
      for i in 0..(@filter_item.length - 1)
        puts 'Filtro Classe: ' + @filter_item[i].text
        @filter_item[i].click
        ticket_item = all('span.service-class')
        ticket_item.each do |item|
          if item.text != @filter_item[i].text
            puts "#{item.text} !=  #{@filter_item[i].text}"
            raise 'Class Filter'
          end
        end
        @filter_item[i].click
      end
      # Filtro Terminal de Saida
      within departure_station_div do
        @filter_item = all(filter_options)
      end
      for i in 0..(@filter_item.length - 1)
        puts 'Filtrado Terminal Saida: ' + @filter_item[i].text
        @filter_item[i].click
        ticket_item = all('span.station-departure')
        ticket_item.each do |item|
          if item.text != @filter_item[i].text
            puts "#{item.text} !=  #{@filter_item[i].text}"
            raise 'Departure Station Filter'
          end
        end
        @filter_item[i].click
      end
      # Filtro Terminal de Chegada
      within arrival_station_div do
        @filter_item = all(filter_options)
      end
      for i in 0..(@filter_item.length - 1)
        puts 'Filtrado Terminal Chegada: ' + @filter_item[i].text
        @filter_item[i].click
        ticket_item = all('.station-arrival')
        ticket_item.each do |item|
          if item.text != @filter_item[i].text
            puts "#{item.text} !=  #{@filter_item[i].text}"
            raise 'Arrival Station Filter'
          end
        end
        @filter_item[i].click
      end
    rescue Exception => e
      raise 'Filter Error: ' + e.to_s
    end
  end

  def checkTerminalsInformations(siteName)
    within('div#terminal-details') do
      settings = $ted.readSettings
      find('div.container').find('h2')
      raise unless $place1 != all('span')[0]
      raise unless $place2 != all('span')[1]
    end
  end

  def fill_searchcustom(siteName)
    search_box = '.search-widget.search-widget-vertical'
    input_departure = '.origin-place.tt-input'
    input_dest = '.destination-place.tt-input'
    ori_text = 'widget-vertical-origin-place'
    dest_text = 'widget-vertical-destination-place'
    settings = $ted.readSettings
    origin_place = settings['origin']

    $searchOrig = Search.new(search_box, input_departure, ori_text)
    $searchOrig.fill_field(origin_place)

    $searchDest = Search.new(search_box, input_dest, dest_text)
    $searchDest.fill_field(origin_place)
  end

  def fill_login(siteName)
    passengers = $ted.readCharacter(siteName)
    email = passengers['0']['email']
    password = passengers['0']['password']
    $login = Login.new
    $login.fill_form(email, password)
    @logged = true
  end

  def enter
    enter_button = '.btn-primary.btn-main-cta.btn-login'
    find(enter_button).click
  end

  def login
    login_button = '#header-login-btn'
    find(login_button).click
  end

  def logo
    logo_link = '.brand-logo'
    find(logo_link).click
  end

  def CheckLogo(siteName)
    siteName = siteName.split(' ')[0].downcase
    within 'header' do |_variable|
      begin
        logo_src = find('img')['src'].downcase
        logo_src.include? siteName
      rescue Exception => e
        raise 'Header Error: ' + e.to_s
      end
    end
  end

  def logout
    find('.user-menu-btn').click
    logout_button = '#header-user-action-logout'
    find(logout_button).click
    find('#header-login-btn')
    @logged = false
  end

  def register
    within('div.account-box.row') do
      find('div.info.right.col.l12').find('a', :text => 'Cadastre-se').click
      generateEmail()
      puts 'New email address: ' + @email
      find('input#name').send_keys  @name
      find('input#email').send_keys @email
      find('input#password').send_keys @password
      find('input#repeat-password').send_keys @password
      find('button.btn-primary.btn-main-cta').click
    end 
    within('div.account-wrapper') do
      raise unless find('div.account-box.account-sign-up-link-sent')
    end
  end

  def generateEmail()
    data = $ted.readBackofficeUser('valid')
    numGen = Random.new
    dataIndex = numGen.rand(data.length).to_s
    @name = data[dataIndex]['name']
    email = data[dataIndex]['email']
    @password = data[dataIndex]['resetPassword']
    timestamp = DateTime.now.to_time.to_s.gsub(' ', '').delete(':')
    @email = email.split('@')[0] + "+#{timestamp}@" + email.split('@')[1]
  end

  def check_heading
    head_1 = 'div > h1.heading'
    raise 'Não estou na página da Minha Conta' unless find(head_1).text === 'Minha conta'
    sleep 5
  end

  def edit_name
    input_name = 'name'
    save_button = 'button.btn-primary'
    @new_name = 'Jean QA ' + Time.now.strftime('%d%m%Y %H%M%S').to_s

    fill_in input_name, with: @new_name
    find(save_button).click
    sleep 1
  end

  def card_last4(card_number)
    card_number = card_number.delete! ' '
    card_size = card_number.length
    card_number = card_number[card_size - 4..card_size]
    card_number
  end

  def click_payms(btnName, siteName)
    creditInfo = $ted.readCreditInfo('Credit', siteName)
    card_set = card_last4(creditInfo['card_number'])
    cards = all('div.payment-method')
    case btnName
    when 'Favoritar'
      for i in 0..cards.length
        begin
          within(cards[i]) do
            find('div.row.card-info')
            card_saved = find('div.payment-card-number')
            if card_set == card_last4(card_saved.text)
              find('span.payment-method-favourite').click unless first('i.icon-heart-f')
              return
            end
          end
        rescue Exception => e
          raise "Could not find 'Favoritar' button. Verify if a saved card exists. " + e.to_s
        end
      end
    when 'Excluir'
      begin
        within(cards[0]) do
          @card_deleted = card_last4(find('div.payment-card-number').text)
          find('.payment-method-delete').click
        end
      rescue Exception => e
        raise "Could not find 'Excluir' button. Verify if a saved card exists. " + e.to_s
      end
      puts 'Card deleted: ' + @card_deleted
    when 'Adicionar'
      add_button = first('a', text: btnName)
      add_new_button = first('i.icon-plus-circle')
      add_button.nil? ? add_new_button.click : add_button.click
    else
      find('a', text: btnName).click
    end
  end

  def check_favcard(siteName)
    creditInfo = $ted.readCreditInfo('Credit', siteName)
    card_set = card_last4(creditInfo['card_number'])
    cards = all('div.payment-method')

    for i in 0..cards.length
      begin
        within(cards[i]) do
          card_saved = find('div.payment-card-number')
          if card_set == card_last4(card_saved.text)
            find('i.icon-heart-f')
            return
          end
        end
      rescue Exception => e
        raise 'Could not find favorite card. ' + e.to_s
      end
    end
  end

  def check_delcard(siteName)
    find('p.alert-message', text: 'Cartão removido')
    cards_saved = all('div.payment-card-number')
    begin
      cards_saved.each do |card_saved|
        return if @card_deleted == card_last4(card_saved.text)
      end
    rescue Exception => e
      raise 'Card was not deleted. ' + e.to_s
    end
  end

  def check_paymspage(titleName)
    find('h1', text: titleName)
  end

  def fill_cardform(siteName)
    creditInfo = $ted.readCreditInfo('Credit', siteName)
    begin
      find('h1', text: 'Novo cartão de crédito')
      fill_in('card-number', with: creditInfo['card_number'])
      fill_in('card-expiration-date', with: creditInfo['expiration_month'] + creditInfo['expiration_year'][-2..-1])
      fill_in('card-security-code', with: creditInfo['cvv'])
      fill_in('card-holder-name', with: creditInfo['card_holder'])
      fill_in('card-document-number', with: creditInfo['holder_id'])
      fill_in('card-zipcode', with: creditInfo['zipcode'])
      find('button', text: 'Salvar').click
      sleep 2
      find('p.alert-message', text: 'Novo cartão adicionado')
    rescue Exception => e
      raise 'Error filling credit card fields. ' + e.to_s
    end
  end

  def check_card(siteName)
    sleep 2
    creditInfo = $ted.readCreditInfo('Credit', siteName)
    card_set = card_last4(creditInfo['card_number'])
    #binding.pry
    cards_saved = all('div.payment-card-number')
    begin
      for i in 0..cards_saved.length
        puts 'card: '
        puts card_last4(cards_saved[i].text)
        puts card_set
        return if card_set == card_last4(cards_saved[i].text)
      end
    rescue Exception => e
      raise 'Settings Card is not saved ' + e.to_s
    end
  end

  def check_newcard
    alert_div = find('#success-create-payment-method')
    raise 'Não foi possivel adicionar cartao' unless alert_div.text == 'Novo cartão adicionado'
  end

  def checkFacebookRedirect
    within('div.social-login.col.l12') do
      facebook_window = window_opened_by { find('a.social-login-btn.facebook-btn').click }
      within_window facebook_window do
        raise unless page.current_url.include? 'https://www.facebook.com/login'
      end
    end
  end

  def checkActivatedAccount
    within('div.account-wrapper') do
      raise unless find('div.alert.alert-success.small')
      find('input#email').send_keys @email
      find('input#password').send_keys @password
      find('button.btn-primary.btn-main-cta.btn-login').click
      sleep 5
    end
  end

  def changePassword(siteName)
    data = $ted.readCharacter(siteName)
    password = data['0']['password']
    within('div.reset-password.customer-box') do
      find('input#password').send_keys password
      find('input#repeat-password').send_keys password
      find('button.btn-primary.btn-big.btn-save-password').click 
    end
  end

  def clickForgotPass
    within('div.account-box.row') do
      find('a.forgot-password.bt-data-layer').click
    end
  end

  def fillEmail(siteName)
    within('div.account-box.row') do
      data = $ted.readCharacter(siteName)
      email = data['0']['email']
      find('input#email').send_keys email
      find('button.btn-primary.btn-main-cta').click
      raise unless find('div.reset-password-link-sent')
    end
  end

  def check_storecardform
    find('h1', text: 'Novo cartão de crédito')
    find('input#card-number')
    find('input#card-expiration-date')
    find('input#card-security-code')
    find('input#card-holder-name')
    find('input#card-document-number')
    find('input#card-zipcode')
    find('button', text: 'Salvar')
  end

  def check_alert
    alert_div = 'div.alert.alert-success'
    raise 'Não foi possivel editar os dados do usuario' unless find(alert_div).text == 'Dados alterados com sucesso'
  end

  def check_name
    input_name = 'input#name'
    raise 'Nome não foi alterado!' unless find(input_name).value == @new_name
  end

  def accessFromSideMenu(titleName)
    find('a.user-menu-btn').click
    find('a', text: titleName).click
  end

  def verifyCloseDate(siteName)
    begin
      while find('div.search-results-wrapper').find('div.search-result-list')
        selectNextTab
      end
    rescue 
      find('div.no-results')
      within('div.content') do
        all('a.btn-primary.suggest-btn:not(.disabled)')[0].click
      end
    end
  end

  def selectNextTab
    within(all('ul.date-tabs.tabs-fixed-width')[0]) do
      all('li.date-tab:not(.activated)')[0].click
    end
  end

  def fill_hori_search
    search_box = '.search-widget.search-widget-horizontal'
    input_departure = '.origin-place.tt-input'
    input_dest = '.destination-place.tt-input'
    ori_text = 'widget-horizontal-origin-place'
    dest_text = 'widget-horizontal-destination-place'
    settings = $ted.readSettings
    origin_place = settings['origin']
    dest_place = settings['destination']

    $searchHoriOrig = Search.new(search_box, input_departure, ori_text)
    $searchHoriOrig.fill_field(origin_place)

    $searchHoriDest = Search.new(search_box, input_dest, dest_text)
    $searchHoriDest.fill_field(dest_place)
  end

  def fill_calendar
    departure_date_form = 'input#widget-vertical-departure-date'
    settings = $ted.readSettings
    departure = settings['departure']
    departureDate = $ted.setDepartureDate(departure)

    $calendarDepart = Calendar.new(departure_date_form, departureDate)
    $calendarDepart.fill_departure_date

    trip = settings['trip']
    trip = trip.to_i

    if trip == Dictionary::ROUNDTRIP
      fields = all('.input-field.col')
      within(fields[2]) do
        label = all('label')
        label[1].click
      end
      return_date_form = 'input#widget-vertical-return-date'
      ret = settings['return']
      returnDate = $ted.setReturnDate(ret)

      $calendarReturn = Calendar.new(return_date_form, returnDate)
      $calendarReturn.fill_return_date
    end
  end

  def hori_calendar
    departure_date_form = 'input#widget-horizontal-departure-date'
    settings = $ted.readSettings
    departure = settings['departure']
    departureDate = $ted.setDepartureDate(departure)
    $calendarHoriDepart = Calendar.new(departure_date_form, departureDate)
    $calendarHoriDepart.fill_departure_date

    trip = settings['trip']
    trip = trip.to_i

    if trip == Dictionary::ROUNDTRIP
      return_date_form = 'input#widget-horizontal-return-date'
      ret = settings['return']
      returnDate = $ted.setReturnDate(ret)

      $calendarHoriReturn = Calendar.new(return_date_form, returnDate)
      $calendarHoriReturn.fill_return_date
    end
  end

  def searchButton
    search_button = 'button.search-btn'
    all(search_button)[0].click
  end

  def sortBy(filter)
    case filter
    when 'price'
      price_sort_btn = 'li.price.has-ordenation'
      find(price_sort_btn).click
      sleep 1
    when 'duration'
      duration_sort_btn = 'li.duration.has-ordenation'
      find(duration_sort_btn).click
      sleep 1
    when 'time'
      time_sort_btn = 'li.hour.has-ordenation'
      find(time_sort_btn).click
      sleep 1
      page.driver.browser.navigate.refresh
    end
  end

  def scroll_to(element)
    page.driver.execute_script('arguments[0].scrollIntoView(true);', element.native)
  end

  def selectETicketResult
    sleep 5
    results_item = '.boarding-pass-disclaimer'
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    begin
      within(search_results_list) do
        all(results_item, minimum: 1)
        puts first(results_item).text
      end
    rescue => e
      raise 'Error, e-ticket results not found! ' + e.to_s
    end
  end

  def selectNoETicketResult
    sleep 5
    results_item = '.boarding-pass-disclaimer'
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    begin
      within(search_results_list) do
        searchResults = all(results_item, maximum: 0)
        puts "Encontrados " + searchResults.length.to_s + " resultados com E-Ticket"
      end
    rescue => e
      raise 'Error, e-ticket results found! ' + e.to_s
    end
  end

  def verifyEticketCheckout
    within('div.disclaimer.boarding-pass.card') do
      raise unless find('i.icon.icon-printer')
      raise unless find('div.content')
      raise unless find('div.content').find('div.title', :text => 'Embarque Express')
      raise unless find('div.content').find('p')
    end
  end

  def selectResult(siteName)
    numGen = Random.new
    results_item = '.search-item'
    item_price = 'div.price'
    select_result = '.search-action-select'
    settings = $ted.readSettings
    trip = settings['trip'].to_i
    search_results_list = find('div.search-results-wrapper').find('div.search-result-list')
    @passengerQuantity = settings['passengerQuantity'].to_i

    begin
      within(search_results_list) do
        searchResults = all(results_item, minimum: 1)
        resultsCollectionSize = searchResults.length
        if trip == Dictionary::ONE_STOP || trip == Dictionary::CONNECTION
          for i in 0..resultsCollectionSize
            i = numGen.rand(resultsCollectionSize)
            next if all('div.service-class')[i].nil?
            next if all('div.search-action')[i].text == 'Esgotado'
            position = i 
            break if all('div.service-class')[i].text == 'Escala'
          end
        else
          for i in 0..resultsCollectionSize
            i = numGen.rand(resultsCollectionSize)
            next if all('div.service-class')[i].nil?
            next if all('div.search-action')[i].text == 'Esgotado'
            position = i 
            break if all('div.service-class')[i].text != 'Escala' 
          end
        end

        result_position = position
        within(searchResults[result_position]) do
          $searchresultsprice = find(item_price).all('span').last.text.split('R$')[1].gsub(/,/,'.')
          puts 'O preço da viagem na Search Results é: ' + $searchresultsprice
          scroll_to(find(select_result, visible: false))
          sleep 3
          find(select_result).click
          if trip == Dictionary::ROUNDTRIP || @passengerQuantity > 1
            @searchPriceAux = @searchPriceAux.to_f.round(2) + ($searchresultsprice.to_f * @passengerQuantity)
            @searchPriceAux = "%.2f" % @searchPriceAux
          end
        end
      end
    rescue Exception => e
      raise 'Error, results not found! ' + e.to_s
    end
  end

  def checkGtmClient(clientid, siteName)
    correctid = clientid
    if siteName.include?('ClickBus')
      correctgtm = 'GTM-N8G5NK'
    else
      correctgtm = 'GTM-MKT9C3F'
    end

    begin
      clientId = page.driver.evaluate_script("Desktop.Config.get('clientId')")
      gtm = page.driver.evaluate_script("Desktop.Config.get('trackingGtm').id")
      raise 'Error: ' unless correctid == clientId && correctgtm == gtm
      puts ('Client Id: ' + clientId + ' GTM: ' + gtm)
    rescue Exception => e
      raise 'Error in Clientid or GTM. ' + 'ClientId: ' + clientId + ' GTM: ' + gtm + ' ' + e.to_s
    end
  end

  def checkCompass(siteName)
    find('span.logo-no-results')
    find('.info-no-results').text.include?('não achamos resultados')
  rescue Exception => e
    raise 'Error in Not Found Page => ' + e.to_s
  end

  def checkSite(siteName)
    url = URI.parse(current_url)
    puts url
    url === siteName
  rescue Exception => e
    radio_sizee 'Error in Website' + e.to_s
  end

  def verifyDoubleDeck
    seatMapDoubleDeck = all 'div.seat-map.double-deck.floor-1-active'
    if seatMapDoubleDeck.length.positive?
      floorsButton = '.floor-button'
      settings = $ted.readSettings
      trip = settings['trip']
      trip = trip.to_i
      if trip == Dictionary::CONNECTION || trip == Dictionary::ONE_STOP
        itemDetails = all('div.search-item-details')[0]
      else
        itemDetails = find('div.search-item-details')
      end
      within(itemDetails) do
        all(floorsButton)[1].click
      end
    end
  end

  def selectSeat
    verifyDoubleDeck
    settings = $ted.readSettings
    trip = settings['trip']
    trip = trip.to_i

    seatMap = Seat.new
    seatMap.select(0)

    if trip == Dictionary::CONNECTION || trip == Dictionary::ONE_STOP
      seatMapConnection = Seat.new
      seatMapConnection.select(1)
    end
  end

  def ValidateMessageSelectSeat
    dialog_alert = find 'div.dialog'
    begin
      within(dialog_alert) do
        error_message = find 'div.dialog-content'
        button_closeAlert = 'button.btn-secondary.btn-medium'
        raise unless error_message.visible?
        find(button_closeAlert).click
      end
    rescue Exception => e
      raise 'Could not close message alert modal. ' + e.to_s
    end
  end

  def bookingButton
    continue_booking = '.continue-booking'
    find(continue_booking).click
  end

  def roundTrip(siteName)
    settings = $ted.readSettings
    trip = settings['trip']
    trip = trip.to_i

    if trip == Dictionary::ROUNDTRIP
      find('li.return.active')
      find("button.search-btn.btn-secondary.btn-small").click
      sleep 6
      selectResult(siteName)
      selectSeat
      bookingButton
    end
  end

  def getOrderSummary
    settings = $ted.readSettings
    trip = settings['trip']
    trip = trip.to_i
    insurance = settings['insurance'].to_i

    within('div.checkout-order-summary-content') do
      $checkoutprice = find('div.summary-details').first('span.summary-value').text
      puts 'O preço da viagem no checkout é: ' + $checkoutprice
      $checkoutfee = find('div.summary-seats-fee').first('span.summary-value').text
      puts 'O preço da taxa no checkout é: ' + $checkoutfee
      $checkouttotal = find('div.summary-total').first('span.summary-value').text
      puts 'O preço total no checkout é: ' + $checkouttotal
      $checkouttotal = $checkouttotal.gsub(/,/ , '.').to_f.round(2)
      if insurance == 1 
        $insuranceprice = find('div.summary-insurance').first('span.summary-value').text
        puts 'O preço do seguro no checkout é: ' + $insuranceprice
        $insuranceprice = $insuranceprice.gsub(/,/ , '.').to_f.round(2)
      end

      if trip == Dictionary::ROUNDTRIP || @passengerQuantity > 1
        puts 'O preço da passagem na Search Results foi: ' + @searchPriceAux
        $checkoutprice = $checkoutprice.gsub(/,/ , '.')
        if $checkoutprice != @searchPriceAux
          checkDiferentValues($checkoutprice, @searchPriceAux)
        end
      else
        puts 'O preço da passagem na Search Results foi: ' + $checkoutprice
        $checkoutprice = $checkoutprice.gsub(/,/ , '.')
        if $checkoutprice != $searchresultsprice
          checkDiferentValues($checkoutprice, $searchresultsprice)
        end
      end
    end

    within('.summary-trip.card') do
      outboundTripDate = find('.summary-trip-details').text.to_s.split('Viagem de ida: ')[1]
      outboundTripDate = outboundTripDate.split
      $outboundDay = outboundTripDate[1]

      if trip == Dictionary::ROUNDTRIP
        returnTripDate = find('.summary-trip-details').text.to_s.split('Viagem de volta: ')[1]
        returnTripDate = returnTripDate.split
        $returnDay = returnTripDate[1]
      end
    end
  end

  def checkDiferentValues(checkoutprice, searchPrice)
    oldpricemsg = find(:xpath, '//*[@id="alert-changing-price"]').text
    puts oldpricemsg
    oldprice = oldpricemsg.split('de R$')[1].gsub(/,/ , '.').to_f.round(2)
    newprice = oldpricemsg.split('para R$')[1].gsub(/,/ , '.').to_f.round(2)
    checkoutprice = checkoutprice.to_s.gsub(',' , '.').to_f
    searchPrice = searchPrice.to_s.gsub(',' , '.').to_f
    puts newprice.to_s + " e " + checkoutprice.to_s
    puts oldprice.to_s + " e " + searchPrice.to_s
    raise 'Error in value prices! ' if  (newprice != checkoutprice) || (oldprice != searchPrice)
  end

  def checkIfLogged
    if @logged
      raise 'User is not logged anymore' unless find('#logged-user-name')
    end
  end

  def passengerData()
    
    # Aqui você deverá implementar a função para preencher os dados de passageiros e contatos do cliente no checkout da Clickbus
    




    



  end

  def fillCreditCardName(siteName)
    within('div#credit_card') do
      credit_name = all('div.input-field.col.l12')[1].find('input#credit-card-holder-name')
      credit_name.native.clear
      credit_name.send_keys 'FUND FUND'
    end 
  end

  def CheckPassengerCard(siteName)
    # passengernametest
    # Check warns (click inside then outside and verify messages)
    # Check mandatory (submit form and verify messages)
    passenger_form = find 'div.passenger-item-data'
    begin
      within(passenger_form) do
        passenger_name = '#passenger_name_1'
        find(passenger_name).click
        find(passenger_name).send_keys %i[shift tab]
        passenger_name_msg = find('div.message > p')
        raise unless passenger_name_msg.visible?

        passenger = 'First'
        find(passenger_name).send_keys passenger, :tab
        passenger_name_msg = find('div.message > p')
        raise unless passenger_name_msg.visible?

        passengers = $ted.readCharacter(siteName)
        passenger = passengers['0']['name']
        find(passenger_name).send_keys %i[shift home], :clear
        find(passenger_name).send_keys passenger, %i[shift tab]
      end
    rescue Exception => e
      raise 'Error in name field: ' + e.to_s
    end

    # documenttest
    within(all('.input-field')[1]) do
      find('input.select-dropdown').click
      find('span', text: 'RG')
      find('span', text: 'CNH')
      find('span', text: 'Passaporte')
      find('span', text: 'CPF').click
    end

    within('div.passenger-data.card') do
      doc_number_field = find('#document_number_passenger_1')
      doc_number_field.click
      doc_number_field.send_keys 'asd', %i[shift tab]
      error_msg = find('div.message > p')
      raise unless error_msg.visible?
      doc_number_field.click
      doc_number_field.send_keys '012.345.678-90', :tab
      sleep 1
    end


  end

  def CheckContactCard(siteName)
    within('div.buyer-data.card') do
      email = find('#email')
      phone = find('#phone')
      customer_doc_menu = 'div.select-wrapper.customer_document_type'
      customer_doc_number = 'input#customer-document-number'
      doc_type = 'span'
      email.click
      dados_do_cliente = $ted.readCharacter(siteName)
      email_usuario = dados_do_cliente['0']['email']

      failemail = email_usuario.split('@')[0]
      erroremail = email_usuario.split('.')[0]
      email.send_keys failemail, %i[shift tab]
      failemailmsg = find('div.message')
      raise unless failemailmsg.visible?
      email.send_keys %i[shift home], erroremail, %i[shift tab]
      raise unless failemailmsg.visible?
      email.send_keys %i[shift home], email_usuario

      find(customer_doc_menu).click
      find(doc_type, text: 'CPF').click
      find(customer_doc_number).send_keys '44168455654'
      sleep 1
      find(customer_doc_menu).click
      doc_number_error = find('div.error.position-top', text: 'CPF inválido')
      raise unless doc_number_error.visible?
      find(customer_doc_number).native.clear
      find(customer_doc_number).send_keys '012.345.678-90'

      phone.click
      fone_fail = ''
      phone.click
      phone.send_keys fone_fail, :tab
      failphonemsg = find('div.message')
      raise unless failphonemsg.visible?
      phone.send_keys '111234567', :tab
      raise unless failphonemsg.visible?
      fone = dados_do_cliente['0']['phone']
      phone.click
      phone.send_keys fone
    end
  end

  def CheckPaymentCard(siteName)
    within(find('#credit_card')) do
      # Cards flags
      within('ul.icons-list') do
        find('.logo-payment-mastercard')
        find('.logo-payment-visa')
        find('.logo-payment-elo')
        find('.logo-payment-amex')
        find('.logo-payment-diners')
        find('.logo-payment-hipercard')
      end

      within(all('div.payment-data')[1]) do
        # fieldtest
        test = 2837465920438254297845245242345
        cartao = $ted.readCreditInfo('Credit', siteName)
        numero = cartao['card_number']
        data = cartao['expiration_month'].to_s + '/' + cartao['expiration_year'].to_s
        sec = cartao['cvv']
        nome = cartao['card_holder']
        doc = cartao['holder_id']
        cep = cartao['zipcode']

        credit_card_number = find('#credit-card-number')
        credit_card_date_expiration = find('#credit-card-date-expiration')
        credit_card_secure_code = find('#credit-card-secure-code')
        credit_card_holder_name = find('#credit-card-holder-name')
        credit_card_doc_number = find('#credit-card-document-number')
        credit_card_zip_code = find('#credit-card-zip-code')

        credit_card_number.click
        credit_card_number.send_keys test, :tab
        credit_card_number_error = find('div.message')
        break unless credit_card_number_error.visible?
        credit_card_number.send_keys %i[shift home], numero

        credit_card_date_expiration.click
        credit_card_date_expiration.send_keys test, :tab
        credit_card_date_expiration_error = find('div.message')
        break unless credit_card_date_expiration_error.visible?
        credit_card_date_expiration.send_keys %i[shift home], data

        credit_card_secure_code.click
        credit_card_secure_code.send_keys 'asd', :tab
        credit_card_secure_code_error = find('div.message')
        break unless credit_card_secure_code_error.visible?
        credit_card_secure_code.send_keys %i[shift home], sec

        credit_card_holder_name.click
        credit_card_holder_name.send_keys test, :tab
        credit_card_holder_name_error = find('div.message')
        break unless credit_card_holder_name_error.visible?

        credit_card_holder_name.native.clear
        credit_card_holder_name.send_keys 'J P I', :tab
        break unless credit_card_holder_name_error.visible?

        credit_card_holder_name.native.clear
        credit_card_holder_name.send_keys 'J', :tab
        break unless credit_card_holder_name_error.visible?

        credit_card_holder_name.native.clear
        credit_card_holder_name.send_keys 'Joao Paulo I', :tab
        break unless find('input.card-holder-name.required.validate-full-name.position-top.valid')

        credit_card_holder_name.native.clear
        credit_card_holder_name.send_keys 'Joao Paulo II', :tab
        break unless find('input.card-holder-name.required.validate-full-name.position-top.valid')

        credit_card_holder_name.send_keys %i[shift home], :delete, nome

        credit_card_doc_number.click
        credit_card_doc_number.send_keys 'asd', :tab
        credit_card_doc_number_error = find('div.message')
        break unless credit_card_doc_number_error.visible?
        credit_card_doc_number.send_keys %i[shift home], doc

        credit_card_zip_code.click
        credit_card_zip_code.send_keys 'asd', :tab
        credit_card_zip_code_error = find('div.message')
        break unless credit_card_zip_code_error.visible?
        credit_card_zip_code.send_keys %i[shift home], cep
      end

      within(all('div.payment-data')[0]) do
        # instalmentsfield
        begin
          find('input.select-dropdown').click
          find('.dropdown-content.select-dropdown', minimum: 2)
          all('.dropdown-content.select-dropdown')[0].click
        rescue Exception => e
          raise 'Error in instalments field: ' + e.to_s
        end
      end
    end

    within('.payment-tab') do
      find("li[data-payment='paypal']").click
    end

    within('#paypal') do
      find('button.buy-button')
    end

    within('.payment-tab') do
      find("li[data-payment='debit_card']").click
    end

    within('#debit_card') do
      # Card Flags
      within('ul.icons-list') do
        find('.logo-payment-mastercard')
        find('.logo-payment-visa')
      end

      test = 'qwertyuio'
      cartao2 = $ted.readCreditInfo('Debit', siteName)
      numero = cartao2['card_number']
      data = cartao2['expiration_month'].to_s + '/' + cartao2['expiration_year'].to_s
      sec = cartao2['cvv']
      nome = cartao2['card_holder']
      debit_card_number = find('#debit-card-number')
      debit_card_date_expiration = find('#debit-card-date-expiration')
      debit_card_secure_code = find('#debit-card-secure-code')
      debit_card_holder_name = find('#debit-card-holder-name')

      # Debit Fields Tests
      debit_card_number.click
      debit_card_number.send_keys test, :tab
      debit_card_number_error = find('div.message')
      break unless debit_card_number_error.visible?
      debit_card_number.send_keys %i[shift home], numero

      debit_card_date_expiration.click
      debit_card_date_expiration.send_keys test, :tab
      debit_card_date_expiration_error = find('div.message')
      break unless debit_card_date_expiration_error.visible?
      debit_card_date_expiration.send_keys %i[shift home], data

      debit_card_secure_code.click
      debit_card_secure_code.send_keys '1', :tab
      debit_card_secure_code_error = find('div.message')
      break unless debit_card_secure_code_error.visible?
      debit_card_secure_code.send_keys %i[shift home], sec

      debit_card_holder_name.click
      debit_card_holder_name.send_keys test, :tab
      debit_card_holder_name_error = find('div.message')
      break unless debit_card_holder_name_error.visible?
      debit_card_holder_name.send_keys %i[shift home], nome
    end

    within('.payment-tab') do
      find("li[data-payment='eletronic_funds_transfer']").click
    end

    within('#eletronic_funds_transfer') do
      document = "input-bank-details-doc-number"
      branch = "input-bank-details-branch"
      account = find("input#input-bank-details-account")
      continueButton = 'button.buy-button.btn-primary.btn-main-cta'
      raise unless find(".item[data-bank-code='237']")
      raise unless find(".item[data-bank-code='001']")
      raise unless find(".item[data-bank-code='104']")
      raise unless find(".item[data-bank-code='033']")
      raise unless find(".item[data-bank-code='341']")
      raise unless find(".item[data-bank-code='212']")
      sleep 2
      fill_in(document, with: "012.345.678-90")
      fill_in(branch, with: "1234")
      find(continueButton).click
      break unless find('div.message').visible?
      find('#input-bank-details-doc-number').native.clear
      account.send_keys '567890'
      find(continueButton).click
      find('div.message')
      fill_in(document, with: "012.345.678-90")
      account.send_keys "567890"
      find('#input-bank-details-branch').native.clear
      find(continueButton).click
      find('div.message')
      fill_in(branch, with: "asads")
      find(continueButton).click
      raise unless find('div.message')
      find('#input-bank-details-branch').native.clear
      fill_in(branch, with: "1234")
      find('#input-bank-details-doc-number').native.clear
      fill_in(document, with: "123456")
      find(continueButton).click
      raise unless find('div.message')
      find('#input-bank-details-doc-number').native.clear
      fill_in(document, with: "012.345.678-90")
      find('#input-bank-details-account').native.clear
      account.send_keys "12ss"
      find(continueButton).click
      raise unless find('div.message')
      find('#input-bank-details-account').native.clear
      account.send_keys '1234-x', :tab
      raise unless find('input.required.no-mouseflow.validate-bank-account.position-top.valid')
    end
  end

  def CheckFooterCheckout(siteName)
    # Security Certificate
    within('footer.checkout-footer') do
      find('span.logo-security-cadastur')
      find('span.logo-security-ssl')
      find('span.logo-payment-mercadopago')
      marca_registrada = find('div.col.l3.offset-l1').text
      raise 'Error' unless marca_registrada.include? 'ClickBus'
    end
  end

  def checkInsurance(siteName)
    settings = $ted.readSettings
    insurance = settings['insurance']
    insurance = insurance.to_i
    siteName = siteName.split[0]
    return if insurance == 0
    if (siteName == 'Bamcaf')
      pass_insure = all('.company-insurance-by-passenger')
      raise if pass_insure.empty?
      for i in 0..pass_insure.length - 1
        within(pass_insure[i]) do
          find('label').click
          sleep 1
        end
      end
    else
      within(find('.check-insurance')) do
        find('label').click
      end
    end
  end

  def paymentData(paymentType, siteName)
    $paymentType = paymentType
    case $paymentType
    when 'Credit'
      paymentCredit(siteName)
    when 'Debit'
      paymentDebit(siteName)
    when 'Paypal'
      paymentPaypal(siteName)
    when 'Paymee'
      paymentPaymee(siteName)
    end
  end

  def paymentCredit(siteName)
    creditInfo = $ted.readCreditInfo($paymentType, siteName)
    settings = $ted.readSettings
    begin
      logged = !all('div.col.l12.logged-user').empty?
      within(find('div.card.payment-card.active')) do
        if logged
          radio_button = all('div.col.l1')
          radio_size = radio_button.length
          radio_button[radio_size - 1].click if radio_size != 0
          within(find('div.col.l12.save-credit-card')) do
            find('label').click if siteName[0..3] == 'Save'
          end
        end
        fill_in 'credit-card-number', with: creditInfo['card_number']
        fill_in 'credit-card-date-expiration', with: creditInfo['expiration_month'].to_s + '/' + creditInfo['expiration_year']
        fill_in 'credit-card-secure-code', with: creditInfo['cvv']
        fill_in 'credit-card-holder-name', with: creditInfo['card_holder']
        fill_in 'credit-card-document-number', with: creditInfo['holder_id']
        fill_in 'credit-card-zip-code', with: creditInfo['zipcode']
        find('input.select-dropdown').click
        within(find('.dropdown-content')) do
          all('span', text: settings['installments'].to_s + 'x')[0].click
        end
      end
    rescue Exception => e
      raise 'Error in information card ' + e.to_s
    end
    puts 'O método de pagamento utilizado é: ' + $paymentType
    puts 'O número do cartão utilizado é: ' + creditInfo['card_number']

    @paymentType = $paymentType
  end

  def paymentDebit(siteName)
    creditInfo = $ted.readCreditInfo($paymentType, siteName)
    debitTab = all('li.tab')[2]
    raise 'No Debit Option' if debitTab.nil?
    debitTab.click
    begin
      fill_in 'debit-card-number', with: creditInfo['card_number']
      fill_in 'debit-card-date-expiration', with: creditInfo['expiration_month'].to_s + '/' + creditInfo['expiration_year']
      fill_in 'debit-card-secure-code', with: creditInfo['cvv']
      fill_in 'debit-card-holder-name', with: creditInfo['card_holder']
    rescue Exception => e
      raise 'Error in information card ' + e.to_s
    end
    puts 'O método de pagamento utilizado é: ' + $paymentType
    puts 'O número do cartão utilizado é: ' + creditInfo['card_number']

    @paymentType = $paymentType
  end

  def paymentPaypal(siteName)
    paypalTab = all('li.tab')[1]
    if siteName.include?('Ipiranga')
      raise 'Ipiranga should not have Paypal' unless paypalTab.nil?
      return
    else
      raise 'No Paypal Option' if paypalTab.nil?
    end
    paypalTab.click
    @paymentType = $paymentType
    sleep 2
  end

  def paymentPaymee(siteName)
    creditInfo = $ted.readCreditInfo($paymentType, siteName)
    settings = $ted.readSettings
    paymeeTab = all('li.tab')[3]
    raise 'No Paymee Option' if paymeeTab.nil?
    paymeeTab.click
    scroll_to(find("div#eletronic_funds_transfer"))
    
    find(".item[data-bank-code='237']").click
    find(".item[data-bank-code='001']").click
    find(".item[data-bank-code='104']").click
    find(".item[data-bank-code='033']").click
    find(".item[data-bank-code='341']").click
    find(".item[data-bank-code='212']").click
    fill_in("input-bank-details-doc-number", with: "012.345.678-90")
    fill_in("input-bank-details-branch", with: "1234")
    fill_in("input-bank-details-account", with: "567890")
    
    @paymentType = $paymentType
    sleep 2
  end

  def readTopRoutesCSV
    arraySlugs =  Array.new
    CSV.foreach('./features/step_definitions/data/Top_Routes.csv') do |row|
      arraySlugs.push(row[1])
      #puts row.length()
    end
    for i in 1..150 #pra pegar apenas as linhas que contêm slugs (as 150 primeiras rotas mais buscadas)
      route1 = arraySlugs[i].split('_')[0]
      route2 = arraySlugs[i].split('_')[1]
      CheckResultsTopRoute(route1, route2)
    end
    verifyIfAnyRouteFailed(@failedRoutes)
  end

  def CheckResultsTopRoute(route1, route2)
    @failedRoutes = 0
    env = ENV['ENV'].downcase
    if ENV['ENV'] == 'Live'
      baseURL = "https://www.clickbus.com.br/onibus/"
    elsif ENV['ENV'] == 'Staging'
      baseURL = "https://www-staging.clickbus.com.br/onibus/"
    else
      baseURL = "https://brazil-#{env}.clickbus.com/onibus/"
    end
    topRoutesSearch = baseURL + route1 + '/' + route2
    visit topRoutesSearch

    begin
      search_results_list = find('div.search-results-wrapper', wait: 1).find('div.search-result-list', wait: 1)
      within(search_results_list) do
        raise unless all('div.search-item.search-item-direct', wait: 1) 
      end
    rescue Exception => e
      puts "Couldn't find results for this route: #{route1} -> #{route2}. " + e.to_s
      puts page.current_url
      @failedRoutes += 1
    end
  end

  def verifyIfAnyRouteFailed(failedRoutes)
    if failedRoutes > 0 
      raise "Check all failed routes! "
    end
  end

  def paymentSavedCard(paymentType, siteName)
    creditInfo = $ted.readCreditInfo(paymentType, siteName)
    settings = $ted.readSettings

    begin
      scroll_to(find('.payment-tab'))
      card_set = card_last4(creditInfo['card_number'])
      within('.payment-list-saved-cards') do
        radio_button = all('.payment-card-saved-item')
        
        i = 0
        radio_button.each do
          within(radio_button[i]) do
            card_saved = find('div.payment-card-number')
            if card_set === card_last4(card_saved.text)
              radio_button[i].click
              find('.payment-card-security-code').send_keys creditInfo['cvv'].to_i
              break
            end
          end
          i += 1
        end
      end
      all('input.select-dropdown').last.click
      within(find('.dropdown-content')) do
        all('span', text: settings['installments'].to_s + 'x')[0].click
      end
    rescue Exception => e
      raise 'Error in information card ' + e.to_s
    end
    puts 'O método de pagamento utilizado é: ' + paymentType
    puts 'O número do cartão utilizado é: ' + creditInfo['card_number']
    $paymentType = @paymentType = paymentType
  end

  def fillVoucherData(siteName)
    voucherField = 'coupon-code'
    buttonadd = '#btn-voucher-add'
    settings = $ted.readSettings
    fill_in voucherField, with: settings['voucher']
    find(buttonadd).click
    sleep 3
    begin
      within("div.summary-discount.added") do
        @discount = find("div.summary-data").find('span.summary-value').text
        puts 'Desconto de ' + @discount + ' no checkout.'
      end
    rescue Exception => e
      raise 'Error in voucher: ' + e.to_s
    end
  end

  def confirmButton(siteName)
    purchaseButton = 'button.buy-button'
    scroll_to(siteName.downcase.include?("clickbus") ? find('h2', text: 'Pagamento') : find('h2', text: 'Dados do Pagamento'))
    case @paymentType
    when 'Credit'
      find(purchaseButton).click
    when 'Debit'
      windowDebit(siteName)
    when 'Paypal'
      windowPaypal(siteName)
    when 'Paymee'
      find(purchaseButton).click
    end
  end

  def windowDebit(siteName)
    creditInfo = $ted.readCreditInfo($paymentType, siteName)
    debitButtonPurchase = 'button.buy-button'
    find('button', text: 'Comprar')
    debit_window = window_opened_by { find(debitButtonPurchase).click }
    within_window debit_window do
      sleep 5
      within('.hst_bank_body_transaction_table') do
        find('input').click
      end
      within('.hst_bank_body_2_font') do
        birthday_field = 'input'
        doc_field = 'input'
        confirm_debit_button = 'input'
        within(all('.hst_bank_body_data_confirm_font')[0]) do
          find(birthday_field).click
          find(birthday_field).set(creditInfo['holder_birthday'])
        end
        within(all('.hst_bank_body_data_confirm_font')[2]) do
          find(doc_field).set(creditInfo['holder_id'])
        end
        sleep 1
        within(find('.hst_bank_body_transaction_table')) do
          find(confirm_debit_button)
          find(confirm_debit_button).click
        end
      end
    end
  end

  def windowPaypal(siteName)
    creditInfo = $ted.readCreditInfo($paymentType, siteName)
    paypalButtonPurchase = 'button.buy-button'
    paypalButtonLogin = 'a.btn.full.ng-binding'
    buttonClass = all('span11.alignRight.baslLoginButtonContainer')

    within(find('#paypal')) do
      paypal_window = window_opened_by { find(paypalButtonPurchase).click }
      sleep 5
      within_window paypal_window do
        begin
          unless buttonClass.length.nil?
            find(paypalButtonLogin, text: 'Log in').click
            fill_in 'email', with: creditInfo['paypal_login']
            find('#btnNext').click
            fill_in 'password', with: creditInfo['paypal_password']
            find('#btnLogin').click
          end
        rescue
          fill_in 'email', with: creditInfo['paypal_login']
          find('#btnNext').click
          fill_in 'password', with: creditInfo['paypal_password']
          find('#btnLogin').click
        end
        find('#confirmButtonTop').click
      end
    end
  end

  def verifyPurchase(siteName)
    success = find('.checkout-status-title').text
    if (success != 'Compra realizada com sucesso' && success != 'Pedido realizado') 
      error_message = find('.dialog-error #error-message').text
      click_button('Ok, entendi')
      raise 'There is a problem with your payment, following error_message: ' + error_message
    end
    orderId = find('.order').text
    $IDorder = orderId
    puts 'O ID da order é: ' + orderId
  end

  def verifyPurchaseEOF(siteName)
    bankinfo = $ted.readCreditInfo($paymentType, siteName)
    # within('div.my-order-status.status-pending') do
    #   find('div.my-order-status-text', text: 'Aguardando pagamento')
    # end
    within('div.card.border-colored') do
      pendingMessage = find('p.center.title').text
      puts pendingMessage
      $doc_number   = find('p.document-number').text
      $our_agency  = find('div.branch-info > p').text
      $our_account = find('div.account-info > p').text
      $our_bank = all('img.bank-image.right')[1]['alt']
      $timelimit = pendingMessage.split('às ')[1]
      raise unless pendingMessage.include? 'Falta pouco'
      raise unless $doc_number.split('CPF: ')[1] == "012.345.678-90"
    end 
    
    orderId = find('.localizer').text
    $IDorder = orderId
    puts 'O ID da order é: ' + orderId
  end

  def verifyAlertPayment(siteName)
    within('div.dialog-error') do
      eftButton = find('button#eft-button')
      errorButton = find('button#error-button')
      raise unless eftButton
      raise unless errorButton
      eftButton.click
    end
  end

  def getOrderId
    $IDorder
  end

  def getPaymeeInfo(siteName)
    bankinfo = $ted.readCreditInfo($paymentType, siteName)
    within('.card.eft-data') do
      pendingMessage = first('.title').text
      doc_number  = find('p.document-number').text
      our_agency  = find('div.branch-info > p').text
      our_account = find('div.account-info > p').text
      raise unless our_account === $our_account
      raise unless our_agency  === $our_agency
      raise unless pendingMessage.include? 'Faça a transferência até às' || 
      raise unless doc_number.split('CPF: ')[1] == "012.345.678-90"
    end 
  end

  def verifyEticketButton
    within('div.card.my-order-e-ticket') do
      raise unless find('div.my-order-e-ticket-qr-code').find('i.icon.icon-printer')
      raise unless find('div.my-order-e-ticket-qr-code').find('span')
      raise unless find('a.btn-primary.btn-big.btn-e-ticket-pdf.right')
    end 
  end

  def accessMyOrder(siteName)
    if(@paymentType == 'Paymee')
      find(".localizer").click
    else
      $myorder = MyOrder.new
      $myorder.click_my_order
      $myorder.checkInfo($IDorder, $checkouttotal) unless siteName.include?('Voucher')
      $myorder.checkTripInfo unless siteName.include?('Voucher')
      sleep 4
    end
  end

  def orderCancellation
    $myorder.click_cancel
  end

  def confirmCancellation
    $myorder.finalizeCancellation
  end

  def checkDiscount
    within("section.payment-summary") do 
      discountMyOrder = find('div.row.discount').find('.col.l3.price').text 
      puts 'Desconto de ' + discountMyOrder + ' em My Order.'
      raise if discountMyOrder.split('R$ ')[1] != @discount
    end
  rescue Exception => e
    raise 'Error in voucher: ' + e.to_s
  end

  def CheckHeaderHome(siteName)
    siteName = siteName.split(' ')[0].downcase
    within 'header' do
      logo = find('a.col.l2')
      logo_href = logo['href'].include? '/'
      logo = find('img')
      logo_title = logo['src'].downcase.include? siteName
      raise 'Logo' unless logo_href && logo_title
      if siteName.include? 'clickbus'
        atend = find('a.info.link')
        atend_href = atend['href'].include? '/institucional/atendimento'
        login = find('#header-login-btn')
        login_href = login['href'].include? '/login'
        raise 'Atendimento' unless atend_href
        raise 'Login' unless login_href
      else
        myorder = find('#header-my-order-btn')
        myorder_ref = myorder['href'].include? '/meu-pedido'
        raise 'Meu Pedido' unless myorder_ref
      end
    end
  rescue Exception => e
    raise 'Header Error: ' + e.to_s
  end

  def CheckTopDestinations(siteName)
    # TO DO: Generalize Top Destinatios for all WL to read from Json

    within('#top-destination') do
      imageTop = 'https://static.clickbus.com/live/destinos/'
      linkTop = '/onibus/'
      top_Links = all('a.mask')
      top_Images = all('img')
      numGen = Random.new
      numGen = numGen.rand(top_Links.length)
      puts "We have #{top_Links.length} top routes"
      raise 'Redirect Link' unless top_Links[numGen]['href'].include? linkTop
      raise 'Image' unless top_Images[numGen]['src'].include? imageTop
      puts top_Links[numGen]['href']
      puts top_Images[numGen]['src']
    end
  rescue Exception => e
    raise 'Top Route Error: ' + e.to_s
  end

  def CheckBusLines(siteName)
    puts 'Step used only for Clickbus'
    begin
      if siteName.include? 'Clickbus'
        within('#buslines .container') do
          logoBusLines = 'https://static.clickbus.com/live/travel-company-logos/'
          linkBusLines = '/viacao'
          buslinesLinks = all('a')
          buslinesLogos = all('img')
          numGen = Random.new
          numGen = numGen.rand(buslinesLogos.length)
          puts "We have #{buslinesLogos.length} buslines"
          raise 'Redirect Link' unless buslinesLinks[numGen]['href'].include? linkBusLines
          raise 'Logo ' unless buslinesLogos[numGen]['src'].include? logoBusLines
          puts buslinesLinks[numGen]['href']
          puts buslinesLogos[numGen]['src']
          puts buslinesLogos[numGen]['title']
        end
      end
    rescue Exception => e
      raise 'BusLines Error: ' + e.to_s
    end
  end

  def CheckFooter(siteName)
    within 'footer' do
      # Links
      within 'div.footer-info' do
        raise 'Main Footer' unless page.has_link?('Política de Privacidade', href: '/institucional/politica-de-privacidade')
        raise 'Main Footer' unless page.has_link?('Termos de Uso', href: '/institucional/termos-de-uso')
        if siteName.include? 'Clickbus'

          # Institucional
          raise 'Main Footer' unless page.has_link?('Aplicativo', href: '/institucional/mobile')
          raise 'Main Footer' unless page.has_link?('Imprensa', href: '/imprensa')
          raise 'Main Footer' unless page.has_link?('Sobre Nós', href: '/institucional/sobre-nos')
          raise 'Main Footer' unless page.has_link?('Carreiras', href: '/institucional/carreiras')
          # Categorias
          raise 'Main Footer' unless page.has_link?('Destinos', href: '/onibus')
          raise 'Main Footer' unless page.has_link?('Glossário', href: '/glossario')
          raise 'Main Footer' unless page.has_link?('Rodoviárias', href: '/rodoviaria')
          raise 'Main Footer' unless page.has_link?('Viações', href: '/viacao')
          # Bussiness
          raise 'Main Footer' unless page.has_link?('Agência de Viagens', href: '/institucional/agencias-de-viagem')
          raise 'Main Footer' unless page.has_link?('Corporativo', href: '/institucional/corporativo')
          raise 'Main Footer' unless page.has_link?('Programa de Afiliados', href: '/institucional/programa-de-afiliados')
          # Ajuda
          raise 'link' unless page.has_link?('Atendimento', href: '/institucional/atendimento')
          raise 'link' unless page.has_link?('Dúvidas Frequentes', href: '/institucional/duvidas-frequentes')
        end
      end
      # Cards Flags
      within('div.cards') do
        cardFlags = all('img')
        raise 'Card Flag' unless cardFlags[0]['src'].include? 'mastercard.svg'
        raise 'Card Flag' unless cardFlags[1]['src'].include? 'visa.svg'
        raise 'Card Flag' unless cardFlags[2]['src'].include? 'american-express.svg'
        raise 'Card Flag' unless cardFlags[3]['src'].include? 'elo.svg'
        raise 'Card Flag' unless cardFlags[4]['src'].include? 'diners.svg'
        raise 'Card Flag' unless cardFlags[5]['src'].include? 'hipercard.svg'
      end

      # Social Media Logos (ONLY CLICKBUS)
      if siteName.include? 'Clickbus'
        within('.icons-list.social-media-logos') do
          socialMediaLinks = all('a')
          socialMediaLogo = all('img')
          raise 'Social Media' unless socialMediaLinks[0]['href'].include? 'https://www.facebook.com/clickbus'
          raise 'Social Media' unless socialMediaLogo[0]['title'].include? 'Facebook'
          raise 'Social Media' unless socialMediaLinks[1]['href'].include? 'https://www.youtube.com/channel/UCyIH7qjfMoTu77im4SCHAqw'
          raise 'Social Media' unless socialMediaLogo[1]['title'].include? 'YouTube'
          raise 'Social Media' unless socialMediaLinks[2]['href'].include? 'https://twitter.com/clickbusbr'
          raise 'Social Media' unless socialMediaLogo[2]['title'].include? 'Twitter'
          raise 'Social Media' unless socialMediaLinks[3]['href'].include? 'https://www.instagram.com/clickbus/'
          raise 'Social Media' unless socialMediaLogo[3]['title'].include? 'Instagram'
        end
      end

      # Security Certificate
      within('div.security-certificate') do
        securityCertificate = all('img')
        raise 'Security' unless securityCertificate[0]['src'].include? 'rapidssl.svg'
        if siteName.include? 'Clickbus'
          raise 'Security' unless securityCertificate[1]['src'].include? 'cadastur.svg'
        end
      end
    end
  rescue Exception => e
    raise 'Footer Error: ' + e.to_s
  end
end

class Login
  include Capybara::DSL

  def initialize
    @input_email = 'email'
    @input_password = 'password'
  end

  def fill_form(email, password)
    fill_in @input_email, with: email
    fill_in @input_password, with: password
  rescue Exception => e
    raise 'Error filling field: ' + e.to_s
  end
end

class Search
  include Capybara::DSL

  def initialize(search_box, input, widget)
    @search_box = search_box
    @input = input
    @widget = widget
  end

  def fill_field(place)
    place_results = '.tt-dataset.tt-dataset-place-results'
    place_suggests = 'div.tt-suggestion.tt-selectable'
    begin
      within(@search_box) do
        find(@input).click
        fill_in @widget, with: (place.split(',')[0])
        sleep 1
      end
      within(place_results, wait: 10) do
        suggests = all(place_suggests)
        i = 0
        suggests.each do |sugest_name|
          if sugest_name.text == place
            suggests[i].click
            break
          end
          i += 1
        end
      end
      find(@input).value === place
    rescue Exception => e
      raise 'Error filling field: ' + e.to_s
    end
  end
end

class Calendar
  include Capybara::DSL

  def initialize(date_form, date)
    @date_form = date_form
    @date = date
  end

  def fill_departure_date
    datepicker_group_next = 'a.ui-datepicker-next.ui-corner-all'
    datepicker_group = '.ui-datepicker-group'

    find(@date_form).click
    d = Date.parse(@date)
    diffmon = (d.year * 12 + d.month) - (Date.today.year * 12 + Date.today.month)
    d = d.mday

    if diffmon >= 2
      for i in 0..diffmon - 2
        find(datepicker_group_next).click
      end
    end

    i = diffmon >= 1 ? 1 : 0
    calendar = all(datepicker_group)[i] # muda card mes
    cal_day = '.ui-state-default'

    within(calendar) do
      all(cal_day).each do |day|
        next unless day.text == d.to_s
        d_class = day[:class]
        decis = d_class.include?('ui-state-disabled' || 'last-month')
        day.click if decis == false
      end
    end

    dateText = find(@date_form).value
    fixmonth = dateText.split('/')[1].to_i
    fixday = dateText.split('/')[0].to_i
    dateText = fixday.to_s + '/' + fixmonth.to_s + '/' + dateText.split('/')[2]
    $dateGlobal = @date
    begin
      raise 'Error' if @date != dateText
    rescue Exception => e
      puts 'Date differs! ' + e.to_s
    end
  end

  def fill_return_date
    find(@date_form).click
    r = Date.parse(@date)
    rday = r.mday

    all('td').each do |day|
      next unless day.text == rday.to_s
      d_class = day[:class]
      decis = d_class.include?('ui-state-disabled' || 'last-month')
      day.click if decis == false
    end

    dateText = find(@date_form).value

    monthfix = dateText.split('/')[1].to_i
    fixday = dateText.split('/')[0].to_i
    fixnewday = @date.split('/')[0].to_i
    fixnewday -= 1
    dateText = fixday.to_s + '/' + monthfix.to_s + '/' + dateText.split('/')[2]
    @date = fixday.to_s + '/' + @date.split('/')[1] + '/' + @date.split('/')[2]

    raise 'Error' if @date != dateText
  end
end

class Seat
  include Capybara::DSL

  def select(item)
    close_dialog = first('.icon-close.dialog-close')
    close_dialog.click unless close_dialog.nil?

    numGen = Random.new
    seats = 'div.bus'
    seat = 'li.seat-free'
    settings = $ted.readSettings
    passengerCount = settings['passengerQuantity'].to_i
    passengerIndex = 0

    sleep 5 # necessario para o all na proxima linha funcionar
    
    within(all(seats, wait: 10)[item]) do
      begin
        $outboundSeatCollection = all(seat, minimum: settings['passengerQuantity'])
        $size = $outboundSeatCollection.count
      rescue Exception => e
        raise 'Not enough seats available in this trip, run the test again to find another trip or try reducing the number of passengers! => ' + e.to_s
      end
    end

    while passengerCount > 0
      within(all(seats, wait: 10)[item]) do
        seatNumber = all(seat, minimum: 1, wait: 5)
        begin
          seatNumber[numGen.rand(seatNumber.length)].click
        rescue
          page.evaluate_script("document.querySelector('w-div').style.display = 'none'")
          seatNumber[numGen.rand(seatNumber.length)].click
        end

      end
      passengerIndex += 1
      passengerCount -= 1
    end
  end
end

class MyOrder
  include Capybara::DSL

  def click_my_order
    find('.btn-primary.btn-big.order').click
  rescue Exception => e
    raise 'Could not find the order button. ' + e.to_s
  end

  def checkInfo(orderId, total)
    moTotal = find('.summary-details-total').find('.summary-data').text.to_s.split('R$ ')[1]
    moOrderId = find('.col.l9.my-order-number').text.to_s.split(': ')[1]
    compareInfo(moTotal.gsub(/,/ , '.').to_f.round(2), total)
    compareInfo(moOrderId, orderId)
  end

  def checkTripInfo
    settings = $ted.readSettings
    trip = settings['trip']
    trip = trip.to_i

    within(find('.purchase-date')) do
      moOutboundDay = find('time').text.to_s.split('/')[0]
      compareInfo(moOutboundDay, $outboundDay)
    end

    if trip == Dictionary::ROUNDTRIP
      within(find('.purchase-date')) do
        moReturnDay = find('time').text.to_s.split('/')[0]
        compareInfo(moReturnDay, $returnDay)
      end
    end
  end

  def compareInfo(moValue, value)
    if moValue != value then
      raise 'Different values' 
    end
  end

  def click_cancel
    find('button.btn-cancel.btn-negative.btn-big.right').click
    find('button.btn-primary.btn-small.modal-confirm-btn').click
  rescue Exception => e
    raise "Could not find 'Cancel' button or was not possible close confirmation modal " + e.to_s
  end

  def finalizeCancellation
    find('button.btn-primary.btn-small.modal-finish-btn').click
    status = find('.my-order-status-text').text.to_s
    canceled = status.eql? 'Cancelado'
    raise 'Cancellation Fail' unless canceled
  end
end
