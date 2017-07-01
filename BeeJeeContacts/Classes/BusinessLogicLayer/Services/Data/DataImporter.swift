//
//  DataImporter.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit
import CoreData

let fileImportName = "contactsData"
let fileImportExt = "json"

class DataImporter {
    var dataAccess: DataAccess!
    
    func importData() {
        guard let url = Bundle.main.url(forResource: fileImportName, withExtension: fileImportExt) else {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        guard let parsedJSON = try? JSONSerialization.jsonObject(with: data, options: []), let typedJSON = parsedJSON as? [String: Any], let contacts = typedJSON["contacts"] as? [[String: String]] else {
            return
        }
        
        for item in contacts {
            self.importEntity(entityJSONRepresentation: item)
        }
    }
    
    private func importEntity(entityJSONRepresentation: [String: String]) {
        let contactID = entityJSONRepresentation["contactID"]!
        let city = entityJSONRepresentation["city"]
        let firstName = entityJSONRepresentation["firstName"]
        let lastName = entityJSONRepresentation["lastName"]
        let phoneNumber = entityJSONRepresentation["phoneNumber"]
        let state = entityJSONRepresentation["state"]
        let streetAddress1 = entityJSONRepresentation["streetAddress1"]
        let streetAddress2 = entityJSONRepresentation["streetAddress2"]
        let zipCode = entityJSONRepresentation["zipCode"]
        
        let alreadyExisted = try? dataAccess.contacts(by: [contactID])
        if let alreadyExisted = alreadyExisted, (alreadyExisted.first) == nil {
            _ = try? dataAccess.createContact(contactID: contactID, city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode)
        }
    }
}
