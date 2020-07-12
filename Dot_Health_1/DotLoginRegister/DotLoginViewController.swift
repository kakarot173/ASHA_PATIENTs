//
//  DotLoginViewController.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 05/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit

class DotLoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: DotTextFieldUtility!
    
    @IBOutlet weak var userNameTextField: DotTextFieldUtility!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func signInAction(_ sender: Any) {
        print("sign in clicked")

    }
    
}
