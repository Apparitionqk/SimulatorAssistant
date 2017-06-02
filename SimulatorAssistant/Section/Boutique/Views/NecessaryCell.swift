//
//  NecessaryCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/27.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit

class NecessaryCell: UICollectionViewCell {
    var imgView : UIImageView = {//cell上的图片
        let view = UIImageView(frame: CGRect.init(x: 10, y: 10, width: (SCREEN_WIDTH-40)/3-20, height: (CONTENT_HEIGHT-44)/3*0.6))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    var titleLabel:UILabel = UILabel()//cell上title
    var installBtn:UIButton = UIButton.init(type: UIButtonType.roundedRect)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //初始化各种控件
        self .addSubview(imgView)
        titleLabel.frame = CGRect.init(x: 10, y: imgView.bottom()+5, width: frame.width-20, height: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor.lightGray
        self .addSubview(titleLabel)
        
        installBtn.frame = CGRect(x: 10, y: titleLabel.bottom(), width: frame.width-20, height: 20)
        installBtn.setTitle("⚡️秒装", for: .normal)
        installBtn.backgroundColor = .blue
        installBtn.setTitleColor(.white, for: .normal)
        self.addSubview(installBtn)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
