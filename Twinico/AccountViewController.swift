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

class AccountViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @objc(AccountViewController)
    
    @IBOutlet var authView: NSView!
    @IBOutlet var accountTableView: NSScrollView!
    
    let accountStore = ACAccountStore()
    var accountType:ACAccountType?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    func setup() {
        accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadViews()
    }
    
    func reloadViews() {
        
        if accountType!.accessGranted {
            self.view.addSubview(accountTableView)
            authView.removeFromSuperview()
        } else {
            self.view.addSubview(authView)
            accountTableView.removeFromSuperview()
        }
    }
    
    @IBAction func authorizeButtonClicked(sender: AnyObject) {
        
        accountStore.requestAccessToAccountsWithType(accountType!, options: nil) {
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
                
                self.reloadViews()
            })
        }
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        if !accountType!.accessGranted {
            return 0
        }
        return accountStore.accountsWithAccountType(accountType).count
    }
    
    func tableView(aTableView: NSTableView, objectValueForTableColumn aTableColumn: NSTableColumn?, row rowIndex: Int) -> AnyObject? {
        
        let allAccounts = accountStore.accountsWithAccountType(accountType!)
        let thisAccount = allAccounts[rowIndex] as ACAccount
        
        if aTableColumn?.identifier == "Username" {
            return thisAccount.username
        }
        return nil
    }
}
