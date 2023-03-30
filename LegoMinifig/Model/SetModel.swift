//
//  SetModel.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

struct SetModel: Codable {
    var results: [Result]
    
    static let mokModel: SetModel = SetModel(results: Result.mokResult1)
      
}


struct Result: Codable {
    let listID: Int?
    var propertySet: SetPropertyModel

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case propertySet = "set"
    }
    
    static let mokResult1: [Result] = [
        Result(listID: 1234, propertySet: SetPropertyModel.mokProperty1),
        Result(listID: 5678, propertySet: SetPropertyModel.mokProperty2)
    ]
}


struct SetPropertyModel: Codable {
    let setNum, name: String
    let year, themeID, numParts: Int
    let setImgURL: String
    let setURL: String
    let lastModifiedDt: String
    var coverImage: Data? = nil
    var userHas: Bool? = nil
    

    enum CodingKeys: String, CodingKey {
        case setNum = "set_num"
        case name, year, coverImage
        case themeID = "theme_id"
        case numParts = "num_parts"
        case setImgURL = "set_img_url"
        case setURL = "set_url"
        case lastModifiedDt = "last_modified_dt"
    }
    
    static let mokProperty1: SetPropertyModel = SetPropertyModel(setNum: "70128-0", name: "Harry Potter", year: 2020, themeID: 1234, numParts: 23, setImgURL: "", setURL: "", lastModifiedDt: "")
    static let mokProperty2: SetPropertyModel = SetPropertyModel(setNum: "70110-0", name: "Toy Story", year: 2020, themeID: 5678, numParts: 23, setImgURL: "", setURL: "", lastModifiedDt: "")
    
    mutating func addCoverImageData(_ data: Data) {
        coverImage = data
    }
}
