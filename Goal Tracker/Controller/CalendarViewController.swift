//
//  CalendarViewController.swift
//  Goal Tracker
//
//  Created by Sam  on 7/12/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

import JTAppleCalendar
import RealmSwift


class CalendarViewController: UIViewController {

    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    @IBOutlet weak var weekCount: UICollectionView!
    
    
    let testCalendar = Calendar(identifier: .gregorian)

    
    @IBOutlet weak var constraint: NSLayoutConstraint!

    
        
    var numberOfRows = 6
    
    var selectedDays: [Date]?
    
    var calendarDataSource: [String:String] = [:]


    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    //Access value stored by the singleton in NewIdeaCreation
        let dateItem2 = Items.sharedInstance.array

        print("dateItem2 is now \(dateItem2)")
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        
        calendarView.allowsMultipleSelection = true
        calendarView.isRangeSelectionUsed = true
        
//        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
//            self.setupViewsOfCalendar(from: visibleDates)
//        }
        
        self.calendarView.scrollToDate(Date(),animateScroll: false)
        self.calendarView.selectDates([ Date() ])
        
        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didStartRangeSelecting(gesture:)))
        panGensture.minimumPressDuration = 0.5
        calendarView.addGestureRecognizer(panGensture)
        
        calendarDataSource.updateValue("newAddedData", forKey: dateItem2)
        print("calendar Datasource now has \(calendarDataSource)")
        
        populateDataSource()


    }
    

    
    @IBAction func toggle(_ sender: Any) {
        
        if numberOfRows == 6 {
            self.constraint.constant = 58.33
            self.numberOfRows = 1
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { completed in
                self.calendarView.reloadData(withanchor: Date())
            }
        } else {
            self.constraint.constant = 350
            self.numberOfRows = 6
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.calendarView.reloadData(withanchor: Date())
            })
        }
    }
    
    
    //handing device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
    
    func populateDataSource() {
        // You can get the data from a server.
        // Then convert that data into a form that can be used by the calendar.
//        calendarDataSource = [
//            "07-Jan-2018": "SomeData",
//            "15-Jan-2018": "SomeMoreData",
//            "15-Feb-2018": "MoreData",
//            "21-Feb-2018": "onlyData",
//        ]

        print("Now the calendarDataSource has \(calendarDataSource)")
        // update the calendar
        calendarView.reloadData()
    }
    
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        //print(cell.dateLabel.text) print out: Optional("date")
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
        print(cell.dateLabel.text!)

    }
    
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.black
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
    
    
    func handleCellEvents(cell: DateCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        if calendarDataSource[dateString] == nil {
            cell.dotView.isHidden = true
        } else {
            cell.dotView.isHidden = false
        }
    }
    
    //Range Selection
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        cell.selectedView.isHidden = !cellState.isSelected
        switch cellState.selectedPosition() {
        case .left:
            cell.selectedView.layer.cornerRadius = 20
            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = []
        case .right:
            cell.selectedView.layer.cornerRadius = 20
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .full:
            cell.selectedView.layer.cornerRadius = 20
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        default: break
        }
    }
    
    
    @objc func didStartRangeSelecting(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let rangeSelectedDates = calendarView.selectedDates

        guard let cellState = calendarView.cellStatus(at: point) else { return }

        if !rangeSelectedDates.contains(cellState.date) {
            let dateRange = calendarView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
            calendarView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
        } else {
            let followingDay = testCalendar.date(byAdding: .day, value: 1, to: cellState.date)!
            calendarView.selectDates(from: followingDay, to: rangeSelectedDates.last!, keepSelectionIfMultiSelectionAllowed: false)
        }
    }

    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
}



//Calendar Data Source Method
extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//            let formatter = Formatter()
//            formatter.dateFormat = "yyyy MM dd"
//            formatter.timeZone = Calendar.current.timeZone
//            formatter.locale = Calendar.current.locale
//
//            var dateComponent = DateComponents()
//            dateComponent.year = 1
////            let startDate = Date()
//        let beginDate = formatter.string(from: Date())
//        print(beginDate)
//
//        let startDate = formatter.date(from: "01-jan-2019")!
//
//
//        let endDate = Date()
//        return ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        formatter.dateFormat = "yyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: dateComponent, to: startDate)
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate!, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forFirstMonthOnly, generateOutDates: .off, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
        
        
        return parameters
        
            }
    
}


//Calendar Delegate Method
extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date: Date = visibleDates.monthDates.first!.date
        let weekNumber = Calendar.current.component(.weekOfYear, from: date)
        weekCount.scrollToItem(at: IndexPath(item: weekNumber - 1, section: 0), at: .top, animated: true)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        let formatter = DateFormatter()// Declare this outside, to avoid instancing this heavy class multiple times.
        

        formatter.dateFormat = "MMM-yyyy"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
    func getFirstDateDescriptionText() -> String? {
        if let days = selectedDays, !days.isEmpty {
            return DateFormatter.shortCurrent.string(from: days.first!)
        } else {
            return nil
        }
    }

}

//extension CalendarViewController: AddDateDelegate {
//    func addDate(date: String, descr: String) {
//
//        calendarDataSource.updateValue(descr, forKey: date)
//        print("The calendarDataSource are now \(calendarDataSource)")
//        calendarView.reloadData()
//    }
//}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 55
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCountCell", for: indexPath) as! WeekCountCell
        cell.countLabel?.text = "\(indexPath.item + 1)"
        return cell
    }
}
