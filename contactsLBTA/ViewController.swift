//
//  ViewController.swift
//  contactsLBTA
//
//  Created by cristian ayala on 1/1/20.
//  Copyright © 2020 cristian ayala. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let CELLID = "cellId"

    
//    var twoDimensionalArray = [["Amy","Bill","Zack","Steve","Jack","Jill","Mary"],["Carl","Chris","Christina","Cameron"],["David","Dan","Dennis"],["Carl","Chris","Christina","Cameron"],["Carl","Chris","Christina","Cameron"],["Carl","Chris","Christina","Cameron"]]
    
    var twoDimensionalArray = [ExpandableNames(isExpanded: true, names: ["Amy","Bill","Zack","Steve","Jack","Jill","Mary"]),ExpandableNames(isExpanded: true, names: ["Carl","Chris","Christina","Cameron"])]
    
    
    var showIndexPath = false
    
//    @objc func handleShowIndexPath(){
//
//
//        var indexPathsToReload = [IndexPath]()
//
//        for section in twoDimensionalArray.indices{
//            for row in twoDimensionalArray[section].names.indices {
//                let indexPath = IndexPath(row: row, section: section)
//                indexPathsToReload.append(indexPath)
//            }
//        }
//        showIndexPath = !showIndexPath
//
//        let animationStyle = showIndexPath ? UITableView.RowAnimation.right : .left
//
//        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
//    }
    
    @objc func handleExpandClose(button : UIButton){
        // close the section first
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices{
            print(0,row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .none)
        }
        else{
            tableView.insertRows(at: indexPaths, with: .none)
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationItem.title = "Contacts"

//        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELLID)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        return twoDimensionalArray[section].names.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = "\(name) section: \(indexPath.section) Row : \(indexPath.row)"
        
        return cell
    }

}

