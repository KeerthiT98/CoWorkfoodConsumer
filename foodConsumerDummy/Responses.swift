//
//  Responses.swift
//  foodConsumerDummy
//
//  Created by Keerthi on 20/11/19.
//  Copyright © 2019 Keerthi. All rights reserved.
//

import Foundation



public class BuildingData{
    let count : Int
    let data : Array<BuildingResponse>
    
    init(json : [String: Any]) {
        count = json["count"] as! Int
        data = json["data"] as! Array<BuildingResponse>
    }
}

public class BuildingResponse{
    let buildingType : String
    let catalogId :String
    let geoLocation : GeoLocation
    let locationId : String
    let name : String
    let primaryAddress : Address
    
    init(buildingType : String, catalogId:String,geoLocation : GeoLocation,locationId : String, name : String,primaryAddress: Address) {
        self.buildingType = buildingType
        self.catalogId = catalogId
        self.geoLocation = geoLocation
        self.locationId = locationId
        self.name = name
        self.primaryAddress = primaryAddress
    }
}

public class GeoLocation{
    let latitude : Int
    let longitude : Int
    
    init(latitude: Int,longitude : Int) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public class Address{
    let addressLine1 : String
    let addressLine2 : String
    let city : String
    let country : String
    let countryCode : String
    let postalCode : String
    let state : String
    
    init(addressLine1: String,addressLine2:String,city:String,country:String,countryCode:String,postalCode:String,state:String) {
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.country = country
        self.countryCode = countryCode
        self.postalCode = postalCode
        self.state = state
    }
}
