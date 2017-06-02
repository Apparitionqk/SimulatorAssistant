//
//  ScrollCellCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/2.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScrollCell: UITableViewCell,FYBannerCustomizable, FYBannerViewDelegate {
    
    var flag:Int = 0
    var bannerView:CyclePictureView!
    
    var controlStyle: FYControlStyle {
        let position:FYPosition = (x:.marginRight(10), y:.centerY)
        var style = FYControlStyle()
        style.position = position
        return style
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        let rect = CGRect(x:0, y:5, width:SCREEN_WIDTH, height:200-10)
//        bannerView = FYBannerView(frame: rect, option: self)
//        bannerView.backgroundColor = UIColor.black
//        bannerView.delegate = self
        bannerView = CyclePictureView(frame: rect, imageURLArray: [String]())
        self.addSubview(bannerView)
    }
    
    func getValue(index:Int, model:[BannerModel], closure:@escaping (_ value:[BannerModel])-> Void) {
        DispatchQueue.global().async {
            //异步执行
            DispatchQueue.main.async {
                closure(model)
            }
            
        }
    }
    func bannerModel(bannerData: JSON) {
        var models = [BannerModel]()
        var imageURLs = [String]()
        for (_,subJson):(String, JSON) in bannerData {
            let bannerModel = BannerModel.init(fromJson:subJson)
            imageURLs.append(bannerModel.img!)
            models.append(bannerModel)
        }
        self.bannerView.imageURLArray = imageURLs
//        for index in 0...models.count {
//            getValue(index: index, model: models) { (value) in
////                self.bannerView.dataSource = value
//            }
//        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: FYBannerViewDelegate
    func bannerView(at index: Int) {
        print(index)
    }
    func bannerView(to index: Int) {
        print(index)
    }
        

}
