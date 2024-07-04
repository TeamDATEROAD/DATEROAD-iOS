//
//  TimelineCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then

final class TimelineInfoTableViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Properties
    
    static let identifier: String = "TimelineInfoTableViewCell"
    
    private let locationList = CourseDetailContents.timelineContents()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDelegate()
        register()
        setStyle()
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setStyle() {
        tableView.do {
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
        }
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func register() {
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.identifier)
    }
}

// MARK: - UITableViewDelegate

extension TimelineInfoTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - UITableViewDataSource

extension TimelineInfoTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count // Update this to return the actual number of items in locationList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        let locationData = locationList[indexPath.row]
        cell.dataBind(locationData) // Bind data to the cell
        return cell
    }
}
