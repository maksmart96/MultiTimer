//
//  TimerCell.swift
//  MultiTimer
//
//  Created by  Максим Мартынов on 05.02.2022.
//

import UIKit

 class TimerCell: UITableViewCell {
    
     let nameLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 16)
         label.backgroundColor = .green
         label.clipsToBounds = true
         label.text = "TEST"
         label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
     }()
     
     let durationLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 20)
         label.textColor = .blue
         label.backgroundColor = .red
         label.clipsToBounds = true
         label.text = "testlabel.text"
         label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
     }()
     
     let containerView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.clipsToBounds = true // this will make sure its children do not go out of the boundary
       return view
     }()
     
//     var task: MyTask? {
//         didSet {
//             guard let taskItem = task else {
//                 return
//             }
//             if let name = taskItem.name {
//                 nameLabel.text = name
//             }
//             if let duration = taskItem.duration {
//                 durationLabel.text = String(duration)
//             }
//         }
//     }
     
     
    
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         containerView.addSubview(nameLabel)
         containerView.addSubview(durationLabel)
         contentView.addSubview(containerView)
    
         configureLabels()
     }
    
    func configureLabels() {
        
            //MARK: - constraints
        //containerView
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true

        //nameLabel
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        //durationLabel
        durationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        durationLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        durationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        print("закончили с льЕблами")

    }
}

