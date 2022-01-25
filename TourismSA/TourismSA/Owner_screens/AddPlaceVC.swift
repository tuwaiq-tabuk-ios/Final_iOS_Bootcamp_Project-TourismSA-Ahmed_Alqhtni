//
//  AddPlaceViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 28/05/1443 AH.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage


class AddPlaceViewController: UIViewController,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource
{
  
  
  
  // MARk: - property
  
  
  var imageForLogo:Bool!
  var imagesForPlace:[UIImage] = [UIImage]()
  
  
  
  // MARk: - IBOutlet
  
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var longitudeTextField: UITextField!
  @IBOutlet weak var latitudeTextField: UITextField!
  @IBOutlet weak var likeTextField: UITextField!
  @IBOutlet weak var infoTextField: UITextField!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var imagesCollectionView: UICollectionView!
  
  
  
  // MARk: - LifeCycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    imagesCollectionView.delegate = self
    imagesCollectionView.dataSource = self
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    imagesForPlace.removeAll()
    nameTextField.text = ""
    addressTextField.text = ""
    longitudeTextField.text = ""
    latitudeTextField.text = ""
    likeTextField.text = ""
    infoTextField.text = ""
    logoImageView.image = UIImage()
    imagesCollectionView.reloadData()
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return imagesForPlace.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath)
  -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell",
                                                  for: indexPath) as! ImagesCollectionViewCell
    cell.imagePlace.image = imagesForPlace[indexPath.row]
    cell.deleteImage.tag = indexPath.row
    
    return cell
  }
  
  
  
  //MARK: - Actions
  
  
  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    
    let index = sender.tag
    imagesForPlace.remove(at: index)
    imagesCollectionView.reloadData()
    
  }
  
  
  @IBAction func addLogoButtonTapped(_ sender: UIButton) {
    imageForLogo = true
    presentPhotoPicker()
    
  }
  
  
  @IBAction func addImagesButtonTapped(_ sender: UIButton) {
    imageForLogo = false
    presentPhotoPicker()
  }
  
  
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    
    var imageID  = ""
    if imageID == "" {
      imageID = UUID().uuidString
    }
    
    let documentID = UUID().uuidString
    
    db.collection("Place").document(documentID).setData([
      "id":documentID,
      "name":nameTextField.text!,
      "description":infoTextField.text!,
      "address":addressTextField.text!,
      "longitude":Double(longitudeTextField.text!)!,
      "latitude":Double(latitudeTextField.text!)!,
      "like":Int(likeTextField.text!)!,
      "image":"",
      "images":[] as Array
    ]) { error in
      if error != nil {
        print("~~ Error Add Document: \(String(describing: error?.localizedDescription))")
      } else {
        
      }
    }
    
    let storeage = Storage.storage()
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    
    var imageData = [Data]()
    for image in imagesForPlace {
      let data = image.jpegData(compressionQuality: 0.5)
      imageData.append(data!)
    }
    
    var images = [String]()
    for data in imageData {
      imageID = UUID().uuidString
      
      let storeageRF = storeage.reference().child(documentID).child(imageID)
      
      storeageRF.putData(data, metadata: uploadMetadata) { metadata, error in
        if error != nil {
          print("~~ Error Upload Image: \(String(describing: error?.localizedDescription))")
        } else {
          storeageRF.downloadURL { url, error in
            if error != nil {
              print("~~ Error url Image: \(String(describing: error?.localizedDescription))")
            } else {
              
              images.append(url!.absoluteString)
              db.collection("Place").document(documentID).setData(["images":images], merge: true)
            }
          }
        }
      }
    }
    
    imageID = UUID().uuidString
    
    let storeageRF = storeage.reference().child(documentID).child(imageID)
    let data = logoImageView.image!.jpegData(compressionQuality: 0.5)!
    
    storeageRF.putData(data,
                       metadata: uploadMetadata) { metadata, error in
      if error != nil {
        print("~~ Error Upload Image: \(String(describing: error?.localizedDescription))")
      } else {
        storeageRF.downloadURL { url, error in
          if error != nil {
            print("~~ Error url Image: \(String(describing: error?.localizedDescription))")
          } else {
            db.collection("Place").document(documentID).setData(["image":url?.absoluteString], merge: true)
          }
        }
      }
    }
  }
  
  
  // MARK: - functions
  
  
  func presentPhotoPicker() {
    var configuration = PHPickerConfiguration()
    if imageForLogo {
      configuration.selectionLimit = 1
    } else {
      configuration.selectionLimit = 5
    }
    configuration.filter = .images
    let photoPicker = PHPickerViewController(configuration: configuration)
    photoPicker.delegate = self
    present(photoPicker, animated: true,
            completion: nil)
  }
  
  
  
}


//MARK: - PHPicker

extension AddPlaceViewController: PHPickerViewControllerDelegate{
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true,
            completion: nil)
    if imageForLogo {
      if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
        result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let image = image as? UIImage {
            // Store the image in the ImageStore for the item's key
            
            // Put that image on the screen in the image view
            DispatchQueue.main.async {
              self.logoImageView.image = image
            }
          }
        }
      }
    } else {
      
      for resulte in results {
        resulte.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let image = image as? UIImage {
            DispatchQueue.main.async {
              self.imagesForPlace.append(image)
              self.imagesCollectionView.reloadData()
            }
          }
        }
      }
    }
  }
}
