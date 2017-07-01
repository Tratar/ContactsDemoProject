//
//  ContactData.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 01/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit

class ContactData {
    
    var contactID: String
    var city: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var state: String?
    var streetAddress1: String?
    var streetAddress2: String?
    var zipCode: String?
    
    init(contactID: String) {
        self.contactID = contactID
    }
}

extension ContactData: Equatable {
    public static func ==(lhs: ContactData, rhs: ContactData) -> Bool {
        return lhs.contactID == rhs.contactID
    }
}
