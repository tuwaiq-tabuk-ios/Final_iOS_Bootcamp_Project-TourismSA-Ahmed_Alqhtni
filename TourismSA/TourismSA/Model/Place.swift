//
//  Place.swift
//  TourismSA
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import Foundation

struct RootPlace : Codable{
    let places: [PlaceData]
}

struct PlaceData : Codable{
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
}

let array:[PlaceData] = [
  PlaceData(id: 0, name: "Wadi al-Dayseh", description: "Wadi Al-Disah is one of the sites of the city of Tabuk in Saudi Arabia. It is characterized by an abundance of water tables, palm trees and wild herbs, which made it acquire a unique nature, in addition to being one of the most important natural pillars of the NEOM project. Its name came to the village of Al-Deesah, which is located at the entrance to the valley from the western side. The word “disa” means (valley filled with palm trees).", address: "Western Tabuk Province", longitude: 27, latitude: 36, like: 89, image: "https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1920,c_scale,q_auto/cnnarabic/2020/07/16/images/159974.webp"),
  
  PlaceData(id: 1, name: "Madain Saleh", description: " According to archeology, the city of Hadar was inhabited by the Mahdistin in the – third millennium BC, and later settled by the Levites in the ninth century BC. In the second century BC, the Nabataeans occupied the city of stone and overthrew the state of Bani Lahyan, stone temples and tombs, and the Nabataeans built a.stone town for themselves in the inscriptions foundBut the city of stone contains a large number of inscriptions and the vital needs – of the study of symbols and decomposition, and areas of Ola and worms and ruins of life and the oldest can return to 1700 BC. The writings, part of which were destroyed by the earthquake, but the stone city is the influence of traders and early traders. In 2008, the United Nations Educational, Scientific and Cultural Organization (UNESCO) announced that Madain Saleh is a world heritage sit  ", address: "northwest of Saudi Arabia", longitude: 90, latitude: 35, like: 45, image: "https://historynpics.com/upload/128/5fae5891e128f_125249630_973838579795622_2900975940721995486_n.jpg"),
  
  PlaceData(id: 2, name: "Old town Al Ula", description: "It represents the old town, which is located in the center of the Al-Ula governorate of the Medina region, and inhabited by about 60 thousand residents, and it dates back to the beginnings of the Islamic era and one of the three Islamic cities in the whole world that still remains. It is there, generation after generation, until it was completely abandoned from the population about forty years ago.The sundial is located south of the old town. It is a pyramid-shaped building and is used to mark the entry of the four seasons, especially the entry of winter, through a stone planted in the ground in front of the pyramidal building, where the shadow of the sundial reaches this stone on the first day of winter on the 21st of December is the first day of winter, and the shadow of the sundial can not reach this stone again until next year and on the same date, and it is still used today, as many visitors and tourists enjoy watching this event that is only repeated once every year.In Al-Ula there are ancient Islamic monuments, the Prophet, peace and blessings be upon him, raised them and prayed in them. Historians confirm that Musa bin Nusair built a historic castle there on the highest mountain in the center of Al-Ula, overlooking the old town of Al-Ula. At the present time, some of the village’s houses have been renovated, and the old town is one of The most important Islamic monuments.", address: "Kingdom of Saudi Arabia in Al Ula", longitude: 12, latitude: 33, like: 56, image: "https://pbs.twimg.com/media/EaAcGtmWsAAJPSU.jpg")


  
  
  ]
