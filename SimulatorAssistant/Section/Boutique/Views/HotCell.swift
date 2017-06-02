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
    @IBOutlet weak var appImage: UIImageView!
//    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downCountLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var installBtn: UIButton!
    var iconMark: UILabel? = {
        let view = UILabel.init(frame: CGRect.init(x: 10, y: 20, width: 20, height: 20))
        view.textColor = .white
        return view
    }()
    
    
    var appModel:AppModel = AppModel(fromJson: JSON.init(parseJSON: "")){
        didSet{
            let urlStr = appModel.icon
            appImage.af_setImage(withURL: URL.init(string: urlStr!)!)
            nameLabel.text = appModel.title
            downCountLabel.text = appModel.downloadnum! + "次下载/" + appModel.size!
            descripLabel.text = appModel.cusDesc
            if let markType = IconMarkType(rawValue: Int(appModel.iconMark!)!) {

                self.setUpLable(markType: markType)
            }
            
            self.setUpLayOut()
        }
    }
    func setUpLable(markType: IconMarkType) {
        iconMark?.frame = CGRect.init(x: appImage.right()-15, y: appImage.y()-8, width: 25, height: 25)
        iconMark?.layer.cornerRadius = 12.5
        iconMark!.layer.masksToBounds = true
        iconMark!.textAlignment = .center
        iconMark?.font = UIFont.boldSystemFont(ofSize: 10)
        self.addSubview(iconMark!)
        switch markType {
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
                appImage.backgroundColor = .gray
    }
    func setUpLayOut()  {

        appImage.layer.masksToBounds = true
        appImage.layer.cornerRadius = 10
    }
    override func layoutSubviews() {
        
//        setUpLayOut()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
