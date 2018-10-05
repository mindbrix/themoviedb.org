//
//  MasterViewController.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        API.getNowPlaying() { results in
            self.objects = results
            self.tableView.reloadData()
            
            API.getDetails(id: results[0].id) { details in
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = movie
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movie = objects[indexPath.row]
        cell.textLabel!.text = movie.title
    
        // Asynchronous image loading
        //  - use cell.tag as a unique key to ensure the image matches the cell
        //  - not enought time to implement async image decompression via ImageIO
        cell.tag = movie.id
        DispatchQueue.global(qos: .userInteractive).async { [id = movie.id, url = movie.poster_url] in
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                if (cell.tag == id) {
                    cell.imageView!.image = UIImage(data: imageData)
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
}
