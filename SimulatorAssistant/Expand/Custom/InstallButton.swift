//
//  InstallButton.swift
//  iOS Example
//
//  Created by 齐科 on 2017/6/6.
//  Copyright © 2017年 PGS Software. All rights reserved.
//

import UIKit

class InstallButton: UIButton {
    internal var isLoading: Bool = false
    var appModel:AppModel?
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    override var frame: CGRect {
        didSet {
            super.frame = frame
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 1.0, alpha: 0.5)
            self.layer.masksToBounds = true
            self.layer.cornerRadius = frame.height/2
            self.setTitle("⚡️安装", for: .normal)
            self.setTitleColor(.white, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            
            self.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func buttonAction(button:InstallButton)  {
        button.isSelected = !button.isSelected
        button.isSelected ? button.startAnimation() : button.stopAnimation()
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

extension InstallButton {
    
    func addSubLayers() {
        
        let path = UIBezierPath(roundedRect: CGRect.init(x: 2, y: 2, width: self.frame.width-4, height: frame.height-4), cornerRadius: frame.height/2)
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.3
        self.layer.addSublayer(shapeLayer)
    }

    func startAnimation() {
        addSubLayers()

        let strokeEndAnimation = CAKeyframeAnimation.init(keyPath: "strokeEnd")
        strokeEndAnimation.values = [NSNumber.init(value: 0.5),
                                     NSNumber.init(value: 0.8),
                                     NSNumber.init(value: 0.9),
                                     NSNumber.init(value: 1.0)]
        strokeEndAnimation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
                                              CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear),
                                              CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear),
                                              CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)]
        strokeEndAnimation.repeatCount = Float.infinity;
        strokeEndAnimation.autoreverses = false
        strokeEndAnimation.calculationMode = kCAAnimationLinear;
        strokeEndAnimation.rotationMode = kCAAnimationRotateAuto
        strokeEndAnimation.duration = 2;
        shapeLayer.add(strokeEndAnimation, forKey: "endAnimation")
        
        let strokeStartAnimation = CAKeyframeAnimation.init(keyPath: "strokeStart")
        strokeStartAnimation.values = [NSNumber.init(value: 0.2),
                                       NSNumber.init(value: 0.5),
                                       NSNumber.init(value: 0.6),
                                       NSNumber.init(value: 0.7)]
        strokeStartAnimation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
                                                CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear),
                                                CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear),
                                                CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)]
        strokeStartAnimation.repeatCount = Float.infinity;
        strokeStartAnimation.autoreverses = false
        strokeStartAnimation.calculationMode = kCAAnimationLinear;
        strokeEndAnimation.rotationMode = kCAAnimationRotateAuto
        strokeStartAnimation.duration = 2;
        shapeLayer.add(strokeStartAnimation, forKey: "startAnimation")
    }
    func stopAnimation() {
        //        shapeLayer.removeAllAnimations()
        
        guard isLoading else {
            return
        }
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.fillMode = kCAFillModeForwards
        strokeEndAnimation.isRemovedOnCompletion = false
        strokeEndAnimation.duration = 1 * 3.0 / 4.0
        shapeLayer.add(strokeEndAnimation, forKey: "catchStrokeEndAnimation")
        
        UIView.animate(withDuration: 0.3, delay: strokeEndAnimation.duration, options: UIViewAnimationOptions(), animations: {
        }) { (_) in
            self.shapeLayer.removeAllAnimations()
            self.isLoading = false
            //            finish?()
        }
    }
}
