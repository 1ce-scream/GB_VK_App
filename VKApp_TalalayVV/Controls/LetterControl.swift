//
//  LettersControl.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.09.2021.
//

import UIKit

/// Контрол для перехода по начальной букве имени
class LettersControl: UIControl {
    
    // MARK: -Properties
    
    /// Нажатая кнопка (буква)
    var selectedLetter: Character? = nil {
        didSet{
            self.sendActions(for: [.touchUpInside])
        }
    }
    
    /// Массив с начальными буквами имен
    var arrChar = [Character]() {
        didSet{
            self.setupView()
        }
    }
    
    // MARK: -Private properties
    
    /// Массив кнопок для начальных букв имен
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    // MARK: -Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }
    
    // MARK: -Private methods
    
    private func setupView(){
        for letter in arrChar {
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setTitle(String(letter.uppercased()), for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemRed, for: .highlighted)
            button.addTarget(self, action: #selector(selectedLetter(_:)), for: [.touchUpInside])
            self.buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    // MARK: -Actions
    
    @objc private func selectedLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        let letter = arrChar[index]
        self.selectedLetter = letter
    }
}
