//
//  DotDetailsView.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 09/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import TinyConstraints
import QuickLook
enum Section :CaseIterable{
    case main
}
class DotDetailsView: UIViewController{

    @IBOutlet weak var profileDataView: UIView!
    let data:NSMutableDictionary = ["Basic Details":["Nationality","Religion","MemberShip Number","Primary Address",["Communication":["a","b","c"]],"Insurance Details","Emirates ID"], "Habits":["Smoking","Drinking","Exercise"],"DOCS":[""]]
    
    let sectionNames = ["Basic Details","Habits","DOCS"]
    var expandableRows = [Any]()
    var isExpanded :Bool = false
    var expandedheader = ""
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var saveHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableviewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var mainView: UIView!
    var constTableView = UITableView()
    var constView = UIView()
    @IBOutlet weak var detailsShow: UIButton!
    @IBOutlet weak var LabelStackView: UIStackView!
    var documentController:UIDocumentInteractionController!
    weak var delegate:setViewAutomatically?
 
    // MARK: DataSource & DataSourceSnapshot typealias
       typealias DataSource = UICollectionViewDiffableDataSource<Section,AdddocumentsModel>
       typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,AdddocumentsModel>
       // MARK: dataSource & snapshot
       private var dataSource :DataSource! =  nil
       private var snapshot = DataSourceSnapshot()
       var collectionSuperView = UIView()
       
       var CardsCollectionView: UICollectionView! = nil
       var identiFierForView:String?
       var doctorDash = ["2:00 PM - 2:45 PM",""]//make didset
       var green = [3,6,9,11]
       var red = [4,12,13,14]
       var dummyModel = [AdddocumentsModel]()
       var docIndex = 0
       let addDocumentsLimiter = 10
    let EditSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Theme.accentColor
        button.tag = 11
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i am here")
        Bundle.main.loadNibNamed("DotDetailsView", owner: self, options: nil)
        profileDataView.edgesToSuperview(usingSafeArea: true)
        profileDataView.height(self.view.frame.height/2 - 250)
        LabelStackView.arrangedSubviews.forEach { (lable) in
            switch lable.tag{
            case 1 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: customStringFormatting(str: "Anna Johnsaan(F)", no: 4), second: "MRN:THB888868",fColor: Theme.accentColor ?? .black, sColor: .black, fBold:true,sBold:true)
            case 2 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: "DOB: ", second: "13/10/1994", fColor:Theme.accentColor ?? #colorLiteral(red: 0.2069825828, green: 0.7254605889, blue: 1, alpha: 1), sColor: .black,fBold:true,sBold:false)
            case 3 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: "Language: ", second: "English", fColor: Theme.accentColor ?? #colorLiteral(red: 0.2069825828, green: 0.7254605889, blue: 1, alpha: 1), sColor: .black,fBold:true,sBold:false)
            case 4 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: "Phone no: ", second: "+971-55-123-1234", fColor: Theme.accentColor ?? #colorLiteral(red: 0.2069825828, green: 0.7254605889, blue: 1, alpha: 1), sColor: .black,fBold:true,sBold:false)
            case 5 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: "Email: ", second: "anna.j@thbglobal.com", fColor: Theme.accentColor ?? #colorLiteral(red: 0.2069825828, green: 0.7254605889, blue: 1, alpha: 1), sColor: .black,fBold:true,sBold:false)
            case 6 : (lable as? UILabel)?.attributedText = NSAttributedString().createAttributedString(first: "Emergency Contact: ", second: "+971-55-123-1234", fColor: Theme.accentColor ?? #colorLiteral(red: 0.2069825828, green: 0.7254605889, blue: 1, alpha: 1), sColor: .black,fBold:true,sBold:false)
            case 7 : print("3")
            case 8 : print("3")
            default: break
                
            }
            
        }
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
    
