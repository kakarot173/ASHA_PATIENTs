//
//  DotDoctorTableViewCell.swift
//  Dot_Health_1
//
//  Created by MUKESH BARIK on 18/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit

class DotDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(rowIndex:Int,dataArray:[Any]){
        if let myMedicineDataArray = dataArray as? [MyMedicineModel]{
            self.doctorImageView.image = UIImage(named: "medImage")
               self.nameLabel.text = myMedicineDataArray[rowIndex].name
               self.specialityLabel.text = myMedicineDataArray[rowIndex].speciality
               self.hospitalNameLabel.text = myMedicineDataArray[rowIndex].hospitalName
               self.priceLabel.text = myMedicineDataArray[rowIndex].price
               self.priceLabel.textColor = #colorLiteral(red: 0, green: 0.6795158386, blue: 0, alpha: 1)
        }
        if let doctorArray = dataArray as? [DoctorModel]{
            self.doctorImageView.image = UIImage(named: "DoctorImage")
                self.nameLabel.text = doctorArray[rowIndex].name
                self.specialityLabel.text = doctorArray[rowIndex].speciality
                self.hospitalNameLabel.text = doctorArray[rowIndex].hospitalName
                self.priceLabel.text = doctorArray[rowIndex].price
                self.priceLabel.textColor = #colorLiteral(red: 0, green: 0.6795158386, blue: 0, alpha: 1)
        }
    
    }

}
