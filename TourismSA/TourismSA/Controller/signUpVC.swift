//
//  signUp.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 16/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpVC: UIViewController {
  
  @IBOutlet weak var errorIb: UILabel!
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      errorIb.alpha = 0
      
      firstNameTextField.layer.cornerRadius = 20
      lastNameTextField.layer.cornerRadius = 20
      emailTextField.layer.cornerRadius = 20
      passwordTextField.layer.cornerRadius = 20
      
      
      
      
 
    }
  
  
  @IBAction func signInButton(_ sender: UIButton) {
    if emailTextField.text?.isEmpty == true {
      print("No")
      return
      
    }
    
signInButton()
    
  }
  
  func signInButton() {
    let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let lastNametName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let emailTextField = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let passwordTextField = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    Auth.auth().createUser(withEmail: emailTextField, password: passwordTextField) {
      (authResult, error) in
      if error != nil {
        self.errorIb.alpha = 1
        self.errorIb.text = error?.localizedDescription
      }else {
        
        let db = Firestore.firestore()
        db.collection("users").document((authResult?.user.uid)!).setData([
          "firstName":firstName,
          "lastNametName":lastNametName
        ])
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBord.instantiateViewController(withIdentifier: "MainVC")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
      }
    }
    
  }
  
}
