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
  
  
  // MARK: - IBOutlet -
  
  
  @IBOutlet weak var errorIb: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var PasswordVerification: UITextField!
  
  // - View Controller lifeCycle 
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    errorIb.isHidden = true
    firstNameTextField.layer.cornerRadius = 15
    lastNameTextField.layer.cornerRadius = 15
    emailTextField.layer.cornerRadius = 15
    passwordTextField.layer.cornerRadius = 15
    PasswordVerification.layer.cornerRadius = 15
    hideKeyboardWhenTappedAround()
    
  }
  
  
  
  // MARK: - IBActions
  
  @IBAction func signInButton(_ sender: UIButton) {
    if emailTextField.text?.isEmpty == true {
      
      errorIb.isHidden = false
      errorIb.text = "Fill in the email"
      return
    }
    
    if passwordTextField.text?.isEmpty == true {
      errorIb.isHidden = false
      errorIb.text = "Enter the password"
      return
    }
    
    if firstNameTextField.text?.isEmpty == true {
      errorIb.isHidden = false
      errorIb.text = "Fill in the first name"
      return
    }
    
    if lastNameTextField.text?.isEmpty == true {
      errorIb.isHidden = false
      errorIb.text = "Fill in the Last name"
      return
    }
    
    
    
    signInButton()
  }
  
  
  // MARK: - Functions
  
  func signInButton() {
    
    let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let lastNametName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let emailTextField = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let passwordTextField = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let PasswordVerification = PasswordVerification.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if passwordTextField == PasswordVerification {
      
      
      
      Auth.auth().createUser(withEmail: emailTextField,
                             password: passwordTextField) {
        (authResult, error) in
        if error != nil {
          self.errorIb.isHidden = false
          self.errorIb.text = error?.localizedDescription
        } else {
          
          let db = Firestore.firestore()
          db.collection("users").document((authResult?.user.uid)!).setData([
            "firstName":firstName,
            "lastNametName":lastNametName,
            "type":"user"
          ])
          
          let storyBord = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyBord.instantiateViewController(withIdentifier: K.Storyboard.mainStoryboard )
          vc.modalPresentationStyle = .overFullScreen
          self.present(vc, animated: true)
          
        }
      }
    } else {
      errorIb.isHidden = false
      errorIb.text = "Password Do not Match"
    }
  }
}
