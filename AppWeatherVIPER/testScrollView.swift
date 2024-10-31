//
//  testScrollView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 26/10/24.
//

import Foundation
import UIKit

class testScrollView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        // Tampilkan kembali Navigation Bar ketika kembali ke halaman sebelumnya
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
}

