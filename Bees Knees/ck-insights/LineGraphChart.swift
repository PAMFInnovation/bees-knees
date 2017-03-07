//
//  LineGraphChart.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 12/21/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


class LineGraphChart: OCKChart {
    
    // Data source
    var dataSource: LineGraphDataSource?
    
    
    override func chartView() -> UIView {
        // Create the line graph chart view
        let chartView: ORKLineGraphChartView = ORKLineGraphChartView()
        
        // Attach a data source
        chartView.dataSource = CarePlanStoreManager.sharedInstance.insightsData[self.title!]
        
        // Configure it
        chartView.showsVerticalReferenceLines = true
        chartView.showsHorizontalReferenceLines = true
        chartView.axisColor = UIColor.lightGray
        chartView.verticalAxisTitleColor = Colors.turquoise.color
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        chartView.widthAnchor.constraint(equalToConstant: 375).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        /*let label: UILabel = UILabel(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
        label.text = "fdsafdsa"
        label.backgroundColor = UIColor.yellow
        chartView.addSubview(label)*/
        
        // Return the container view
        return chartView
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
