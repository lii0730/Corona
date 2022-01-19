//
//  DataResponseModel.swift
//  Corona
//
//  Created by LeeHsss on 2022/01/18.
//

import Foundation

struct DataResponse: Codable {
    let resultCode: String
    let resultMessage: String
    let korea: CoronaData
    let seoul: CoronaData
    let busan: CoronaData
    let daegu: CoronaData
    let incheon: CoronaData
    let gwangju: CoronaData
    let daejeon: CoronaData
    let ulsan: CoronaData
    let sejong: CoronaData
    let gyeonggi: CoronaData
    let gangwon: CoronaData
    let chungbuk: CoronaData
    let chungnam: CoronaData
    let jeonbuk: CoronaData
    let jeonnam: CoronaData
    let gyeongbuk: CoronaData
    let gyeongnam: CoronaData
    let jeju: CoronaData
    let quarantine: CoronaData
}

struct CoronaData: Codable {
    let countryName: String
    let newCase: String
    let totalCase: String
    let recovered: String
    let death: String
    let percentage: String
    let newCcase: String
    let newFcase: String
    
    let count: Int = 8
}

