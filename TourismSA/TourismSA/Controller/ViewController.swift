//
//  ViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
  
  @IBOutlet weak var tourismTableView: UITableView!
  @IBOutlet weak var profileButton:
  UIButton!
  
  
  var place = [PlaceData]()
  
  
  @IBAction func signOut(_ sender: Any) {
    
    let auth = Auth.auth()
            
            do {
                try auth.signOut()
                self.dismiss(animated: true, completion:nil)
                
            } catch let signOutError {
                let alert = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        
        }
    
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    
    self.place = array
    tourismTableView.register(UINib(nibName: "TourismTableViewCell", bundle: nil), forCellReuseIdentifier: "TourismCell")
  }
  
  
  func addTapped(parameter: UIButton){
    parameter.isUserInteractionEnabled = true
    parameter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.objectTapped)))
  }
  
  
  @objc func objectTapped(gesture: UIGestureRecognizer){
    let controller = ProfileTourismVC(nibName: "ProfileTourismViewController", bundle: nil)
    self.navigationController?.pushViewController(controller, animated: true)
    
  }
  
}


extension ViewController : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return place.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tourismTableView.dequeueReusableCell(withIdentifier: "TourismCell", for: indexPath) as? TourismTableViewCell{
      
      cell.selectionStyle = UITableViewCell.SelectionStyle.none
      
      let newPlace = place[indexPath.row]
      cell.tourismName.text = newPlace.name
      cell.tourismAddress.text = newPlace.address
      
      let urlImg = newPlace.image
      let img = URL(string: urlImg)
      cell.tourismImage.downloaded(from: img!)
      cell.tourismImage.contentMode = UIView.ContentMode.scaleAspectFill
      cell.tourismImage.layer.cornerRadius = 21
      
      return cell
    }else{
      return UITableViewCell()
    }
  }
}


extension ViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detail = storyboard.instantiateViewController(withIdentifier: "DetailTourismViewController") as! DetailTourismVC
    
    
    detail.place = place[indexPath.row]
    
    self.navigationController?.pushViewController(detail, animated: true)
    
  }
  
}


extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }.resume()
  }
  
  
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  
  
  
  
}
