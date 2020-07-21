//
//  ContactButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 4/6/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

open class ContactButton: UIButton {
    
    open var userPickedContactNumber: ((String)->Void)?
    open var controllerForPresantation: UIViewController?
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(openContacts), for: .touchUpInside)
    }
    
    @objc private func openContacts() {
        let contactViewController = CNContactPickerViewController()
        
        contactViewController.displayedPropertyKeys = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
        contactViewController.delegate = self
        contactViewController.modalPresentationStyle = .overFullScreen
        contactViewController.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactViewController.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        
        
        controllerForPresantation?.present(contactViewController, animated: true)
        
//        CNContactStore().requestAccess(for: .contacts) { (access, error) in
//            debugPrint("Access: \(access)")
//
//        }
    }
}

extension ContactButton: CNContactPickerDelegate {
    open func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contactProperty: CNContactProperty) {
        guard let phone = contactProperty.value as? CNPhoneNumber else { return }
        let phoneNumber = phone.stringValue
        userPickedContactNumber?(phoneNumber)
    }

    open func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        let firstPhoneNumber = userPhoneNumbers[0].value.stringValue
        userPickedContactNumber?(firstPhoneNumber)
    }

    open func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
}
