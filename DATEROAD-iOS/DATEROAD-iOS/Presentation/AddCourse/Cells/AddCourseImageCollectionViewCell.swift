//
//  AddCourseImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let imageView: UIImageView = UIImageView()
    private let thumbnailTagView: UIView = UIView()
    private let thumbnailTagLabel: DRTextLabel = DRTextLabel(
        title: "대표",
        textLabelType: .clear(.semi13_white),
        alignment: .center
    )
    
    let deleteImageBtn: DRImageButton = DRImageButton(
        image: UIImage(resource: .icDeletepic),
        buttonName: .clear_clear_8,
        isHidden: true
    )
    
    private let emptyView: UIView = UIView()
    
    private let emptyCameraImage: UIImageView = UIImageView()
    
    private let emptyLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.emptyImage,
        textLabelType: .clear(.bold11_gray300),
        numberOfLines: 2
    )
    
    
    // MARK: - Prepare Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(image: nil)
    }
    
    func prepare(image: UIImage?) {
        self.imageView.image = image
    }
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        contentView.addSubviews(
            imageView,
            emptyView,
            deleteImageBtn
        )
        imageView.addSubview(thumbnailTagView)
        thumbnailTagView.addSubview(thumbnailTagLabel)
        emptyView.addSubviews(emptyCameraImage, emptyLabel)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumbnailTagView.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.44)
            $0.height.equalTo(thumbnailTagView.snp.width).multipliedBy(0.5)
        }
        
        thumbnailTagLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteImageBtn.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.trailing.equalToSuperview().inset(6)
        }
        
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyCameraImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyCameraImage.snp.bottom).offset(13)
            $0.centerX.equalTo(emptyCameraImage)
        }
    }
    
    override func setStyle() {
        imageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
            $0.isHidden = true
            $0.layer.borderWidth = 2
        }
        
        thumbnailTagView.do {
            $0.backgroundColor = UIColor(resource: .purple600)
            $0.layer.cornerRadius = 4
        }
        
        emptyView.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 14
            $0.isHidden = false
        }
        
        emptyCameraImage.do {
            $0.image = UIImage(resource: .cameraWithBg)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .gray200
            $0.layer.cornerRadius = 32 / 2
        }
    }
    
}


// MARK: - Extension Methods

extension AddCourseImageCollectionViewCell {
    
    func configurePickedImage(pickedImage: UIImage, isThumbnail: Bool) {
        imageView.do {
            $0.image = pickedImage
            $0.layer.borderColor = isThumbnail
            ? UIColor.purple600.cgColor : UIColor.clear.cgColor
        }
        thumbnailTagView.isHidden = !isThumbnail
    }
    
    func updateImageCellUI(isImageEmpty: Bool, vcCnt: Int) {
        emptyView.isHidden = !isImageEmpty
        imageView.isHidden = isImageEmpty
        if vcCnt > 1 {
            deleteImageBtn.setButtonHidden(true)
        } else {
            deleteImageBtn.setButtonHidden(isImageEmpty)
        }
    }
    
}
