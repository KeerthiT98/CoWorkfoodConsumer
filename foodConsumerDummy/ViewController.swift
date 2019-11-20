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
    
    let url_string = "http://prod-cowork-p-food-bff-api.ap-southeast-1.elasticbeanstalk.com/api/wsfoodordering_preprod/"
    
    var buildingId = " "
    
    var buildingDetails = [BuildingDetails]()
    var currentBuildingDetails = [BuildingDetails]()
    
    var buildingSelected = ""
    
    let preferences  = UserDefaults.standard
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
              setUpBuildings()
              searchBar.delegate = self
        searchBar.backgroundImage = UIImage()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buildingSelected = buildingDetails[indexPath.row].buildingName
        buildingId = buildingDetails[indexPath.row].buildingId
    
        preferences.set(buildingId, forKey: "vendorLocationId")
         let session = URLSession.shared
        var urlE =  NSURLComponents(string: url_string + "consumer/menu/getcanteens")!
        urlE.queryItems = [URLQueryItem(name: "buildingId", value: buildingId)]
        
            
        var request = URLRequest(url: urlE.url!)
        print(request)
        request.addValue("sherlock", forHTTPHeaderField: "accessToken")
        request.addValue("CorporateGuest", forHTTPHeaderField: "deviceRole")
        
            let task = session.dataTask(with: request){ (data, response, error) in
            if error != nil || data==nil{
                 print("Error")
                 return
                        }
            do{
                let resp = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                print(resp)
                            
                guard let newValue = resp as? [String: Any] else{
                print("invalid form")
                return
            }
            print(newValue)
        }
        catch{
            print("JSON Error")
        }
    }
         task.resume()
         performSegue(withIdentifier: "homeSegue", sender: self)
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentBuildingDetails.isEmpty){
            return 0
        }
            return currentBuildingDetails.count
        }
    

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:BuildingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "buildingCell") as! BuildingTableViewCell
            cell.buildingName.text = currentBuildingDetails[indexPath.row].buildingName
//            print(":::::::::")
            print(currentBuildingDetails[indexPath.row])
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
            currentBuildingDetails = buildingDetails.filter({ buildingDetail -> Bool in
                guard let text = searchBar.text else {
                    return false
                }
                return (buildingDetail.buildingName.lowercased().contains(text.lowercased()) ||
                    buildingDetail.buildingAddress.lowercased().contains(text.lowercased()))
            })
            self.buildingTable.reloadData()
        }
        
        private func setUpBuildings() {
//            buildingDetails.append(BuildingDetails(buildingName: "Pioneer", buildingAddress: "P Janardhan Reddy Nagar, Gachibowli, Hyderabad, Telangana 500081"))
//            buildingDetails.append(BuildingDetails(buildingName: "Sreshta Marvel Workflo", buildingAddress: "Santosh Nagar, Mehdipatnam, Hyderabad, Telangana 500028"))
//            buildingDetails.append(BuildingDetails(buildingName: "GCR", buildingAddress: "2nd Floor, Above Sri Suman Electricals, YMCA Circle, Narayanaguda, Hyderabad"))
//            buildingDetails.append(BuildingDetails(buildingName: "Orchid", buildingAddress: "First Floor, Opp. Ginger Court Restaurant, Madhapur, Hyderabad, Telangana"))
//            currentBuildingDetails = buildingDetails
            
            let session = URLSession.shared
            
            if let url = URL(string: url_string + "catalog/building/all"){
            
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil || data==nil{
                    print("Error")
                    return
                }
                do{
                    let res = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
                    print(res)
                    
                    guard let newValue = res as? [String: Any] else{
                        print("invalid form")
                        return
                    }
                    print(newValue)
                    let buildingData = newValue["data"] as? [[String: Any]]
                    for i in buildingData!{
//                        print(i["name"] as! String + "}}}}}}")
                        var buildingAddress = i["primaryAddress"] as? [String: String]
                        var address1 = buildingAddress?["addressLine1"] ?? " "
                        var address2 = buildingAddress?["addressLine2"] ?? " "
                        self.buildingDetails.append(BuildingDetails.init(buildingId: i["locationId"] as! String,buildingName: i["name"] as! String, buildingAddress: address1  + " " + address2))
                    }
                    self.currentBuildingDetails = self.buildingDetails
                    DispatchQueue.main.async {
                        self.buildingTable.reloadData()
                          }
//                    self.buildingTable.reloadData()
                }
                catch{
                    print("JSON Error")
                }
            }
                 task.resume()
            }
            
        }
    
    //api response

    class BuildingDetails {
        let buildingId: String
        let buildingName: String
        let buildingAddress: String
        
        init(buildingId:String,buildingName: String, buildingAddress: String) {
            self.buildingId = buildingId
            self.buildingName = buildingName
            self.buildingAddress = buildingAddress
        }
    }
    

}

