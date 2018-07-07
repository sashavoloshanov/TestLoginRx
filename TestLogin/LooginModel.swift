// TODO: Remove header

//
//  LooginModel.swift
//  TestLogin
//
//  Created by Sasha Voloshanov on 7/7/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import Foundation
import RxSwift
// TODO: No need of 'RxCocoa' here. Read about it
import RxCocoa

// TODO: It should be named as "LoginViewModel"

// TODO: Create protocol for ViewModel with suffix '...Type'. for this example it should be 'LoginViewModelType'

struct LoginModel {
    var login = Variable<String>("")
    var password = Variable<String>("")
}
