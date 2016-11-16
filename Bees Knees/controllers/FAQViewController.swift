//
//  FAQViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class FAQViewController: UITableViewController {
    
    // Data source
    var dataSource = [FAQItem]()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Add the FAQs
        dataSource.append(FAQItem(question: "How long will I experience pain pre surgery?", answer: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."))
        dataSource.append(FAQItem(question: "How long will I experience pain post surgery?", answer: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."))
        dataSource.append(FAQItem(question: "How long does surgery take?", answer: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."))
        dataSource.append(FAQItem(question: "What color is the sky", answer: "Blue."))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        // Customize the table view
        self.tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Hide the footer
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Table View Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the data source and cell
        let data = dataSource[indexPath.row]
        
        // Return cell's height, based on expanded state
        return data.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source
        let data = dataSource[indexPath.row]
        
        // Get the cell
        let cell: FAQTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FAQTableViewCell
        cell.question.text = data.question
        cell.answer.text = data.answer
        cell.selectionStyle = .none
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the data source and cell
        let data = dataSource[indexPath.row]
        let cell = (self.tableView.cellForRow(at: indexPath) as! FAQTableViewCell)
        
        // Toggle the cell
        data.expanded = !data.expanded
        data.height = cell.getHeight(data.expanded)
        if data.expanded! {
            cell.select()
        }
        else {
            cell.deselect()
        }
        
        // Perform table view updates
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
