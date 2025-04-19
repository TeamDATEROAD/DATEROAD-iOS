//
//  PointShortageViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/2/25.
//

import UIKit

final class PointShortageViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    private let bottomSheetView: UIView = UIView()
    
    private let noPointLabel: DRTextLabel = DRTextLabel(title: StringLiterals.PointDetail.collectPoint, textLabelType: .clear(.bold17_black))
    
    private let xButton: DRImageButton = DRImageButton(image: UIImage(resource: .btnClose), buttonName: .clear_clear_0)
    
    private let advertisePointShortageView: PointShortageView = PointShortageView(pointImage: UIImage(resource: .imgAdvertise),
                                                                                  titleText: StringLiterals.PointDetail.advertiseTitle,
                                                                                  descriptionText: StringLiterals.PointDetail.advertiseDescription)
    
    private let addCoursePointShortageView: PointShortageView = PointShortageView(pointImage: UIImage(resource: .imgCourse),
                                                                                  titleText: StringLiterals.PointDetail.addCourseTitle,
                                                                                  descriptionText: StringLiterals.PointDetail.addCourseDescription)
    
    // MARK: - Properties
    
    var onAdvertisementDismiss: (() -> Void)?
    
    var onAddCourseDismiss: (() -> Void)?
    
    
    // MARK: - Methods
    override func setHierarchy() {
        self.view.addSubviews(backgroundView, bottomSheetView)
        
        bottomSheetView.addSubviews(noPointLabel,
                                    xButton,
                                    advertisePointShortageView,
                                    addCoursePointShortageView)
    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(270)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        noPointLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.leading.equalToSuperview().inset(25)
        }
        
        xButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.top.equalToSuperview().inset(23)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        advertisePointShortageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }
        
        addCoursePointShortageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(158)
        }
    }
    
    override func setStyle() {
        backgroundView.do {
            $0.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.4)
        }
        
        bottomSheetView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        
        advertisePointShortageView.do {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(advertisePointShortageViewTapped)))
        }
        
        addCoursePointShortageView.do {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addCoursePointShortageViewTapped)))
        }
    }
}


extension PointShortageViewController {
    
    @objc
    func advertisePointShortageViewTapped() {
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickAd)
        self.dismiss(animated: false, completion: self.onAdvertisementDismiss)
    }
    
    @objc
    func addCoursePointShortageViewTapped() {
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickAddSchedule)
        self.dismiss(animated: false, completion: self.onAddCourseDismiss)
    }
    
    @objc
    func xButtonTapped() {
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickCollectPointClose)
        self.dismiss(animated: false)
    }
    
}
