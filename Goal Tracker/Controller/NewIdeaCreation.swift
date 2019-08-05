//
//  NewIdeaCreation.swift
//  Goal Tracker
//
//  Created by Sam  on 6/8/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import UIKit
import RealmSwift
import DSColorPicker
import PickerViewCell
import UserNotifications


protocol AddItemDelegate {
    func addItem(item: item)
}

protocol AddDateDelegate {
    func addDate(date: String)
}



class NewIdeaCreation: UITableViewController {
    
    var calendarHandlerViewModel: CalendarSelectionViewModelContrast!
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
//    var daysDates: String = []


    var backgroundColor: Int?
    
    @IBOutlet weak var fromDateLabel: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var nameTextField: UITextField!
    
        
    @IBAction func sliderChange(_ sender: Any) {
        
//        print("\(colorArray[Int(slider.value)])")
        return backgroundColor = colorArray[Int(slider.value)]
    }
    
    
    let realm = try! Realm()
    
    var delegate: AddItemDelegate?
    
    var dateDelegate: AddDateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.becomeFirstResponder()
        
        }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//            if settings.authorizationStatus != .authorized {
//                let alertController = UIAlertController(title: "Notification was disabled", message: "Turn on your notifications.", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
//                    self.navigationController?.popViewController(animated: true)
//                }))
//                alertController.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (action) in
//                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//                }))
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
    
    
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        return formatter
    }()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerTableViewCell {
            cell.delegate = self
            if !cell.isFirstResponder {
                _ = cell.becomeFirstResponder()
                
                //Deselection not working
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        if touch?.view == self.view {
//            self.view.resignFirstResponder()
//        }
//    }
    
    
    //function to store and display the Name Field
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let ideaName = item()
        
        ideaName.name = nameTextField.text ?? ""
        ideaName.color = String(colorArray[Int(slider.value)]) //Data Type?
//        ideaName.date = days
        
        delegate?.addItem(item: ideaName)
        
//        dateDelegate?.addDate(date: ideaName.date)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // a function that can convert Date type to String type
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    

}


//Date Picker Configuration

extension NewIdeaCreation: DatePickerTableCellDelegate {
    
    func onDateChange(_ sender: UIDatePicker, cell: DatePickerTableViewCell) {
        let selectedDate = sender.date
        print(selectedDate)
        
        let  dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: selectedDate)
        fromDateLabel?.text = strDate
//        daysDates.append(strDate)
        print(strDate)
        
        scheduleNotification(at: selectedDate)


    }
    
    func onDatePickerOpen(_ cell: DatePickerTableViewCell) {
        fromDateLabel.text = fromDateLabel.text!.isEmpty ? dateFormatter.string(from: Date()) : fromDateLabel.text
        fromDateLabel.textColor = UIColor.red
    }
    
    func onDatePickerClose(_ cell: DatePickerTableViewCell) {
        fromDateLabel.textColor = UIColor.gray
    }
    
    
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        //Configure
        let content = UNMutableNotificationContent()
        content.title = "You have a new idea now!"
        content.title = NSString.localizedUserNotificationString(forKey: "Calendar Title", arguments: nil)
        content.subtitle = "This is cool"
        content.body = "Remember to finish your reading today"
        content.sound = UNNotificationSound.default
        content.badge = 0
        
        let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: trigger)
        
        // Schedule the request with the system.
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Failed to add request to notification center. error:\(error)")
            }
        }
        
    }
    
}

// MARK: - PickerTableCellDataSource

extension NewIdeaCreation: PickerTableCellDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: PickerTableViewCell) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell cell: PickerTableViewCell) -> Int {
        return 10
    }
    
}


