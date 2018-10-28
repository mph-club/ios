//
//  CalendarViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import JTAppleCalendar

final class CalendarViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Calendar
    @IBOutlet private weak var calendar: JTAppleCalendarView! {
        didSet {
            // Register collection view cell
            registerCollectionViewCell()
        }
    }
    
    // MARK: Label
    @IBOutlet private weak var yearAndMonthLabel: UILabel!
    
    // MARK: Text Field
    @IBOutlet private weak var startTimeTextField: UITextField!
    @IBOutlet private weak var endTimeTextField: UITextField!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Lazy Var
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        return formatter
    }()
    
    private lazy var startTimePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.timeZone = Calendar.current.timeZone
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(startTimePickerValueChanged), for: .valueChanged)
        return timePicker
    }()
    
    private lazy var endTimePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.timeZone = Calendar.current.timeZone
        timePicker.addTarget(self, action: #selector(endTimePickerValueChanged), for: .valueChanged)
        return timePicker
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        //
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        //
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        //
        return toolBar
    }()
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CalendarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .whiteNavigationBar
        //
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
}

// ===============
// MARK: - Actions
// ===============
private extension CalendarViewController {
    @IBAction func startTimePickerValueChanged(_ sender: UIDatePicker) {
        endTimePicker.minimumDate = sender.date
        //
        dateFormatter.dateFormat = "hh:mm aa"
        startTimeTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func endTimePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "hh:mm aa"
        endTimeTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func donePicker() {
        view.endEditing(true)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension CalendarViewController {
    func registerCollectionViewCell() {
        calendar.registerCell(CalendarCollectionViewCell.self)
    }
    
    func configView() {
        //
        startTimeTextField.inputView = startTimePicker
        startTimeTextField.inputAccessoryView = toolBar
        //
        endTimeTextField.inputView = endTimePicker
        endTimeTextField.inputAccessoryView = toolBar
        //
        calendar.scrollToDate(Date())
    }
}

// ========================
// MARK: - JTApple Calendar
// ========================

// MARK: Data Source
extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = dateFormatter.date(from: "2018 01 01") ?? Date()
        let endDate = dateFormatter.date(from: "2030 12 31") ?? Date()
        //
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

// MARK: Delegate
extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {}
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell: CalendarCollectionViewCell = calendar.dequeueReusableCell(for: indexPath)
        //
        cell.setContent(cellState.text)
        //
        cell.handleCellTextColor(cellState)
        //
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first?.date ?? Date()
        //
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        //
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: date)
        //
        yearAndMonthLabel.text = "\(month) \(year)"
    }
}
