//
//  SearchPlaceTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

final class SearchPlaceTableViewCell: BaseTableViewCell {
    
    // MARK: - UI Properties
    
    private let placeNameLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_black), alignment: .left)

    private let placeAddressLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_gray300), alignment: .left)

    private let divider: UIView = UIView()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(placeNameLabel, placeAddressLabel, divider)
    }
    
    override func setLayout() {
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(27)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(27)
        }
        
//        divider.snp.makeConstraints {
//            $0.horizontalEdges.bottom.equalToSuperview()
//            $0.height.equalTo(1)
//        }
        
    }
    
    override func setStyle() {
        divider.backgroundColor = UIColor.gray100
    }
    
}

extension SearchPlaceTableViewCell {
    
    func bindData(_ data: SearchPlaceData?) {
        guard let searchPlaceData = data else { return }
        placeNameLabel.text = searchPlaceData.name
        placeAddressLabel.text = searchPlaceData.address
    }

}
