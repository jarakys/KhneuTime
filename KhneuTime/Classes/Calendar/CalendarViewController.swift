//
//  CalendarViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 03.03.2021.
//

import UIKit

protocol CalendarViewControllerDelegate: class {
    func dateChanged(date: Date)
}

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var calendarCollectionView: SwipableCollectionView!
    @IBOutlet var liftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    
    private var calendar = Calendar.iso8601UTC
    private var days = [Day]()
    private var selectedDay: Day?
    
    
    var doneAction: ((Date) -> Void)?
    public var initDate: Date!
    
    var selectedDate: Date = Date() {
        didSet {
            headerView.baseDate = selectedDate
        }
    }
    private var selectedDateChanged: ((Date) -> Void)?
    var baseDate: Date! {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            headerView.baseDate = baseDate
        }
    }
    
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.register(CalendarCell.nib, forCellWithReuseIdentifier: CalendarCell.reusableIndentify)
        calendarCollectionView.isScrollEnabled = false
        view.addSubview(headerView)
        let constraints = [
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: actionStackView.bottomAnchor),
            headerView.bottomAnchor.constraint(equalTo: calendarCollectionView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85),
        ]
        headerView.baseDate = baseDate
        NSLayoutConstraint.activate(constraints)
        liftSwipe.delegate = calendarCollectionView
        rightSwipe.delegate = calendarCollectionView
        calendarCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        days = generateDaysInMonth(for: baseDate)
        selectedDay = days.first(where: {$0.date.startOfDay == selectedDate.startOfDay})
        calendarCollectionView?.reloadData()
        updateCalendarViewSelection()
    }
    
    func updateCalendarViewSelection() {
        calendarCollectionView?.reloadData()
        guard let day = selectedDay else { return }
        let position  = days.firstIndex(where: { $0.number == day.number}) ?? 0
        let indexPath = IndexPath(item: position, section: 0)
        self.calendarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        self.collectionView(calendarCollectionView, didSelectItemAt: indexPath)
    }
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = monthMetadata(for: baseDate) else {
            fatalError("An error occurred when generating the metadata for \(baseDate)")
        }
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        let days: [Day] = (2..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                let dayOffset =
                    isWithinDisplayedMonth ?
                    day - offsetInInitialRow :
                    -(offsetInInitialRow - day)
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        //days += generateStartOfNextMonth(using: firstDayOfMonth)
        return days
    }
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                                 to: firstDayOfDisplayedMonth)
        else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }
        return days
    }
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
            ?? baseDate
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = "dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: false,
            isWithinDisplayedMonth: isWithinDisplayedMonth
        )
    }
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            baseDate = baseDate.addMonth(value: -1)
        case .left:
            baseDate = baseDate.addMonth(value: 1)
        default: return
        }
        calendarCollectionView.reloadData()
    }
    
    @IBAction func doneDidTap(_ sender: Any) {
        doneAction?(selectedDate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.reusableIndentify, for: indexPath)
        let model = days[indexPath.row]
        (cell as? CalendarCell)?.configure(number: model.number)
        (cell as? CalendarCell)?.numberTitle.textColor = model.date.startOfDay == Date().startOfDay ? UIColor.systemOrange : .label
        cell.selectedBackgroundView?.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = days[indexPath.row]
        selectedDate = selectedDay?.date ?? Date()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)!.isSelected = false
    }
    
}

extension CalendarViewController {
    func monthMetadata(for baseDate: Date) -> MonthMetadata? {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            return nil
        }
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        return MonthMetadata(numberOfDays: numberOfDaysInMonth, firstDay: firstDayOfMonth, firstDayWeekday: firstDayWeekday)
    }
}

