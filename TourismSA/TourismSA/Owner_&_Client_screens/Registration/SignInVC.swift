//
//  SignInVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 16/05/1443 AH.


import UIKit
import Firebase
import FirebaseAuth


class SignInVC: UIViewController {
  
  
  // MARK: - IBOutlet -
  
  @IBOutlet weak var errorIb: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
 
  
  
  // - View Controller lifeCycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    errorIb.isHidden = true
    emailTextField.layer.cornerRadius = 18
    passwordTextField.layer.cornerRadius = 18
    hideKeyboardWhenTappedAround()
 
  }

  
  
  // MARk: - IBAction
  
  @IBAction func signInButton(_ sender: UIButton) {
    
  
    let email = emailTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    
    Auth.auth().signIn(withEmail: email,
                       password: password) {
(authResult,error) in
      if error != nil {
        self.errorIb.isHidden = false
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
              let vc = storyBord.instantiateViewController(withIdentifier: K.Storyboard.OwnerStoryboard)
              vc.modalPresentationStyle = .overFullScreen
              self.present(vc, animated: true)
              
            } else {
              
              let vc = storyBord.instantiateViewController(withIdentifier:K.Storyboard.mainStoryboard)
              vc.modalPresentationStyle = .overFullScreen
              self.present(vc, animated: true)
            }
          }
        }
      }
    }
  }
}
