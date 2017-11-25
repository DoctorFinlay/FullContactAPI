//
//  Constants.swift
//  FullContact
//
//  Created by Iain Coleman on 24/11/2017.
//  Copyright © 2017 Fiendish Corporation. All rights reserved.
//

import Foundation

//When we send a web request, we need to know if it completed or not - the completion handler is a closure that handles this
typealias CompletionHandler = (_ Success: Bool) -> ()



//API Urls
let BASE_URL = "https://api.fullcontact.com/v2/person.json?email="


//Headers
//Headers need to be a dictionary, not a string otherwise Alamofire kicks off about extra argument 'method'

//Insert your key from fullcontact.com between the empty speech marks below
let HEADER_WITH_KEY = ["X-FullContact-APIKey":""]


//Notifications
let NOTIF_SERVER_SUCCESS = Notification.Name("serverSuccess")
let NOTIF_SERVER_ERROR = Notification.Name("serverError")

