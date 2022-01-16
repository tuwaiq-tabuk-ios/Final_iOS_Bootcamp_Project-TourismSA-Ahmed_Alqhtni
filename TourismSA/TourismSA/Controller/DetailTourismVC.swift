//
//  DetailTourismViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit
import MapKit
import AVFAudio
import AVFoundation

class DetailTourismVC: UIViewController,
                       UICollectionViewDelegate,
                       UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  
  // MARk: - property
  
  var arrImage = [String]()
  var timer :Timer?
  var cellindex = 0
  let synthesizer = AVSpeechSynthesizer()
  var player: AVAudioPlayer?
  var place: PlaceData? {
    didSet {
      self.navigationController?.title = place?.name
    }
  }
  
  
  //MARK: - IBOutlet
  
  @IBOutlet weak var detailImage: UIImageView!
  @IBOutlet weak var detailName: UILabel!
  @IBOutlet weak var detailAddress: UILabel!
  @IBOutlet weak var detailDescription: UILabel!
  @IBOutlet weak var detailLikes: UILabel!
  @IBOutlet weak var iconMap: UIImageView!
  @IBOutlet weak var mapKit: MKMapView!
  @IBOutlet weak var collectionView: UICollectionView!
  
 
  
  
  // MARk: - lifeCycle
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if synthesizer.isSpeaking {
      synthesizer.stopSpeaking(at: .immediate)
    }
  }
  
  
  // MARk: - IBAction
  
  @IBAction func talk(_ sender: Any) {
    
    talks(place!.description)
    
  }
  
  // MARk: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.layer.cornerRadius = 48
    collectionView.delegate = self
    collectionView.dataSource = self
    
    self.navigationItem.title = "Detail"
    startTime()
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    if let result = place {
      detailName.text = result.name
      detailAddress.text = result.address
      detailDescription.text = result.description
      print("\n\n\n******THE result.description::\(result.description)")
      detailLikes.text = "\(result.like) Likes"
      for image in result.images {
        arrImage.append(image)
      }
      
      
      let lat = result.latitude
      
      let long = result.longitude
      
      let anotation = MKPointAnnotation()
      
      anotation.coordinate = CLLocationCoordinate2D(latitude: lat
                                                    ,
                                                    longitude: long)
      anotation.title = detailName.text
      mapKit.addAnnotation(anotation)
      let region = MKCoordinateRegion(center: anotation.coordinate,
                                      latitudinalMeters: 100000,
                                      longitudinalMeters: 100000)
                                      mapKit.setRegion(region,
                                      animated: true)
      
    }
  }
  
  
  // MARk: - function
  
  func talks(_ string:String) {
    let utterance = AVSpeechUtterance(string:string)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")
    
    if synthesizer.isSpeaking {
      synthesizer.stopSpeaking(at: .word)
      //       synthesizer.speak(utterance)
    } else {
      synthesizer.speak(utterance)
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    return arrImage.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) ->
  UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Place",
                                                  for:indexPath) as! CollectionViewCell
    
    cell.imageCell.sd_setImage(with: URL(string: arrImage[indexPath.row]),
                               placeholderImage: UIImage(named: "IMG_1287"))
    return cell
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath)
  -> CGSize {
    return CGSize(width: collectionView.frame.width ,
                  height: collectionView.frame.height )
  }
  
  
  func startTime() {
    timer = Timer.scheduledTimer(timeInterval: 2.5,
                                 target: self,
                                 selector: #selector(move),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  
  @objc func move() {
    print("\ncellindex: \(cellindex)")
    let testArrImageSize = arrImage.count - 1
    print("arrImage.cont -1: \(testArrImageSize)")
    
    if cellindex < arrImage.count - 1 {
      cellindex += 1
    } else {
      cellindex = 0
    }
    
    collectionView.isPagingEnabled = false
    collectionView.scrollToItem(
      at: IndexPath(item: cellindex,
                    section: 0),
      at: .right,
      animated: true
    )
    collectionView.isPagingEnabled = true
    
    //    collectionView.reloadData()
  }
  
}
