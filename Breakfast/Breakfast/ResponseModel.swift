//
//  ResponseModel.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/8.
//  Copyright © 2017年 卢键. All rights reserved.
//

import Foundation
import HandyJSON

class Food: HandyJSON {
    
    var createTs:String?
    var sales:Int?
    var id:Int?
    var price:Float?
    var image:String?
    var place:Place?
    var name:String?
    required init() {}
    
}
class Place:HandyJSON{
    var id:Int?
    var name:String?
    var orderNum:Int?
    required init() {}
}
class BaseResponseModel<T>: HandyJSON {
    var code:String?
    var data:T?
    var message:String?
    required init() {
    }
}
