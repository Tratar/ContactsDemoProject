//
//  Dependencies.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit


class Dependencies {
    
    let dataAccess = DataAccess()
    let dataImporter = DataImporter()
    
    let contactsRouter = ContactsRouter()
    let contactsInteractor = ContactsInteractor()
    let contactDataMapper = ContactDataMapper()
    
    func configure(window: UIWindow) {
        self.dataImporter.dataAccess = self.dataAccess
        
        self.contactsInteractor.dataAccess = self.dataAccess
        self.contactsInteractor.dataImporter = self.dataImporter
        self.contactsInteractor.contactDataMapper = self.contactDataMapper
        
        self.contactsRouter.contactsInteractor = self.contactsInteractor
        self.contactsRouter.window = window
        
        dataImporter.importData()
    }
    
    func presentContactsScreen() {
        self.contactsRouter.presentContacts()
    }
}
