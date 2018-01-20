//
//  RecommendViewController.swift
//  DBSwift
//
//  Created by Young on 2018/1/18.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemHeaderH: CGFloat = 50
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellId = "kNormalCellId"
private let kPrettyCellId = "kPrettyCellId"
private let kHeaderId = "kHeaderId"

class RecommendViewController: UIViewController {
    private lazy var recommedVM: RecommendViewModel = {
        let recommedVM = RecommendViewModel()
        return recommedVM
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:kItemW, height:kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width:kScreenW, height:kItemHeaderH)
        layout.sectionInset = UIEdgeInsets(top:0, left:kItemMargin, bottom:0,right:kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
        
        
        let cellNormal = UINib(nibName:"CollectionNormalCell", bundle:nil)
        collectionView.register(cellNormal, forCellWithReuseIdentifier: kNormalCellId)
        
        let cell = UINib(nibName:"CollectionPrettyCell", bundle:nil)
        collectionView.register(cell, forCellWithReuseIdentifier: kPrettyCellId)
        
        let headerView = UINib(nibName:"CollectionHeaderView", bundle:nil)
        collectionView.register(headerView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderId)
        return collectionView
    }()
    
    private lazy var recommendCycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }
}

extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(recommendCycleView)
        collectionView.addSubview(gameView)
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController {
    private func loadData() {

        recommedVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.recommedVM.anchorGroups
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            var baseGameModelGroup:Array<BaseGameModel> = []
            for anchorGroup in groups {
                let model = BaseGameModel()
                model.tag_name = anchorGroup.tag_name
                model.icon_url = anchorGroup.icon_url
                baseGameModelGroup.append(model)
            }
            self.gameView.groups = baseGameModelGroup
        }
        
        recommedVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommedVM.cycleModels
        }
    
    }
}

extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width:kItemW, height:kPrettyItemH)
        }else {
            return CGSize(width:kItemW, height:kNormalItemH)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommedVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommedVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommedVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        if indexPath.section == 1 {
            let cell : CollectionPrettyCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId,
                                                                                  for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell
        } else {
            let cell : CollectionNormalCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId,
                                                       for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderId, for: indexPath) as! CollectionHeaderView
        let group = recommedVM.anchorGroups[indexPath.section]
        headerView.group = group
        return headerView
    }
}
