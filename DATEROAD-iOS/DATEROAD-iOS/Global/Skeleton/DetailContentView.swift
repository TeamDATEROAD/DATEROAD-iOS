//
//  DetailContentView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/2/24.
//

import UIKit

final class DetailContentView: BaseView {
    
    // MARK: - UI Properties
    
    private let lineOne: UILabel = UILabel()
    
    private let lineTwo: UILabel = UILabel()
    
    private let lineThree: UILabel = UILabel()
    
    private let lineFour: UILabel = UILabel()
    
    private let lineFive: UILabel = UILabel()
    
    private let lineSix: UILabel = UILabel()
    
    private let lineSeven: UILabel = UILabel()
    
    private let lineEight: UILabel = UILabel()
    
    private let lineNine: UILabel = UILabel()
    
    private let lineTen: UILabel = UILabel()
    
    
    override func setHierarchy() {
        self.addSubviews(lineOne,
                         lineTwo,
                         lineThree,
                         lineFour,
                         lineFive,
                         lineSix,
                         lineSeven,
                         lineEight,
                         lineNine,
                         lineTen)
    }
    
    override func setLayout() {
        lineOne.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineTwo.snp.makeConstraints {
            $0.top.equalTo(lineOne.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineThree.snp.makeConstraints {
            $0.top.equalTo(lineTwo.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 3 * 2)
            $0.height.equalTo(15)
        }
        
        lineFour.snp.makeConstraints {
            $0.top.equalTo(lineThree.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineFive.snp.makeConstraints {
            $0.top.equalTo(lineFour.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineSix.snp.makeConstraints {
            $0.top.equalTo(lineFive.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineSeven.snp.makeConstraints {
            $0.top.equalTo(lineSix.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineEight.snp.makeConstraints {
            $0.top.equalTo(lineSeven.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 3 * 2)
            $0.height.equalTo(15)
        }
        
        lineNine.snp.makeConstraints {
            $0.top.equalTo(lineEight.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        lineTen.snp.makeConstraints {
            $0.top.equalTo(lineNine.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 3 * 2)
            $0.height.equalTo(15)
        }
    }
    
    override func setStyle() {
        [lineOne, lineTwo, lineThree, lineFour, lineFive, lineSix, lineSeven, lineEight, lineNine, lineTen].forEach {
            $0.setSkeletonLabel(radius: 6)
        }
    }
    
}