        table.register(UINib(nibName: "DotDetailsCellView", bundle: nil), forCellReuseIdentifier: "cellId")
        table.register(UINib(nibName: "MultiDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "multiCell")
        table.register(UINib(nibName: "DotAddDocsTableViewCell", bundle: nil), forCellReuseIdentifier: "docs")
        constTableView = table
        constView = mainView
        configureCollectionView()
        configureCollectionViewDataSource()
        createDummyData()
    }
    @IBAction func ShowDetails(_ sender: Any) {
        table = constTableView
        mainView = constView
        if detailsShow.titleLabel?.text != " Back"{
            detailsShow.setTitle(" Back", for: .normal)
            detailsShow.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            delegate?.addChildView(mainView,back: false)
            table.edgesToSuperview()
        }
        else{
            detailsShow.setTitle("Details", for: .normal)
            detailsShow.setImage(UIImage(), for: .normal)
            delegate?.addChildView(mainView,back: true)
            
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    
    func customStringFormatting( str: String,no:Int) -> String {
        var newStr = str
        for _ in 0...no{newStr += " " }
        return newStr
    }
    @objc func buttonClicked(_ sender:UIButton){
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 0.2,
                                      delay: 0,
                                      usingSpringWithDamping: CGFloat(0.20),
                                      initialSpringVelocity: CGFloat(6.0),
                                      options: UIView.AnimationOptions.allowUserInteraction,
                                      animations: {
                                       sender.transform = CGAffineTransform.identity
               },
                                      completion: { Void in()  }
           )
    }

}
protocol setViewAutomatically : class{
    func addChildView(_ view: UIView, back:Bool)
}
extension DotDetailsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.value(forKey: sectionNames[section]) as? NSArray)?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionNames[indexPath.section] == "Habits"{
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "multiCell") as? MultiDetailsTableViewCell else{return UITableViewCell()}
            cell.first.text = (data.value(forKey: sectionNames[indexPath.section]) as? NSArray)?.object(at: indexPath.row) as? String
            return cell
        }
        else  if sectionNames[indexPath.section] == "DOCS" {
                         guard let cell = tableView.dequeueReusableCell(withIdentifier: "docs") as? DotAddDocsTableViewCell else{return UITableViewCell()}
                       cell.backgroundColor = .clear
                       cell.addSubview(CardsCollectionView)
                       CardsCollectionView.edgesToSuperview()
                           return cell
                       }
        else if let arr = (data.value(forKey: sectionNames[indexPath.section]) as? NSArray)?.object(at: indexPath.row) as? NSDictionary{
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? DotDetailsCellView else{return UITableViewCell()}
            cell.first.text = arr.allKeys.first as? String ?? ""
            cell.indicatorButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
            return cell
        }
        else {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? DotDetailsCellView else{return UITableViewCell()}
            cell.first.text = (data.value(forKey: sectionNames[indexPath.section]) as? NSArray)?.object(at: indexPath.row) as? String
            if (cell.expandableRows as NSArray).contains(cell.first.text as AnyObject) {
                cell.buttonLeadingConstraint.constant = 50
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("~* make some magic at row: \(indexPath.row) *~")
        if let arr = (data.value(forKey: sectionNames[indexPath.section]) as? NSArray)?.object(at: indexPath.row) as?  [String:[Any]]{
           
            if let cell = tableView.cellForRow(at: indexPath) as? DotDetailsCellView{
                        addModifiedItemsIntoArray(arr: arr, key: sectionNames[indexPath.section], indexPath: indexPath, expand: false, cell: cell)
                        expandedheader = cell.first.text ?? ""
                   }
        }
        else if let cell = tableView.cellForRow(at: indexPath) as? DotDetailsCellView,cell.isExpand != nil {
            addModifiedItemsIntoArray(arr: [:], key: sectionNames[indexPath.section], indexPath: indexPath, expand: cell.isExpand!, cell: cell)
        }
        
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 359, height: 55))
        EditSaveButton.frame =  CGRect(x: tableView.frame.width-100, y: 17, width: 60, height: 20)
        let countCheck = header.subviews.filter({$0.tag == 13}).count
        EditSaveButton.isHidden = false
            if section == 0 {
                EditSaveButton.isHidden = false
                if !header.subviews.contains(EditSaveButton) && countCheck == 0{
                     header.addSubview(EditSaveButton)
                    print("editsavebutton")
                }
            }
            
             let label = UILabel()
                       label.frame = CGRect.init(x: 5, y: 5, width: header.frame.width-10, height: header.frame.height-10)
                       label.text = sectionNames[section]
                        label.font = UIFont.boldSystemFont(ofSize: 14) // my custom font
        label.textColor = UIColor.darkGray // my custom colour

                       header.addSubview(label)
        return header
    }
