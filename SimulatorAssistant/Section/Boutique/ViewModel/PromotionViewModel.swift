//
//  PromotionViewModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/7.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PromotionViewModel: NSObject {
    var newPromotionTable:PromotionView?
    var hotVC: BaseViewController = BaseViewController()
    override init() {
        super.init()
    }
    convenience  init(promotionView:PromotionView, viewController: BaseViewController) {
        self.init()
        newPromotionTable = promotionView
        hotVC = viewController
        
    }
    class func getAppData(promotionView:PromotionView) {
        let urlStr = PromotionViewModel().promotionUrl()
        Alamofire.request(urlStr).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case.success:
                let dict =  JSON(dataResponse.result.value!)//json as! Dictionary<String,AnyObject>
                print("dict:\(dict["data"]["list"])")
                promotionView.reloadWithData(dic: dict["data"])
            case.failure:
                print("\(String(describing: dataResponse.result.error))")
            }
        }
    }
    
    func promotionUrl() -> String {
        return "http://interface.xyzs.com/v2/ios/c04/act/iosList?clientversion=6.1.5&lang=zh-Hans-CN&clienttype=1&device_uuid=Unknow&flagdata1=0&sn=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&devicetype=1&systemversion=10.3.2&deviceimei=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&channel=500077&appleid=&uuid=3D95768F-F763-45E4-8D77-A99EE39387A7&nettype=WiFi&isidfatracking=1&resolveip=17.253.75.201&clientip=119.253.46.106&platform=iPhone8,2&uid=-1&simulateidfa=782BDA50-66CC-D7B7-B275-D768814F4B0E&idfv=67D83F28-EED4-42F0-A480-6FF9C6C4747A&jailbreak=1&identity=760&openidfa=C24CD820-B4D3-9D20-27C7-DD725150BD5B&showModel=iphone_6plus&certId=760&isauthor=2&flagdata=0&spflag=0&ipatype=1&screensize=1242-2208&idfa=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&timestamp=1496745626&sign=0f57ea5a275e5346e3ac60711a3296f7&p=1&ps=20&agent_id=1"
    }
    func benifitUrl() -> String {
        return "http://sdk.xyzs.com/coupon/v2/productlist.php?clientversion=6.1.5&lang=zh-Hans-CN&clienttype=1&device_uuid=Unknow&flagdata1=0&sn=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&devicetype=1&systemversion=10.3.2&deviceimei=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&channel=500077&appleid=&uuid=0F180ED9-39B1-45E4-8F9E-A409D9B9AD29&nettype=WiFi&isidfatracking=1&resolveip=17.253.75.201&clientip=119.253.46.106&platform=iPhone8,2&uid=-1&simulateidfa=782BDA50-66CC-D7B7-B275-D768814F4B0E&idfv=67D83F28-EED4-42F0-A480-6FF9C6C4747A&jailbreak=1&identity=760&openidfa=C24CD820-B4D3-9D20-27C7-DD725150BD5B&showModel=iphone_6plus&certId=760&isauthor=2&flagdata=0&spflag=0&ipatype=1&screensize=1242-2208&idfa=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&timestamp=1496745568&sign=37a461cadaf8d6985fb9e6d31bd47185"
    }

}
