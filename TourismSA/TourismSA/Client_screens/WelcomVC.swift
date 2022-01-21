//
//  UsrTourismVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage

class WelcomVC: UIViewController {
  
  
  //MARK: - property
  
  var place = [PlaceData]()
  var collectionRF: CollectionReference!
  var isSlideMenuHidden = true
  
  
  //MARK: - IBOutlet
  
  
  @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
  @IBOutlet weak var tourismTableView: UITableView!
  @IBOutlet weak var profileButton:
  UIButton!
  
  
  
  
  //MARK: - IBAction
  
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
  
  
  @IBAction func organizeButton(_ sender: UIBarButtonItem) {
    
    if isSlideMenuHidden {
      sideMenuConstraint.constant = 0
      UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
      
    } else {
      sideMenuConstraint.constant = -160
      UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
    }
    
    isSlideMenuHidden = !isSlideMenuHidden

  }
  
  
  //MARK: - lifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sideMenuConstraint.constant = -200
    hideKeyboardWhenTappedAround()
    //    self.place = array
    tourismTableView.register(UINib(nibName: "TourismTableViewCell", bundle: nil), forCellReuseIdentifier: "TourismCell")
  
    let db = Firestore.firestore()
    collectionRF = db.collection("Place")
    getData()
    tourismTableView.layer.shadowOpacity = 0.7
    tourismTableView.layer.shadowRadius = 20
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  
  //MARK: - functions
  
  func getData() {
    
    collectionRF.getDocuments { snapshot, error in
      if error != nil {
        print("~~ error get data: \(error?.localizedDescription)")
      } else {
        self.place.removeAll()
        for document in snapshot!.documents {
          let data = document.data()
          
          let place = PlaceData(id: data["id"] as! String,
                                name: data["name"] as! String,
                                description: data["description"] as! String,
                                address: data["address"] as! String,
                                longitude: data["longitude"] as! Double,
                                latitude: data["latitude"] as! Double,
                                like: data["like"] as! Int,
                                image: data["image"] as! String,
                                images: data["images"] as? [String])
          
          print("\n\n # # # # # #\(#file) - \(#function)")
          print(" - data[images] as? [String]: \(String(describing: data["images"] as? [String]))")
          self.place.append(place)
        }
      }
      
      self.tourismTableView.reloadData()
    }
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


extension WelcomVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return place.count
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tourismTableView.dequeueReusableCell(withIdentifier: "TourismCell", for: indexPath) as? TourismTableViewCell{
      
      cell.selectionStyle = UITableViewCell.SelectionStyle.none
      
      let newPlace = place[indexPath.row]
      
      cell.tourismName.text = newPlace.name
      cell.tourismAddress.text = newPlace.address
      cell.tourismImage.sd_setImage(with: URL(string: newPlace.image), placeholderImage: UIImage(named: "IMG_1287"))
      cell.tourismImage.contentMode = UIView.ContentMode.scaleAspectFill
      cell.tourismImage.layer.cornerRadius = 21
      
      return cell
      
    } else {
      
      return UITableViewCell()
      
    }
  }
}


extension WelcomVC: UITableViewDelegate{
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
      else {
        return
        
      }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }
    .resume()
  }
  
  
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link)
    else {
      return
      
    }
    downloaded(from: url, contentMode: mode)
  }
  
}




