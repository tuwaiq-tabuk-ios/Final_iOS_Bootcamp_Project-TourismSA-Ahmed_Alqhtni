//
//  DetailTourismViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit
import MapKit

class DetailTourismVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailAddress: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailLikes: UILabel!
    @IBOutlet weak var iconMap: UIImageView!
    @IBOutlet weak var mapKit: MKMapView!
  
  @IBOutlet weak var CollectionView: UICollectionView!
  var place: PlaceData?
  
  var arrImage = [String]()
  var timer :Timer?
  var cellindex = 0
  
  var arrFoto :PlaceData!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    CollectionView.delegate = self
    CollectionView.dataSource = self
      
      self.navigationItem.title = "Detail"
    startTime()
      
  }
 
  
  override func viewWillAppear(_ animated: Bool) {
    if let result = place{
        detailName.text = result.name
        detailAddress.text = result.address
        detailDescription.text = result.description
        detailLikes.text = "\(result.like) Likes"
        
        arrImage = result.images
        let lat = result.latitude
        let long = result.longitude
        
        let anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        anotation.title = detailName.text
        mapKit.addAnnotation(anotation)
        
        let region = MKCoordinateRegion(center: anotation.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapKit.setRegion(region, animated: true)
      
      

    }
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return arrImage.count
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Place", for:indexPath) as! CollectionViewCell
    
    cell.imageCell.downloaded(from: arrImage[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
  }
  func startTime(){
    timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(move), userInfo: nil, repeats: true)
  }
 @objc func move (){
   if cellindex < arrImage.count - 1 {
      cellindex += 1
    }else{
      cellindex = 0
    }
   CollectionView.scrollToItem(at: IndexPath(item: cellindex, section: 0), at: .centeredHorizontally, animated: true)
   
  }
}
