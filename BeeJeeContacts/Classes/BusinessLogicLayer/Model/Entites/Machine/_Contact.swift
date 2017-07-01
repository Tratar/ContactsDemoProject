// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.swift instead.

import Foundation
import CoreData

public enum ContactAttributes: String {
    case city = "city"
    case contactID = "contactID"
    case firstName = "firstName"
    case lastName = "lastName"
    case phoneNumber = "phoneNumber"
    case state = "state"
    case streetAddress1 = "streetAddress1"
    case streetAddress2 = "streetAddress2"
    case zipCode = "zipCode"
}

open class _Contact: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Contact"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Contact.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var city: String?

    @NSManaged open
    var contactID: String?

    @NSManaged open
    var firstName: String?

    @NSManaged open
    var lastName: String?

    @NSManaged open
    var phoneNumber: String?

    @NSManaged open
    var state: String?

    @NSManaged open
    var streetAddress1: String?

    @NSManaged open
    var streetAddress2: String?

    @NSManaged open
    var zipCode: String?

    // MARK: - Relationships

}

