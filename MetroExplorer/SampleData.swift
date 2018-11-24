//
//  SampleData.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/13/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

final class SampleData {

    static func generateStationsData() -> [NearestStation] {
      return [
        NearestStation(name: "Foggybottom", area: "Washington D.C."),
        NearestStation(name: "PentagonCity", area: "Arlington")
        ]
    }

}
