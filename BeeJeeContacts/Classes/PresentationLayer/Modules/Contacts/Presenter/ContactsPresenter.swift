//
//  ContactsPresenter.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit
import CoreData

class ContactsPresenter {
    var interactor: ContactsInteractor!
    var state: ContactsPresenterState!
    var view: ContactsRootViewController!
    
    func configure() {
        self.reloadData()
    }
    
    // MARK: - Input
    
    func createContact() {
        self.state.currentContact = nil
        self.view.createContact()
    }
    
    func remove(contact: ContactData) {
        self.interactor.removeContact(by: contact.contactID)
        let list = self.interactor.listContacts()
        self.state.contacts = list
        
        self.view.remove(contact: contact)
        
        if self.state.currentContact == contact {
            self.state.currentContact = nil
        }
    }
    
    func commitContact(city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) {
        if let contact = self.state.currentContact {
            self.state.currentContact = self.interactor.updateContact(with: contact.contactID, city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode)
        } else {
            self.state.currentContact = self.interactor.createContact(city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode)
        }
        self.reloadData()
    }

    func editContact(contact: ContactData) {
        self.state.currentContact = contact
        self.view.edit(contact: contact)
    }
    
    // MARK: - Private
    
    func reloadData() {
        let list = self.interactor.listContacts()
        self.state.contacts = list
        self.view.update(contactList: list)
        self.view.update(currentContact: self.state.currentContact)
    }
}
