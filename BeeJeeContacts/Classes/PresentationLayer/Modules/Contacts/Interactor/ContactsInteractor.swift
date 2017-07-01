//
//  ContactsInteractor.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit
import CoreData

class ContactsInteractor {
    
    var dataAccess: DataAccess!
    var dataImporter: DataImporter!
    var contactDataMapper: ContactDataMapper!
    
    // MARK: - Input
    
    func listContacts() -> [ContactData] {
        return contactDataMapper.map(contacts: (try? dataAccess.list()) ?? [])
    }
    
    func updateContact(with contactID: String, city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) -> ContactData? {
        if let contactOpt = try? self.dataAccess.updateContact(contactID: contactID, city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode), let contact = contactOpt {
            return self.contactDataMapper.map(contact: contact)
        }
        return nil
    }
    
    func removeContact(by contactID: String) {
        if let contact = ((try? dataAccess.contacts(by: [contactID])) ?? []).first {
            try? dataAccess.remove(contacts: [contact])
        }
    }
    
    func createContact(city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) -> ContactData? {
        if let contact = try? self.dataAccess.createContact(contactID: nil, city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode) {
            return self.contactDataMapper.map(contact: contact)
        }
        return nil
    }
}
