//
//  DetailViewController.swift
//  Corona
//
//  Created by LeeHsss on 2022/01/19.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var coronaData: CoronaData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "tabelViewCell", for: indexPath) as? MyCell else { return MyCell() }
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "신규 확진자"
            cell.valueLabel.text = "\(self.coronaData.newCase) 명"
        case 1:
            cell.nameLabel.text = "확진자"
            cell.valueLabel.text = "\(self.coronaData.totalCase) 명"
        case 2:
            cell.nameLabel.text = "완치자"
            cell.valueLabel.text = "\(self.coronaData.recovered) 명"
        case 3:
            cell.nameLabel.text = "사망자"
            cell.valueLabel.text = "\(self.coronaData.death) 명"
        case 4:
            cell.nameLabel.text = "발생률"
            cell.valueLabel.text = "\(self.coronaData.percentage)%"
        case 5: cell.nameLabel.text = "신규 확진자"
            cell.nameLabel.text = "해외유입 신규 확진자"
            cell.valueLabel.text = "\(self.coronaData.newFcase) 명"
        case 6:
            cell.nameLabel.text = "지역발생 신규 확진자"
            cell.valueLabel.text = "\(self.coronaData.newCcase) 명"
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coronaData.count - 1
    }
}
