//
//  EditPlaceVC.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 28/05/1443 AH.
//



import PhotosUI
import Firebase
import FirebaseStorage
import SDWebImage

class EditPlaceVC: UIViewController,
                   UICollectionViewDelegate {
 
  
  // MARk: - proprty
  
  var imageForLogo: Bool!
  var imagesForPlace: [UIImage] = [UIImage]()
  var placeData: PlaceData!
  var ID: String!
  
  
  // MARK: - IBOutlet -
  
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var longitudeTextField: UITextField!
  @IBOutlet weak var latitudeTextField: UITextField!
  @IBOutlet weak var likeTextField: UITextField!
  @IBOutlet weak var infoTextField: UITextField!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var imagesCollectionView: UICollectionView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    imagesCollectionView.delegate = self
    imagesCollectionView.dataSource = self
    
    print("\n\n - - - - -  \(#file) - \(#function)")
    configureScreen()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    configureScreen()
  }
  
  //MARK: - Action
  
  @IBAction func addLogoButtonTapped(_ sender: UIButton) {
    imageForLogo = true
    presentPhotoPicker()
  }
  
  
  @IBAction func addImagesButtonTapped(_ sender: UIButton) {
    imageForLogo = false
    presentPhotoPicker()
  }
  
  
  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    
    let index = sender.tag
    imagesForPlace.remove(at: index)
    imagesCollectionView.reloadData()
    
  }
  
  
  @IBAction func saveButtonPressed(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    
    var imageID  = ""
    if imageID == "" {
      imageID = UUID().uuidString
    }
    let documentID = ID!
    
    db.collection("Place").document(documentID).setData([
      "id" : documentID,
      "name" : nameTextField.text!,
      "description" : infoTextField.text!,
      "address" : addressTextField.text!,
      "longitude" : Double(longitudeTextField.text!)!,
      "latitude" : Double(latitudeTextField.text!)!,
      "like": Int(likeTextField.text!)!,
      "image" : "",
      "images" : [] as Array
    ]) { error in
      if error != nil {
        print("~~ Error Add Document: \(error?.localizedDescription)")
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
      storeage.reference().child(documentID).delete()
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
              self.navigationController?.popViewController(animated: true)
            }
          }
        }
      }
    }
    
    
    imageID = UUID().uuidString
    
    let storeageRF = storeage.reference().child(documentID).child(imageID)
    let data = logoImageView.image!.jpegData(compressionQuality: 0.5)!
    
    storeageRF.putData(data, metadata: uploadMetadata) { metadata, error in
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
  
  
  // MARK: - Configure screen
  
  func configureScreen() {
    print("\n\n --------  \(#file) - \(#function)")
    ID = placeData.id
    nameTextField.text = placeData.name
    addressTextField.text = placeData.address
    longitudeTextField.text = String(placeData.longitude)
    latitudeTextField.text = String(placeData.latitude)
    likeTextField.text = String(placeData.like)
    infoTextField.text = placeData.description
    
    print(" - ID: \(placeData.id)")
    logoImageView.sd_setImage(with: URL(string: placeData.image),
                              placeholderImage: UIImage(named: "IMG_1287"))
    
    print(" - placeData.images: \(String(describing: placeData.images))")
    
    for imageFromPlaceData in placeData.images {
      let imageView = UIImageView()
      
      print(" ------ imageFromPlaceData: \(imageFromPlaceData)")
                  imageView.sd_setImage(with: URL(string: imageFromPlaceData),
                                        placeholderImage: UIImage(named: "IMG_1287"))
      
      let testURL = URL(string: imageFromPlaceData)
      print(" - testURL: \(String(describing: testURL))")
      
      
      
      imageView.sd_setImage(
        with: URL(string: imageFromPlaceData)) { sdImage,
          error, _,_ in
          if error != nil {
           
          } else {
            
            print(" + + + + + sdImage: \(String(describing: sdImage))")
            self.imagesForPlace.append(sdImage!)
          }
        }
      
    }
    
    print(" - - - - imagesForPlace: \(imagesForPlace)")
  
    
    self.imagesCollectionView.reloadData()
    print(" - AFTER: self.imagesCollectionView.reloadData()")
    
  }
  
  
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
    present(photoPicker, animated: true, completion: nil)
  }
  
}


// MARK: - UICollectionViewDataSource

extension EditPlaceVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print("\n\n$$$\(#file) - \(#function)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell",
                                                  for: indexPath) as! ImagesCollectionViewCell
    
    let image = imagesForPlace[indexPath.row]
    print(" - imagesForPlace: \(imagesForPlace)")
    //    print(" - image: \(image)")
    
    cell.imagePlace.image = image
    cell.deleteImage.tag = indexPath.row
    
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    print("\n\n<<<\(#file) - \(#function)")
    print(" - imagesForPlace.count: \(imagesForPlace.count)")
    return imagesForPlace.count
  }
  
}


// MARK: - PHPickerViewControllerDelegate

extension EditPlaceVC: PHPickerViewControllerDelegate {
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
    if imageForLogo {
      if let result = results.first,
         result.itemProvider.canLoadObject(ofClass: UIImage.self) {
         result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let image = image as? UIImage {
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




