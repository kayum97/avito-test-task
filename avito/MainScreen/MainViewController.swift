//
//  ViewController.swift
//  avito
//
//  Created by Admin on 29.12.2020.
//

import UIKit

protocol MainViewControllerProtocol: class {
    func showResult(_ result: ResultModel)
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol!
    
    private var proposalsResult: ResultModel? = nil
    
    private var closeButton = UIButton()
    
    private var screenTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        return label
    }()
    
    private var listOfProposals: UITableView = {
        var tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        return tableView
    }()
    
    private var submitButton = UIButton()
    
    private var isAnyProposalSelected: Bool {
        proposalsResult?.list.first(where: { $0.isSelected }) == nil ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        configureCloseButton()
        configureScreenTitle()
        configureTableView()
        configureSubmitButton()
        
        submitButton.addTarget(self, action: #selector(tapOnTheSelectButton), for: .allTouchEvents)
        
        presenter.getAllProposals()
    }
    
    @objc private func tapOnTheSelectButton() {
        guard let list = proposalsResult?.list else { return }
        isAnyProposalSelected ? presenter.tapOnSubmitButton(proposals: list) : presenter.toContinueWithoutChanges()
    }
    
    private func createUI() {
        view.addSubview(closeButton)
        view.addSubview(screenTitle)
        view.addSubview(listOfProposals)
        view.addSubview(submitButton)
    }
    
    private func configureCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        closeButton.imageView?.contentMode = .scaleAspectFill
        closeButton.tintColor = .black
        
        
        NSLayoutConstraint.activate([
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15.0),
            closeButton.widthAnchor.constraint(equalToConstant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureScreenTitle() {
        NSLayoutConstraint.activate([
            screenTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            screenTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            screenTitle.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30.0)
        ])
    }
    
    private func configureTableView() {
        listOfProposals.translatesAutoresizingMaskIntoConstraints = false
        listOfProposals.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifierForTableView)
        listOfProposals.backgroundColor = .clear
        listOfProposals.rowHeight = UITableView.automaticDimension
        listOfProposals.delegate = self
        listOfProposals.dataSource = self
        listOfProposals.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            listOfProposals.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            listOfProposals.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            listOfProposals.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20.0),
            listOfProposals.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -10.0)
        ])
    }
    
    private func configureSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.masksToBounds = false
        submitButton.backgroundColor = .lightBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitleColor(.lemonChiffon, for: .highlighted)
        
        NSLayoutConstraint.activate([
            submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            submitButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proposalsResult?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifierForTableView, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.data = proposalsResult?.list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let isSelectList = proposalsResult?.list[indexPath.row].isSelected else { return }
        proposalsResult?.list[indexPath.row].isSelected = !isSelectList
        
        isAnyProposalSelected ? submitButton.setTitle(proposalsResult?.selectedActionTitle, for: .normal) : submitButton.setTitle(proposalsResult?.actionTitle, for: .normal)
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func showResult(_ result: ResultModel) {
        self.proposalsResult = result
        screenTitle.text = proposalsResult?.title
        isAnyProposalSelected ? submitButton.setTitle(proposalsResult?.selectedActionTitle, for: .normal) : submitButton.setTitle(proposalsResult?.actionTitle, for: .normal)
        listOfProposals.reloadData()
    }
}
