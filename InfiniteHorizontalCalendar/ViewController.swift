//
//  ViewController.swift
//  InfiniteHorizontalCalendar
//
//  Created by 李日杰 on 2021/1/17.
//

import UIKit

class ViewController: UIViewController {

    var calendarView: CalendarView!
    
    let calendarWidth = 350
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        calendarView = CalendarView(parentView: self.view)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.setContentOffset(CGPoint(x: calendarWidth, y: 0), animated: false)
    }
    
}

