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
    
    override func chartView() -> UIView {
        
        // Create the line graph chart view
        let view: ORKLineGraphChartView = ORKLineGraphChartView()
        
        // Attach a data source
        let dataSource: LineGraphDataSource = LineGraphDataSource()
        view.dataSource = dataSource
        view.noDataText = "fck you"
        
        // Configure it
        view.showsVerticalReferenceLines = true
        view.showsHorizontalReferenceLines = true
        view.axisColor = UIColor.white
        view.verticalAxisTitleColor = UIColor.orange
        //view.scrubberLineColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // Return the view
        return view
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
