//
//  MainViewController
//  Twinico
//
//  Created by b123400 on 26/10/14.
//  Copyright (c) 2014 b123400. All rights reserved.
//

import Cocoa
import Accounts
import Social

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AccountViewController.canStartStream() {
            startStream()
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func startStream() {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        let accounts = accountStore.accountsWithAccountType(accountType)
        if accounts.count > 0 {
            let thisAccount = accounts[0] as ACAccount
            let twitter = STTwitterAPI.twitterAPIOSWithAccount(thisAccount)
            
            twitter.getUserStreamDelimited(nil,
                stallWarnings: nil,
                includeMessagesFromFollowedAccounts: nil,
                includeReplies: 1,
                keywordsToTrack: nil,
                locationBoundingBoxes: nil,
                progressBlock: { (response) -> Void in
                    NSLog(response.description);
            }, stallWarningBlock: { (code, message, percentFull) -> Void in
                NSLog("Stall warining %@ %@ %d", code, message, percentFull)
            }, errorBlock: { (error) -> Void in
                NSLog("error %@", error.description)
            })
            
        }
    }
}

