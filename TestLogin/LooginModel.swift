//
//  LooginModel.swift
//  TestLogin
//
//  Created by Sasha Voloshanov on 7/7/18.
//  Copyright © 2018 Sasha Voloshanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginModel {
    var login = Variable<String>("")
    var password = Variable<String>("")
}
