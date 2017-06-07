//
//  NecessaryCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/27.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class NecessaryCell: UICollectionViewCell {
    var imgView : UIImageView = UIImageView()
    var titleLabel:UILabel = UILabel()
    var installBtn:InstallButton = InstallButton.init(type: UIButtonType.roundedRect)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //初始化各种控件
        imgView = UIImageView(frame: CGRect.init(x: 10, y: 10, width: frame.width-20, height: frame.width-20))
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 8
        self .addSubview(imgView)
        
        titleLabel.frame = CGRect.init(x: 10, y: imgView.bottom()+5, width: frame.width-20, height: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor.lightGray
        self .addSubview(titleLabel)
        
        installBtn.frame = CGRect(x: 10, y: titleLabel.bottom()+5, width: frame.width-20, height: 30)

//        installBtn.addTarget(self, action: #selector(installButtonAction(button:)), for: .touchUpInside)
        self.addSubview(installBtn)
    }

    func installButtonAction(button:UIButton) {
        print("install button clicked")
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
