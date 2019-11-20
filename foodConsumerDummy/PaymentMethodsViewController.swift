//
//  PaymentMethodsViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 19/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class PaymentMethodsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var paymentMethodsTable: UITableView!
    var name = ["OYO Wallet", "OYO Wallet", "OYO Wallet","Cash"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentMethodCell") as! PaymentMethodTableViewCell
        if name[indexPath.row] == "Cash"{
            cell.paymentLogo.image = UIImage(named:"icCash.png")
        }
        else{
            cell.paymentLogo.image = UIImage(named:"icLettermark.png")
        }
        cell.paymentMethod.text = self.name[indexPath.row]
        cell.paymentLogo.layer.borderWidth = 1
        cell.paymentLogo.layer.borderColor = UIColor(named:"focus")?.cgColor
        cell.paymentLogo.layer.cornerRadius = 5
        cell.balance.text = "Rs. 500"
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
