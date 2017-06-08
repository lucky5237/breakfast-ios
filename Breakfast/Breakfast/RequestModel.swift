//
//  RequestModel.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/8.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit

class RequestModel: NSObject {
    var number:Int?
    var placeId:Int?
    var flag:Int?
    
    init(number:Int?,placeId:Int?,flag:Int?) {
        super.init()
        self.number = number
        self.placeId = placeId
        self.flag = flag
    }

}
