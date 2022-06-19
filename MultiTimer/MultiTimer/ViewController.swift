//
//  ViewController.swift
//  MultiTimer
//
//  Created by  Максим Мартынов on 29.10.2021.
//

import UIKit

class TimerViewController: UIViewController, UITextFieldDelegate {
    let timerCell = TimerCell()
    
    lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createTimer), userInfo: nil, repeats: true)
        return timer
    }()
    
    var timerTableView = UITableView()
    let addingNewTimerCell = UITableViewCell()
    var timerNameTextField = UITextField()
    var timerDurationTextField = UITextField()
    var startButton = UIButton()
    
    var timers = [TimerCell]()
    
    
    
    override func loadView() {
        super.loadView()
        
        // set title
        self.title = "Мульти Таймер"
        //construct cell
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerTableView = UITableView(frame: view.bounds, style: .grouped)
        timerTableView.register(TimerCell.self, forCellReuseIdentifier: "TimerCell")
        
        timerTableView.delegate = self
        timerTableView.dataSource = self
       
        addingNewTimerCell.selectionStyle = .none
        configureAddingButton()
        configureNameTextfield()
        configureDurationTextField()
        setToolbar()
        
        view.addSubview(timerTableView)
        timerTableView.addSubview(addingNewTimerCell)
       
        
        

    }
    //MARK: - Create Timer
    
    @objc func createTimer() {
        guard let durationInSeconds = Int(self.timerDurationTextField.text!) else { return }
            var count = durationInSeconds
                if count > 0 {
                    count -= 1
                    if count >= 60 {
                        let minutes = count / 60
                        let seconds = count % 60
                        self.timerCell.durationLabel.text = "\(minutes):\(seconds)"
                    }
                    self.timerCell.durationLabel.text = "осталось - \(count) секунд"
                    self.timerTableView.reloadData()
                    print("осталось - \(count)")
                } else if count == 0 {
//                    timer.invalidate()
                    print("DONE")
                }
            }
        
    
    
    //MARK: - UserInterface
    
   private func configureAddingButton() {
        startButton = UIButton(type: .roundedRect)
        startButton.frame = CGRect(x: 0, y: 110, width: self.addingNewTimerCell.bounds.width - 20, height: 35)
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 0
        
        startButton.setTitle("Добавить", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "System", size: 18)
        startButton.titleLabel?.textColor = .systemBlue
        startButton.center.x = view.center.x

       if let time = timerDurationTextField.text, time.isEmpty {
           startButton.isEnabled = false
       }
        startButton.addTarget(self, action: #selector(buttonActionHandler), for: UIControl.Event.touchUpInside)
         
        startButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1)
        addingNewTimerCell.contentView.addSubview(startButton)
    }
    
    @objc func buttonActionHandler() {

            timers.insert(timerCell, at: 0)

    }
  
   private func configureNameTextfield() {
        timerNameTextField = UITextField(frame: CGRect(x: 10, y: 10, width: view.bounds.width / 4 * 3, height: 31))
        timerNameTextField.borderStyle = .roundedRect
        timerNameTextField.placeholder = "Название таймера"
        
        addingNewTimerCell.contentView.addSubview(timerNameTextField)
    }
    
   private func configureDurationTextField() {
        
        timerDurationTextField = UITextField(frame: CGRect(x: 10, y: 50, width: view.bounds.width / 4 * 3, height: 31))
        timerDurationTextField.borderStyle = .roundedRect
        timerDurationTextField.placeholder = "Время в секундах"
        timerDurationTextField.keyboardType = UIKeyboardType.decimalPad
        
        addingNewTimerCell.contentView.addSubview(timerDurationTextField)
    }
    
    //MARK: - Toolbar DoneButton
    func setToolbar() {
    let toolBar = UIToolbar()
        toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
    
    toolBar.setItems([doneButton], animated: false)
        timerDurationTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        if let time = timerDurationTextField.text, !time.isEmpty {
        startButton.isEnabled = true
        }
        timerDurationTextField.resignFirstResponder()
    }
}




//MARK: - UITableViewDelegate & DataSource
extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return timers.count
        default:
            fatalError("Unknownn number of rows in section")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            return self.addingNewTimerCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerCell
            cell.nameLabel.text = timerNameTextField.text
            
            guard let durationInSeconds = Int(timerDurationTextField.text ?? "0") else { return cell }
            if durationInSeconds >= 60 {
                let minutes = durationInSeconds / 60
                let seconds = durationInSeconds % 60
                cell.durationLabel.text = "\(minutes):\(seconds)"
//                self.timer.fire()
            }
            
            cell.isUserInteractionEnabled = false
            
            return cell
        default:
            fatalError("Unknown row in sections")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 150
        case 1: return 40
        default: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Добавление таймеров"
        case 1: return "Таймеры"
        default: break
        }
        return "nil"
    }
    
}
