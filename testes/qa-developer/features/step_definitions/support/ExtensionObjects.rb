include RSpec::Matchers

module ExtensionObjects
  class Verify
    include Capybara::DSL

    def CheckUrl(siteName)
      siteName = siteName.split(' ')
      websiteURL = current_url
      urlArray = websiteURL.split('-')
      urlArray1 = urlArray[1].split('.')
      puts 'Estou em ' + urlArray1[0].to_s
      begin
        urlArray1[0].include?('Live')
      rescue Exception => e
        raise 'Error, must not run cancelation in backoffice Live environment => ' + e.to_s
      end
    end

    def CheckTitle(siteName)
      title = page.title
      puts title
      raise if (title.split(' ')[1]).empty?
    rescue Exception => e
      raise 'Title not found => ' + e.to_s
    end

    def CheckButtons(siteName)
      button = find('button.search-btn').text
    rescue Exception => e
      raise 'Button name not found => ' + e.to_s
    end

    def CheckHomeErrorMessageOrigin(siteName)
      search_form = 'div.search-box'
      begin
        within(search_form) do
          search_box = '.search-widget.search-widget-vertical'
          originField = '#widget-vertical-origin-place'
          input_departure = '.origin-place.tt-input'
          ori_text = 'widget-vertical-origin-place'
          settings = $ted.readSettings
          origin_place = settings['origin']
          find(originField).click
          find(originField).send_keys [:tab]
          errorMessageOrigin = find('div.message > p')
          raise unless errorMessageOrigin.visible?

          $searchOrig = Search.new(search_box, input_departure, ori_text)
          $searchOrig.fill_field(origin_place)
        end
      end
    end

    def CheckHomeErrorMessageDestination(siteName)
      search_form = 'div.search-box'
      begin
        within(search_form) do
          @destinationField = '#widget-vertical-destination-place'
          find(@destinationField).click
          find(@destinationField).send_keys [:tab]
          errorMessage = find('div.message > p')
          raise unless errorMessage.visible?
        end
      end
    end

    def CheckHomeErrorOriginNotFound(siteName)
      search_form = 'div.search-box'
      begin
        within(search_form) do
          originField = '#widget-vertical-origin-place'
          find(originField).click
          find(originField).send_keys 'asd'
          errorMessage = find('span', text: 'Nenhum Resultado', match: :first)
          raise unless errorMessage.visible?
        end
      end
    end

    def CheckHomeErrorDestinationNotFound(siteName)
      search_form = 'div.search-box'
      begin
        within(search_form) do
          find(@destinationField).click
          find(@destinationField).send_keys 'asd'
          errorMessage = all('span', text: 'Nenhum Resultado').last
          raise unless errorMessage.visible?
        end
      end
    end

    def RemoveAcento(string)
      string.gsub! /[áàâã]/, 'a'
      string.gsub! /[éê]/, 'e'
      string.gsub! /[í]/, 'i'
      string.gsub! /[óôõ]/, 'o'
      string.gsub! /[ú]/, 'u'
      string.gsub! /[Á]/, 'A'
      string.gsub! /[É]/, 'E'
      string.gsub! /[Í]/, 'I'
      string.gsub! /[ÓÔ]/, 'O'
      string.gsub! /[Ú]/, 'U'
      string
    end

    def urlTreatment(siteName)
      $ted.readEnv

      differentUrl
      $url = $url.gsub 'asd', @urlComplement
      urlTreatmentForEnvironment(siteName)
    end

    def differentUrl
      @urlComplement = 'utm_source=qa-ignore&' + Time.now.strftime('%d%m%Y%H%M%S').to_s 
      return @urlComplement
    end

    def addQueryString
      puts page.current_url
      if page.current_url.include? '?'
        visit page.current_url.split('?')[0] + '?utm_source=qa-ignore&' + page.current_url.split('?')[1] 
        sleep 5 #sleep pra dar tempo das paginas carregarem (search e checkout) e so entao montar a nova url
      else
        visit page.current_url + '?utm_source=qa-ignore'
        puts page.current_url
        sleep 5 #sleep pra dar tempo das paginas carregarem (search e checkout) e so entao montar a nova url
      end
    end

    def urlTreatmentForEnvironment(siteName)
      case $environment
      when 'Staging'
        if siteName.casecmp('Clickbus').zero?
          $siteURL = $url.gsub '{{siteName}}-', 'www-'
        elsif siteName.casecmp('NovoRio').zero?
          $siteURL = 'https://passagemdeonibus-staging.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('GuiaDaSemana').zero?
          $siteURL = 'https://passagemdeonibus-staging.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('Tiete').zero?
          $siteURL = 'https://passagens-staging.terminalrodoviariodo{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('RodoviariaDeSalvador').zero? 
          $siteURL = 'https://passagens-staging.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('Onibuz').zero? || siteName.casecmp('Onibuz').zero?
          $siteURL = 'https://passagens-staging.{{siteName}}.com/?asd'.gsub '{{siteName}}', siteName
        else
          $siteURL = $url.gsub '{{siteName}}', siteName
        end
      when 'Live'
        if siteName.casecmp('Clickbus').zero?
          $siteURL = $url.gsub '{{siteName}}.', ''
        elsif siteName.casecmp('NovoRio').zero?
          $siteURL = 'https://passagemdeonibus.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('Tiete').zero?
          $siteURL = 'https://passagens.terminalrodoviariodo{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('GuiaDaSemana').zero?
          $siteURL = 'https://passagemdeonibus.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('RodoviariaDeSalvador').zero? 
          $siteURL = 'https://passagens.{{siteName}}.com.br/?asd'.gsub '{{siteName}}', siteName
        elsif siteName.casecmp('Onibuz').zero? || siteName.casecmp('Onibuz').zero?
          $siteURL = 'https://passagens.{{siteName}}.com/?asd'.gsub '{{siteName}}', siteName
        else
          $siteURL = $url.gsub '{{siteName}}', siteName
        end
      when 'Cabal', 'Taken', 'Fallen', 'Hive', 'Vex'
        siteName = 'brazil' if siteName.casecmp('Clickbus').zero?
        $siteURL = $url.gsub '{{siteName}}', siteName
      else
        puts 'Error to Create URL'
      end
    end

    def CheckTitleSearch(siteName)
      title = RemoveAcento(page.title.to_s)
      puts title
      raise 'Missing Origin' unless title.include? $place1.split(',')[0]
      raise 'Missing Destination' unless title.include? $place2.split(',')[0]
    rescue Exception => e
      raise 'Title Error: ' + e.to_s
    end

    def CheckSearhErrorMessageOrigin(siteName)
      search_form = 'div.search-widget-header.col.l10'
      begin
        within (search_form) do
          search_box = '.search-widget.search-widget-horizontal'
          originField = '#widget-horizontal-origin-place'
          input_departure = '.origin-place.tt-input'
          ori_text = 'widget-horizontal-origin-place'
          settings = $ted.readSettings
          origin_place = settings['origin']
          find(originField).click
          find(originField).send_keys %i[delete tab]
          errorMessageOrigin = find('div.message > p')
          raise unless errorMessageOrigin.visible?
          $searchOrig = Search.new(search_box, input_departure, ori_text)
          $searchOrig.fill_field(origin_place)
        end
      end
    end

    def CheckSearhErrorMessageDestination(siteName)
      search_form = 'div.search-widget-header.col.l10'
      begin
        within (search_form) do
          @destinationField = '#widget-horizontal-destination-place'
          find(@destinationField).click
          find(@destinationField).send_keys %i[delete tab]
          errorMessageDestination = find('div.message > p')
          raise unless errorMessageDestination.visible?
        end
      end
    end

    def CheckSearchResultsErrorOriginNotFound(siteName)
      search_form = 'div.search-widget-header.col.l10'
      begin
        within(search_form) do
          originField = '#widget-horizontal-origin-place'
          find(originField).click
          find(originField).send_keys 'asd'
          errorMessage = find('span', text: 'Nenhum Resultado', match: :first)
          raise unless errorMessage.visible?
        end
      end
    end

    def CheckSearchResultsErrorDestinationNotFound(siteName)
      search_form = 'div.search-widget-header.col.l10'
      begin
        within(search_form) do
          find(@destinationField).click
          find(@destinationField).send_keys 'asd'
          errorMessage = all('span', text: 'Nenhum Resultado').last
          raise unless errorMessage.visible?
          find(@destinationField).send_keys [:command, 'r']
        end
      end
    end

    def CheckReverse(siteName)
      find('a.reverse-route').click
      numGen = Random.new
      within('div.search-result-list') do
        searchResults = all('.search-item')[0]
        within(searchResults) do     
          within('div.bus-stations') do
            departure_site = find('span.station-departure').text
            departue_place = $place2.split(',')[0]
            raise 'Wrong Departure' unless departure_site.include? departue_place
            destination_site = find('span.station-arrival').text
            destination_place = $place1.split(',')[0]
            raise 'Wrong Destination' unless destination_site.include? destination_place
          end
        end
      end
      page.find('a.reverse-route').click
      sleep 3
    rescue Exception => e
      raise 'Reverse Button Error => ' + e.to_s
    end

    def CheckWeekTab(siteName)
      within 'ul.date-tabs.tabs-fixed-width' do
        @tabs = all('a')
        i = @tabs.length - 1
        @tab_date = @tabs[i]['href']
        @tab_date = @tab_date.split('=')[1]
        @tabs[i].click
        sleep 2
      end
      ticket_dep_date = all('time.departure-time')
      ticket_dep_date.each do |item|
        raise 'Week Tab Error' if item['data-date'] != @tab_date
      end
    end

    def CheckValues(siteName)
      numGen = Random.new
      within('div.search-result-list') do
        searchResults = all('.search-item', minimum: 1)
        within(searchResults[numGen.rand(searchResults.length)]) do
          $searchresultsprice = find('div.price').text
          puts 'O preço da vigem na Search Results é: ' + $searchresultsprice
          find('.search-action-select').click
        end
      end
      sleep 1
      within('.bus-seats') do
        seatNumber = all('li.seat', minimum: 1)
        seatNumber[numGen.rand(seatNumber.length)].click
      end
    end

    def CheckReorder(siteName)
      tickets_lenght = all('div.search-result-item.valign-wrapper').length
      numGen = Random.new
      numGen = numGen.rand(tickets_lenght - 1)

      # Ordenação de Saida
      within('.sort-results') do
        reorder = find('li.hour.has-ordenation')
        reorder.click
        @order = reorder['data-order']
      end
      case @order
      when 'desc'
        puts 'Ordenado por Saida: Decrescente'
        ticket_item = all('time.departure-time')
        bigOne = ticket_item[numGen].text
        smallOne = ticket_item[numGen + 1].text
        raise 'Departure Time Descending' if bigOne < smallOne
      when 'asc'
        puts 'Ordenado por Saida: Crescente'
        ticket_item = all('time.departure-time')
        smallOne = ticket_item[numGen].text
        bigOne = ticket_item[numGen + 1].text
        raise 'Departure Time Ascending' if bigOne < smallOne
      else
        raise 'Departure Time'
      end

      # Ordenação de Duração
      within('.sort-results') do
        reorder = find('li.duration.has-ordenation')
        reorder.click
        @order = reorder['data-order']
      end
      case @order
      when 'desc'
        puts 'Ordenado por Duraçao: Decrescente'
        ticket_item = all('div.duration')
        bigOne = ticket_item[numGen]['data-duration'].tr(' ', ':')
        smallOne = ticket_item[numGen + 1]['data-duration'].tr(' ', ':')
        bigOne = bigOne.delete 'hm'
        smallOne = smallOne.delete 'hm'
        raise 'Duration Descending' if bigOne < smallOne
      when 'asc'
        puts 'Ordenado por Duraçao: Crescente'
        ticket_item = all('div.duration')
        smallOne = ticket_item[numGen]['data-duration'].tr(' ', ':')
        bigOne = ticket_item[numGen + 1]['data-duration'].tr(' ', ':')
        smallOne = smallOne.delete 'hm'
        bigOne = bigOne.delete 'hm'
        raise 'Duration Ascending' if bigOne < smallOne
      else
        raise 'Duration Time'
      end

      # Ordenação por Preço
      within('.sort-results') do
        reorder = find('li.price.has-ordenation')
        reorder.click
        @order = reorder['data-order']
      end
      case @order
      when 'asc'
        puts 'Ordenado por Preço: Crescente'
        ticket_item = all('div.price')
        smallOne = ticket_item[numGen]['data-price']
        bigOne = ticket_item[numGen + 1]['data-price']
        raise 'Price Ascending' if bigOne < smallOne
      when 'desc'
        puts 'Ordenado por Preço: Descrescente'
        ticket_item = all('div.price')
        bigOne = ticket_item[numGen]['data-price']
        smallOne = ticket_item[numGen + 1]['data-price']
        raise 'Price Descending' if bigOne < smallOne
      else
        raise 'Price :' + @order.to_s
      end
    end

    def CheckDuration(siteName)
      ticket_dep_time = all('time.departure-time')
      ticket_arr_time = all('time.return-time')
      duration = all('div.duration')
      for i in 0..(duration.length - 1)
        tick_dep_date = Time.parse(ticket_dep_time[i]['data-date'])
        tick_dep_time = Time.parse(ticket_dep_time[i]['data-time'], tick_dep_date)
        tick_arr_date = Time.parse(ticket_arr_time[i]['data-date'])
        tick_arr_time = Time.parse(ticket_arr_time[i]['data-time'], tick_arr_date)
        t = (tick_arr_time - tick_dep_time)
        mm, ss = t.divmod(60)
        hh, mm = mm.divmod(60)
        dd, hh = hh.divmod(24)
        difference = ''
        difference += "#{dd}d" if dd != 0
        difference += "#{hh}h#{mm}m"
        duration_time = duration[i]['data-duration']
        duration_time.delete! ' '
        raise 'Duration Wrong' if duration_time != difference
      end
    end

    def CheckButtonCheckout(siteName)
      button = find('.buy-button')
    end
  end
end
