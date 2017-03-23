//
//  TabTwoController.swift
//  CobaProject
//
//  Created by Fery Syukur on 3/20/17.
//  Copyright © 2017 Fery Syukur. All rights reserved.
//

import UIKit

class TabTwoController: UIViewController {
    
    let imgProfile : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = img.layer.frame.width/2
        img.layer.masksToBounds = true
        img.image = UIImage(named: "groupImage")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
