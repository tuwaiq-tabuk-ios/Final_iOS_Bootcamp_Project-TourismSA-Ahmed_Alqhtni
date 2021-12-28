//
//  ProfileTourismViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit

class ProfileTourismVC: UIViewController {

    @IBOutlet weak var highlightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        
        highlightLabel?.layer.cornerRadius = 15
        highlightLabel?.layer.masksToBounds = true
      
    }

}
