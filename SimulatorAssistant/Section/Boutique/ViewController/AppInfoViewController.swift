//
//  AppInfoViewController.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/6/6.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit

class AppInfoViewController: BaseViewController {
    open var appModel:AppModel = AppModel.init(fromJson: ""){
        didSet {
            iconView.af_setImage(withURL: URL(string: appModel.icon!)!)
            titleLabel.text = appModel.title
            downLoadLabel.text = appModel.size! + "    " + appModel.downloadnum! + "次下载"
            subTitleLabel.text = appModel.cusDesc
        }
    }
    let scrollImageView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64))
        scrollView.backgroundColor = .lightGray
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let pageControl:UIPageControl = {
        let pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-64, width: SCREEN_WIDTH, height: 40))
        pageControl.tintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    let maskView:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    let whiteBack:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-200, width: SCREEN_WIDTH, height: 200))
        view.backgroundColor = .white
        return view
    }()
    private let iconView:UIImageView = UIImageView()
    private let titleLabel:UILabel = UILabel()
    private let downLoadLabel:UILabel = UILabel()
    private let subTitleLabel:UILabel = UILabel()
    private let downLoadBtn:UIButton = UIButton.init(type: .custom)
    
    var showDownLoadView = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(scrollImageView)
        scrollImageView.addSubview(pageControl)
        view.addSubview(maskView)
        detailSubViews()
    }
    
    func detailSubViews() {
        
        
        maskView.addSubview(whiteBack)
        
        iconView.frame = CGRect.init(x: (SCREEN_WIDTH-100)/2, y: -50, width: 100, height: 100)
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 5
        whiteBack.addSubview(iconView)
        
        titleLabel.frame = CGRect.init(x: 0, y: iconView.bottom()+10, width: SCREEN_WIDTH, height: 20)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        whiteBack.addSubview(titleLabel)
        
        downLoadLabel.frame = CGRect.init(x: 0, y: titleLabel.bottom()+10, width: SCREEN_WIDTH, height: 20)
        downLoadLabel.textAlignment = .center
        downLoadLabel.font = UIFont.systemFont(ofSize: 12)
        downLoadLabel.textColor = .lightGray
        whiteBack.addSubview(downLoadLabel)
        
        subTitleLabel.frame = CGRect.init(x: 0, y: downLoadLabel.bottom()+10, width: SCREEN_WIDTH, height: 20)
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel.textColor = .lightGray
        whiteBack.addSubview(subTitleLabel)
        
        downLoadBtn.frame = CGRect.init(x: 0, y: whiteBack.height() - 49, width: SCREEN_WIDTH, height: 49)
        downLoadBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0.3, alpha: 0.3)
        downLoadBtn.setTitle("秒装", for: .normal)
        downLoadBtn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        whiteBack.addSubview(downLoadBtn)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        maskView.addGestureRecognizer(tapGesture)
        
        let scrollTap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        scrollImageView.addGestureRecognizer(scrollTap)
    }
    
    func buttonAction(button:UIButton) {
        
    }
    func tapAction(tap:UITapGestureRecognizer) {
//        showDownLoadView = !showDownLoadView
        tap.view == maskView ? dismissAnimation():showanimation()
    }
    
    // MARK: Animations
    func showanimation() {
        view.addSubview(maskView)
        UIView.animate(withDuration: 0.2) { 
            self.whiteBack.frame.origin.y = SCREEN_HEIGHT - 200
        }
    }
    func dismissAnimation() {
        UIView.animate(withDuration: 0.2, animations: { 
            self.whiteBack.frame.origin.y = SCREEN_HEIGHT
        }) { (_) in
            self.maskView.removeFromSuperview()
        }
    }
    // MARK : Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
