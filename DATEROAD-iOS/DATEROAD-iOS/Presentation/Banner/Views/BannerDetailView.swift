//
//  BannerDetailView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import UIKit

import SnapKit
import Then

final class BannerDetailView: BaseView {
    
    // MARK: - UI Properties
    
    var scrollView: UIScrollView = UIScrollView()
    
    private var contentView: UIView = UIView()
    
    lazy var bannerImageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
                
    private var indexLabel: DRTextLabel = DRTextLabel(title: "1/10", textLabelType: .background(.med13_white, .gray400_11))
        
    private var bannerTypeLabel: DRTextLabel = DRTextLabel(textLabelType: .background(.semi13_white, .mediumPurple_10), numberOfLines: 1)
    
    private var visitDateLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_gray400))
    
    private var bannerTitleLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold24_black),
        alignment: .left,
        numberOfLines: 2
    )
    
    private var bannerContentLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.systemMed13_black), alignment: .left)
    
    private let gradientView = GradientView()
    
    let stickyHeaderNavBarView = StickyHeaderNavBarView()
    
    
    // MARK: - Properties
        
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(scrollView, stickyHeaderNavBarView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            bannerImageCollectionView,
            indexLabel,
            bannerTypeLabel,
            visitDateLabel,
            bannerTitleLabel,
            bannerContentLabel
        )
        
        bannerImageCollectionView.addSubview(gradientView)
        bannerImageCollectionView.bringSubviewToFront(gradientView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stickyHeaderNavBarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        bannerImageCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.width.equalToSuperview()
            $0.height.equalTo(ScreenUtils.width)
        }
        
        gradientView.snp.makeConstraints {
            $0.top.horizontalEdges.width.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        indexLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(ScreenUtils.width - 33)
        }
        
        bannerTypeLabel.snp.makeConstraints {
            $0.top.equalTo(bannerImageCollectionView.snp.bottom).offset(23)
            $0.leading.equalToSuperview().inset(16)
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.top.equalTo(bannerTypeLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(16)
        }

        bannerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(visitDateLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        bannerContentLabel.snp.makeConstraints {
            $0.top.equalTo(bannerTitleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-50)
        }

    }
    
    override func setStyle() {
        scrollView.do {
            $0.backgroundColor = .drWhite
            $0.showsVerticalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        contentView.backgroundColor = .drWhite
        
        bannerImageCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            $0.collectionViewLayout = flowLayout
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsHorizontalScrollIndicator = false
            $0.decelerationRate = .normal
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
        }
        
        bannerTypeLabel.setPadding(top: 2, left: 10, bottom: 2, right: 10)
        
        stickyHeaderNavBarView.backgroundColor = .clear
        
        indexLabel.setPadding(top: 2.5, left: 14.5, bottom: 2.5, right: 14.5)
    }
    
}

extension BannerDetailView {
    
    func registerCell() {
        bannerImageCollectionView.register(BannerImageCollectionViewCell.self, forCellWithReuseIdentifier: BannerImageCollectionViewCell.cellIdentifier)
    }

    func updateData(_ bannerDetailData: BannerDetailModel?) {
        guard let newData = bannerDetailData else { return }

        bannerTypeLabel.do {
            $0.text = newData.headerData.tag
            $0.setPadding(top: 2, left: 10, bottom: 2, right: 10)
        }
        
        if let formattedDate = newData.headerData.createAt.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일 방문") {
            visitDateLabel.text = formattedDate
        } else {
            visitDateLabel.text = newData.headerData.createAt
            print("날짜 포맷 변환에 실패했습니다.")
        }
        bannerTitleLabel.text = newData.title
        bannerContentLabel.text = newData.mainContents.description
    }
    
    func updateIndexLabel(_ index: Int, _ totalIndex: Int) {
        indexLabel.text = "\(index + 1)/\(totalIndex)"
    }
    
}


