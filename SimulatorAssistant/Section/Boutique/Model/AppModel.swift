//
//  AppModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/27.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class AppModel: NSObject {
    var acturl : String?
    var addtime : String?
    var bundleVersion : String?
    var bundleid : String?
    var cusDesc : String?
    var downloadIconType : String?
    var downloadnum : String?
    var firstClassId : String?
    var giftPackType : String?
    var giftType : String?
    var icon : String?
    var iconMark : String?
    var isAppid : String?
    var isCooperation : Int?
    var itunesid : String?
    var minimumOsVersion : String?
    var price : String?
    var relatedrecommend : String?
    var size : String?
    var title : String?
    var titleArr : [String]?
    var version : String?
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == JSON.null{
            return
        }
        acturl = json["acturl"].stringValue
        addtime = json["addtime"].stringValue
        bundleVersion = json["bundleVersion"].stringValue
        bundleid = json["bundleid"].stringValue
        cusDesc = json["cus_desc"].stringValue
        downloadIconType = json["download_icon_type"].stringValue
        downloadnum = json["downloadnum"].stringValue
        firstClassId = json["first_class_id"].stringValue
        giftPackType = json["gift_pack_type"].stringValue
        giftType = json["gift_type"].stringValue
        icon = json["icon"].stringValue
        iconMark = json["icon_mark"].stringValue
        isAppid = json["is_appid"].stringValue
        isCooperation = json["is_cooperation"].intValue
        itunesid = json["itunesid"].stringValue
        minimumOsVersion = json["minimum_os_version"].stringValue
        price = json["price"].stringValue
        relatedrecommend = json["relatedrecommend"].stringValue
        size = json["size"].stringValue
        title = json["title"].stringValue
        titleArr = [String]()
        let titleArrArray = json["title_arr"].arrayValue
        for titleArrJson in titleArrArray{
//            titleArr.append(titleArrJson.stringValue)
            titleArr?.append(titleArrJson.stringValue)
        }
        version = json["version"].stringValue
    }
}
