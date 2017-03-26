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
        // Configure the container view
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        var containerHeight: CGFloat = 0
        
        
        // Create the line graph chart view and attach a data source
        let chartView: ORKLineGraphChartView = ORKLineGraphChartView()
        chartView.dataSource = CarePlanStoreManager.sharedInstance.insightsData[self.title!]?.0
        
        // Configure the line graph
        chartView.showsVerticalReferenceLines = true
        chartView.showsHorizontalReferenceLines = true
        chartView.axisColor = UIColor.lightGray
        chartView.verticalAxisTitleColor = Colors.turquoise.color
        
        // Size the line graph
        let chartWidth: CGFloat = UIScreen.main.bounds.size.width - 40
        let chartHeight: CGFloat = 150
        chartView.frame.origin = CGPoint(x: 0, y: 0)
        chartView.frame.size = CGSize(width: chartWidth, height: chartHeight)
        
        // Add the line graph as a subview
        containerView.addSubview(chartView)
        containerHeight += chartHeight
        
        
        // Get the associated assessment
        let activityType = ActivityType(rawValue: self.title!)
        if activityType != nil {
            let assessment = CarePlanStoreManager.sharedInstance.assessmentWithType(activityType!)
            let granularity = CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment(self.title!)
            
            if assessment != nil && (assessment?.getInsightGranularity())! != [] {
                // Create the segmented control for displaying data at a specific granularity
                let granularityViewWidth: CGFloat = chartWidth * 0.5
                let granularityViewHeight: CGFloat = 30
                let granularityViewXOffset: CGFloat = (chartWidth - granularityViewWidth) / 2
                let granularityViewYOffset: CGFloat = 10
                let granularityView = UISegmentedControl(items: assessment?.getInsightGranularity())
                granularityView.frame = CGRect(x: granularityViewXOffset, y: granularityViewYOffset + chartHeight, width: granularityViewWidth, height: granularityViewHeight)
                
                if granularity == .None {
                    granularityView.selectedSegmentIndex = 0
                } else {
                    granularityView.selectedSegmentIndex = (assessment?.getInsightGranularity().index(of: granularity.rawValue))!
                }
                
                granularityView.addTarget(self, action: #selector(LineGraphChart.granularityViewChanged), for: .valueChanged)
                
                // Add the segmented control as a subview
                containerView.addSubview(granularityView)
                containerHeight += granularityViewYOffset
                containerHeight += granularityViewHeight
            }
        }
        
        
        // Adjust sizing constraints of container view
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        
        // Return the container view
        return containerView
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func granularityViewChanged(_ sender: UISegmentedControl!) {
        let activityType = ActivityType(rawValue: self.title!)
        let assessment = CarePlanStoreManager.sharedInstance.assessmentWithType(activityType!)
        
        CarePlanStoreManager.sharedInstance.insightsData[self.title!]?.1 = InsightGranularity(rawValue: (assessment?.getInsightGranularity()[sender.selectedSegmentIndex])!)!
        CarePlanStoreManager.sharedInstance.updateInsights()
    }
}
