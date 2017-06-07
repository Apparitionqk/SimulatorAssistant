//
//  NewGameViewModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/6.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewGameViewModel: NSObject {
    var newGameTable:UITableView?
    var hotVC: BaseViewController = BaseViewController()
    override init() {
        super.init()
    }
    convenience  init(tableView:UITableView, viewController: BaseViewController) {
        self.init()
        newGameTable = tableView
        hotVC = viewController
        
    }
    class func getAppData(gameView: NewGameView) {
        let urlStr = NewGameViewModel().serverUrl()
        Alamofire.request(urlStr).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case.success:
                let dict =  JSON(dataResponse.result.value!)//json as! Dictionary<String,AnyObject>
                print("dict:\(dict["data"]["apps"])")
                gameView.reloadWithData(dic: dict["data"])
            case.failure:
                print("\(String(describing: dataResponse.result.error))")
            }
        }
    }
    
    func serverUrl() -> String {
        return "http://interface.xyzs.com/v2/ios/c04/webgame/sf?clientversion=6.1.5&lang=zh-Hans-CN&clienttype=1&device_uuid=Unknow&flagdata1=0&sn=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&devicetype=1&systemversion=10.3.2&deviceimei=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&channel=500077&appleid=&uuid=1861EA12-6634-4340-9150-68C68CD1DF3B&nettype=WiFi&isidfatracking=1&resolveip=17.253.75.201&clientip=119.253.46.106&platform=iPhone8,2&uid=-1&simulateidfa=782BDA50-66CC-D7B7-B275-D768814F4B0E&idfv=67D83F28-EED4-42F0-A480-6FF9C6C4747A&jailbreak=1&identity=760&openidfa=C24CD820-B4D3-9D20-27C7-DD725150BD5B&showModel=iphone_6plus&certId=760&isauthor=2&flagdata=0&spflag=0&ipatype=1&screensize=1242-2208&idfa=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&timestamp=1496745236&sign=d363b93d0d83c9b2fa8fcbdb8051cbf2&p=1&size=20&page=1"
    }
}
