//
//  PayPalClientSidePayment.swift
//  ParkingManagement
//
//  Created by iOSDev on 03/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import Braintree

class PaypalPayment: NSObject {
    
    static var sharedPayment = PaypalPayment()
    var braintree: BTAPIClient?
    var token = ""
    
    func fetchClientToken() {
         BTAppSwitch.setReturnURLScheme("com.park.app.payments")
        
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            self.token = String(data: data!, encoding: String.Encoding.utf8)!
            print("Token generated and is \(self.token)")

            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    
}
