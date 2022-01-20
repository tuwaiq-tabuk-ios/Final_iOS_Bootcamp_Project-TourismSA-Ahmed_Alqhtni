//
//  Extension.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 24/05/1443 AH.

import UIKit


extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self,
                                     action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    
    
  }
  
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
    
  }
  
}
