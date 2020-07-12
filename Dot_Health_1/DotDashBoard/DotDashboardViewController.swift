//
//  DotDashboardViewController.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 06/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import LBTATools
import TinyConstraints

class DotDashboardViewController: UIViewController {
    let profileDetailsHeight:CGFloat = 100
     
    @objc static let sharedInstance = DotDashboardViewController(nibName:String(describing: DotDashboardViewController.self), bundle:.main)
    @IBOutlet weak var profileDetailsView: UIView!
    var detailsView = DotDetailsView()
    
    var identifier:String = "test1"
    @IBOutlet weak var dashboardSubview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //declaration of bundle XIB
        Bundle.main.loadNibNamed(String(describing: DotDashboardViewController.self), owner: self, options: nil)
        let collectionViewObj = DotCollectionViewController()
        collectionViewObj.delegate = self
        // Do any additional setup after loading the view.
        //Adding view with constraints
        profileDetailsView.edgesToSuperview(excluding: .bottom, insets: .left(8) + .right(8),  usingSafeArea: true)
        profileDetailsView.height(self.view.frame.height/2 - 250)
        profileDetailsView.addSubview(detailsView.view)
        detailsView.view.edgesToSuperview()
        detailsView.delegate = self
        dashboardSubview.topToBottom(of: profileDetailsView,offset: 8)
        dashboardSubview.edgesToSuperview(excluding: .top, insets: .left(8) + .right(8) + .bottom(8),usingSafeArea: true)
        profileDetailsView.layer.borderWidth = 1
        profileDetailsView.layer.borderColor = UIColor.black.cgColor
        collectionViewObj.setBounds(bound: dashboardSubview.bounds)
        let _ = collectionViewObj.view
        
        let view = collectionViewObj.CardsCollectionView
        collectionViewObj.collectionSuperView = dashboardSubview
        dashboardSubview.addSubview(view ?? UIView())
        view?.edgesToSuperview()
        self.view.alpha = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        UIView.animate(withDuration: 0.7) {
            self.view.alpha = 1.0
        }
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let x = UIBarButtonItem(image: UIImage(named: "back_home"), style: .plain, target: nil, action: nil)
       
        navigationItem.backBarButtonItem = x
        
    }
    func check(){
        self.identifier = "1"
//        print(self.dashboardSubview.description)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DotDashboardViewController:setViewAutomatically,setViewControllerAutomatically{

    
    func addChildViewController(_ views:UIViewController, back: Bool) {
        self.navigationController?.pushViewController(views, animated: true)
        self.navigationController?.navigationBar.barTintColor = Theme.tintcolor
        self.navigationController?.navigationBar.tintColor = Theme.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
      
    }
    
    func addChildView(_ view: UIView, back: Bool) {
       
        
        if back{
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
        else{
            self.dashboardSubview.addSubview(view)
            view.edgesToSuperview()
            view.layoutIfNeeded()
        }
        
    }

   
    
    
}
