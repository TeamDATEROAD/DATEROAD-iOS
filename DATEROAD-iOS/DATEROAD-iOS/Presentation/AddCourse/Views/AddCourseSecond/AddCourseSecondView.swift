//
//  AddCourseSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseSecondView: BaseView {
    
    // MARK: - UI Properties
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let addSecondView = AddSecondView()
    
    let editButton: DRTextButton = DRTextButton(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.edit,
        buttonName: .med_white_0,
        isEnabled: false
    )
    
    private let guideLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.guideLabel,
        textLabelType: .clear(.med13_gray400),
        alignment: .left
    )
    
    var addPlaceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
            
    private let warningType: DRErrorType = Warning()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews (collectionView, addSecondView)
        
        addSecondView.addSubviews(editButton,
                                  guideLabel,
                                  addPlaceCollectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(146)
        }
        
        addSecondView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(7)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(addSecondView.separatorLine.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(59)
            $0.height.equalTo(30)
        }
        
        guideLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(editButton)
        }
        
        addPlaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(addSecondView.nextBtn.snp.top).offset(-12)
        }
    }
    
    override func setStyle() {
        collectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 12.0
            layout.itemSize = CGSize(width: 130, height: 130)
            $0.collectionViewLayout =  layout
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
            $0.clipsToBounds = true
        }
        
        addPlaceCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 14.0
            layout.itemSize = CGSize(width: ScreenUtils.width * 343/375, height: 76)
            $0.collectionViewLayout =  layout
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.dragInteractionEnabled = true
        }
    }
    
}


// MARK: - Extension Methods

extension AddCourseSecondView {
    
    /// editMode 활성화라면
    func updateEditBtnText(flag: Bool) {
        let text = flag ? StringLiterals.AddCourseOrSchedule.AddSecondView.done : StringLiterals.AddCourseOrSchedule.AddSecondView.edit
        editButton.setTitle(text, for: .normal)
    }
    
    func editBtnState(isAble: Bool) {
        let state: TextButtonType = isAble ? .med_white_0_purple : .med_white_0
        editButton.setButtonStyle(state, isEnabled: isAble)
    }
    
}
