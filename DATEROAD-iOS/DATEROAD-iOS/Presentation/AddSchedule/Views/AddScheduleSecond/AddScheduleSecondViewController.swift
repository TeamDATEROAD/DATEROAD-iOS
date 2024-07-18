//
//  AddScheduleSecondViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleSecondViewController: BaseNavBarViewController {
   
   // MARK: - UI Properties
   
   private var addScheduleSecondView = AddScheduleSecondView()
   
   private let viewModel: AddScheduleViewModel
   
   private var alertVC: AddScheduleBottomSheetViewController?
   
   
   // MARK: - Initializer
   
   init(viewModel: AddScheduleViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - LifeCycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addCourseTitle, alignment: .center)
      setLeftBackButton()
      setAddTarget()
      setDelegate()
      registerCell()
      bindViewModel()
      setupKeyboardDismissRecognizer()
   }
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      super.setHierarchy()
      
      self.view.addSubview(contentView)
      contentView.addSubview(addScheduleSecondView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addScheduleSecondView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      addScheduleSecondView.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
}


// MARK: - ViewController Methods

private extension AddScheduleSecondViewController {
   
   func registerCell() {
      addScheduleSecondView.addPlaceCollectionView.do {
         $0.register(AddSecondViewCollectionViewCell.self, forCellWithReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier)
      }
   }
   
   func setDelegate() {
      addScheduleSecondView.addPlaceCollectionView.do {
         $0.delegate = self
         $0.dragDelegate = self
         $0.dropDelegate = self
         $0.dataSource = self
      }
      
      [addScheduleSecondView.inAddScheduleSecondView.datePlaceTextField,
       addScheduleSecondView.inAddScheduleSecondView.timeRequireTextField].forEach { i in
         i.delegate = self
      }
   }
   
   func bindViewModel() {
      viewModel.isDataSourceNotEmpty()
      
      viewModel.editBtnEnableState.bind { [weak self] date in
         guard let date = date else {return}
         self?.addScheduleSecondView.editBtnState(isAble: date)
      }
      
      viewModel.datePlace.bind { [weak self] date in
          self?.addScheduleSecondView.inAddScheduleSecondView.datePlaceTextField.text = date
          if let flag = self?.viewModel.isAbleAddBtn() {
              self?.addScheduleSecondView.inAddScheduleSecondView.changeAddPlaceButtonState(flag: flag)
          }
      }
      
      viewModel.timeRequire.bind { [weak self] date in
         self?.addScheduleSecondView.inAddScheduleSecondView.timeRequireTextField.text = date
         if let flag = self?.viewModel.isAbleAddBtn() {
            self?.addScheduleSecondView.inAddScheduleSecondView.changeAddPlaceButtonState(flag: flag)
         }
      }
      
      self.viewModel.isChange = { [weak self] in
         print(self?.viewModel.addPlaceCollectionViewDataSource ?? "")
         self?.viewModel.isDataSourceNotEmpty()
         
         let state = self?.viewModel.editBtnEnableState.value ?? false
         
         self?.addScheduleSecondView.editBtnState(isAble: state)
         
         self?.addScheduleSecondView.inAddScheduleSecondView.finishAddPlace()
         
         self?.viewModel.isSourceMoreThanOne()
         
         self?.addScheduleSecondView.addPlaceCollectionView.reloadData()
      }
      
      self.viewModel.isValidOfSecondNextBtn.bind { [weak self] date in
         self?.addScheduleSecondView.inAddScheduleSecondView.changeNextBtnState(flag: date ?? false)
      }
      
   }
   
