//
//  AddCourseThirdViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class AddCourseThirdViewController: BaseNavBarViewController {
   
   // MARK: - UI Properties
   
   private var addCourseThirdView = AddCourseThirdView()
   
   private let viewModel: AddCourseViewModel
   
   
   // MARK: - Initializer
   
   init(viewModel: AddCourseViewModel) {
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
      setDelegate()
      registerCell()
      addTarget()
      bindViewModel()
      setupKeyboardDismissRecognizer()
   }
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      super.setHierarchy()
      
      self.view.addSubview(contentView)
      contentView.addSubview(addCourseThirdView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addCourseThirdView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalToSuperview()
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      addCourseThirdView.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
}


// MARK: - ViewController Methods

extension AddCourseThirdViewController {
   
   private func registerCell() {
      addCourseThirdView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
      }
   }
   
   private func setDelegate() {
      addCourseThirdView.collectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
      
      addCourseThirdView.addThirdView.contentTextView.delegate = self
      addCourseThirdView.addThirdView.priceTextField.delegate = self
   }
   
   private func addTarget() {
      addCourseThirdView.addThirdView.priceTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
      addCourseThirdView.addThirdView.addThirdDoneBtn.addTarget(self, action: #selector(didTapAddCourseBtn), for: .touchUpInside)
   }
   
   private func bindViewModel() {
      viewModel.contentTextCount.bind { [weak self] date in
         self?.addCourseThirdView.addThirdView.updateContentTextCount(textCnt: date ?? 0)
         let flag = (date ?? 0) >= 200 ? true : false
         self?.viewModel.contentFlag = flag
         self?.viewModel.isDoneBtnValid()
         print("contentFlag :", self?.viewModel.contentFlag)
         
      }
      viewModel.priceText.bind { [weak self] date in
         self?.addCourseThirdView.addThirdView.updatePriceText(price: date ?? 0)
         let flag = (date ?? 0 > 0) ? true : false
         self?.viewModel.priceFlag = flag
         self?.viewModel.isDoneBtnValid()
         print("priceFlag :", self?.viewModel.priceFlag)
      }
      
      viewModel.isDoneBtnOK.bind { [weak self] date in
         self?.addCourseThirdView.addThirdView.updateAddThirdDoneBtn(isValid: date ?? false)
      }
   }
   
   /// navigationController를 통해 뷰컨트롤러 스택에서 originVC로 돌아가는 코드
   func goBackOriginVC() {
      if let navigationController = self.navigationController {
         navigationController.popToRootViewController(animated: true)
      }
   }
   
}


extension AddCourseThirdViewController: UITextViewDelegate {
   
   func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.text == addCourseThirdView.addThirdView.textViewPlaceHolder {
         textView.text = nil
         textView.textColor = .black
      }
      print(textView.text ?? "")
   }
   
   func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
         textView.text = addCourseThirdView.addThirdView.textViewPlaceHolder
         textView.textColor = UIColor(resource: .gray300)
      }
   }
   
   func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      let currentText = textView.text ?? ""
      guard let stringRange = Range(range, in: currentText) else { return false }
      
      let changedText = currentText.replacingCharacters(in: stringRange, with: text)
      // 리턴 눌렸을 때의 "\n" 입력을 count로 계산하지 않음
      let filteredTextCount = changedText.filter { $0 != "\n" }.count
      
      //      addCourseThirdView.addThirdView.updateContentTextCount(textCnt: filteredTextCount)
      viewModel.contentTextCount.value = filteredTextCount
      
      // 리턴 키 입력을 처리합니다.
      if text == "\n" {
         textView.resignFirstResponder()
         return false
      }
      return true
   }
   
   // 이거 안씀
   /// priceTextField 실시간 변경 감지
   
   
}


// MARK: - UITextFieldDelegate Methods

extension AddCourseThirdViewController: UITextFieldDelegate {
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
   }
   
   func textFieldDidEndEditing(_ textField: UITextField) {
      print("textFieldDidEndEditing 에서 출력")
      print(textField.text)
      viewModel.priceText.value = Int(textField.text ?? "0")
   }
   
   
   //이거 왜 입력받는거 출력이안되지~
   @objc
   func textFieldDidChanacge(_ textField: UITextField) {
      print("~~~~~~~~~~~~~")
      print(textField.text ?? "~~")
   }
   
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate Methods

extension AddCourseThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.pickedImageArr.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
         for: indexPath
      ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
      
      cell.updateImageCellUI(isImageEmpty: false, vcCnt: 2)
      cell.configurePickedImage(pickedImage: viewModel.pickedImageArr[indexPath.item])
      cell.prepare(image: viewModel.pickedImageArr[indexPath.item])
      
      return cell
   }
}


// MARK: - Alert Delegate

extension AddCourseThirdViewController: CustomAlertDelegate {
   
   @objc
   private func didTapAddCourseBtn() {
      let customAlertVC = CustomAlertViewController(alertTextType: .hasDecription, alertButtonType: .oneButton, titleText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertTitleLabel, descriptionText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertSubTitleLabel, longButtonText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.doneButton)
      customAlertVC.delegate = self
      customAlertVC.modalPresentationStyle = .overFullScreen
      self.present(customAlertVC, animated: false)
   }
   
   func exit() {
      goBackOriginVC()
   }
   
}
