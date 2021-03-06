//
//  CoursesTableViewController.swift
//  UniQuiziOS
//
//  Created by Pedro Neto on 10/09/17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    var courses = [Course]()
    var fieldPk : Int?
    
    func getCourses(){
        guard let url = URL(string: Properties.getCourseURL(field:(fieldPk)!)) else {return}
        print(url)
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response else {
                return
            }
            print(response)
            if let data = data {
                self.courses.removeAll()
                do{
                    let newItems = try  JSONDecoder().decode([Course].self, from: data)
                    self.courses += newItems
                }
                catch{
                    print("Unable to decode")
                }
                DispatchQueue.main.sync {
                    self.refreshControl?.beginRefreshing()
                    self.tableView?.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
            }.resume()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCourses()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell", for: indexPath) as! CoursesTableViewCell

        cell.courseName.text = courses[indexPath.row].courseName

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? QuizFromCourseTableViewController
        guard let selectedCell = sender as? CoursesTableViewCell else {
            return
        }
        guard let indexPath = tableView.indexPath(for: selectedCell) else {
            return
        }
        destination?.coursePk = self.courses[indexPath.row].pk
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
