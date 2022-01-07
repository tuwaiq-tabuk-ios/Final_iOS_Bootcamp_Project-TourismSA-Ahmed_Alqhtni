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

//let array:[PlaceData] = [
//  PlaceData(id: 0,
//            name: "Wadi al-Dayseh",
//            description: "Wadi Al-Disah is one of the sites of the city of Tabuk in Saudi Arabia. It is characterized by an abundance of water tables, palm trees and wild herbs, which made it acquire a unique nature, in addition to being one of the most important natural pillars of the NEOM project. Its name came to the village of Al-Deesah, which is located at the entrance to the valley from the western side. The word “disa” means (valley filled with palm trees).",
//            address: "Western Tabuk Province",
//            longitude: 27,
//            latitude: 36,
//            like: 89,
//            image:UIImage(named: "aldish1")!,
//            images: [UIImage(named: "aldish1")!,UIImage(named: "aldish2")!,UIImage(named: "aldish3")!]),
//
////  PlaceData(id: 1,
////            name: "Madain Saleh",
////            description: " According to archeology, the city of Hadar was inhabited by the Mahdistin in the – third millennium BC, and later settled by the Levites in the ninth century BC. In the second century BC, the Nabataeans occupied the city of stone and overthrew the state of Bani Lahyan, stone temples and tombs, and the Nabataeans built a.stone town for themselves in the inscriptions foundBut the city of stone contains a large number of inscriptions and the vital needs – of the study of symbols and decomposition, and areas of Ola and worms and ruins of life and the oldest can return to 1700 BC. The writings, part of which were destroyed by the earthquake, but the stone city is the influence of traders and early traders. In 2008, the United Nations Educational, Scientific and Cultural Organization (UNESCO) announced that Madain Saleh is a world heritage sit  ",
////            address: "northwest of Saudi Arabia",
////            longitude: 90,
////            latitude: 35,
////            like: 45,
////            image: UIImage(named: "az")!,
////            images: [UIImage(named: "az")!]),
//
//
//  PlaceData(id: 2,
//            name: "Old town Al Ula",
//            description: "It represents the old town, which is located in the center of the Al-Ula governorate of the Medina region, and inhabited by about 60 thousand residents, and it dates back to the beginnings of the Islamic era and one of the three Islamic cities in the whole world that still remains. It is there, generation after generation, until it was completely abandoned from the population about forty years ago.The sundial is located south of the old town. It is a pyramid-shaped building and is used to mark the entry of the four seasons, especially the entry of winter, through a stone planted in the ground in front of the pyramidal building, where the shadow of the sundial reaches this stone on the first day of winter on the 21st of December is the first day of winter, and the shadow of the sundial can not reach this stone again until next year and on the same date, and it is still used today, as many visitors and tourists enjoy watching this event that is only repeated once every year.In Al-Ula there are ancient Islamic monuments, the Prophet, peace and blessings be upon him, raised them and prayed in them. Historians confirm that Musa bin Nusair built a historic castle there on the highest mountain in the center of Al-Ula, overlooking the old town of Al-Ula. At the present time, some of the village’s houses have been renovated, and the old town is one of The most important Islamic monuments.",
//            address: "Kingdom of Saudi Arabia in Al Ula",
//            longitude: 12,
//            latitude: 33,
//            like: 56,
//            image: UIImage(named: "oldTown")!,
//            images: [UIImage(named: "oldTown")!,UIImage(named: "oldTown1")!,UIImage(named: "oldTown2")!]),
//
//
//  PlaceData(id: 3,
//            name: "Fursan Islands",
//            description: " Farasan Islands passed through many civilizations such as Portuguese and Ottoman , it have many monuments until the present time, and it is mentioned that the history of the islands dates back to the era of the Himyarite Kingdom , as it were a station to meet and rest commercial caravans that were passing through it , When the Ottomans reached the Red Sea, They managed to control it and made it an Ottoman island in 1538 , but the Imam al-Muayyad managed to free it from the Ottoman rule and imposed his control over it in 1635 , and the Germans seized it in 1901 , but it  now follows the rule of the Al Saudi family.",
//            address: "southwest of Saudi Arabia", longitude: 32, latitude: 11,
//            like: 56,
//            image: UIImage(named: "farasan")!,
//            images: [UIImage(named: "farasan")!,UIImage(named: "farasan1")!,UIImage(named: "farasan2")!,UIImage(named: "farasan3")!]),
//
//
//  PlaceData(id: 4,
//            name: "World of the Edge",
//            description: "Jabal Tuwaiq is one of the most important geographical features in the Arabian Peninsula, and one of the most prominent topographical features that can be seen from outer space. It is located in the Kingdom of Saudi Arabia, and it is the heart of the historic Yamama and Najd regions. The name of the mountain is Tuwaiq, a diminutive of the word tuq, and the diminutive of the names to salt them is an old custom among the Arabs. Tuwaiq is one of the oldest antiquities in Najd, which the peoples of the Arabian Peninsula have known for a long time. The global archaeological excavations taking place today under the supervision of the General Authority for Tourism and National Heritage are digging deep into prehistoric times, revealing many exciting details related to ancient human migrations, and confirming the existence of ancient villages on Tuwaiq Mountains. The highest peaks at the edge of Tuwaiq is the Farida Al-Shiza summit, located northwest of the city of Al-Hariq in the Riyadh region, with a height of about 1200 meters.",
//            address: "Northwest of the city of Hariq in the Riyadh region",
//            longitude: 12,
//            latitude: 45,
//            like: 87,
//            image: UIImage(named: "world")!,
//            images: [UIImage(named: "world")!])
//
//  
//]
