//
//  TableViewExampleViewController.swift
//  LoadingPlaceholderViewDemo
//
//  Created by Mario on 04/05/2018.
//  Copyright © 2018 Mario. All rights reserved.
//

import UIKit

class TableViewExampleViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var numberOfSections = 2
    private var numberOfRows = 5
    private var loadingPlaceholderView = LoadingPlaceholderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingPlaceholderView()
//        performFakeNetworkRequest()
    }
    
    private func performFakeNetworkRequest() {
        // simulate network request
        loadingPlaceholderView.startLoading(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) { [weak self] in
            self?.finishFakeRequest()
        }
    }
    
    private func finishFakeRequest() {
        self.numberOfSections = 2
        self.numberOfRows = 5
        self.tableView.reloadData()
        self.loadingPlaceholderView.stopLoading(animated: true)
    }
    
    private func setupLoadingPlaceholderView() {
        loadingPlaceholderView.configuration.gradientColor = .white
        loadingPlaceholderView.configuration.backgroundColor = .white
        loadingPlaceholderView.cover(view)
    }
    
    @IBAction private func showLoaderButtonTapped() {
        performFakeNetworkRequest()
    }
    
    @IBAction private func hideLoaderButtonTapped() {
        finishFakeRequest()
    }
    
}

extension TableViewExampleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier = ""
        if indexPath.item < 2 {
            cellIdentifier = "AvatarAndLabelCell"
        } else {
            cellIdentifier = "TextViewAndSegmentControllCell"
        }
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    }
    
}

class AvatarAndLabelCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var simpleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
    }
    
}

class TextViewAndSegmentControllCell: UITableViewCell {
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
}
