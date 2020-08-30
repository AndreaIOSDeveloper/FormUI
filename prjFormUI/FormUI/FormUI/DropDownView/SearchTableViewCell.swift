//
//  SearchTableViewCell.swift
//  FormUI
//
//  Created by Andrea Di Francia on 04/05/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.fill(view: contentView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), useSafeArea: false)
    }
    
    func configureCell(with title: String) {
        titleLabel.text = title
    }
}

