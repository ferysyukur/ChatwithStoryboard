//
//  ViewController.swift
//  CobaProject
//
//  Created by Fery Syukur on 3/20/17.
//  Copyright © 2017 Fery Syukur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseGoogleAuthUI

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSignOut(){
        do {
            try FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Error Sign Out")
        }
    }


}

