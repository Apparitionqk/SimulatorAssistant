//
//  BannerModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/2.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

public class BannerModel: NSObject {
    var id:String?
    var title:String?
    var img:String?
    var url:String?
    var lableId:String?
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        
        if json == JSON.null{
            return
        }
        id = json["id"].stringValue
        title = json["title"].stringValue
        img = json["img"].stringValue
        url = json["url"].stringValue
        lableId = json["lableid"].stringValue

    }
}
