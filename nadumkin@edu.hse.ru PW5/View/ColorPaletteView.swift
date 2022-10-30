//
//  ColorPaletteView.swift
//  nadumkin@edu.hse.ru PW 3
//
//  Created by Никита Думкин on 29.09.2022.
//

import UIKit

final class ColorPaletteView: UIControl{
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray
    
    init(){
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView(){
        let redControl = ColorSliderView(colorName: "Red", value: Float(UIColor.systemGray6.redComponent))
        let greenControl = ColorSliderView(colorName: "Green", value: Float(UIColor.systemGray6.greenComponent))
        let blueControl = ColorSliderView(colorName: "Blue", value: Float(UIColor.systemGray6.blueComponent))
        
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
            $0.addTarget(self, action: #selector(sliderTouched), for: .touchDown)
        }
        
        addSubview(stackView)
        
        stackView.pin(to: self) //
    }
        
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.greenComponent,
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        case 1:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: CGFloat(slider.value),
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        default:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: chosenColor.greenComponent,
                blue: CGFloat(slider.value),
                alpha: chosenColor.alphaComponent
            )
            
        }
        sendActions(for: .touchDragInside)
    }
    
    @objc
    private func sliderTouched(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
