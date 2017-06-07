//
//  BannerCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/5.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class BannerCell: UITableViewCell {
    let maskImage:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 5, y: 10, width: SCREEN_WIDTH-10, height: 130))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var appTitle:UILabel = UILabel()
    var appSubTitle:UILabel = UILabel()
    var appImage:UIImageView = UIImageView()
    var appModel:AppModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubViews() {
        self.contentView.addSubview(maskImage)
        let maskView = UIView.init(frame: CGRect.init(x: 0, y: 80, width: maskImage.width(), height: 50))
        maskView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        maskView.tag = 999
        maskImage.addSubview(maskView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapHandler(tap:)))
        maskView.addGestureRecognizer(tap)
        
        appImage = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: 40, height: 40))
        appImage.layer.masksToBounds = true
        appImage.layer.cornerRadius = 4
        maskView.addSubview(appImage)
        
        appTitle = UILabel.init(frame: CGRect.init(x: appImage.right()+5, y: 5, width: maskView.width()-appImage.width()-10-20-50, height: 20))
        appTitle.font = UIFont.systemFont(ofSize: 14)
        appTitle.textColor = .white
        maskView.addSubview(appTitle)
        
        appSubTitle = UILabel.init(frame: CGRect.init(x: appTitle.x(), y: appTitle.bottom(), width: appTitle.width(), height: 20))
        appSubTitle.font = UIFont.systemFont(ofSize: 12)
        appSubTitle.textColor = .lightGray
        maskView.addSubview(appSubTitle)
        
        let installBtn = InstallButton.init(type: .custom)
        installBtn.frame = CGRect.init(x: appTitle.right()+10, y: 15, width: 50, height: 20)
        installBtn.setTitle("秒装", for: .normal)
        installBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        installBtn.addTarget(self, action: #selector(installAction(sender:)), for: .touchUpInside)
        maskView.addSubview(installBtn)
    }
    
    func setBannerData(json:JSON) {
        maskImage.af_setImage(withURL: URL(string:json["img"].stringValue)!)
        appImage.af_setImage(withURL: URL(string:json["appinfo"]["icon"].stringValue)!)
        appTitle.text = json["appinfo"]["title"].stringValue
        appSubTitle.text = json["appinfo"]["desc"].stringValue
        appModel = AppModel.init(fromJson: json["appinfo"])
    }
    
    // MARK:  InstallAction
    func installAction(sender:UIButton) {
        print("install button clicked")
    }
    func tapHandler(tap:UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:APPINFONOTIFICATION), object: appModel)
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true;
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
