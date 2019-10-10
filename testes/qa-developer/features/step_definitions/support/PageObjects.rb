module PageObjects
  $poDesktop = Desktop.new

  class Home
    def SearchForm(siteName)
      $poDesktop.fill_search(siteName)
    end

    def fill_searchcustom(siteName)
      $poDesktop.fill_searchcustom(siteName)
    end

    def CalendarCommand(siteName)
      $poDesktop.fill_calendar
    end

    def CalendarCommandAmp(siteName)
      $poDesktop.fill_calendar
    end

    def PerformSearch(siteName)
      $poDesktop.searchButton
    end

    def CheckHomeHeader(siteName)
      $poDesktop::CheckHeaderHome(siteName)
    end
  end

  class SearchResults
    def SearchForm(siteName)
      $poDesktop.fill_hori_search
    end

    def CalendarCommand(siteName)
      $poDesktop.hori_calendar
    end

    def VerifyCloseDate(siteName)
      $poDesktop::verifyCloseDate(siteName)
    end

    def PerformSearch(siteName)
      $poDesktop.searchButton
    end

    def HeaderSearch(siteName)
      $poDesktop.CheckHeaderSearch(siteName)
    end

    def CheckSearchResults(siteName)
      $poDesktop.CheckResults(siteName)
    end

    def CheckDate(siteName)
      $poDesktop.CheckDateSearch(siteName)
    end

    def CheckFilters(siteName)
      $poDesktop.CheckFiltersSearch(siteName)
    end

    def CheckTerminalsInformations(siteName)
      $poDesktop.checkTerminalsInformations(siteName)
    end

    def selectCompanyBySlug(siteName)
      $poDesktop.SelectCompanybyslug(siteName)
    end

    def checkCompanyfilteredBySlug(siteName)
      $poDesktop.CheckFilterbyCompany(siteName)  
    end

    def SortBy(filter)
      $poDesktop.sortBy(filter)
    end

    def checkCompass(siteName)
      $poDesktop.checkCompass(siteName)
    end

    def checkGtmClient(clientid, siteName)
      $poDesktop.checkGtmClient(clientid, siteName)
    end

    def checkSite(siteName)
      $poDesktop.checkSite(siteName)
    end

    def RandomSelect(siteName)
      $poDesktop.selectResult(siteName)
    end

    def SelectETicket(siteName)
      $poDesktop.selectETicketResult
    end

    def SelectNoETicket(siteName)
      $poDesktop.selectNoETicketResult
    end

    def RandomSelectSeats(siteName)
      $poDesktop.selectSeat
    end

    def ContinueBooking(siteName)
      $poDesktop.bookingButton
    end

    def verifyRoundTrip(siteName)
      $poDesktop.roundTrip(siteName)
    end
  end

  class Seatmap
    def Close(siteName)
      $poDesktop.close
    end

    def ValidateMessageAlertonSeatMap(siteName)
      $poDesktop.ValidateMessageSelectSeat()
    end
  end

  class Checkout
    def getSumaryValues(siteName)
      $poDesktop.getOrderSummary
    end

    def checkLogged(siteName)
      $poDesktop.checkIfLogged
    end

    def FillPassengerData()
      $poDesktop.passengerData()
    end

    def CheckInsurance(siteName)
      $poDesktop.checkInsurance(siteName)
    end

    def FillPaymentData(paymentType, siteName)
      $poDesktop.paymentData(paymentType, siteName)
    end

    def FillPaymentSavedCard(paymentType, siteName)
      $poDesktop.paymentSavedCard(paymentType, siteName)
    end

    def SubmitPurchase(siteName)
      $poDesktop.confirmButton(siteName)
    end

    def ConfirmPurchase(siteName)
      $poDesktop.verifyPurchase(siteName)
      $poDesktop.getOrderId
    end

    def VerifyAlertPayment(siteName)
      $poDesktop.verifyAlertPayment(siteName)
    end

    def VerifyEticketCheckout(siteName)
      $poDesktop.verifyEticketCheckout
    end

    def confirmEOForder(siteName)
      $poDesktop.verifyPurchaseEOF(siteName)
      $orderId = $poDesktop.getOrderId
    end

    def FillBankInformations(siteName)
      $poDesktop.fillBankInformations(siteName)
    end

    def FillVoucherData(siteName)
      $poDesktop.fillVoucherData(siteName)
    end

    def FillCreditCardName(siteName)
      $poDesktop.fillCreditCardName(siteName)
    end

    def Checklogo(siteName)
      $poDesktop.CheckLogo(siteName)
    end

    def CheckPassenger(siteName)
      $poDesktop.CheckPassengerCard(siteName)
    end

    def CheckPassengerContact(siteName)
      $poDesktop.CheckContactCard(siteName)
    end

    def CheckPayment(siteName)
      $poDesktop.CheckPaymentCard(siteName)
    end

    def FooterCheckout(siteName)
      $poDesktop.CheckFooterCheckout(siteName)
    end
  end

end
