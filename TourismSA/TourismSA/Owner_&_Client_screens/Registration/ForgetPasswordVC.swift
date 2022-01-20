//
//  ForgetPasswordVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 23/05/1443 AH.
//

import UIKit
import FirebaseAuth


class ForgetPasswordVC:
  UIViewController {
  
  // MARK: - IBOutlet -
  
  @IBOutlet weak var email: UITextField!
  
  // - View Controller lifeCycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
  }
  
  
  // MARk: - IBAction
  
  @IBAction func forgetPassword(_ sender: Any) {
    let auth = Auth.auth()
    auth.sendPasswordReset(withEmail: email.text!) { (error) in
      if let error = error {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        return
        alert.addAction((UIAlertAction(title: "Ok", style: .destructive, handler: nil)))
        self.present(alert, animated: true, completion: nil)
      }
      let alert = UIAlertController(title: "Succesfully",
                                    message: "A password reset email has been sent!", preferredStyle: UIAlertController.Style.alert)
      
      let action = UIAlertAction(title: "Done", style: .cancel) { UIAlertAction in
        self.navigationController?.popViewController(animated: true)
        
        
      }
      alert.addAction(action)
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

