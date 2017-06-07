//
//  NecessaryView.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class NecessaryView: UICollectionView, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var jsonData:JSON?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        //注册一个cell
        self.register(NecessaryCell.self, forCellWithReuseIdentifier:"cell")
        //注册一个headView
        self.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (jsonData != nil) ? jsonData!.count : 10
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:NecessaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! NecessaryCell


        if (jsonData != nil) {
            let json = jsonData![indexPath.row]
            cell.imgView.af_setImage(withURL: URL(string:json["icon"].stringValue)!)
            cell.titleLabel.text = json["title"].stringValue
        }
       
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    //返回HeadView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 10)
    }
    
 
    //返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var v = UIView()
        v.backgroundColor = .blue
        if kind == UICollectionElementKindSectionHeader{
            v = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath as IndexPath)

        }
        return v as! UICollectionReusableView
    }
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    // MARK:  获取数据，刷新视图
    func setJsonData(json:JSON) {
        jsonData = json
        self.reloadData()
    }
    // MARK: UICollectionViewDataDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let json = jsonData![indexPath.row]
        let appModel = AppModel.init(fromJson: json)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:APPINFONOTIFICATION), object: appModel)

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
