//
//  PromotionView.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit
import SwiftyJSON

class PromotionView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var jsonData:JSON?
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registNib()
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        self.separatorStyle = .singleLine
    }
    func registNib()  {
        self.register(HotCell.classForCoder(), forCellReuseIdentifier: "HotCell")
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData != nil ? (jsonData?.count)! : 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellIdenfier = "HotCell"
        let cell: HotCell = self.dequeueReusableCell(withIdentifier: cellIdenfier) as! HotCell
        cell.setJsonData(json: (jsonData?[indexPath.row])!)
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func reloadWithData(dic:JSON) {
        jsonData = dic
        self.reloadData()
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
