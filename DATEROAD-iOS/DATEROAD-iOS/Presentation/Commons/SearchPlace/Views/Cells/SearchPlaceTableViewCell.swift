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
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(placeNameLabel, placeAddressLabel)
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
    }
    
}

extension SearchPlaceTableViewCell {
    
    func bindData(_ inputText: String, _ data: SearchPlaceModel?) {
        guard let searchPlaceData = data else { return }
        placeNameLabel.updateTextColor(searchPlaceData.name, .drBlack)
        let attributedString = NSMutableAttributedString(string: searchPlaceData.name)
        let range = (searchPlaceData.name as NSString).range(of: inputText, options: .caseInsensitive)
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: UIColor(resource: .purple600), range: range)
        }
        placeNameLabel.attributedText = attributedString
        placeAddressLabel.text = searchPlaceData.address
    }

}
