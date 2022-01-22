
//  OwnerSginUpVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 14/06/1443 AH.


import UIKit
import Firebase
import FirebaseAuth

class OwnerSginUpVC: UIViewController {
  
  
  // MARK: - IBOutlet -
  
  
  @IBOutlet weak var errorIb: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var PasswordVerification: UITextField!
  
  //MARK: - View Controller lifeCycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    errorIb.isHidden = true
    firstNameTextField.layer.cornerRadius = 15
    lastNameTextField.layer.cornerRadius = 15
    emailTextField.layer.cornerRadius = 15
    passwordTextField.layer.cornerRadius = 15
    hideKeyboardWhenTappedAround()
    
  }
  
  
  // MARK: - IBActions
  
  @IBAction func signUpButton(_ sender: UIButton) {
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
    
    
    
    signUpButton()
  }
  
  
  // MARK: - Functions
  
  func signUpButton() {
    
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
          db.collection("Owner").document((authResult?.user.uid)!).setData([
            "firstName":firstName,
            "lastNametName":lastNametName,
            "type":"owner"
          ])
          
          let storyBord = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyBord.instantiateViewController(withIdentifier: Constants.K.OwnerStoryboard)
          vc.modalPresentationStyle = .overFullScreen
          self.present(vc, animated: true)
          
        }
      }
    
    } else {
      
      errorIb.isEnabled = false
      errorIb.text = "Password Do not Match"
    }
  }
}
