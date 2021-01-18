//
//  String.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 17/1/21.
//

import Foundation

extension String {
    func formatedStringDate(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = fromFormat
        guard let date = dateFormat.date(from: self) else {return ""}
        dateFormat.dateFormat = toFormat
        return dateFormat.string(from: date)
    }
}
