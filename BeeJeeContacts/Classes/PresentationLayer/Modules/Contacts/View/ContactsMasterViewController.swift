//
//  MasterViewController.swift
//  BeeJeeContacts
//
//  Created by Michael Belenchenko on 30/06/2017.
//  Copyright © 2017 We. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class ContactsMasterViewController: UITableViewController {

    var presenter: ContactsPresenter!
    var contactDatas: [ContactData] = []
    var detailItem: ContactData? = nil
    
    var rootContactsViewController : ContactsRootViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        self.rootContactsViewController = splitViewController as! ContactsRootViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    func insertNewObject(_ sender: Any) {
        self.rootContactsViewController.createRequest()
    }
    
    // MARK: - Input
    
    func reloadContactList(contacts: [ContactData]) {
        self.contactDatas = contacts
        self.tableView.reloadData()
    }
    
    func showEmptyDetail() {
        self.show(contact: nil)
    }
    
    func show(contact: ContactData?) {
        self.detailItem = contact
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func removeContact(contact: ContactData) {
        if let index = self.contactDatas.index(of: contact) {
            self.contactDatas.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! ContactsDetailViewController
            _ = controller.view
            controller.item = self.detailItem
            controller.title = self.detailItem == nil ? "New Contact" : "\(self.detailItem!.firstName ?? "")"
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactData = self.contactDatas[indexPath.row]
        self.rootContactsViewController.showContactDetailRequest(contact: contactData)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactDatas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        let contact = self.contactDatas[indexPath.row]
        
        configureCell(cell!, withContact: contact)
        return cell!
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.rootContactsViewController.remove(contact: self.contactDatas[indexPath.row])
    }

    // MARK: - Private 
    
    func configureCell(_ cell: UITableViewCell, withContact contact: ContactData) {
        cell.textLabel!.text = "\(contact.firstName ?? "") \(contact.lastName ?? "")"
    }
}

