//
//  HomeViewController.swift
//  DBSwift
//
//  Created by Young on 2018/1/16.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    private lazy var pageTitleView: PageTitleView = {[weak self] in
        let frame = CGRect(x:0, y:kStatusBarH + kNavigationBarH,
            width:kScreenW,height:kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame:frame, titles:titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)), g:CGFloat(arc4random_uniform(255)),
                                              b:CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
//        childVcs.append(GameViewController())
//        childVcs.append(AmuseViewController())
//        childVcs.append(FunnyViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parenViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

}
// 设置UI界面
extension HomeViewController {
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.createItem(imageName: "logo", highImageName: nil)
        
        let size = CGSize(width:40, height:40)
        
        
        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history",
                                                     highImageName: "Image_my_history_click",
                                                     size: size)
        
        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search",
                                                    highImageName: "btn_search_clicked",
                                                    size: size)
//      该item调用的是便利构造函数
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan",
                                         highImageName: "Image_scan_click",
                                         size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
// 遵守titleView的协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int) {
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
