//
//  DotMyMedicineModel.swift
//  Dot_Health_1
//
//  Created by MUKESH BARIK on 21/07/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

struct MyMedicineModel:Decodable {
    var id:UUID
    var name: String
    var speciality: String
    var hospitalName: String
    var price: String
    
    init(name: String, speciality: String, hospitalName: String, price: String ) {
        self.id = UUID()
        self.name = name
        self.speciality = speciality
        self.hospitalName = hospitalName
        self.price = price
    }
}
