//
//  DatePickerCalendarView.swift
//  InfiniteHorizontalCalendar
//
//  Created by 李日杰 on 2021/1/17.
//

import Foundation
import UIKit

// MARK: - DatePickerCell Define
public class CalendarFrameView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var componentsMonth: Date!
    var calendarMap: [Int: Date]!
    var calendarCollectionView: UICollectionView!
    var monthLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        componentsMonth = Date()
        calendarMap = componentsMonth.getCalendarMap()
        
        setupSelf()
        setupMonthLabel()
        setupCalendarCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarMap.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "datePickerCalendarCell", for: indexPath) as? DatePickerCalendarCell else {
            fatalError("DatePickerCalendarCellView Not implement property!")
        }
        
        cell.configure(info: calendarMap[indexPath.row+1]!, calendarMonth: componentsMonth)
        
        return cell
    }
    
    func setupSelf() {
        
    }
    
    func setupMonthLabel() {
        monthLabel = UILabel()
        monthLabel.textColor = .black
        monthLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        monthLabel.text = componentsMonth.yearAndMonthString
        
        self.contentView.addSubview(monthLabel)
        
        monthLabel.addCustomConstraints(
            monthLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            monthLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 50)
        )
    }
    
    func setupCalendarCollectionView() {
        calendarCollectionView = UICollectionView(frame: frame, collectionViewLayout: Self.customFlowLayout())
        calendarCollectionView.register(DatePickerCalendarCell.self, forCellWithReuseIdentifier: "datePickerCalendarCell")
        
        self.contentView.addSubview(calendarCollectionView)
        
        calendarCollectionView.addCustomConstraints(
            calendarCollectionView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            calendarCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            calendarCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            calendarCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        )
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.backgroundColor = .white
    }
    
    func configure(info: Date) {
        componentsMonth = info
        calendarMap = componentsMonth.getCalendarMap()
        monthLabel.text = info.yearAndMonthString
        calendarCollectionView.reloadData()
    }
    
    static func customFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let windowWidth = 330
        layout.itemSize = CGSize(width: windowWidth/7, height: 290/6)
//        layout.scrollDirection = .horizontal
        
        return layout
    }
}

public class DatePickerCalendarCell: UICollectionViewCell {
    
    let cellLabel = UILabel()
    let todayComponent = Date().todayDateComponents
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(cellLabel)
        
        cellLabel.addCustomConstraints(
            cellLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cellLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        )
        
        cellLabel.textColor = .black
        cellLabel.font = .systemFont(ofSize: 14)
        self.backgroundColor = .white
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(info: Date, calendarMonth: Date) {
        cellLabel.text = String(info.dayOfMonth)

        if info.todayDateComponents.year == todayComponent.year &&
            info.todayDateComponents.month == todayComponent.month &&
            info.todayDateComponents.day == todayComponent.day {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 16
        } else {
            self.layer.borderWidth = 0
            self.layer.borderColor = nil
        }
        
        let components = calendarMonth.todayDateComponents
        
        if info.todayDateComponents.year != components.year ||
            info.todayDateComponents.month != components.month {
            self.cellLabel.textColor = .gray
        } else {
            self.cellLabel.textColor = .black
        }
    }
}
