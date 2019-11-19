//
//  ProfileViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var pastCVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var profileScrollvIew: UIScrollView!
    
    @IBOutlet weak var consumerName: UILabel!
    @IBOutlet weak var consumerDetails: UILabel!
    
    @IBOutlet weak var activeOrdersTxt: UILabel!
    
    @IBOutlet weak var activeCV: UICollectionView!
    
    @IBOutlet weak var pastOrdersCV: UICollectionView!
    
    @IBOutlet weak var viewOlderOrdersBtn: UIButton!
    
    @IBOutlet weak var logout: UIButton!
    
    @IBAction func viewOlderOrderClicked(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "oyo_red")], for: .selected)
    viewOlderOrdersBtn.setTitleColor(UIColor(named: "oyo_red"), for: .normal)
           
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.activeCV){
            return 2
        }
        else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.activeCV){
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "activeOrdersCell", for: indexPath) as! ProfileActiveCollectionViewCell
            cellA.activeRestaurantName.text = "VNB Factory"
            cellA.activeOrderDetails.text = "Rajma Combo × 1 · Milk × 1"
            cellA.activeOrderTime.text = "September 4 · 2:30 pm"
            cellA.activeOrderPrice.text = "Rs. 150"
            cellA.activeOrderesBtn.setTitle("CALL", for: .normal)
            cellA.activeOrderesBtn.setTitleColor(UIColor(named: "secondary"), for: .normal)
            cellA.activeOrderesBtn.layer.borderWidth = 1
            cellA.activeOrderesBtn.layer.cornerRadius = 16
            cellA.activeOrderesBtn.layer.borderColor = UIColor(named: "secondary")?.cgColor
            cellA.layer.borderWidth = 1
            cellA.layer.cornerRadius = 16
            cellA.layer.borderColor = UIColor(named: "focus")?.cgColor
            
            return cellA
        }
        else{
            let cellP = collectionView.dequeueReusableCell(withReuseIdentifier: "pastOrdersCell", for: indexPath) as! PrevOrderedCollectionViewCell
            cellP.PrevOrderedRestaurantName.text = "VNB Factory"
            cellP.PrevOrderDetails.text = "Rajma Combo × 1 · Milk × 1"
            cellP.PrevOrderTime.text = "September 4 · 2:30 pm"
            cellP.PrevOrderedPrice.text = "Rs. 150"
            cellP.prevOrderedReorderBtn.setTitle("CALL", for: .normal)
            cellP.prevOrderedReorderBtn.setTitleColor(UIColor(named: "secondary"), for: .normal)
            cellP.prevOrderedReorderBtn.layer.borderWidth = 1
            cellP.prevOrderedReorderBtn.layer.cornerRadius = 16
            cellP.prevOrderedReorderBtn.layer.borderColor = UIColor(named: "secondary")?.cgColor
            cellP.layer.borderWidth = 1
           cellP.layer.cornerRadius = 16
           cellP.layer.borderColor = UIColor(named: "focus")?.cgColor
            return cellP
        }
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
