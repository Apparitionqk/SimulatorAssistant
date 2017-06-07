//
//  NecessaryViewModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/6.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NecessaryViewModel: NSObject {
    var necessaryTable:UICollectionView?
    var hotVC: BaseViewController = BaseViewController()
    override init() {
        super.init()
    }
    convenience  init(collectionView:UICollectionView, viewController: BaseViewController) {
        self.init()
        necessaryTable = collectionView
        hotVC = viewController
        
    }
    class func getAppData(colloctionView: NecessaryView) {
        let urlStr = NecessaryViewModel().serverUrl()
        Alamofire.request(urlStr).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case.success:
                let dict =  JSON(dataResponse.result.value!)//json as! Dictionary<String,AnyObject>
                print("dict:\(dict["data"]["apps"])")
                colloctionView.setJsonData(json: dict["data"]["apps"])
            case.failure:
                print("\(String(describing: dataResponse.result.error))")
            }
        }
    }
    
    func serverUrl() -> String {
        return "http://interface.xyzs.com/v2/ios/c04/favourite/essential?clientversion=6.1.5&lang=zh-Hans-CN&clienttype=1&device_uuid=Unknow&flagdata1=0&sn=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&devicetype=1&systemversion=10.3.2&deviceimei=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&channel=500077&appleid=&uuid=CE5D904B-382B-4467-9D39-30254583EE72&nettype=WiFi&isidfatracking=1&resolveip=17.253.75.201&clientip=119.253.46.106&platform=iPhone8,2&uid=-1&simulateidfa=782BDA50-66CC-D7B7-B275-D768814F4B0E&idfv=67D83F28-EED4-42F0-A480-6FF9C6C4747A&jailbreak=1&identity=760&openidfa=C24CD820-B4D3-9D20-27C7-DD725150BD5B&showModel=iphone_6plus&certId=760&isauthor=2&flagdata=0&spflag=0&ipatype=1&screensize=1242-2208&idfa=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&timestamp=1496745515&sign=bb1d10d27de8662d7f4ca7a9c4cfdb05"
    }
}
