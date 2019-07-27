//
 //  DateRangePickerCell.swift
//  Goal Tracker
//
//  Created by Sam  on 7/17/19.
//  Copyright © 2019 Sam. All rights reserved.
//

//import UIKit
//import Foundation
//import PickerViewCell
//
//class DateRangePickerTableViewCell: UITableViewController {
//    
//    
//    @IBOutlet weak var fromDateLabel: UILabel!
//
//    @IBOutlet weak var toDateLabel: UILabel!
//
//    fileprivate lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = DateFormatter.Style.long
//        formatter.timeStyle = DateFormatter.Style.none
//        return formatter
//    }()
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerTableViewCell {
//            cell.delegate = self
//            if !cell.isFirstResponder {
//                _ = cell.becomeFirstResponder()
//            }
//        } else if let cell = tableView.cellForRow(at: indexPath) as? PickerTableViewCell {
//            cell.delegate = self
//            cell.dataSource = self
//            if !cell.isFirstResponder {
//                _ = cell.becomeFirstResponder()
//            }
//        }
//    }
//}
//
//// MARK: - DatePickerTableCellDelegate
//
//extension DateRangePickerTableViewCell: DatePickerTableCellDelegate {
//    
//    func onDateChange(_ sender: UIDatePicker, cell: DatePickerTableViewCell) {
//        fromDateLabel.text = dateFormatter.string(from: sender.date)
//    }
//    
//    func onDatePickerOpen(_ cell: DatePickerTableViewCell) {
//        fromDateLabel.text = fromDateLabel.text!.isEmpty ? dateFormatter.string(from: Date()) : fromDateLabel.text
//        fromDateLabel.textColor = UIColor.red
//    }
//    
//    func onDatePickerClose(_ cell: DatePickerTableViewCell) {
//        fromDateLabel.textColor = UIColor.gray
//    }
//    
//}
//
//// MARK: - PickerTableCellDataSource
//
//extension DateRangePickerTableViewCell: PickerTableCellDataSource {
//    
//    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: PickerTableViewCell) -> Int {
//        return 1
//    }
//    
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell cell: PickerTableViewCell) -> Int {
//        return 2
//    }
//    
//}
//extension DateRangePickerTableViewCell: PickerTableCellDelegate {
//    
//    func onPickerOpen(_ cell: PickerTableViewCell) {
//        toDateLabel.text = toDateLabel.text!.isEmpty ? "MALE" : toDateLabel.text
//        toDateLabel.textColor = UIColor.red
//    }
//    
//    func onPickerClose(_ cell: PickerTableViewCell) {
//        toDateLabel.textColor = UIColor.gray
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: PickerTableViewCell) -> String? {
//        return row == 0 ? "MALE" : "FEMALE"
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: PickerTableViewCell) {
//        toDateLabel.text = row == 0 ? "MALE" : "FEMALE"
//    }
//    
//}
    



