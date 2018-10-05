//
//  DetailViewController.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailOverviewLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!

    func configureView() {
        // Update the user interface for the detail item.
        if let movie = detailItem {
            if let label = detailTitleLabel {
                label.text = movie.title
            }
            if let label = detailOverviewLabel {
                label.text = movie.overview
            }
            if let label = detailDateLabel {
                label.text = DateFormatter.localizedString(from: movie.release_date, dateStyle:.medium, timeStyle:.none)
            }
            if let imageView = detailImage {
                imageView.loadImageFrom(movie.poster_url, tag: movie.id) {}
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Movie? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}
