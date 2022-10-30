//
//  WelcomeViewController.swift
//  nadumkin@edu.hse.ru PW 3
//
//  Created by Никита Думкин on 20.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController{
    
    private let commentLabel = UILabel();
    private let valueLabel = UILabel();
    private let incrementButton = UIButton(type: .system);
    private let colorPaletteView = ColorPaletteView()
    private let notesViewController = NotesViewController();
    var buttonsSV:UIStackView = UIStackView(arrangedSubviews: [])

    
    private var value: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        
        setupColorControlSV() //new
    }
    
    @discardableResult
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentView.addSubview(commentLabel)
        
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])
        
        updateCommentLabel(value)
        
        return commentView
    }
    
    private func setupIncrementButton(){
        incrementButton.setTitle("Increment", for: .normal);
        incrementButton.setTitleColor(.black, for: .normal);
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        
        incrementButton.CALayerShadow(
            width: 5.0,
            height: 5.0,
            color: CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha:1)
        )
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
       
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    
    private func makeMenuButton(title: String,_ bottomTitle: String? = nil) -> UIButton {
        let button = UIButton()
        let label = UILabel();
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        
        if bottomTitle != nil{
            label.text = bottomTitle
            label.textColor = .systemGray
            label.font = .systemFont(ofSize: 12.0)
            label.textAlignment = .center
            button.addSubview(label)
            
            label.pinBottom(to: button, 12)
            label.pinWidth(to: button.widthAnchor)
        }
        
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝", "notes: 0")
        let newsButton = makeMenuButton(title: "📰")
        
        buttonsSV.addArrangedSubview(colorsButton)
        buttonsSV.addArrangedSubview(notesButton)
        buttonsSV.addArrangedSubview(newsButton)
        
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func notesButtonPressed(){
        show(notesViewController, sender: self)
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func newsButtonPressed(){
        let newsListController = NewsListViewController()
        navigationController?.pushViewController(newsListController, animated: true)
    }
    
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    private func setupColorControlSV() { //new
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
        colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
        colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
        colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8)
        ])
        
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
    }
                                            
    @objc
    private func incrementButtonPressed() {
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        self.updateUI()
    }
    
    func updateCommentLabel(_ value: Int) {
        switch value {
            case 0...10:
                commentLabel.text = "1"
            case 10...20:
                commentLabel.text = "2"
            case 20...30:
                commentLabel.text = "3"
            case 30...40:
                commentLabel.text = "4"
            case 40...50:
                commentLabel.text = "! ! ! ! ! ! ! ! ! "
            case 50...60:
                commentLabel.text = "big boy"
            case 60...70:
                commentLabel.text = "70 70 70 moreeeee"
            case 70...80:
                commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
            case 80...90:
                commentLabel.text = "80+\n go higher!"
            case 90...100:
                commentLabel.text = "100!! to the moon!!"
            default:
                break
        }
    }
    
    private func updateUI(){
        valueLabel.text = "\(value)"
        
        if (value-1) % 10 == 0 && value != 1{
            let animation:CATransition = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.type = CATransitionType.push
            animation.subtype = CATransitionSubtype.fromBottom
            animation.duration = 0.4
            updateCommentLabel(value)
            self.commentLabel.layer.add(animation, forKey: CATransitionType.push.rawValue)

            
        }
    }
}
