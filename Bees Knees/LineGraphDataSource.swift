//
//  LineGraphDataSource.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 12/21/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


class LineGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    
    var plotPoints = [
        [
            ORKValueRange(minimumValue: 1, maximumValue: 2),
            ORKValueRange(minimumValue: 3, maximumValue: 4),
            ORKValueRange(minimumValue: 4, maximumValue: 5),
            ORKValueRange(minimumValue: 1, maximumValue: 2),
            ORKValueRange(minimumValue: 3, maximumValue: 3),
            ORKValueRange(minimumValue: 5, maximumValue: 6),
            ORKValueRange(minimumValue: 2, maximumValue: 3)
            /*ORKValueRange(value: 2),
            ORKValueRange(value: 4),
            ORKValueRange(value: 5),
            ORKValueRange(value: 2),
            ORKValueRange(value: 3),
            ORKValueRange(value: 6),
            ORKValueRange(value: 3)*/
        ],
        [
            ORKValueRange(minimumValue: 0, maximumValue: 1),
            ORKValueRange(minimumValue: 2, maximumValue: 3),
            ORKValueRange(minimumValue: 3, maximumValue: 4),
            ORKValueRange(minimumValue: 0, maximumValue: 1),
            ORKValueRange(minimumValue: 1, maximumValue: 2),
            ORKValueRange(minimumValue: 4, maximumValue: 5),
            ORKValueRange(minimumValue: 3, maximumValue: 4)
            /*ORKValueRange(value: 1),
            ORKValueRange(value: 3),
            ORKValueRange(value: 4),
            ORKValueRange(value: 1),
            ORKValueRange(value: 2),
            ORKValueRange(value: 5),
            ORKValueRange(value: 4)*/
        ]
    ]
    
    
    // MARK: - Graph Chart View Data Source Methods
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        print(plotIndex, pointIndex)
        print(plotPoints[plotIndex][pointIndex])
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 10
    }
    
    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Sun"
        case 1:
            return "Mon"
        case 2:
            return "Tue"
        case 3:
            return "Wed"
        case 4:
            return "Thu"
        case 5:
            return "Fri"
        case 6:
            return "Sat"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
    
    /*func graphChartView(_ graphChartView: ORKGraphChartView, drawsPointIndicatorsForPlotIndex plotIndex: Int) -> Bool {
        if plotIndex == 1 {
            return false
        }
        return true
    }*/
    
    func graphChartView(_ graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        if plotIndex == 0 {
            return UIColor.purple
        }
        return UIColor.blue
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, drawsPointIndicatorsForPlotIndex plotIndex: Int) -> Bool {
        return true
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, fillColorForPlotIndex plotIndex: Int) -> UIColor {
        return UIColor.red
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, drawsVerticalReferenceLineAtPointIndex pointIndex: Int) -> Bool {
        return true
    }
}
