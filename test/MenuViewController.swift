//
//  MenuViewController.swift
//  MenuViewController
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class MenuViewController: UIViewController {
    public private(set) var tableView: UITableView!
    
    private var identifier: String {
        return String(describing: MenuTableViewCell.self)
    }
    
    //MARK: - Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.register(MenuTableViewCell.self)
        for nib in nibs() {
            tableView.register(nib)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        view.addSubview(tableView)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    //MARK: - Public
    
    public func nibs() -> [UITableViewCell.Type] {
        return []
    }
    
    public func dataSource() -> [String] {
        return []
    }
    
    public func customCell(at indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        /* Abstract. */
    }
    
    //MARK: - Private
    
    private func title(at indexPath: IndexPath) -> String? {
        let row = indexPath.row
        let array = dataSource()
        if row < array.count {
            return array[row]
        }
        return nil
    }
}

extension MenuViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource().count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = customCell(at: indexPath) {
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MenuTableViewCell
        cell.title = title(at: indexPath)
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }
}
