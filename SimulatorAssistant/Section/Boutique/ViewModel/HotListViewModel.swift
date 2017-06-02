//
//  HotListViewModel.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/27.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HotListViewModel: NSObject {
    var hotTable:UITableView = UITableView()
    var hotVC: BaseViewController = BaseViewController()
    override init() {
        super.init()
    }
    convenience  init(tableView:UITableView, viewController: BaseViewController) {
        self.init()
        hotTable = tableView
        hotVC = viewController
        
    }
    class func getAppData(urlString: String,tableView: HotListView) {
        Alamofire.request(urlString).responseJSON { (dataResponse) in
//            let dict = try? JSONSerialization.jsonObject(with: dataResponse.value, options: JSONSerialization.ReadingOptions)
            
            switch dataResponse.result {
                case.success:
                    let dict =  JSON(dataResponse.result.value!)//json as! Dictionary<String,AnyObject>
                    print("dict:\(dict)")
                tableView.reloadWithData(dic: dict)
                case.failure:
                print("\(String(describing: dataResponse.result.error))")
            }
        }
    }
}
