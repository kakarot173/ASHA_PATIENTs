//
//  Model1.swift, Model2.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 02/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

struct Model1: Decodable {
    let key1: String?
    let key2: String?
    let key3: String?
    let key4: String?
    let key5: String?
    let key6: String?
}

struct Model2: Decodable {
    let results: [Model1]?
}
struct ailment :Decodable{
    let ailment :String
    let ailment_id:Int
}
struct service :Decodable{
    let service :String
    let service_id:Int
}
struct registerModel:Decodable{
    let patient_name:String
    let patient_dob:String
    let patient_gender:String
    let patient_email:String
    let patient_mobile:String
    let patient_refcode:String
    let patient_city:String
    let patient_pincode:String
    let patient_address1:String
    let patient_address2:String
    let patient_country:String
    let patient_state:String
    let patient_id:Int
    let patient_password:String
}

//struct FacilityModel:Decodable,Hashable{
//    let name:String
//    let doe:String
//    let type:String
//    let email:String
//    let phone:String
//    let facility_id:Int
//    let city:String
//    let pincode:String
//    let address1:String
//    let address2:String
//    let country:String
//    let state:String
//}
struct FileInfo {
var fileContents: Data?
var mimetype: String?
var filename: String?
var name: String?

init(withFileURL url: URL?, filename: String, name: String, mimetype: String) {
    guard let url = url else { return }
    fileContents = try? Data(contentsOf: url)
    self.filename = filename
    self.name = name
    self.mimetype = mimetype
}
}
struct record:Codable,Hashable{
    var category:String?
    var file_content:String?
    var medical_record_id:Int?
    var patient_id:Int?
    var storage_link:String?
}
struct HeaderValues {
    private var values: [String: String] = [:]
    
    mutating func add(value: String, forKey key: String) {
        values[key] = value
    }
    
    func value(forKey key: String) -> String? {
        return values[key]
    }
    
    func allValues() -> [String: String] {
        return values
    }
    
    func totalItems() -> Int {
        return values.count
    }
}
