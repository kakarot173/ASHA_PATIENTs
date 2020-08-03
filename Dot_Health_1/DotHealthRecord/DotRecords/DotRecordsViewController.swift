//
//  DotRecordsViewController.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 01/08/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import LBTATools
import MobileCoreServices
class CellClass: UITableViewCell {
    
}
class DotRecordsViewController: LBTAFormController {
    let transparentView = UIView()
      let tableView = UITableView()
      var docTextField = UITextField()
      var selectedButton = UIButton()
     var headers = HeaderValues()
    var httpBody: Data?
     let client = DotConnectionClient()
      // MARK: DataSource & DataSourceSnapshot typealias
      typealias DataSource = UICollectionViewDiffableDataSource<Section,AdddocumentsModel>
      typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,AdddocumentsModel>
      // MARK: dataSource & snapshot
       var dataSource :DataSource! =  nil
       var snapshot = DataSourceSnapshot()
      var collectionSuperView = UIView()
      
      var CardsCollectionView: UICollectionView! = nil
      var identiFierForView:String?
      var doctorDash = ["2:00 PM - 2:45 PM",""]//make didset
      var green = [3,6,9,11]
      var red = [4,12,13,14]
      var dummyModel = [AdddocumentsModel]()
      var docIndex = 0
      let addDocumentsLimiter = 10
      var dataItems = [String]()
    let signUpButton = UIButton(title: "Appointment ID                                  ", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: Theme.gradientColorDark!, target: self, action: #selector(handleCancel))
    let cancelButton = UIButton(title: "Cancel", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: .red, target: self, action: #selector(handleCancel))
    var buttonsArr = ["Take Photo","Open Documents","Gallery"]
    @objc fileprivate func handleCancel() {
        dismiss(animated: true)
    }

    let fbButton = UIButton(backgroundColor: .green)
    
    let twitterButton = UIButton(backgroundColor: .green)
//    let githubButton = UIButton(image: #imageLiteral(resourceName: "github_circle").withRenderingMode(.alwaysOriginal))
    let downButton:UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = true
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 25
        formContainerStackView.layoutMargins = .init(top: 20, left: 24, bottom: 16, right: 24)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        configureCollectionView()
               configureCollectionViewDataSource()
               createDummyData()
        let separator1 = UIView()
        let separator2 = UIView()
        let collectionViewContainer = UIView()
        view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            downButton.setImage(UIImage(systemName:"chevron.down"), for: .normal)
        } else {
            // Fallback on earlier versions
             downButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
         downButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        downButton.addTarget(self, action: #selector(self.selectType), for: .touchUpInside)
    
        (0...0).forEach { (_) in
            let tf = IndentedTextField(placeholder: "Select Document Type", padding: 12, cornerRadius: 5, backgroundColor: .white)
            tf.constrainHeight(60)
            tf.rightView = downButton
            tf.rightViewMode = .always
            tf.layer.borderWidth = 1
            
            tf.layer.borderColor = UIColor.darkGray.cgColor
            docTextField = tf
            formContainerStackView.addArrangedSubview(tf)
        }
        
        let buttonsStack = UIStackView()
        (0...2).forEach { (i) in
            let buttons1 = UIButton(backgroundColor: Theme.accentColor!)
             let nameLabel = UILabel(text: buttonsArr[i], font: .boldSystemFont(ofSize: 14), numberOfLines: 2)
            nameLabel.textAlignment = .center
             buttons1.layer.cornerRadius = 35
            buttons1.constrainWidth(70)
            buttons1.constrainHeight(70)
            let stack1 = UIStackView(arrangedSubviews: [buttons1,nameLabel])
            stack1.constrainHeight(60)
            stack1.axis = .vertical
            stack1.alignment = .center
         
            buttonsStack.addArrangedSubview(stack1)
            buttonsStack.spacing = 8
            buttonsStack.constrainHeight(110)
            buttonsStack.distribution = .fillEqually
        }
        formContainerStackView.addArrangedSubview(buttonsStack)
        fbButton.layer.cornerRadius = 50
        twitterButton.layer.cornerRadius = 50
        formContainerStackView.addArrangedSubview(separator1)
        separator1.backgroundColor = .black
        separator1.constrainHeight(1)
        formContainerStackView.addArrangedSubview(signUpButton)
        //appointmentSetup
        signUpButton.constrainHeight(60)
        signUpButton.semanticContentAttribute = .forceRightToLeft
        signUpButton.setImage(UIImage(systemName:"chevron.down"), for: .normal)
        signUpButton.tintColor = Theme.tintcolor
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(self.selectAppointment), for: .touchUpInside)
        //end
        formContainerStackView.addArrangedSubview(separator2)
        separator2.backgroundColor = .black
        separator2.constrainHeight(1)
        formContainerStackView.addArrangedSubview(collectionViewContainer)
        collectionViewContainer.backgroundColor = .lightGray
        collectionViewContainer.constrainHeight(300)
        collectionViewContainer.layer.cornerRadius = 10
        collectionViewContainer.addSubview(CardsCollectionView)
        CardsCollectionView.edgesToSuperview()
//        formContainerStackView.addArrangedSubview(stack)
//        stack.constrainHeight(100)
//        stack.spacing = 8
//        buttonsStackView.distribution = .fillEqually
    }
    @objc func selectAppointment(_ sender: UIButton) {
            dataItems = ["Apple", "Mango", "Orange"]
            selectedButton = sender
            addTransparentView(frames: signUpButton.frame)
        guard let imageFileURL = URL(string: dummyModel[1].cardTitle ?? "") else {return}
     
        upload(files: [FileInfo(withFileURL: imageFileURL, filename: "sampleImage.PNG", name: "uploadedFile", mimetype: "image/png")], toURL: imageFileURL, withHttpMethod: .post){
            [weak self] (x,y) in
            
        }
        }
    @objc func selectType(_ sender: UIButton) {
               dataItems = ["Apple", "Mango", "Orange"]
               selectedButton = sender
               addTransparentView(frames: docTextField.frame)
           }
    func addTransparentView(frames: CGRect) {
        let window = view.window
           transparentView.frame = window?.frame ?? self.view.frame
           self.view.addSubview(transparentView)
           
           tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
           self.view.addSubview(tableView)
           tableView.layer.cornerRadius = 10
           
           transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
           tableView.reloadData()
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
           transparentView.addGestureRecognizer(tapgesture)
           transparentView.alpha = 0
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0.5
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataItems.count * 50))
           }, completion: nil)
       }
       
       @objc func removeTransparentView() {
           let frames = selectedButton.frame
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
           }, completion: nil)
       }

}
extension DotRecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataItems[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
