//
//  RecommendCell.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/5.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendCell: UITableViewCell {
    var itemView:NecessaryView = {
        //定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout.init()
        //设置cell的大小
        let width = (SCREEN_WIDTH-40)/3
        
        layout.itemSize = CGSize(width: width, height: width*1.5)
        //滑动方向 默认方向是垂直
        layout.scrollDirection = .vertical
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 0
        //每行之间最小的间距
        layout.minimumLineSpacing = 10
        let neceView = NecessaryView.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH-40+30)), collectionViewLayout: layout)
        return neceView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.contentView.addSubview(itemView)
    }
    func setRecommondJson(json:JSON) {
        print("recommend Json \(json)")
        itemView.setJsonData(json: json)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
