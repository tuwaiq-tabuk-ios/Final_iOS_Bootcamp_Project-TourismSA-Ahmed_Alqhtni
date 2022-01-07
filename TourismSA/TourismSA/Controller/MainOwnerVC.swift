//
//  MainOwnerVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 28/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage

class MainOwnerVC: UIViewController {
  
  
  @IBOutlet weak var tourismTableView: UITableView!
  @IBOutlet weak var profileButton:UIButton!
  
  var place = [PlaceData]()
  var collectionRF:CollectionReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    
    //    self.place = array
    tourismTableView.register(UINib(nibName: "TourismTableViewCell", bundle: nil), forCellReuseIdentifier: "TourismCell")
    let db = Firestore.firestore()
    
    collectionRF = db.collection("Place")
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getData()
  }
  
  
  //MARK: - Action
  
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
          print("id: data[id]:  \(data["id"] as! String)")
          print(" - data[images] as? [String]: \(String(describing: data["images"] as? [String]))")
          
          self.place.append(place)
        }
      }
      
      self.tourismTableView.reloadData()
      
    }
  }
}


extension MainOwnerVC : UITableViewDataSource{
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
    }else{
      return UITableViewCell()
    }
  }
}


extension MainOwnerVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detail = storyboard.instantiateViewController(withIdentifier: "editID") as! EditPlaceVC
    
    detail.placeData = place[indexPath.row]
    
    self.navigationController?.pushViewController(detail, animated: true)
    
  }
  
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = place[indexPath.row]
      let db = Firestore.firestore()
      let storaage = Storage.storage()
      
      storaage.reference().child(item.id).listAll { result, error in
        if error != nil {
          
        } else {
          result.items.forEach { item in
            item.delete()
          }
        }
      }
      
      db.collection("Place").document(item.id).delete()
      place.remove(at: indexPath.row)
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
    }
    
  }
  
}
