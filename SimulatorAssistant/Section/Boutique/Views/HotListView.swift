//
//  HotListView.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotListView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var dataDic:Dictionary<String, Any> = Dictionary()
    var dataJson = JSON.init(parseJSON: "")
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registNib()
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        self.separatorStyle = .singleLine
    }
    func registNib()  {
        let cellNib = UINib(nibName: "HotCell", bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: "HotCell")
        self.register(ScrollCell.classForCoder(), forCellReuseIdentifier: "ScrollCell")
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataJson["data"]["modular"].count + 1 //numbers!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let modular = (dataDic["data"] as! Dictionary<String,AnyObject>)["modular"]
//        let tempDic = modular?[section] as! Dictionary<String,AnyObject>
//        let tempArray = tempDic["data"]
//        if tempDic["type"] as! String == "applist" {
//            return (tempArray?.count)!
//        }
        if section==0 {
            return 1
        }else if dataJson["data"]["modular"][section]["type"] == "applist" {
             let array = dataJson["data"]["modular"][section]["data"]
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var scrollCell:ScrollCell = self.dequeueReusableCell(withIdentifier: "ScrollCell", for: indexPath) as! ScrollCell
            if scrollCell.isEqual(nil) {
                scrollCell = ScrollCell.init(style: .default, reuseIdentifier: "ScrollCell")
            }
            let banners = dataJson["data"]["banner"]
//            print("banners :\(banners)")
            scrollCell.bannerModel(bannerData: banners)
            return scrollCell
        }
        let  cellIdenfier = "HotCell"
        let appCell: HotCell = self.dequeueReusableCell(withIdentifier: cellIdenfier) as! HotCell
        appCell.appModel = AppModel.init(fromJson:dataJson["data"]["modular"][indexPath.section]["data"][indexPath.row])
        return appCell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

     // MARK: Reload Data
    func reloadWithData(dic:JSON) {
//        dataDic = dic
        dataJson = dic
        self.reloadData()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
