//
//  ContactDataFabric.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 01/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit
import CoreData

class ContactDataMapper {
    
    func map(contact: Contact) -> ContactData {
        let contactData = ContactData(contactID: contact.contactID!)
        contactData.city = contact.city
        contactData.firstName = contact.firstName
        contactData.lastName = contact.lastName
        contactData.phoneNumber = contact.phoneNumber
        contactData.state = contact.state
        contactData.streetAddress1 = contact.streetAddress1
        contactData.streetAddress2 = contact.streetAddress2
        contactData.zipCode = contact.zipCode
        return contactData
    }
    
    func map(contacts: [Contact]) -> [ContactData] {
        return contacts.map(map)
    }
}
