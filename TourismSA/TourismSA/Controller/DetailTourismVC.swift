//
//  DetailTourismViewController.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit
import MapKit

class DetailTourismVC: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailAddress: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailLikes: UILabel!
    @IBOutlet weak var iconMap: UIImageView!
    @IBOutlet weak var mapKit: MKMapView!
  
  var place: PlaceData?

  
  override func viewDidLoad() {
      super.viewDidLoad()
      
      self.navigationItem.title = "Detail"
      
      if let result = place{
          detailName.text = result.name
          detailAddress.text = result.address
          detailDescription.text = result.description
          detailLikes.text = "\(result.like) Likes"
          
          let urlImg = result.image
          let img = URL(string: urlImg)
          detailImage.downloaded(from: img!)
          detailImage.contentMode = UIView.ContentMode.scaleAspectFill
          
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

}
