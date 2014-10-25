//
//  AccountViewController.swift
//  Twinico
//
//  Created by b123400 on 26/10/14.
//  Copyright (c) 2014 b123400. All rights reserved.
//

import Cocoa
import Accounts
import Social
import QuartzCore

class AccountViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func authorizeButtonClicked(sender: AnyObject) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        if accountType.accessGranted {
            
        }

        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
            (granted, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil {
                    let alert = NSAlert(error: error)
                    alert.runModal()
                    return
                }
                if !granted {
                    let alert = NSAlert()
                    alert.messageText = "Eh~~~ Why don't give me permission?"
                    alert.runModal()
                    return
                }
                
                let account = accountStore.accountsWithAccountType(accountType)
                if account.count == 0 {
                    let alert = NSAlert()
                    alert.messageText = "No Twitter account ar"
                    alert.runModal()
                }
                NSLog(account.description)
            })
        }
    }
}