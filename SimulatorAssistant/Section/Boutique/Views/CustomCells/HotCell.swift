 //
//  HotCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/27.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage
import SwiftyJSON

class HotCell: UITableViewCell {
    var appImage: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var downCountLabel: UILabel = UILabel()
    var descripLabel: UILabel = UILabel()
    var installBtn: InstallButton = InstallButton()
    var iconMark: UILabel? = {
        let view = UILabel.init(frame: CGRect.init(x: 10, y: 20, width: 20, height: 20))
        view.textColor = .white
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpLable(markType: IconMarkType) {
        iconMark?.frame = CGRect.init(x: appImage.right()-15, y: appImage.y()-8, width: 25, height: 25)
        iconMark?.layer.cornerRadius = 12.5
        iconMark!.layer.masksToBounds = true
        iconMark!.textAlignment = .center
        iconMark?.font = UIFont.boldSystemFont(ofSize: 10)
        self.addSubview(iconMark!)
        switch markType {
        case .OnlyOne:
             iconMark?.text = "独家"
             iconMark?.backgroundColor = .purple
        case .First:
            iconMark?.text = "首发"
            iconMark?.backgroundColor = .blue
        case .Hot:
            iconMark?.text = "热门"
            iconMark?.backgroundColor = UIColor.karPink()
        case .Promotion:
            iconMark?.text = "活动"
            iconMark?.backgroundColor = .yellow
        case .Recommond:
            iconMark?.text = "推荐"
            iconMark?.backgroundColor = .green
        default:
            iconMark?.text = ""
            iconMark?.backgroundColor = .clear
            break
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpLayOut()  {
        appImage.frame = CGRect.init(x: 5, y: 10, width: 60, height: 60)
        appImage.layer.masksToBounds = true
        appImage.layer.cornerRadius = 10
        appImage.backgroundColor = .gray
        contentView.addSubview(appImage)
        
        nameLabel.frame = CGRect.init(x: appImage.right()+10, y: 10, width: 100, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        downCountLabel.frame = CGRect.init(x: nameLabel.x(), y: nameLabel.bottom(), width: nameLabel.width(), height: 20)
        downCountLabel.font = UIFont.systemFont(ofSize: 12)
        downCountLabel.textColor = .lightGray
        contentView.addSubview(downCountLabel)
        
        descripLabel.frame = CGRect.init(x: nameLabel.x(), y: downCountLabel.bottom(), width: nameLabel.width(), height: 20)
        descripLabel.font = UIFont.systemFont(ofSize: 12)
        descripLabel.textColor = .lightGray
        contentView.addSubview(descripLabel)
        
        installBtn.frame = CGRect.init(x: SCREEN_WIDTH-80, y: 25, width: 60, height: 30)
        contentView.addSubview(installBtn)
    }
    func setJsonData(json:JSON) {
        print("applist json :\(json)")
        if json == JSON.null {
            return
        }
        let appModel:AppModel = AppModel.init(fromJson: json)
        let urlStr = appModel.icon
        if let url = URL(string:urlStr!) {
            appImage.af_setImage(withURL: url)
        }
        nameLabel.text = appModel.title
        downCountLabel.text = appModel.downloadnum! + "次下载/" + appModel.size!
        descripLabel.text = appModel.cusDesc
        if let markType = IconMarkType(rawValue: Int(appModel.iconMark!)!) {
            
            self.setUpLable(markType: markType)
        }
        
        self.setUpLayOut()
    }
    override func layoutSubviews() {
        
//        setUpLayOut()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
