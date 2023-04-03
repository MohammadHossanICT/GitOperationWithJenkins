//
//  ViewController.swift
//  AppleExamplePay
//
//  Created by M A Hossan on 03/04/2023.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    @IBOutlet weak var btn_pay: UIButton!
    @IBOutlet weak var textFieldAmount: UITextField!

    private var payment : PKPaymentRequest = PKPaymentRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_pay.addTarget(self, action: #selector(tapForPay), for: .touchUpInside)

        payment.merchantIdentifier = "merchant.Swift.AppleWallet"
        payment.supportedNetworks = [.quicPay,.masterCard, .visa,
                                     .amex, .maestro]
        payment.supportedCountries = ["IN", "US","GB"]
        payment.merchantCapabilities = .capability3DS
        payment.countryCode = "GB"
        payment.currencyCode = "GBP"
    }
    @objc func tapForPay(){
        if !textFieldAmount.text!.isEmpty {
            let amount = textFieldAmount.text!
            payment.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPhone XR 128 GB", amount: NSDecimalNumber(string: amount))]

            let controller = PKPaymentAuthorizationViewController(paymentRequest: payment)
            if controller != nil {
                controller!.delegate = self
                present(controller!, animated: true, completion: nil)
            }
        }
    }
}
extension ViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}

