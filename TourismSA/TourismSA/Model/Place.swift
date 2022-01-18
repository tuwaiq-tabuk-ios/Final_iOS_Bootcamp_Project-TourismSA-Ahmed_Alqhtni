//
//  Place.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import Foundation

struct RootPlace {
  let places: [PlaceData]
}

struct PlaceData {
  let id: String
  let name: String
  let description: String
  let address: String
  let longitude: Double
  let latitude: Double
  let like: Int
  let image: String
  let images:[String]!

}