   func setAddTarget() {
      addScheduleSecondView.editButton.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
      addScheduleSecondView.inAddScheduleSecondView.addPlaceButton.addTarget(self, action: #selector(tapAddPlaceBtn), for: .touchUpInside)
      addScheduleSecondView.inAddScheduleSecondView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
   }
   
   func successDone() {
      let customAlertVC = DRCustomAlertViewController(rightActionType: .none, alertTextType: .hasDecription, alertButtonType: .oneButton, titleText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertScheduelTitleLabel, longButtonText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.doneButton)
      customAlertVC.delegate = self
      customAlertVC.modalPresentationStyle = .overFullScreen
      self.present(customAlertVC, animated: false)
   }
   
   /// navigationController를 통해 뷰컨트롤러 스택에서 originVC로 돌아가는 코드
   func goBackOriginVC() {
      if let navigationController = self.navigationController {
         navigationController.popToRootViewController(animated: true)
      }
   }
   
   
   // MARK: - @objc Methods
   
   @objc
   func tapAddPlaceBtn() {
      viewModel.tapAddBtn(datePlace: viewModel.datePlace.value ?? "", timeRequire: viewModel.timeRequire.value ?? "")
   }
   
   @objc
   func didTapNextBtn() {
      viewModel.postAddScheduel()
      successDone()
   }
   
   @objc
   func removeCell(sender: UIButton) {
      guard let cell = sender.superview?.superview as? AddSecondViewCollectionViewCell,
            let indexPath = addScheduleSecondView.addPlaceCollectionView.indexPath(for: cell) else { return }
      
      viewModel.addPlaceCollectionViewDataSource.remove(at: indexPath.item)
      addScheduleSecondView.addPlaceCollectionView.deleteItems(at: [indexPath])
      viewModel.isSourceMoreThanOne()
      
      //여기서 datasource가 1개 미만이면
      let dataSourceCnt = viewModel.addPlaceCollectionViewDataSource.count
      if dataSourceCnt < 1 {
         cell.updateEditMode(flag: false)
         addScheduleSecondView.updateEditBtnText(flag: false)
         addScheduleSecondView.editBtnState(isAble: false)
         viewModel.isEditMode = false
      }
   }
   
   @objc
   func moveCell(sender: UIButton) {
      // Move cell logic here
   }
   
   @objc
   func toggleEditMode() {
      print("EditButton 눌림")
      viewModel.isEditMode.toggle()
      let collectionView = addScheduleSecondView.addPlaceCollectionView
      
      let flag = viewModel.isEditMode
      print("현재 editButton editBtnEnableState.value 값 ::: \(flag)")
      
      collectionView.visibleCells.forEach { cell in
         if let customCell = cell as? AddSecondViewCollectionViewCell {
            customCell.updateEditMode(flag: flag)
            customCell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
            if flag {
               customCell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
            } else {
               customCell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
            }
         }
      }
      addScheduleSecondView.updateEditBtnText(flag: flag)
      
      Dispatch.DispatchQueue.main.async {
         collectionView.reloadData()
      }
   }
}


// MARK: - UITextFieldDelegate Methods

extension AddScheduleSecondViewController: UITextFieldDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField != addScheduleSecondView.inAddScheduleSecondView.timeRequireTextField {
         return true
      } else {
         textFieldTapped(textField)
         return false
      }
   }
   
   func textFieldDidEndEditing(_ textField: UITextField) {
      viewModel.datePlace.value = textField.text
      print(textField.text ?? "")
   }
   
   @objc
   private func textFieldTapped(_ textField: UITextField) {
      let alertVC = AddScheduleBottomSheetViewController(viewModel: viewModel)
      alertVC.addSheetView = AddScheduleBottomSheetView(isCustomPicker: true)
      
      self.alertVC = alertVC // alertVC를 인스턴스 변수에 저장
      
      DispatchQueue.main.async {
         alertVC.modalPresentationStyle = .overFullScreen
         self.present(alertVC, animated: true, completion: nil)
      }
   }
   
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate Methods

extension AddScheduleSecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
      return true
   }
   
   func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.addPlaceCollectionViewDataSource.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == addScheduleSecondView.addPlaceCollectionView {
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier,
            for: indexPath
         ) as? AddSecondViewCollectionViewCell else { return UICollectionViewCell() }
         
         cell.configure(model: viewModel.addPlaceCollectionViewDataSource[indexPath.item])
         cell.updateEditMode(flag: viewModel.isEditMode)
         cell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
         if viewModel.isEditMode {
            cell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
         } else {
            cell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
         }
         
         return cell
      } else {
         return UICollectionViewCell()
      }
   }
   
}


// MARK: - UICollectionViewDropDelegate Methods

extension AddScheduleSecondViewController: UICollectionViewDropDelegate {
   
   func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
      if collectionView == addScheduleSecondView.addPlaceCollectionView {
         var destinationIndexPath: IndexPath
         if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
         } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
         }
         
         if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
         }
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
      if collectionView == addScheduleSecondView.addPlaceCollectionView {
         if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
         }
      }
      return UICollectionViewDropProposal(operation: .forbidden)
   }
   
   private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
      if collectionView == addScheduleSecondView.addPlaceCollectionView {
         if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
               let temp = viewModel.addPlaceCollectionViewDataSource[sourceIndexPath.item]
               viewModel.addPlaceCollectionViewDataSource.remove(at: sourceIndexPath.item)
               viewModel.addPlaceCollectionViewDataSource.insert(temp, at: destinationIndexPath.item)
               collectionView.deleteItems(at: [sourceIndexPath])
               collectionView.insertItems(at: [destinationIndexPath])
            }) { done in
               //
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
         }
         viewModel.updatePlaceCollectionView()
      }
   }
   
}


// MARK: - UICollectionViewDragDelegate Methods

extension AddScheduleSecondViewController: UICollectionViewDragDelegate {
   func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
      return []
   }
}


extension AddScheduleSecondViewController: DRCustomAlertDelegate {
   
   func exit() {
      goBackOriginVC()
   }
   
}

