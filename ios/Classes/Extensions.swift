import Foundation
import YooKassaPayments

// Возвращает Amount
func fetchAmount(_ amountJson: [String: Any]) -> Amount{
    let value = amountJson["value"] as! Double
    let currencyArgs = amountJson["currency"] as! [String: Any]
    let currency = (currencyArgs["value"] as! String).toCurrency()
    return Amount(value: Decimal(Double(round(100*value)/100)),
                  currency: currency)
}


func fetchTokenizationSettings(myArgs: [String : Any]) -> TokenizationSettings {
    var tokenizationSettings = TokenizationSettings()
    if let tokenizationSettingsArgs = myArgs["tokenizationSettings"] as? [String: Any],
       let paymentMethodTypesArgs = tokenizationSettingsArgs["paymentMethodTypes"] as? [String: Any],
       let rawValue = paymentMethodTypesArgs["rawValue"] as? Array<String>,
       let showYooKassaLogo = tokenizationSettingsArgs["showYooKassaLogo"] as? Bool {
        var paymentTypes: PaymentMethodTypes = []
        if (rawValue.contains("bank_card")) {
            paymentTypes.insert(.bankCard)
        }
        if (rawValue.contains("sberbank")) {
            paymentTypes.insert(.sberbank)
        }
        if (rawValue.contains("apple_pay")) {
            paymentTypes.insert(.applePay)
        }
        if (rawValue.contains("yoo_money")) {
            paymentTypes.insert(.yooMoney)
        }
        
        tokenizationSettings = TokenizationSettings(
            paymentMethodTypes: paymentTypes,
            showYooKassaLogo: showYooKassaLogo
        )
    }
    return tokenizationSettings
}

func fetchCustomizationSettings(myArgs: [String : Any]) -> CustomizationSettings {
    var customizationSettings: CustomizationSettings = CustomizationSettings()
    if let customizationSettingsArgs = myArgs["customizationSettings"] as? [String: Any],
       let hex = customizationSettingsArgs["mainScheme"] as? String {
        let mainScheme = UIColor.init(hex: hex) ?? CustomizationColors.blueRibbon
        customizationSettings = CustomizationSettings(mainScheme: mainScheme)
    }
    return customizationSettings
}

func fetchTestModeSettings(myArgs: [String : Any]) -> TestModeSettings? {
    var testModeSettings: TestModeSettings? = nil
    
    // Если есть test mode settings
    if let testModeSettingsArgs = myArgs["testModeSettings"] as? [String: Any],
       
        // paymentAuthorizationPassed
       let paymentAuthorizationPassed = testModeSettingsArgs["paymentAuthorizationPassed"] as? Bool,
       
        // cardsCount кол-во карточек
    let cardsCount = testModeSettingsArgs["cardsCount"] as? Int,
       
        
    let testAmountJson = testModeSettingsArgs["charge"] as? [String: Any],
       
    let enablePaymentError = testModeSettingsArgs["enablePaymentError"] as? Bool
    {
        testModeSettings = TestModeSettings(
            paymentAuthorizationPassed: paymentAuthorizationPassed,
            cardsCount: cardsCount,
            charge: fetchAmount(testAmountJson),
            enablePaymentError: enablePaymentError)
    }
    return testModeSettings
}




extension String {
    func toCurrency() -> Currency {
        switch self {
        case "RUB":
            return Currency.rub
        case "USD":
            return Currency.usd
        case "EUR":
            return Currency.eur
        default:
            return Currency.custom(self)
        }
    }

    func toSavePaymentMethod() -> SavePaymentMethod {
        switch self {
        case "on":
            return SavePaymentMethod.on
        case "off":
            return SavePaymentMethod.off
        case "user_selects":
            return SavePaymentMethod.userSelects
        default:
            return SavePaymentMethod.userSelects
        }
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x000000ff) >> 0) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
