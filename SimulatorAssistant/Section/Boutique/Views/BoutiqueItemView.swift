//
//  BoutiqueItemView.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
protocol BoutiqueItemProtocal: class {
    func selectedButtonAtIndex(index: Int)
}
class BoutiqueItemView: UIView {
    var items: [String]
    var slideView:UIView
    var borderSpace:CGFloat = 50.0 //button 边距
    var intervalSpace:CGFloat = 20.0  //button 间距
    var btnWidth:CGFloat = 0.0
    var delegate: BoutiqueItemProtocal?
    override init(frame: CGRect) {
        self.slideView = UIView()
        items = NSArray() as! [String]
        super.init(frame: frame)
    }

    convenience init(items:NSArray, frame:CGRect) {
        self.init(frame: frame)
        self.items = items as! [String]
        setUpSubViews()
    }
    func  setUpSubViews() {
        btnWidth = (SCREEN_WIDTH - borderSpace*2.0 - intervalSpace*CGFloat((items.count - 1)))/CGFloat(items.count)
        self.slideView.frame = CGRect.init(x: borderSpace, y: 5, width: btnWidth, height: self.height()-10.0)
        self.slideView.layer.cornerRadius = 5
        self.slideView.backgroundColor = UIColor.karBule()
        self.addSubview(slideView)
        for index in 1...items.count  {
            let button = UIButton.init(type: .roundedRect)
            button.frame = CGRect.init(x: borderSpace + (btnWidth + intervalSpace)*CGFloat(index-1), y: 5, width: btnWidth, height: self.height()-10.0)
            button.setTitle(items[index-1], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .clear
            button.tag = index-1
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    func buttonAction(button: UIButton) {
        print("\(button.tag)")
        UIView.animate(withDuration: 0.3) {
            self.slideView.frame = button.frame
        }
        delegate?.selectedButtonAtIndex(index: button.tag)
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
