//
//  UIView+Convenience.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
extension UIView {
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    func width() -> CGFloat {
        return self.frame.size.width
    }
    func height() -> CGFloat {
        return self.frame.size.height
    }
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
}
