//
//  ChartsVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/1/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class ChartsVC: UIViewController {
    var x:Int = 0
    var y:Int = 0
    var ChartItem = [Chart]()
    @IBOutlet weak var PieChartView: PieChartView!
    
    var DataEntryX = PieChartDataEntry(value: 0)
    var DataEntryY = PieChartDataEntry(value: 0)
    
    var NumberOfRows = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        UpdateData()
        
        PieChartView.chartDescription?.text = ""
        DataEntryX.value = Double(self.x)
        DataEntryY.value = Double(self.y)
        NumberOfRows = [DataEntryX,DataEntryY]
    }
    
    
    func UpdateData(){
        let chartDataSet = PieChartDataSet(values:NumberOfRows, label:nil)
        let ChartData = PieChartData(dataSet: chartDataSet)
       
//        let colors = [UIColor(named: "black"), UIColor(named: "orange")]
//        chartDataSet.colors = colors as! [NSUIColor]
         PieChartView.data = ChartData
        
        
    }
    
    func GetData(){
        guard let api_User = Services.getApiTell() else {
            return }
        let url = Urls.GetUserDownloadChart
        let ChartURL = url + api_User
        Alamofire.request(ChartURL, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Charts:[Chart] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let Chartitem =  Chart()
                        Chartitem.x = data["x"]?.int ?? 0
                        self.x = Chartitem.x
                        Chartitem.y = data["y"]?.int ?? 0
                        self.y = Chartitem.y
                        Charts.append(Chartitem)
                        print("Chart",data)
                    }
                }
        }
        
    }
    }
    
    
