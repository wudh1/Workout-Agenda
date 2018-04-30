//
//  WgerExerciseTableViewCell.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/28/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit

class WgerArmExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var equipmentName: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(input: WgerExercise) {
        self.descriptionLabel.text = input.description
        self.exerciseName.text = input.name
        self.equipmentName.text = input.equipment
        load_image1(image_url_string: input.image1)
        load_image2(image_url_string: input.image2)
    }
    
    func load_image1(image_url_string: String)
    {
        let URL_IMAGE = URL(string: image_url_string)
        let task = URLSession.shared.dataTask(with: URL_IMAGE!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                self.imageView1.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func load_image2(image_url_string: String)
    {
        let URL_IMAGE = URL(string: image_url_string)
        let task = URLSession.shared.dataTask(with: URL_IMAGE!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                self.imageView2.image = UIImage(data: data)
            }
        }
        task.resume()
    }

}
