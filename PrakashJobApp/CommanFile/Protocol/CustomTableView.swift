//
//  CustomTableView.swift
//  ProjectSetUp
//
//  Created by PSSPL on 17/05/22.
//

import UIKit

protocol CustomTableView {
    func numberofRows() -> Int
    func itemAtIndex<T>(index:Int) -> T
    func heightForRow() -> CGFloat
}
