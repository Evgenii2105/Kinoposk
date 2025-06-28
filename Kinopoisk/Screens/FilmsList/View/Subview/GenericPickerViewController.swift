//
//  GenericPickerViewController.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 28.06.2025.
//

import UIKit

protocol CustomPickerDelegate: AnyObject {
    func didSelectYear(year: GenericPickerViewController.YearFilter)
}

class GenericPickerViewController: UIViewController {
    
    enum YearFilter {
        case allYears
        case specificYear(Int)
        
        var stringValue: String {
            switch self {
            case .allYears:
                return "Все года"
            case .specificYear(let year):
                return String(year)
            }
        }
    }
    
    private var selectedFilter: YearFilter = .allYears
    private let pickerView: UIPickerView
    private let filters: [YearFilter]
    weak var delegate: CustomPickerDelegate?
    
    init(with title: String? = nil, items: [YearFilter]) {
        self.pickerView = UIPickerView()
        self.filters = items
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
    }
    
    static func makePickerController(with items: [YearFilter]) -> UIViewController {
        let picker = GenericPickerViewController(with: "Выбор года", items: items)
        let navigationController = UINavigationController(rootViewController: picker)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        return navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pickerView)
        pickerView.backgroundColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func doneTapped() {
        delegate?.didSelectYear(year: selectedFilter)
        dismiss(animated: true)
    }
}

extension GenericPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFilter = filters[row]
    }
}

extension GenericPickerViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        filters.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(
            string: filters[row].stringValue,
            attributes: [.foregroundColor: UIColor.label]
        )
    }
    
    
}
