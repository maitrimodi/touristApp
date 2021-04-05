//
//  AttractionList.swift
//  TouristApp
//
//  Created by maitri Modi on 2021-04-04.
//

import Foundation

struct AttractionList:Codable {
    let id: Int
    let name: String
    let address: String
    let photos: [String]
    let phoneNo : String
    let website: String
    let description: String
    let pricing : Double
}
