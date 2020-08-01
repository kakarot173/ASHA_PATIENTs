//
//  DotLoginViewController.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 05/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import SVProgressHUD
class DotLoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: DotTextFieldUtility!
     public static let shared = DotLoginViewController()
    @IBOutlet weak var userNameTextField: DotTextFieldUtility!
    @IBOutlet weak var signIn: LoadingButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var proImage: UIImageView!
       var iconClick = true
    var eyeButton:UIButton = UIButton(type: .custom)
    private let client = DotConnectionClient()
    override func viewDidLoad() {
        super.viewDidLoad()
    eyeButton.setImage(UIImage(systemName:"eye.slash")?.withTintColor(Theme.gradientColorLight!), for: .normal)
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        eyeButton.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        eyeButton.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        signIn.hideLoading()
        signIn.setTitle("Sign In", for: .normal)
        signIn.isEnabled = true
        signIn.titleLabel?.textAlignment = .right
        
        // Do any additional setup after loading the view.
    }
   @objc func refresh(_ sender: Any) {
         if(iconClick == true) {
             passwordTextField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName:"eye")?.withTintColor(Theme.gradientColorLight!), for: .normal)
         } else {
             passwordTextField.isSecureTextEntry = true
             eyeButton.setImage(UIImage(systemName:"eye.slash")?.withTintColor(Theme.gradientColorLight!), for: .normal)
             
         }
         
         iconClick = !iconClick
     }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        checkLoginData(){ [weak self]result in
            guard let self = self else { return }
            if result{
                DispatchQueue.main.async(execute: {
                    let _ = self.view.subviews.map({$0.isHidden = true})
                    self.bgImage.isHidden = false
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sameViewController = storyboard.instantiateViewController(withIdentifier: "mainTab") as! DotTabViewController
                    self.navigationController?.pushViewController(sameViewController, animated: true)
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                })
                
            }
            else{
                DispatchQueue.main.async(execute: {
                    let _ = self.view.subviews.map({$0.isHidden = false})
                    self.proImage.isHidden = true
                })
                
            }
        }
        
    }
    func checkLoginData(completion :@escaping (Bool) -> Void){
    if let _ = (KeychainService.loadPassword(service: keyChainPrefix.loginSession.rawValue, account: keyChainPrefix.patientAccount.rawValue)){
        
        completion(true)
    }
    completion(false)
    }
    @IBAction func signInAction(_ sender: Any) {
        print("sign in clicked")
        self.signIn.showLoading()
        self.signInUser(account:keyChainPrefix.patientAccount.rawValue)
    }
    func signInAct(account:String) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let sameViewController = storyboard.instantiateViewController(withIdentifier: "mainTab") as! DotTabViewController
      self.navigationController?.pushViewController(sameViewController, animated: true)
      self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func signUpAction(_ sender: Any) {
        showRegister()
        
    }
    func showRegister(){
        self.navigationController?.pushViewController(DotRegisterViewController(), animated: true)
        self.navigationController?.navigationBar.topItem?.title = "Register"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK:- API Calls
    func signInUser(account:String){
           
           // Query item
           let queryItem = [ URLQueryItem(name: "keyName", value: "ValueName") ]
    
           /*
           // Body as string
           let bodyString = "yourParameterString"
           let body = bodyString.data(using: .utf8) */
           
           // Body as dictionary
           var paramsDictionary = [String:String]()
           paramsDictionary["username"] = userNameTextField.text ?? kblankString //"john@doe10.com"
           paramsDictionary["password"] = passwordTextField.text ?? kblankString //password
           paramsDictionary["usertype"] = account

           guard let body = try? JSONSerialization.data(withJSONObject: paramsDictionary) else { return }
           
           // Headers
          let headers = ["Content-Type":"application/json"]
           
           let api: API = .api1
           let endpoint: Endpoint = api.getPostAPIEndpoint(urlString: "\(api.rawValue)sessions", queryItems: nil, headers: headers, body: body)
           
           client.userLogin(from: endpoint) { [weak self] result in
               guard let self = self else { return }
               switch result {
               case .success(let model2Result):
                   self.signIn.hideLoading()
                   guard let model2Result = model2Result else { return }
                   print(model2Result)
                   if let dataModel = model2Result as? NSDictionary ,let type = dataModel["type"] as? String,let desc = dataModel["description"] as? String{
                       switch type{
                       case "error":self.showAlertView("Login Failed", message: desc)
                       default:
                            KeychainService.savePassword(service: "sessions", account: keyChainPrefix.patientAccount.rawValue , data: "password")
                            self.signInAct(account: keyChainPrefix.patientAccount.rawValue)
                       }
                   }else {
                           self.showAlertView("Login Failed", message: "Some Error Occured")
                       }
                   
                  
                   
               case .failure(let error):
                    self.signIn.hideLoading()
                   print("the error \(error)")
               }
           }
       }
}
