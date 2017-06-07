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
    let HotCellIdentifier = "HotCell"
    let VaneCellIdentifier = "VaneCell"
    let ScrollCellIdentifier = "ScrollCell"
    let BannerCellIdentifier = "BannerCell"
    let RecommondCellIdentifier = "RecommendCell"
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registNib()
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        self.separatorStyle = .none
    }
    func registNib()  {
        self.register(HotCell.classForCoder(), forCellReuseIdentifier: HotCellIdentifier)
        self.register(ScrollCell.classForCoder(), forCellReuseIdentifier: ScrollCellIdentifier)
        self.register(VaneOfFashionCell.classForCoder(), forCellReuseIdentifier: VaneCellIdentifier)
        self.register(BannerCell.classForCoder(), forCellReuseIdentifier: BannerCellIdentifier)
        self.register(RecommendCell.classForCoder(), forCellReuseIdentifier: RecommondCellIdentifier)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataJson["data"]["modular"].count + 1 //numbers!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let type = dataJson["data"]["modular"][section-1]["type"]
        print("number type == \(type)")
        if section==0 {
            return 1
        }else if type == "applist" {
             let array = dataJson["data"]["modular"][section-1]["data"]
            return array.count
        }else if type  == "app_box12"{
            return 1
        }else if type  == "app_box6"{
            return 1
        }else if type == "banner_common" {
            return dataJson["data"]["modular"][section-1]["data"].count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        let type = dataJson["data"]["modular"][indexPath.section-1]["type"]
        print("height type == \(type)")
        var height = 0.0
        switch type {
        case "applist":
            height = 80
            break
        case "app_box12":
            height = 140
            break
        case "app_box6":
            height = Double(SCREEN_WIDTH-40+CGFloat(30))
            break
        case "banner":
            height = 200
            break
        case "banner_common":
            height = 150
            break
        default:
            height = 80
        }
        return CGFloat(height)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
        if indexPath.section == 0 {
            let scrollCell:ScrollCell = self.dequeueReusableCell(withIdentifier: ScrollCellIdentifier, for: indexPath) as! ScrollCell
            let banners = dataJson["data"]["banner"]
            scrollCell.bannerModel(bannerData: banners)
            return scrollCell
        }else {
            let type = dataJson["data"]["modular"][indexPath.section-1]["type"]
            print("section == \(indexPath.section)\ncell type == \(type)")
            switch type {
            case "app_box12":
                let vaneCell:VaneOfFashionCell = self.dequeueReusableCell(withIdentifier: VaneCellIdentifier, for: indexPath) as! VaneOfFashionCell
                vaneCell.setVaneData(json: dataJson["data"]["modular"][indexPath.section-1])
                return vaneCell
            case "applist":
                let appCell: HotCell = self.dequeueReusableCell(withIdentifier: HotCellIdentifier, for: indexPath) as! HotCell
                print("applist data:\(dataJson["data"]["modular"][indexPath.section-1])")
                appCell.setJsonData(json: dataJson["data"]["modular"][indexPath.section-1]["data"][indexPath.row])
                return appCell
            case "banner_common":
                let bannerCell:BannerCell = self.dequeueReusableCell(withIdentifier: BannerCellIdentifier, for: indexPath) as! BannerCell
                bannerCell.setBannerData(json: dataJson["data"]["modular"][indexPath.section-1]["data"][indexPath.row])
                return bannerCell
            case "app_box6":
                let recommondCell:RecommendCell = self.dequeueReusableCell(withIdentifier: RecommondCellIdentifier, for: indexPath) as! RecommendCell
                recommondCell.setRecommondJson(json: dataJson["data"]["modular"][indexPath.section-1]["data"])
                return recommondCell
            default:
                break
            }
        }
   
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = dataJson["data"]["modular"][indexPath.section-1]["type"]
        if type == "applist" {
            let appInfoModel = AppModel.init(fromJson: dataJson["data"]["modular"][indexPath.section-1]["data"][indexPath.row])
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:APPINFONOTIFICATION), object: appInfoModel)
        }
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
