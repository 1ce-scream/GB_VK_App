//
//  LettersControl.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.09.2021.
//

import UIKit

/// Контрол для перехода по начальной букве имени
class LettersControl: UIControl {
    
    // MARK: Properties
    
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
    
    // MARK: Private properties
    
    /// Массив кнопок для начальных букв имен
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    // MARK: Lifecycle
    
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
    
    // MARK: Private methods
    
    private func setupView(){
        // Добавляем кнопки в массив
        for letter in arrChar {
            // Инициализация экземпляра кнопки типа system
            let button = UIButton(type: .system)
            // Цвет фона кнопки
            button.backgroundColor = .clear
            // Заголовок кнопки
            button.setTitle(String(letter.uppercased()), for: .normal)
            // Цвет заголовка в обычном состоянии
            button.setTitleColor(.systemBlue, for: .normal)
            // Цвет заголовка в нажатом состоянии
            button.setTitleColor(.systemRed, for: .highlighted)
            // Задаем действие при нажатии на кнопку
            button.addTarget(self, action: #selector(selectedLetter(_:)), for: [.touchUpInside])
            // Добавляем кнопку в массив
            self.buttons.append(button)
        }
        // Добавляем в стэквью массив кнопок
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        // Расстояние между кнопками
        stackView.spacing = 0
        // Ориентация стэка
        stackView.axis = .vertical
        // Расположение кнопок по центру
        stackView.alignment = .center
        // Расзмер кнопок одинаковый
        stackView.distribution = .fillEqually
    }
    
    // MARK: Actions

    private func updateSelectView() {
        for (index, button) in self.buttons.enumerated() {
            let letter = arrChar[index]
            button.isSelected = letter == self.selectedLetter
        }
    }
    
    @objc private func selectedLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        let letter = arrChar[index]
        self.selectedLetter = letter
    }
}
