//
//  ViewController.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 18/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
     
    @IBOutlet weak var buildingTable: UITableView!
    
    var buildingDetails = [BuildingDetails]()
    var currentBuildingDetails = [BuildingDetails]()
    
    var buildingSelected = ""
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.viewDidLoad()
              setUpBuildings()
              searchBar.delegate = self

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buildingSelected = buildingDetails[indexPath.row].buildingName
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentBuildingDetails.count
        }
    

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:BuildingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "buildingCell") as! BuildingTableViewCell
            cell.buildingName.text = currentBuildingDetails[indexPath.row].buildingName
            cell.buildingAddress.text = currentBuildingDetails[indexPath.row].buildingAddress
            cell.buildingAddress.numberOfLines = 0
            cell.buildingAddress.lineBreakMode = NSLineBreakMode.byWordWrapping
            return cell
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                currentBuildingDetails = buildingDetails
                buildingTable.reloadData()
                return
            }
            currentBuildingDetails = buildingDetails.filter({ buildingDetails -> Bool in
                guard let text = searchBar.text else {
                    return false
                }
                return (buildingDetails.buildingName.lowercased().contains(text.lowercased()) ||
                    buildingDetails.buildingAddress.lowercased().contains(text.lowercased()))
            })
            self.buildingTable.reloadData()
        }
        
        private func setUpBuildings() {
            buildingDetails.append(BuildingDetails(buildingName: "Pioneer", buildingAddress: "P Janardhan Reddy Nagar, Gachibowli, Hyderabad, Telangana 500081"))
            buildingDetails.append(BuildingDetails(buildingName: "Sreshta Marvel Workflo", buildingAddress: "Santosh Nagar, Mehdipatnam, Hyderabad, Telangana 500028"))
            buildingDetails.append(BuildingDetails(buildingName: "GCR", buildingAddress: "2nd Floor, Above Sri Suman Electricals, YMCA Circle, Narayanaguda, Hyderabad"))
            buildingDetails.append(BuildingDetails(buildingName: "Orchid", buildingAddress: "First Floor, Opp. Ginger Court Restaurant, Madhapur, Hyderabad, Telangana"))
            currentBuildingDetails = buildingDetails
        }

    class BuildingDetails {
        let buildingName: String
        let buildingAddress: String
        
        init(buildingName: String, buildingAddress: String) {
            self.buildingName = buildingName
            self.buildingAddress = buildingAddress
        }
    }
  

}

