//
//  DatePickerCollectionView.swift
//  InfiniteHorizontalCalendar
//
//  Created by 李日杰 on 2021/1/17.
//

import Foundation
import UIKit

public class CalendarView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let numberOfItems = 3
    var initialDate: Date!
    var dateMap: [Date] = []
    var currentViewIndex = 1
    
    init(parentView: UIView) {
        super.init(frame: parentView.frame, collectionViewLayout: Self.customFlowLayout())
        
        initialDate = Date()
        for index in 1...(numberOfItems+2) {
            dateMap.append(initialDate.addingMonths(index-2))
        }
        
        parentView.addSubview(self)
        setupSelf(parentView: parentView)
        
        self.register(CalendarFrameView.self, forCellWithReuseIdentifier: "datePickerCalendarView")
        
        self.delegate = self
        self.dataSource = self

    }

    func currentViewToBufferPage() {
        if currentViewIndex == 0 {
            let bufferPageIndex = currentViewIndex + numberOfItems
            dateMap[bufferPageIndex] = dateMap[currentViewIndex]
            currentViewIndex = bufferPageIndex
        } else if currentViewIndex == 4{
            let bufferPageIndex = currentViewIndex - numberOfItems
            dateMap[bufferPageIndex] = dateMap[currentViewIndex]
            currentViewIndex = bufferPageIndex
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let newPageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        currentViewIndex = newPageIndex
        
        if currentViewIndex == 0 {
            currentViewToBufferPage()
            scrollView.contentOffset = CGPoint(x: CGFloat(currentViewIndex) * scrollView.frame.size.width, y: 0)
        }
        
        if currentViewIndex == 4 {
            currentViewToBufferPage()
            scrollView.contentOffset = CGPoint(x: CGFloat(currentViewIndex) * scrollView.frame.size.width, y: 0)
        }
        
        dateMap[currentViewIndex-1] = dateMap[currentViewIndex].addingMonths(-1)
        dateMap[currentViewIndex+1] = dateMap[currentViewIndex].addingMonths(1)
        
        self.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func customFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let windowWidth = 350
        layout.itemSize = CGSize(width: windowWidth, height: windowWidth)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    func setupSelf(parentView: UIView) {
        self.addCustomConstraints(
            self.heightAnchor.constraint(equalToConstant: 350),
            self.widthAnchor.constraint(equalToConstant: 350),
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        )
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Collection DataSource and Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems + 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "datePickerCalendarView", for: indexPath) as? CalendarFrameView else {
            fatalError("DatePickerCell Cause this problem")
        }
        
        cell.configure(info: dateMap[indexPath.row])
        return cell
    }
    
}
