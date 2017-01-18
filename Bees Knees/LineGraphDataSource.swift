//
//  LineGraphDataSource.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 12/21/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import ResearchKit


class LineGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    
    // MARK: - Members
    var plotPoints: [ORKValueRange] = []
    var labels: [String] = []
    
    
    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    init(_ plotPoints: [ORKValueRange], labels: [String]) {
        self.plotPoints = plotPoints
        self.labels = labels
        
        super.init()
    }
    
    
    // MARK: - Graph Chart Delegate
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return 1
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints.count
    }
    
    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 10
    }
    
    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return self.labels[pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        switch plotIndex {
        case 0:
            return Colors.turquoiseLight1.color
        case 1:
            return UIColor.blue
        case 2:
            return UIColor.green
        default:
            return UIColor.black
        }
    }
}
