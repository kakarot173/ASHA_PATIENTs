//
//  DotAddAppointmentViewController.swift
//  Dot_Health_1
//
//  Created by MUKESH BARIK on 18/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import FittedSheets
class DotAddAppointmentViewController: UIViewController {

    @IBOutlet weak var ailmentButton: UIButton!
    @IBOutlet weak var doctorButton: UIButton!
    @IBOutlet weak var specialityButton: UIButton!
    @IBOutlet weak var doctorListTableView: UITableView!
    var selectedAilment : [String] = []
    @IBOutlet weak var selectedAilmentLabel: UILabel!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    var selectedIndexPath: IndexPath = IndexPath()
    var screenName : String = kblankString
    let controller = UIStoryboard(name: "DotMedicines", bundle: nil).instantiateInitialViewController() as? DotMedicinesController
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorListTableView.delegate = self
        doctorListTableView.dataSource = self
        doctorListTableView.reloadData()
        
     
        doctorListTableView.rowHeight = 135
        if screenName == "Medications"{
             self.navigationItem.title = "Medications"
             ailmentButton.isHidden = true
             topViewHeightConstraint.constant = 0
            MyMecicationFunctions.readMyMedicine(complition: {[unowned self] in
                     
                     self.doctorListTableView.reloadData()
                    
                 })
        }
        else{
             self.navigationItem.title = "Add Appointments"
             topViewHeightConstraint.constant = 99
             ailmentButton.isHidden = false
            doctorFunctions.readDoctors(complition: {[unowned self] in
                     
                     self.doctorListTableView.reloadData()
                    
                 })
        }
        self.configureViewItems()
        
    }
    func configureViewItems(){
        self.doctorButton.createOptionButton()
        self.specialityButton.createOptionButton()
        self.ailmentButton.createOptionButton()
        ailmentButton.titleLabel?.numberOfLines = 1;
        ailmentButton.titleLabel?.adjustsFontSizeToFitWidth = true;
        ailmentButton.titleLabel?.lineBreakMode = .byClipping;
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? DotAilmentViewController  {
               destination.callback = {result in
               self.selectedAilmentLabel.text = result.joined(separator: ", ")
           }
        
        }
        
            if (segue.identifier == "timeSlotView") &&  self.selectedIndexPath.count > 0{
                let viewController = segue.destination as? DotTimeSlotViewController
                viewController?.selectedName = MyData.doctorModelArray[ self.selectedIndexPath.row].name
                viewController?.selectedSpec = MyData.doctorModelArray[ self.selectedIndexPath.row].speciality
                viewController?.selectedHosPitalName = MyData.doctorModelArray[ self.selectedIndexPath.row].hospitalName
                viewController?.selectedPrice = MyData.doctorModelArray[ self.selectedIndexPath.row].price
                   }
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        
        switch sender.titleLabel?.text {
        case "Ailment":
            sender.createSelectedOptionButton()
        case "Doctor":
            sender.createSelectedOptionButton()
            ailmentButton.setTitle("Ailment", for: .normal)
            self.specialityButton.createOptionButton()
        case "Facility":
            sender.createSelectedOptionButton()
            ailmentButton.setTitle("Services", for: .normal)
            self.doctorButton.createOptionButton()
        case "Services":
             sender.createSelectedOptionButton()
        default:
            print("Wrong button")
        }
    }
    


}
extension DotAddAppointmentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if screenName == "Medications"{
            return   MyData.myMedicineModelArray.count
        }
        return MyData.doctorModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DotDoctorTableViewCell
        if screenName == "Medications"{
             cell.setUp(rowIndex: indexPath.row,dataArray: MyData.myMedicineModelArray)
        }
        else{
             cell.setUp(rowIndex: indexPath.row,dataArray: MyData.doctorModelArray)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        if screenName == "Medications"{
            let sheetController = SheetViewController(controller: controller ?? UIViewController(), sizes: [.fixed(250), .halfScreen])
                   
                   
                   sheetController.adjustForBottomSafeArea = false
                   sheetController.blurBottomSafeArea = true
                   sheetController.dismissOnBackgroundTap = true
                   sheetController.extendBackgroundBehindHandle = false
                   sheetController.topCornersRadius = 15
                   
                   sheetController.willDismiss = { _ in
                       print("Will dismiss ")
                   }
                   sheetController.didDismiss = { _ in
                       print("Will dismiss ")
                   }
            self.present(sheetController, animated: false, completion: nil)
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: String(describing: DotTimeSlotViewController.self) , bundle:nil)
            let nextViewController = storyBoard.instantiateInitialViewController() as! DotTimeSlotViewController
            
            let _ = nextViewController.view
            nextViewController.setUpDoctorDetail(rowIndex:indexPath.row)
            self.show(nextViewController, sender: self)
        }
        
        
    }
    
}
