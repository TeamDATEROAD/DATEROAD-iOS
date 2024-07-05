//
//  AddCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

@available(iOS 17.0, *)
#Preview {
   AddCourseViewController()
}

final class AddCourseViewController: BaseNavBarViewController {
   
   private var dataSource = getSampleImages()
   
   private var addCourseFirstView = AddCourseFirstView()
   
   // MARK: - Life Cycle
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrScheduleFirst.addCourseTitle)
      setLeftBackButton()
      registerCell()
   }
   
   override func setHierarchy() {
      
      super.setHierarchy()
      self.view.addSubview(contentView)
      contentView.addSubview(addCourseFirstView)
   }
   
   override func setLayout() {
      
      super.setLayout()
      addCourseFirstView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.bottom.equalToSuperview()
         $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-4)
      }
   }
   
   override func setStyle() {
      
      super.setStyle()
      addCourseFirstView.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
}

extension AddCourseViewController: UICollectionViewDataSource, UICollectionViewDelegate {

   private func registerCell() {
      addCourseFirstView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: "AddCourseImageCollectionViewCell")
         $0.delegate = self
         $0.dataSource = self
         $0.backgroundColor = .deepPurple
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.dataSource.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: AddCourseImageCollectionViewCell.id,
         for: indexPath
      ) as! AddCourseImageCollectionViewCell
      cell.prepare(image: self.dataSource[indexPath.item])
      return cell
   }
   
}

func getSampleImages() -> [UIImage?] {
   (1...9).map { _ in return UIImage(resource: .test) }
}
