//
//  ViewController.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit

class BoutiqueRootViewController: BaseViewController, UIScrollViewDelegate, BoutiqueItemProtocal {
    let itemView: BoutiqueItemView = {
        let view = BoutiqueItemView.init(items: ["热门","必备","新游","活动",], frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 44))
        return view
    }()
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize.init(width: SCREEN_WIDTH*4, height: SCREEN_HEIGHT-44-64-49)
        view.backgroundColor = .gray
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    let hotList:HotListView = {
         let view = HotListView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-44), style: .plain)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(itemView)
        itemView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        addSubViews()
        self.view.setNeedsUpdateConstraints()
        
        networkOperation()
    }

    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(64+44)
            make.size.equalTo(CGSize.init(width: SCREEN_WIDTH, height: CONTENT_HEIGHT-44))
        }
        super.updateViewConstraints()
    }
    // MARK: 添加子视图
    func addSubViews()  {
       
        scrollView.addSubview(hotList)
        
        //定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout()
        //设置cell的大小
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-40)/3, height: (CONTENT_HEIGHT-44)/3)
        //滑动方向 默认方向是垂直
        layout.scrollDirection = .vertical
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 0
        //每行之间最小的间距
        layout.minimumLineSpacing = 10
        let necessaryView = NecessaryView.init(frame: CGRect.init(origin: CGPoint.init(x: SCREEN_WIDTH, y: 0), size: CGSize.init(width: SCREEN_WIDTH, height: CONTENT_HEIGHT-44)), collectionViewLayout: layout)
        scrollView.addSubview(necessaryView)
        
        let newGameView = NewGameView.init(frame: CGRect.init(x: SCREEN_WIDTH*2, y: 0, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-44), style: .plain)
        scrollView.addSubview(newGameView)
        
        let promotionView = PromotionView.init(frame: CGRect.init(x: SCREEN_WIDTH*3, y: 0, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-44), style: .plain)
        scrollView.addSubview(promotionView)
    }

    func networkOperation()  {
        HotListViewModel.getAppData(urlString: "http://interface.xyzs.com/v2/ios/c04/homepage/index?clientversion=6.1.5&lang=zh-Hans-CN&clienttype=1&device_uuid=Unknow&flagdata1=0&sn=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&devicetype=1&systemversion=10.3.1&deviceimei=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&channel=500077&appleid=&uuid=2017B1AB-FC87-431F-8FFD-7AF43EA814D8&nettype=WiFi&isidfatracking=1&resolveip=17.253.75.205&clientip=119.253.46.106&platform=iPhone8,2&uid=-1&simulateidfa=6FF0C3DB-7D1E-5E7C-DE7B-4FE55947E8A2&idfv=67D83F28-EED4-42F0-A480-6FF9C6C4747A&jailbreak=1&identity=760&openidfa=20C530C2-5544-5D10-0484-60F76727E7F7&showModel=iphone_6plus&certId=760&isauthor=2&flagdata=0&spflag=0&ipatype=1&screensize=1242-2208&idfa=BC7BCEAE-E6EF-4A86-9A27-4D68D9E176AC&timestamp=1495881257&sign=86eb76b41a2abd3dc695937e0dd18986&size=20&p=1&type=2&page=1", tableView: hotList)
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset:CGPoint = scrollView.contentOffset
        let itemWidth = itemView.width()-itemView.borderSpace*2+itemView.intervalSpace
        itemView.slideView.frame.origin.x = itemView.borderSpace+(itemWidth*offset.x)/scrollView.contentSize.width

    }
    
    
    // MARK: BoutiqueItemProtocal
    func selectedButtonAtIndex(index: Int) {
        self.scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*SCREEN_WIDTH, y: 0), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

