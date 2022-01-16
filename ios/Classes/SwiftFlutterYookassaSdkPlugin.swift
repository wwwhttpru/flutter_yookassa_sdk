import Flutter
import UIKit
import YooKassaPayments

public class SwiftFlutterYookassaSdkPlugin: NSObject, FlutterPlugin {

    private var vc: FlutterYookassaViewController = {
        let vc = FlutterYookassaViewController()
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_yookassa_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterYookassaSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func present() {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        if (rootViewController != nil) {
            rootViewController?.present(self.vc, animated: false, completion: nil)
        }
    }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      let completionHandler = { (_ response: Result<PaymentData?, PaymentProcessError>) in
          switch response {
              case .success(let res):
                  result(TokenizationResult(success: true, data: res).toMap())
              case .failure(let error):
                  result(TokenizationResult(success: false, error: error.localizedDescription).toMap())
          }
          DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }
              self.vc.dismiss(animated: false, completion: nil)
          }
      };
      
      
      // MARK: Method tokenization
      if (call.method == "tokenization") {
              guard let myArgs = call.arguments as? [String: Any] else {
                  result(TokenizationResult(success: false, error: "iOS could not extract one of obligatory arguments " +
                      "(clientApplicationKey, shopName, purchaseDescription, amount, savePaymentMethod, tokenizationSettings) \n" +
                      "in flutter channel method: (\(call.method))").toMap())
                  return
              }
              if let clientApplicationKey = myArgs["clientApplicationKey"] as? String,
              let shopName = myArgs["shopName"] as? String,
              let purchaseDescription = myArgs["purchaseDescription"] as? String,
              let amountJson = myArgs["amount"] as? [String: Any],
              let savePaymentMethod = myArgs["savePaymentMethod"] as? String {
                  let testModeSettings = fetchTestModeSettings(myArgs: myArgs)
                  let isLoggingEnabled = myArgs["isLoggingEnabled"] as? Bool ?? false
                  let customizationSettings = fetchCustomizationSettings(myArgs: myArgs)
                  let gatewayId = myArgs["gatewayId"] as? String
                  let tokenizationSettings = fetchTokenizationSettings(myArgs: myArgs)
                  let applePayMerchantIdentifier = myArgs["applePayMerchantIdentifier"] as? String
                  let userPhoneNumber = myArgs["userPhoneNumber"] as? String
                  let moneyAuthClientId = myArgs["moneyAuthClientId"] as? String
                  let applicationScheme = myArgs["applicationScheme"] as? String
                  let tokenizationModuleInputData = TokenizationModuleInputData(
                      clientApplicationKey: clientApplicationKey,
                      shopName: shopName,
                      purchaseDescription: purchaseDescription,
                      amount: fetchAmount(amountJson),
                      gatewayId: gatewayId,
                      tokenizationSettings: tokenizationSettings,
                      testModeSettings: testModeSettings,
                      applePayMerchantIdentifier: applePayMerchantIdentifier, isLoggingEnabled: isLoggingEnabled,
                      userPhoneNumber: userPhoneNumber,
                      customizationSettings: customizationSettings,
                      savePaymentMethod: savePaymentMethod.toSavePaymentMethod(),
                      moneyAuthClientId: moneyAuthClientId,
                      applicationScheme: applicationScheme)
                  
                  // Отображаю вьюшку
                  self.present();
                  // Запускаю токенезацию
                  vc.startCheckout(
                    tokenizationModuleInputData: tokenizationModuleInputData,
                    completionHandler: completionHandler)
              }
          
          
          // MARK: Method confirm3dsCheckout
      } else if (call.method == "confirm3dsCheckout") {
          guard let args = call.arguments as? [String : Any] else {
              result(TokenizationResult(success: false, error: "iOS could not extract one of obligatory arguments " +
                  "(confirmationUrl, paymentMethodType) \n" +
                  "in flutter channel method: (\(call.method))").toMap())
              return
          }
          if let confirmationUrl = args["confirmationUrl"] as? String,
             let paymentMethodTypeArgs = args["paymentMethodType"] as? String,
             let paymentMethodType = PaymentMethodType.init(rawValue: paymentMethodTypeArgs) {
              // Отображаю вьюшку
              self.present();
              vc.startConfirmationProcess(confirmationUrl: confirmationUrl,
                                           paymentMethodType: paymentMethodType,
                                           completionHandler: completionHandler)
          }
      } else if (call.method == "bankCardRepeat") {
          guard let myArgs = call.arguments as? [String: Any] else {
              result(TokenizationResult(success: false, error: "iOS could not extract one of obligatory arguments " +
                  "(clientApplicationKey, shopName, purchaseDescription, amount, savePaymentMethod, tokenizationSettings) \n" +
                  "in flutter channel method: (\(call.method))").toMap())
              return
          }
          if let clientApplicationKey = myArgs["clientApplicationKey"] as? String,
          let shopName = myArgs["shopName"] as? String,
          let purchaseDescription = myArgs["purchaseDescription"] as? String,
          let paymentMethodId = myArgs["paymentMethodId"] as? String,
          let amountJson = myArgs["amount"] as? [String: Any],
          let savePaymentMethod = myArgs["savePaymentMethod"] as? String {
              let testModeSettings = fetchTestModeSettings(myArgs: myArgs)
              let isLoggingEnabled = myArgs["isLoggingEnabled"] as? Bool ?? false
              let customizationSettings = fetchCustomizationSettings(myArgs: myArgs)
              let gatewayId = myArgs["gatewayId"] as? String
              // TODO: Incoming version 6.6.0
//              let customerId = myArgs["customerId"] as? String
//              let isSafeDeal = myArgs["isSafeDeal"] as? Bool ?? false
              let bankCardRepeatModuleInputData = BankCardRepeatModuleInputData(
                  clientApplicationKey: clientApplicationKey,
                  shopName: shopName,
                  purchaseDescription: purchaseDescription,
                  paymentMethodId: paymentMethodId,
                  amount: fetchAmount(amountJson),
                  testModeSettings: testModeSettings,
                  isLoggingEnabled: isLoggingEnabled,
                  customizationSettings: customizationSettings,
                  savePaymentMethod: savePaymentMethod.toSavePaymentMethod(),
                  gatewayId: gatewayId)
              // TODO: Incoming version 6.6.0
//                  customerId: customerId,
//                  isSafeDeal: isSafeDeal)
              // Отображаю вьюшку
              self.present();
              vc.startBankCardCheckout(
                bankCardRepeatModuleInputData: bankCardRepeatModuleInputData,
                completionHandler: completionHandler)
          }
      }  else {
            result(FlutterMethodNotImplemented)
          }
      }
  }


struct TokenizationResult: Codable{
    var success: Bool
    var data: PaymentData?
    var error: String?
    func toMap() -> [String: Any?] {
        return ["success": success, "error": error, "data": data?.toMap()].filter { (elem) -> Bool in
            elem.value != nil
        }
    }
}

struct PaymentData: Codable {
    var token: String
    var paymentMethod: String
    func toMap() -> [String: Any?] {
        return ["token": token, "paymentMethod": paymentMethod].filter { (elem) -> Bool in
            elem.value != nil
        }
    }
}
