//
//  ItemListingViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ItemListingViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var itemListingRestaurantName: UILabel!
    
    @IBOutlet weak var itemListingTags: UILabel!
    
    @IBOutlet weak var itemListingSearchBar: UISearchBar!
    
    @IBOutlet weak var prevOrderedTxt: UILabel!
    
    @IBOutlet weak var itemPrevOrderedCollectionView: UICollectionView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
