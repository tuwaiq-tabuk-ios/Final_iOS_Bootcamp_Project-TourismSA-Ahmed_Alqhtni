//
//  SignInVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 16/05/1443 AH.


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
    emailTextField.layer.cornerRadius = 18
    passwordTextField.layer.cornerRadius = 18
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
        let db = Firestore.firestore()
        
        let documentRF =  db.collection("users").document((authResult?.user.uid)!)
        
        documentRF.getDocument { snapchot, error in
          if error != nil {
            print("~~ error get user data: \(String(describing: error?.localizedDescription))")
          } else {
            
            let data = snapchot!.data()!
            let type = data["type"] as! String
            let storyBord = UIStoryboard(name: "Main", bundle: nil)
            if type == "owner"{
              let vc = storyBord.instantiateViewController(withIdentifier: "ownerID")
              vc.modalPresentationStyle = .overFullScreen
              self.present(vc, animated: true)
              
            } else {
              let vc = storyBord.instantiateViewController(withIdentifier: "MainVC")
              vc.modalPresentationStyle = .overFullScreen
              self.present(vc, animated: true)
            }
          }
        }
      }
    }
  }
}
