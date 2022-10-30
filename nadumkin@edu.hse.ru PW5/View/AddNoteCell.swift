//
//  AddNoteCell.swift
//  nadumkin@edu.hse.ru PW4
//
//  Created by Никита Думкин on 10.10.2022.
//

import UIKit

protocol AddNoteDelegate: AnyObject{
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    var delegate: AddNoteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView(){
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.text = "Write your note here..."
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setHeight(to: 140)
        textView.delegate = self
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    private func clearTextView(){
        textView.text = "Write your note here..."
        textView.textColor = UIColor.lightGray
    }
    
    private func updateUI(){
        addButton.isEnabled = false
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton){
        if textView.text == "" || textView.text == "Write your note here..."{
            
        }
        else{
            delegate?.newNoteAdded(note: ShortNote(text: textView.text))
            clearTextView()
        }
    }
}
//MARK: - "AddNoteCellDelegate"
extension AddNoteCell: UITextViewDelegate{
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Placeholder"
                textView.textColor = UIColor.lightGray
        }
    }
}
