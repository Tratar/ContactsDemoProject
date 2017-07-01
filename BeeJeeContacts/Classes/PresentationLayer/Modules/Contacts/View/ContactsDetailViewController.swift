//
//  DetailViewController.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    var rootContactsViewController : ContactsRootViewController!

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var streetAddress1TextField: UITextField!
    @IBOutlet weak var streetAddress2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var item: ContactData? {
        didSet {
            configureView()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.rootContactsViewController = splitViewController as! ContactsRootViewController
    }
    
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        self.save()
    }
    
    // MARK: - Private
    
    private func configureView() {
        self.firstNameTextField.text = item?.firstName
        self.lastNameTextField.text = item?.lastName
        self.phoneNumberTextField.text = item?.phoneNumber
        self.streetAddress1TextField.text = item?.streetAddress1
        self.streetAddress2TextField.text = item?.streetAddress2
        self.cityTextField.text = item?.city
        self.stateTextField.text = item?.state
        self.zipCodeTextField.text = item?.zipCode
    }
    
    private func save() {
        self.rootContactsViewController.commitContactRequest(city: cityTextField.text, firstName: firstNameTextField.text, lastName: lastNameTextField.text, phoneNumber: phoneNumberTextField.text, state: stateTextField.text, streetAddress1: streetAddress1TextField.text, streetAddress2: streetAddress2TextField.text, zipCode: zipCodeTextField.text)
    }
}