//   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//    let header = view as! UITableViewHeaderFooterView
//    EditSaveButton.frame =  CGRect(x: tableView.frame.width-80, y: 15, width: 60, height: 30)
//    let countCheck = header.subviews.filter({$0.tag == 13}).count
//    EditSaveButton.isHidden = false
//        if section == 0 {
//            EditSaveButton.isHidden = false
//            if !header.subviews.contains(EditSaveButton) && countCheck == 0{
//                 header.addSubview(EditSaveButton)
//                print("editsavebutton")
//            }
//        }
//
//        if let textlabel = header.textLabel {
//            textlabel.font = UIFont.boldSystemFont(ofSize: 14)
//        }
//
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if sectionNames[indexPath.section] == "DOCS"{
          return 120
      }
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
extension DotDetailsView{
    func addModifiedItemsIntoArray(arr:[String:[Any]],key:String,indexPath:IndexPath,expand:Bool,cell:UITableViewCell){
        var values:[Any]?
        let row = indexPath.row
        var newStr = [Any]()
        switch expand {
        case false:
            (cell as? DotDetailsCellView)?.retainRows = arr
            newStr.append(arr.keys.first ?? "")
            expandedheader.append(arr.keys.first ?? "")
            if (((arr as NSDictionary).allValues).first) != nil{
                newStr += (((arr as NSDictionary).allValues).first) as! Array<Any>
                (cell as? DotDetailsCellView)?.expandableRows = (((arr as NSDictionary).allValues).first) as? [Any] ?? []
            }
            values = data.value(forKey: key) as? [Any]
            values?.remove(at: row)
            
                var ind = row
                for item in newStr{
                    values?.insert(item, at: ind)
                    ind += 1
                }
            (cell as? DotDetailsCellView)?.isExpand = true
        case true:
            values = data.value(forKey: key) as? [Any]
            values?.removeAll(where: { (item) -> Bool in
                ((cell as? DotDetailsCellView)?.expandableRows.filter({($0 as? String) == item as? String}))?.count ?? 0>0
            })
            values?.remove(at: row)
            values?.insert((cell as? DotDetailsCellView)?.retainRows ?? [], at: row)
            (cell as? DotDetailsCellView)?.isExpand = false
        }
        
        data.setValue(values, forKey: key)
        UIView.transition(with: table, duration: 0.5, options: .transitionCrossDissolve, animations: {self.table.reloadData()}, completion: nil)
    }
}
extension DotDetailsView {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds , collectionViewLayout: generateLayout())
//        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        // register collection view to different types of cells
        collectionView.register(DotAddDocsCell.self, forCellWithReuseIdentifier: DotAddDocsCell.reuseIdentifier)
        //For registering sections
        
        CardsCollectionView = collectionView
//        CardsCollectionView.edgesToSuperview()
    }
    //dynamic for multi sections and layouts
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            //add cases with sections
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .main: return self.generateMyAlbumsLayout(isWide: isWideView)
            }
        }
        return layout
    }
    func generateMyAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 4, trailing: 0)
        
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(3.0),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: addDocumentsLimiter)
        
        //TODO : - Add section header
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        return section
    }
    private func configureCollectionViewDataSource() {
        // TODO: dataSource
        
        dataSource = DataSource(collectionView: CardsCollectionView, cellProvider: { (collectionView, indexpath, mov) -> DotAddDocsCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DotAddDocsCell.reuseIdentifier, for: indexpath) as? DotAddDocsCell
                else{fatalError("Could not create new cell")}
            cell.nameLabel.text =  self.dummyModel[indexpath.row].cardName
//            cell.nameButton.setTitle( self.doctorDash[indexpath.row] , for: .normal)
            cell.isSelect = mov.isSelect ?? false
            if self.dummyModel[indexpath.row].cardName == ""{
                cell.DocumentImageView.image = #imageLiteral(resourceName: "icons8-plus-64")
            }
            else{
                cell.DocumentImageView.image = UIImage()
            }
//            cell.cardImageView.image = DotLoginViewController.shared.signature == "Doctor" ? self.imagesArray[indexpath.row] : self.imagesArray1[indexpath.row]
            return cell
        })
    }
    private func createDummyData() {
        var dummyContacts: [AdddocumentsModel] = []
        let count = doctorDash.count
        for i in 0..<count {
           dummyContacts.append(AdddocumentsModel(cardName: "\(self.doctorDash[i])", cardTitle: "Test\(i)",isSelect: false))
            
        }
        dummyModel = dummyContacts
        applySnapshot(items: dummyContacts)
        
    }
    private func applySnapshot(items: [AdddocumentsModel]) {
        
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot,animatingDifferences: true)
    }
    func openDocumentPicker(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)

              documentPicker.delegate = self
              present(documentPicker, animated: true, completion: nil)
    }
    func showPreview(url: String){
                   // Instantiate the interaction controller
//        if let file = URL(string: url){
//                   let previewQL = QLPreviewController() // 4
//                   previewQL.dataSource = self // 5
//                   previewQL.currentPreviewItemIndex = docIndex // 6
//                    show(previewQL, sender: nil) // 7
//
//               }else {
//                   print("File missing! Button has been disabled")
//               }
    }
}

extension DotDetailsView: UICollectionViewDelegate,UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    docIndex = indexPath.row
    if item.cardName == ""{
        openDocumentPicker()
    }
    else{
        showPreview(url: item.cardTitle!)
    }
    
  }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print(url)

        print(url.lastPathComponent.split(separator: "_").first!)

        print(url.pathExtension)
        let newCard = AdddocumentsModel(cardName: "", cardTitle: "", selectedImage: UIImage(), isSelect: false)
        
        var model = dummyModel.remove(at: docIndex)
        model.cardName = (url.lastPathComponent.components(separatedBy: "-").first) ?? ""
        model.cardTitle = "\(url)"
        dummyModel.insert(model, at: docIndex)
        dummyModel.insert(newCard, at: dummyModel.count)
        applySnapshot(items: dummyModel)
                  }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

