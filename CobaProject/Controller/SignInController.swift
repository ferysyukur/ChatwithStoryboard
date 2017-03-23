//
//  SignInController.swift
//  CobaProject
//
//  Created by Fery Syukur on 3/23/17.
//  Copyright © 2017 Fery Syukur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class SignInController: UIViewController, UINavigationControllerDelegate {
    
    fileprivate var _authHandler : FIRAuthStateDidChangeListenerHandle!
    var user : FIRUser?
    
    var displayName = "Anonymous"

    @IBOutlet weak var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignInButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        if FIRAuth.auth()?.currentUser?.uid == nil{
            checkSession()
        } else{
            print("Is Login")
            let mainST = UIStoryboard(name: "Main", bundle: Bundle.main)
            let VC = mainST.instantiateViewController(withIdentifier: "tabbar")
            self.present(VC, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkSession(){
        let provide : [FUIAuthProvider] = [FUIGoogleAuth()]
        FUIAuth.defaultAuthUI()?.providers = provide
        
        _authHandler = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user: FIRUser?) in
            
            if let activeUser = user {
                self.navigationItem.leftBarButtonItem?.title = "Logout"
                if self.user != activeUser{
                    self.user = activeUser
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                    self.navigationItem.title = user!.displayName
                    print(user!.uid)
                    let databaseRef = FIRDatabase.database().reference()
                    
                    databaseRef.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        if !snapshot.hasChild(user!.uid){
                            
                            print("false => \(user!.uid) not exist")
                            
                            let photoURL = user?.photoURL?.absoluteString ?? nil
                            let value : [String : Any] = ["name": self.displayName,
                                                          "email": user!.email!,
                                                          "profileImageUrl" : photoURL ?? nil ]
                            self.registerUserIntoDatabaseWithUID(uid: user!.uid, values: value)
                            
                        }
                        
                        let mainST = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let VC = mainST.instantiateViewController(withIdentifier: "tabbar")
                        self.present(VC, animated: true, completion: nil)
                        
                        
                    })
                    
                    
                }
                
            }else{
                self.loginSession()
            }
        })
        
    }
    
    func registerUserIntoDatabaseWithUID(uid : String, values: [String : Any]){
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print("Error Register \(err)")
                return
            }
            
            print("save user succesfully into firebase database ")
        })
    }
    
    func loginSession(){
        self.navigationItem.leftBarButtonItem?.title = "Login"
        let authView = FUIAuth.defaultAuthUI()!.authViewController()
        present(authView, animated: true, completion: nil)
    }
    
    func handleLogout(){
        print("Logout")
        do {
            try FIRAuth.auth()?.signOut()
            checkSession()
        } catch  {
            print("Unable sign Out ")
        }
    }

}
