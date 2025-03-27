//
//  AddCourseFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseFirstView: BaseView {
    
    // MARK: - UI Properties
    
    let scrollView: UIScrollView = UIScrollView()
    
    private let scrollContentView: UIView = UIView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let addFirstView = AddFirstView()
    
    private let imageAccessoryView = UIView()
    
    let cameraBtn: DRImageButton = DRImageButton(image: UIImage(resource: .camera), buttonName: .clear_clear_16)
    
    private let imageCountLabelContainer = UIView()
    
    let imageCountLabel: DRTextLabel = DRTextLabel(title: "1/10", textLabelType: .clear(.med10_white))
    
    let dateNameErrorLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNameErrorLabel,
        textLabelType: .clear(.reg11_alertRed),
        hidden: true
    )
    
    let visitDateErrorLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateErrorLabel,
        textLabelType: .clear(.reg11_alertRed),
        hidden: true
    )
        
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(scrollView)
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubviews(
            collectionView,
            imageAccessoryView,
            addFirstView,
            dateNameErrorLabel,
            visitDateErrorLabel)
        
        imageAccessoryView.addSubviews(cameraBtn, imageCountLabelContainer)
        
        imageCountLabelContainer.addSubview(imageCountLabel)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(146)
        }
        
        imageAccessoryView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(collectionView)
            $0.height.equalTo(32)
        }
        
        cameraBtn.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        imageCountLabelContainer.snp.makeConstraints {
            $0.centerY.equalTo(cameraBtn)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        
        imageCountLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addFirstView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        dateNameErrorLabel.snp.makeConstraints {
            $0.top.equalTo(addFirstView.dateNameTextField.snp.bottom).offset(2)
            $0.leading.equalTo(addFirstView.dateNameTextField).offset(9)
        }
        
        visitDateErrorLabel.snp.makeConstraints {
            $0.top.equalTo(addFirstView.visitDateTextField.snp.bottom).offset(2)
            $0.leading.equalTo(addFirstView.visitDateTextField.snp.leading).offset(9)
        }
    }
    
    override func setStyle() {
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .always
        }
        
        collectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 12.0
            $0.collectionViewLayout =  layout
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
        }
        
        imageCountLabelContainer.do {
            $0.backgroundColor = .gray400
            $0.layer.cornerRadius = 10
        }
    }
    
}


// MARK: - Extension Methods

extension AddCourseFirstView {
    
    func updateDateNameTextField(isPassValid: Bool) {
        dateNameErrorLabel.updateLabelHidden(isPassValid)
        addFirstView.dateNameTextField.layer.borderWidth = isPassValid ? 0 : 1
    }
    
    func updateVisitDateTextField(isPassValid: Bool) {
        visitDateErrorLabel.updateLabelHidden(isPassValid)
        addFirstView.visitDateTextField.layer.borderWidth = isPassValid ? 0 : 1
    }
    
    func updateImageCellUI(isEmpty: Bool, ImageDataCount: Int) {
        cameraBtn.setButtonHidden(isEmpty)
        imageCountLabel.text = "\(ImageDataCount)/10"
    }
    
}
