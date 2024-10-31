//
//  checkBoxAsset.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit

class checkBoxAsset: UIButton {
    var onCheckedCheckBox: ((Bool) -> Void)?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setup()
    }
    
    private func updateAppearance() {
        if isChecked {
            self.setTitle("", for: .normal)
            self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            self.tintColor = UIColor.systemBlue
        } else {
            self.setTitle("", for: .normal)
            self.setImage(UIImage(systemName: "square"), for: .normal)
            self.tintColor = UIColor(hex: "#9CE0FB")!
        }
    }
    
    var isChecked: Bool = false{
        didSet{
            updateAppearance()
        }
    }
    
    @objc private func toggle(){
        isChecked.toggle()
        onCheckedCheckBox?(isChecked)
    }
    
    private func setup(){
        self.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        updateAppearance()
    }
}

