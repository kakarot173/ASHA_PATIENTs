//
//  DotDoctorModel.swift
//  Dot_Health_1
//
//  Created by MUKESH BARIK on 18/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation

struct DoctorModel:Codable,Hashable {
  /*  var id:UUID
    var name: String
    var speciality: String
    var hospitalName: String
    var price: String
 */
   var doctor_id:Int
   var name:String
   var dob:String
   var gender:String
   var email:String
   var phone:String
   var facility_id:Int
   var city:String
   var pincode:String
   var address1:String
   var address2:String
   var country:String
   var state:String
    
    
    init(doctor_id: Int, name: String, dob: String, gender: String, email: String, phone:String, facility_id:Int, city:String, pincode:String, address1:String, address2:String, country:String, state:String) {
        /*self.id = UUID()
        self.name = name
        self.speciality = speciality
        self.hospitalName = hospitalName
        self.price = price
      */
        self.doctor_id = doctor_id
        self.name = name
        self.dob = dob
        self.gender = gender
        self.email = email
        self.phone = phone
        self.facility_id = facility_id
        self.city = city
        self.pincode = pincode
        self.address1 = address1
        self.address2 = address2
        self.country = country
        self.state = state
    }
}
