//
//  SignInVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 16/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {
  
  @IBOutlet weak var errorIb: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var forgetPassword: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    errorIb.alpha = 0
    emailTextField.layer.cornerRadius = 20
    passwordTextField.layer.cornerRadius = 20
    hideKeyboardWhenTappedAround()
    
    
    
  }
  
  
  
  
  @IBAction func signInButton(_ sender: UIButton) {
    let email = emailTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    
    Auth.auth().signIn(withEmail: email, password: password) {
      
      (authResult,error) in
      if error != nil {
        self.errorIb.alpha = 1
        self.errorIb.text = error?.localizedDescription
        
      } else {
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBord.instantiateViewController(withIdentifier: "MainVC")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        
      }
    }
    
  }
  
}


