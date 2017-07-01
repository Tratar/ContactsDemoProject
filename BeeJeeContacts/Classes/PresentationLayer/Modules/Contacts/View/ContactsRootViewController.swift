//
//  ContactsRootViewController.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 01/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit

class ContactsRootViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    var presenter: ContactsPresenter!
    
    var contactsMasterViewController: ContactsMasterViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        let controllers = self.viewControllers
        self.contactsMasterViewController = (controllers[0] as! UINavigationController).topViewController as? ContactsMasterViewController
    }
    
    // MARK: - Input
    
    func update(contactList: [ContactData]) {
        self.contactsMasterViewController?.reloadContactList(contacts: contactList)
    }
    
    func remove(contact: ContactData) {
        self.contactsMasterViewController?.removeContact(contact: contact)
    }
    
    func createContact() {
        self.contactsMasterViewController?.showEmptyDetail()
    }
    
    func edit(contact: ContactData) {
        self.contactsMasterViewController?.show(contact: contact)
    }
    
    func update(currentContact: ContactData?) {
        let detailViewController = self.findDetailViewController()
        detailViewController?.title = currentContact == nil ? "New Contact" : "\(currentContact!.firstName ?? "")"
    }
    
    // MARK: - Output
    
    func removeRequest(contact: ContactData) {
        self.presenter.remove(contact: contact)
    }
    
    func createRequest() {
        self.presenter.createContact()
    }
    
    func showContactDetailRequest(contact: ContactData) {
        self.presenter.editContact(contact: contact)
    }
    
    func commitContactRequest(city: String?, firstName: String?, lastName: String?, phoneNumber: String?, state: String?, streetAddress1: String?, streetAddress2: String?, zipCode: String?) {
        self.presenter.commitContact(city: city, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, state: state, streetAddress1: streetAddress1, streetAddress2: streetAddress2, zipCode: zipCode)
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? ContactsDetailViewController else { return false }
        if topAsDetailController.item == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    // MARK: - Private
    
    func findDetailViewController() -> ContactsDetailViewController? {
        guard self.viewControllers.count > 0 else {
            return nil
        }
        
        if let detailViewController = (self.viewControllers[self.viewControllers.count - 1] as? UINavigationController)?.topViewController as? ContactsDetailViewController {
            return detailViewController
        }
        
        if let navigationViewController = (self.viewControllers[self.viewControllers.count - 1] as? UINavigationController)?.topViewController as? UINavigationController, let detailViewController = navigationViewController.topViewController as? ContactsDetailViewController {
            return detailViewController
        }
        
        return nil
    }
}
