// TODO: Remove this header. Code should be faceless :]
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

// TODO: Make your class 'final' by default.
class ViewController: UIViewController {

    // TODO: IBOutlets must be private
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    // TODO: Move this variable to viewModel
    var isEnabled = Variable<Bool>(false)
    // TODO: Create ViewModel instead. Also, your viewModel must be injected into your view controller.
    var loginModel = LoginModel()
    
    // TODO: 'private' all properties, if you don't need access them
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Use bind instead subscribe
        loginField.rx.text.subscribe(onNext:{ text in
            self.loginModel.login.value = text!
            // TODO: Move this check to viewModel
            self.chekFields()
            
        }).disposed(by: bag)
        passwordField.rx.text.subscribe(onNext:{ text in
            self.loginModel.password.value = text!
            self.chekFields()
            
        }).disposed(by: bag)
        // TODO: This warning says that it can be memory leak. You, as a good developer, must know and remember about it.
        // Read 'Disposing and terminating' section on page #54 'RxSwift' book.
        isEnabled.asObservable().bind { (bool) in
            self.loginButton.isEnabled = bool
        }
        passwordField.rx.text.orEmpty
            // TODO: You don't need scan operator here if you will move it to the view model.
            
            /// View Controller should only show data and react for the updates. Everything else - is view model's work.
            .scan("") { (previous, new) -> String in
                // TODO: ViewController shouldn't know about this check. It must be done by viewModel.
                if new.count > 8 {
                    return previous ?? String(new.prefix(8))
                } else {
                    return new
                }
            }
            // TODO: Use 'bind' instead
            .subscribe(passwordField.rx.text)
            .disposed(by: bag)
        
    }
    
    // TODO: Mistype 'chek' (must be 'check')
    // TODO: Move it to the viewModel
    func chekFields() {
        // TODO: if the text will be nil and you will call that function - your app will crash. Autocomplete shouldn't be your friend :]
        if (self.loginField.text?.count)! > 5 && (self.passwordField.text?.count)! >= 8 {
            self.isEnabled.value = true
        } else {
            self.isEnabled.value = false
        }
    }

}

