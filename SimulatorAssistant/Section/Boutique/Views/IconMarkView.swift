
//
//  IconMarkView.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/31.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
enum IconMarkType:Int {
    
    case None = 0
    case OnlyOne = 1
    case First = 2
    case Hot = 3
    case Recommond = 4
    case Promotion = 5
   
    
}
class IconMarkView: UIView {
    var markType: IconMarkType = .None{
        didSet{
            switch markType {
            case .OnlyOne:
                self.titleLabel.text = "独家"
                self.backgroundColor = .purple
            case .First:
                self.titleLabel.text = "首发"
                self.backgroundColor = .blue
            case .Hot:
                self.titleLabel.text = "热门"
                self.backgroundColor = UIColor.karPink()
            case .Promotion:
                self.titleLabel.text = "活动"
                self.backgroundColor = .yellow
            case .Recommond:
                self.titleLabel.text = "推荐"
                self.backgroundColor = .green
            default:
                self.titleLabel.text = ""
                self.backgroundColor = .clear
                break
            }
        }
    }
    private var titleLabel: UILabel = {
        let label = UILabel.init()
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = self.frame
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = .white
        titleLabel.text = "fdsafsad"
        titleLabel.backgroundColor = .red
        self.addSubview(titleLabel)
        self.layer.cornerRadius = 10
    }
    convenience init(markType: IconMarkType, frame: CGRect) {
        self.init(frame: frame)
        titleLabel.frame = CGRect.init(x: 0, y: 5, width: self.width(), height: self.height()-10)
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.text = "fdsafsad"
        self.addSubview(titleLabel)
        self.layer.cornerRadius = self.width()/2
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
