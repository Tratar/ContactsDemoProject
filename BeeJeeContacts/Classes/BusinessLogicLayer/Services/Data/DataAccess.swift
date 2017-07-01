//
//  DataAccess.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit
import CoreData

class DataAccess {
    
    func createContact(contactID: String?, city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) throws -> Contact {
        let context = self.persistentContainer.viewContext
        
        let contact = Contact(context: context)
        
        contact.contactID = contactID ?? NSUUID().uuidString
        contact.city = city
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        contact.state = state
        contact.streetAddress1 = streetAddress1
        contact.streetAddress2 = streetAddress2
        contact.zipCode = zipCode
        
        context.insert(contact)
        try context.save()
        return contact
    }
    
    func updateContact(contactID: String, city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) throws -> Contact? {
        let context = self.persistentContainer.viewContext
        
        guard let contact = ((try? self.contacts(by: [contactID])) ?? []).first else {
            return nil
        }
        
        contact.city = city
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        contact.state = state
        contact.streetAddress1 = streetAddress1
        contact.streetAddress2 = streetAddress2
        contact.zipCode = zipCode
        
        try context.save()
        
        return contact
    }
    
    func contacts(by ids: [String]) throws -> [Contact]  {
        let context = self.persistentContainer.viewContext

        let request = NSFetchRequest<Contact>(entityName: "Contact")
        
        request.predicate = NSPredicate(format: "contactID IN %@", ids)
        return try context.fetch(request)
    }
    
    func list() throws -> [Contact] {
        let context = self.persistentContainer.viewContext
        
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        
        request.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true), NSSortDescriptor(key: "lastName", ascending: true)]
        
        return try context.fetch(request)
    }
    
    func remove(contacts: [Contact]) throws {
        let context = self.persistentContainer.viewContext
        
        for contact in contacts {
            context.delete(contact)
        }
        
        try context.save()
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BeeJeeContacts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
