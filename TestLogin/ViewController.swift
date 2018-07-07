//
//  ViewController.swift
//  TestLogin
//
//  Created by Sasha Voloshanov on 7/7/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var isEnabled = Variable<Bool>(false)
    var loginModel = LoginModel()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.rx.text.subscribe(onNext:{ text in
            self.loginModel.login.value = text!
            self.chekFields()
            
        }).disposed(by: bag)
        passwordField.rx.text.subscribe(onNext:{ text in
            self.loginModel.password.value = text!
            self.chekFields()
            
        }).disposed(by: bag)
        isEnabled.asObservable().bind { (bool) in
            self.loginButton.isEnabled = bool
        }
        passwordField.rx.text.orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 8 {
                    return previous ?? String(new.prefix(8))
                } else {
                    return new
                }
            }
            .subscribe(passwordField.rx.text)
            .disposed(by: bag)
        
    }
    
    func chekFields() {
        if (self.loginField.text?.count)! > 5 && (self.passwordField.text?.count)! >= 8 {
            self.isEnabled.value = true
        } else {
            self.isEnabled.value = false
        }
    }

}

