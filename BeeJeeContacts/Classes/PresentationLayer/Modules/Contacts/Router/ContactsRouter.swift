//
//  ContactsRouter.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit

class ContactsRouter: UISplitViewControllerDelegate {

    var contactsInteractor: ContactsInteractor!
    var window: UIWindow!
    
    func presentContacts() {
        let storyboard = UIStoryboard(name: "Contacts", bundle: nil)
        
        let rootViewController = storyboard.instantiateInitialViewController() as! ContactsRootViewController
        rootViewController.preferredDisplayMode = .allVisible
        
        let navigationController = rootViewController.viewControllers[rootViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = rootViewController.displayModeButtonItem
        rootViewController.delegate = rootViewController
    
        let presenter = ContactsPresenter()
        rootViewController.presenter = presenter

        presenter.view = rootViewController
        presenter.state = ContactsPresenterState()
        presenter.interactor = contactsInteractor
        
        presenter.configure()

        self.window.rootViewController = rootViewController
    }
}
