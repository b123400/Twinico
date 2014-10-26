//
//  PreferenceWindowController.swift
//  Twinico
//
//  Created by b123400 on 26/10/14.
//  Copyright (c) 2014 b123400. All rights reserved.
//

import Cocoa

class PreferenceWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        let accountViewController = AccountViewController(nibName:"AccountViewController", bundle:NSBundle.mainBundle())
        
        if let window = self.window {
            if let vc = accountViewController {
                contentViewController = accountViewController
            }
        }
    }
    
}
