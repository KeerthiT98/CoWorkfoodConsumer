//
//  HomeViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var PrevOrderedCollectionView: UICollectionView!
    
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var buildingView: UIView!
    @IBOutlet weak var restaurantTableView: UITableView!
    
    @IBOutlet weak var prevOrderedTxt: UILabel!
    @IBOutlet weak var restauarntsTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prevOrderedTxt.textColor = UIColor(named: "text light")
        restauarntsTxt.textColor = UIColor(named: "text light")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 2
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restroCell") as! RestaurantTableViewCell
        cell.restaurantImg.image = UIImage(named: "Restaurant")
        cell.restaurantName.text = "Masala Fusion Delight"
        cell.restaurantTags.text = "Chinese · Asian · Thai · Indian"
        cell.restaurantAvPrice.text = "Rs. 200 for two"
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        cell.layer.borderColor = UIColor(named: "focus")?.cgColor
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemListingSegue", sender: self)
    }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 5
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrevOrderedCell", for: indexPath) as! PrevOrderedCollectionViewCell
        cell.PrevOrderedRestaurantName.text = "VNB Factory"
        cell.PrevOrderDetails.text = "Rajma Combo × 1 · Milk × 1"
        cell.PrevOrderTime.text = "Sep 2 · 2:20 pm"
        cell.PrevOrderedPrice.text = "Rs. 150"
        cell.prevOrderedReorderBtn.setTitle("REORDER",for: .normal)
        cell.prevOrderedReorderBtn.setTitleColor(UIColor(named: "secondary"), for: .normal)
        cell.prevOrderedReorderBtn.layer.borderColor = UIColor(named: "secondary")?.cgColor
        cell.prevOrderedReorderBtn.layer.borderWidth = 1
        cell.prevOrderedReorderBtn.layer.cornerRadius = 4
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        cell.layer.borderColor = UIColor(named: "focus")?.cgColor
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
