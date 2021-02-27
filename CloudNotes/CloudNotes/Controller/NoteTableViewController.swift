//
//  NoteTableViewController.swift
//  CloudNotes
//
//  Created by 김태형 on 2021/02/15.
//

import UIKit
import CoreData

final class NoteTableViewController: UITableViewController {
    // MARK: - Property
    private var noteList: [NSManagedObject] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        registerCell()
        configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCoreData()
        tableView.reloadData()
    }
    
    // MARK: - UI
    private func registerCell() {
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
    }
    
    private func configureNavigationItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = NoteString.memo
    }
    
    @objc private func touchUpAddButton() {
        let detailView = DetailViewController()
        splitViewController?.showDetailViewController(detailView, sender: nil)
        
        saveData(EntityString.newNote)
        tableView.reloadData()
    }
    
    private func loadCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: EntityString.entityName)
        
        do {
            noteList = try managedContext.fetch(request)
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error)")
        }
    }
    
    private func saveData(_ data: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: EntityString.entityName, in: managedContext) else {
            return
        }
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        let splitedData = data.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
        
        note.setValue(splitedData[0], forKey: EntityString.title)
        note.setValue(splitedData[1], forKey: EntityString.body)
        note.setValue((Date()), forKey: EntityString.lastModified)
        
        do {
            try managedContext.save()
            noteList.append(note)
        } catch let error as NSError {
            debugPrint("Could not save. \(error)")
        }
    }

}

// MARK: - DataSource
extension NoteTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else {
            debugPrint(ErrorCase.cellError.localizedDescription)
            return UITableViewCell()
        }
        let note = noteList[indexPath.row]
        cell.configure(note)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            debugPrint("여기 이 \(indexPath.row)에 대해 삭제기능 넣어야함")
        }
    }
}

// MARK: - Delegate
extension NoteTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        detailView.note = noteList[indexPath.row]
        splitViewController?.showDetailViewController(detailView, sender: nil)
    }
}
