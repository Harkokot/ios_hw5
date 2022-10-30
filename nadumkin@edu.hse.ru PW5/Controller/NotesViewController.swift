//
//  NotesViewController.swift
//  nadumkin@edu.hse.ru PW4
//
//  Created by Никита Думкин on 09.10.2022.
//

import UIKit
import Foundation

final class NotesViewController: UIViewController{
//    private var dataSource = [
//        ShortNote(text: "aababbabab abababba abababab abababab ababa ba"),
//        ShortNote(text: "b"),
//        ShortNote(text: "c")
//    ]
    
    let cellId = "MyCell"
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
        if let data = UserDefaults.standard.object(forKey: "dataSource") as? Data,
           let category = try? JSONDecoder().decode([ShortNote].self, from: data) {
            dataSource = category
        }
    }
    
    private func setupView(){
        setupTableView()
        setupNavBar()
    }
    
    private func setupNavBar(){
        self.title = "Notes"
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc
    func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView(){
        tableView.register(NoteCell.self , forCellReuseIdentifier: cellId)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.pin(to: self.view, [.right, .left, .top, .bottom])
    }
}

//MARK: - "NotesViewController dataSource extension"
extension NotesViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell{
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        
        return UITableViewCell()
    }
    
    private func handleDelete(indexPath: IndexPath){
            dataSource.remove(at: indexPath.row)
            saveObj()
            tableView.reloadData()
    }
    
    private func saveObj(){
        if let encoded = try? JSONEncoder().encode(dataSource) {
            UserDefaults.standard.set(encoded, forKey: "dataSource")
        }
    }
    
}

extension NotesViewController: AddNoteDelegate{
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        saveObj()
        tableView.reloadData()
    }
}

//MARK: - "NotesViewController deligate extension"
extension NotesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section != 0{
            let deleteAction = UIContextualAction(style: .destructive, title: .none){
                [weak self] (action, view, completion) in
                self?.handleDelete(indexPath: indexPath)
                completion(true)
            }
            deleteAction.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white)
            deleteAction.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        else{
            return nil
        }
    }
    
}
