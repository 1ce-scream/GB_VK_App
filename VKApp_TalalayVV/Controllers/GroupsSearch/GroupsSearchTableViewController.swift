//
//  GroupsSearchTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsSearchTableViewController: UITableViewController {
    
    var someGroups = [
        Group(id: 4444, name: "Group 4", logo: UIImage(named: "group4")),
        Group(id: 5555, name: "Group 5", logo: UIImage(named: "group5")),
        Group(id: 6666, name: "Group 6", logo: UIImage(named: "group6"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        someGroups.count
    }


    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "groupSearchCells",
            for: indexPath) as? GroupsSearchCell
        else { return UITableViewCell() }

        cell.configure(group: someGroups[indexPath.row])

        return cell
    }

    // Метод выделения ячейки
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        //defer конструкция которая всегда выполняется в конце кода
        //в независимоти от места ее написания
        defer {
            //метод для снятия выделения с ячейки
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
