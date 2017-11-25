//
//  APIDataService.swift
//  FullContact
//
//  Created by Iain Coleman on 24/11/2017.
//  Copyright © 2017 Fiendish Corporation. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class APIDataService {
    
    static let instance = APIDataService()
    
    public private(set) var responseStatus = Int()
    public private(set) var personName = String()
    public private(set) var personGender = String()
    public private(set) var personLocation = String()
    public private(set) var personImageUrls = [String]()
    public private(set) var personSocialNetworkName = [String]()
    public private(set) var personSocialNetworkUrl = [String]()
    public private(set) var personDigitalFootprint = [String]()
    
    
    enum jsonKeys : String {
        
        case status
        case message
        case likelihood
        
        case photos
        case typeName
        case url
        case isPrimary
        
        case contactInfo
        case chats
        case websites
        case familyName
        case fullName
        case givenName
        
        case organizations
        // case isPrimary
        case name
        case title
        case startDate
        
        case demographics
        case locationDeduced
        case normalizedLocation
        case city
        case state
        case country
        case continent
        case county
        case gender
        
        case socialProfiles
        //case typeName
        //case url
        
        case digitalFootprint
        case topics
        case value
    }
    
    
    func getPersonData(email: String, completion: @escaping CompletionHandler) {
        
        //Clear previous data
        personName = ""
        personGender = ""
        personLocation = ""
        personImageUrls.removeAll()
        personSocialNetworkUrl.removeAll()
        personSocialNetworkName.removeAll()
        personDigitalFootprint.removeAll()
        
        let fullUrl = "\(BASE_URL)\(email)"
        
        Alamofire.request(fullUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_WITH_KEY).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setPersonData(data: data)
                completion(true)
            } else {
                completion(false)
                print("Nope!")
                //Notification posted to say there is a server error
                NotificationCenter.default.post(name: NOTIF_SERVER_ERROR, object: nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setPersonData(data: Data) {
        do {
            let json = try JSON(data: data)
            responseStatus = json[jsonKeys.status.rawValue].int!
            if responseStatus == 200 {
                NotificationCenter.default.post(name: NOTIF_SERVER_SUCCESS, object: nil)
                personName = json[jsonKeys.contactInfo.rawValue][jsonKeys.fullName.rawValue].stringValue
                personGender = json[jsonKeys.demographics.rawValue][jsonKeys.gender.rawValue].stringValue
                personLocation = json[jsonKeys.demographics.rawValue][jsonKeys.locationDeduced.rawValue][jsonKeys.normalizedLocation.rawValue].stringValue
                personImageUrls = json[jsonKeys.photos.rawValue].arrayValue.map{$0[jsonKeys.url.rawValue].stringValue}
                personSocialNetworkName = json[jsonKeys.socialProfiles.rawValue].arrayValue.map{$0[jsonKeys.typeName.rawValue].stringValue}
                personSocialNetworkUrl = json[jsonKeys.socialProfiles.rawValue].arrayValue.map{$0[jsonKeys.url.rawValue].stringValue}
                personDigitalFootprint = json[jsonKeys.digitalFootprint.rawValue].arrayValue.map{$0[jsonKeys.topics.rawValue][jsonKeys.value.rawValue].stringValue}
                print("Person name is \(personName)")
            }
        } catch {
            print(error)
        }  
    }
    
    
    
}
