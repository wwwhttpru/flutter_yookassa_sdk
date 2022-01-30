import Flutter
import UIKit
import Foundation
import PassKit
import YooKassaPayments


typealias ResultCompletionHandler = ((_ result: Result<PaymentData?, PaymentProcessError>) -> Void)

/// Decoding errors.
public enum PaymentProcessError: Error {

    case cancelled

    /// This error is possible if you use `TokenizationFlow.bankCardRepeat`,
    /// and by paymentMethodId was not found any saved payment methods.
    case paymentMethodNotFound

    case on3dsConfirmNotFound
}

final class FlutterYookassaViewController: UIViewController {
    // MARK: - Properties
    private var resultCompletionHandler: ResultCompletionHandler?
    private var tokenizationViewController: UIViewController?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .clear
        view.isOpaque = false
        super.viewDidLoad()
    }


    public func startCheckout(
        tokenizationModuleInputData: TokenizationModuleInputData,
        completionHandler: @escaping ResultCompletionHandler
        )  {
       resultCompletionHandler = completionHandler
        let inputData: TokenizationFlow = .tokenization(tokenizationModuleInputData)
        let viewController = TokenizationAssembly.makeModule(inputData: inputData, moduleOutput: self)
            self.tokenizationViewController = viewController;
            self.present(viewController, animated: true)
    }

    public func startConfirmationProcess(
        confirmationUrl: String,
        paymentMethodType: PaymentMethodType,
        completionHandler: @escaping ResultCompletionHandler
    ) {
        self.resultCompletionHandler = completionHandler
        if (self.tokenizationViewController != nil && self.tokenizationViewController is TokenizationModuleInput) {
            self.present(self.tokenizationViewController!, animated: true)
            (self.tokenizationViewController as! TokenizationModuleInput)
                .startConfirmationProcess(
                    confirmationUrl: confirmationUrl,
                    paymentMethodType: paymentMethodType
                )
        } else {
            self.resultCompletionHandler?(Result.failure(.on3dsConfirmNotFound))
        }
    }

    public func startBankCardCheckout(
        bankCardRepeatModuleInputData: BankCardRepeatModuleInputData,
        completionHandler: @escaping ResultCompletionHandler
    ) {
        self.resultCompletionHandler = completionHandler
        let inputData: TokenizationFlow = .bankCardRepeat(bankCardRepeatModuleInputData)
        let viewController = TokenizationAssembly.makeModule(inputData: inputData, moduleOutput: self)
        self.tokenizationViewController = viewController
        self.present(viewController, animated: true)
    }


}

extension FlutterYookassaViewController: TokenizationModuleOutput {
    func didSuccessfullyPassedCardSec(on module: TokenizationModuleInput) {
        print("didSuccessfullyPassedCardSec")
    }


    func tokenizationModule(
        _ module: TokenizationModuleInput,
        didTokenize token: Tokens,
        paymentMethodType: PaymentMethodType
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            // Отправьте токен в вашу систему
            self.resultCompletionHandler?(
                Result.success(
                    PaymentData(
                        token: token.paymentToken,
                        paymentMethod: paymentMethodType.rawValue)
                )
            )
        }
    }

    func didFinish(
        on module: TokenizationModuleInput,
        with error: YooKassaPaymentsError?
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            var result: Result<PaymentData?, PaymentProcessError>
            if let error = error {
                switch error {
                case .paymentMethodNotFound:
                    result = Result.failure(.paymentMethodNotFound)
                }
            } else {
                result = Result.failure(.cancelled)
            }
            self.resultCompletionHandler?(
                result
            )
        }
    }

    func didSuccessfullyConfirmation(
        paymentMethodType: PaymentMethodType
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            // Создать экран успеха после прохождения подтверждения (3DS или Sberpay)
            // Показать экран успеха
            self.resultCompletionHandler?(
                Result.success(nil)
            )
        }
    }
}

