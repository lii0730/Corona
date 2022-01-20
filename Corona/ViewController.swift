//
//  ViewController.swift
//  Corona
//
//  Created by LeeHsss on 2022/01/17.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pieChartView.delegate = self
        
        loadDataAndParsingData()
        initPieChartView()
        
    }
    
    private func initPieChartView() {
        self.pieChartView.noDataText = "데이터가 없습니다."
        self.pieChartView.noDataFont = .systemFont(ofSize: 20)
        self.pieChartView.noDataTextColor = .lightGray
    }


    private func loadDataAndParsingData() {
        //MARK: Alamofire를 통해 데이터 수신
        AF.request(URL.REQUEST_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: DataResponse.self) { [weak self] response in
                switch response.result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.parsingData(response: response)
                        self?.setPieChartView(response: response)
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
    
    private func parsingData(response: DataResponse) {
        //MARK: 데이터를 파싱
        self.newCaseLabel.text = "\(response.korea.totalCase) 명"
        self.totalCaseLabel.text = "\(response.korea.newCase) 명"
    }
    
    private func setPieChartView(response: DataResponse) {
        var dataSet: [PieChartDataEntry] = []
        
        dataSet.append(createData(data: response.seoul))
        dataSet.append(createData(data: response.busan))
        dataSet.append(createData(data: response.daegu))
        dataSet.append(createData(data: response.incheon))
        dataSet.append(createData(data: response.gwangju))
        dataSet.append(createData(data: response.daejeon))
        dataSet.append(createData(data: response.ulsan))
        dataSet.append(createData(data: response.sejong))
        dataSet.append(createData(data: response.gyeonggi))
        dataSet.append(createData(data: response.gangwon))
        dataSet.append(createData(data: response.chungbuk))
        dataSet.append(createData(data: response.chungnam))
        dataSet.append(createData(data: response.jeonbuk))
        dataSet.append(createData(data: response.jeonnam))
        dataSet.append(createData(data: response.gyeongbuk))
        dataSet.append(createData(data: response.gyeongnam))
        dataSet.append(createData(data: response.jeju))
        
        
        let chartDataSet: PieChartDataSet = PieChartDataSet(entries: dataSet, label: "코로나 발생 현황")
        
        chartDataSet.valueTextColor = .black
        chartDataSet.entryLabelColor = .black
        chartDataSet.sliceSpace = 1
        chartDataSet.xValuePosition = .outsideSlice
        chartDataSet.valueLinePart1OffsetPercentage = 0.6
        chartDataSet.valueLinePart1Length = 0.2
        chartDataSet.valueLinePart2Length = 0.3
        
        chartDataSet.colors = ChartColorTemplates.colorful() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.material() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.vordiplom()
        
        let data = PieChartData(dataSet: chartDataSet)
        self.pieChartView.data = data
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    
    private func createData(data: CoronaData) -> PieChartDataEntry {
        return PieChartDataEntry(value: data.newCase.toDouble, label: data.countryName, data: data)
    }
}

extension String {
    var toDouble: Double {
        return (self as NSString).doubleValue
    }
}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let selectedEntry = entry as? PieChartDataEntry else { return }
        guard let selectedCountryData = selectedEntry.data as? CoronaData else { return }
        
        //MARK: 선택된 데이터를 가지고, 상세화면 표시
        //MARK: ViewController와 NavigationView를 연결?
        
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.coronaData = selectedCountryData
            detailViewController.navigationItem.title = selectedCountryData.countryName
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
            
    }
}

