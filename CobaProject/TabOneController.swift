//
//  TabOneController.swift
//  CobaProject
//
//  Created by Fery Syukur on 3/20/17.
//  Copyright © 2017 Fery Syukur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class TabOneController: UIViewController, UINavigationControllerDelegate {
    
    let imgProfile : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = img.layer.frame.width/2
        img.layer.masksToBounds = true
        img.image = UIImage(named: "userImage")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))

        view.backgroundColor = .white
        view.addSubview(imgProfile)
        
        imgProfile.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgProfile.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        imgProfile.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgProfile.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
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
