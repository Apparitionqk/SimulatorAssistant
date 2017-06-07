//
//  VaneOfFashionCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/5.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class VaneOfFashionCell: UITableViewCell {
    var jsonData:JSON?
    
    var titleLabel :UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: SCREEN_WIDTH, height: 20))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    var contentScroll:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: 120))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
    }
    
    
    func setUpSubViews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentScroll)
    }
    func setVaneData(json:JSON)  {
        jsonData = json
        titleLabel.text = json["title"].string
        let data = json["data"]
        let numbers = data.count
        let itemWidth = 80
        let itemSpace = 10
        contentScroll.contentSize = CGSize.init(width: itemWidth*numbers + itemSpace*(numbers + 1), height: 120)
        for index in 0...numbers-1 {
            let appModel = AppModel.init(fromJson: data[index])
            let frame = CGRect.init(x: itemSpace+(itemWidth+itemSpace)*index, y: 5, width: itemWidth, height: itemWidth)
            let button = InstallButton.init(type: .custom)
            button.frame = frame
            if (appModel.icon != nil) {
                button.af_setImage(for: .normal, url: URL(string: appModel.icon!)!)
            }
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
            button.tag = index
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            contentScroll.addSubview(button)
            let buttonLabel = UILabel.init(frame: CGRect.init(x: frame.minX, y: frame.maxY+5, width: frame.width, height: 20))
            buttonLabel.text = appModel.titleArr?[0]
            buttonLabel.font = UIFont.systemFont(ofSize: 12)
            buttonLabel.textAlignment = .center
            contentScroll.addSubview(buttonLabel)
        }
        
    }
    func buttonAction(button:UIButton) {
        let appModel = AppModel.init(fromJson: jsonData!["data"][button.tag])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:APPINFONOTIFICATION), object: appModel)
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
