//
//  FilteredSearchViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/28/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

protocol FilterDataSentDelegate {
    func userDidApplySomeFilter(query: String, genre: String, minRate: Int, quality: String, sortBy: String, orderBy: String)
}

class FilteredSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var movieGenreTextField: UITextField!
    @IBOutlet weak var minRatingLabel: UILabel!
    @IBOutlet weak var sortByCollectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var movieGenrePicker: UIPickerView = UIPickerView()
    
    let genres: [String] = ["All",
         "Action"
        ,"Adventure",
         "Animation",
         "Biography",
         "Comedy",
         "Crime",
         "Documentary",
         "Drama",
         "Family",
         "Fantasy",
         "Film Noir",
         "History",
         "Horror",
         "Music",
         "Musical",
         "Mystery",
         "Romance",
         "Sci-Fi",
         "Short",
         "Sport",
         "Superhero",
         "Thriller",
         "War",
         "Western"]
    
    var movieQuality: String = "All"
    var moviesOrderBy: String = "desc"
    
    
    // the sort by options
    let sortByOptions: [String] = ["date added", "title", "year", "rating", "peers", "seeds", "download count", "like count"]
    
    // the currently selected sort by option
    var sortBySelectedOption: String = "date added"
    
    // define the delegate for this view controller to use it to send data to the previous view controller
    var delegate: FilterDataSentDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfiguration()
    }
    
    
    // MARK: - components init config
    func initConfiguration(){
        self.movieTitleTextField.layer.borderColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        self.movieTitleTextField.layer.borderWidth = 1
        self.movieTitleTextField.layer.cornerRadius = 5
        self.movieTitleTextField.delegate = self
        self.movieTitleTextField.returnKeyType = .done
        
        self.movieGenreTextField.layer.borderColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        self.movieGenreTextField.layer.borderWidth = 1
        self.movieGenreTextField.layer.cornerRadius = 5
        
        self.filterButton.layer.cornerRadius = 5
        
        self.cancelButton.layer.cornerRadius = 5
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        
        // genre picker view delegate and data source
        self.movieGenrePicker.delegate = self
        self.movieGenrePicker.dataSource = self
        
        // set the input of the genre textfield to the picker view
        self.movieGenreTextField.inputView = self.movieGenrePicker
        
        // sort by collection view delegate and data source
        self.sortByCollectionView.dataSource = self
        self.sortByCollectionView.delegate = self
        
        
    }
    
    
    // MARK: - Rating stepper action
    @IBAction func ratingSteperAction(_ sender: UIStepper) {
        // for dismiss the keyboard or the picker
        self.view.endEditing(true)
        
        self.minRatingLabel.text = String(sender.value)
    }
    
    // MARK: - Quality segmented view action
    @IBAction func qualitySegmentedViewAction(_ sender: UISegmentedControl) {
        // for dismiss the keyboard or the picker
        self.view.endEditing(true)
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.movieQuality = "All"
        case 1:
            self.movieQuality = "720p"
        case 2:
            self.movieQuality = "1080p"
        default:
            self.movieQuality = "3D"
        }
    }
    
    // MARK: - Order by segmented view action
    @IBAction func orderBySegmentedViewAction(_ sender: UISegmentedControl) {
        // for dismiss the keyboard or the picker
        self.view.endEditing(true)
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.moviesOrderBy = "desc"
        default:
            self.moviesOrderBy = "asc"
        }
    }
    
    
    // MARK: - Configuration of the genre picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.movieGenreTextField.text = self.genres[row]
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.genres[row]
    }
    
    // MARK: - Configuration of the sort by collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sortByOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortByCell", for: indexPath) as! SortByCollectionViewCell
        
        cell.configure(with: self.sortByOptions[indexPath.row], isSelected: (self.sortBySelectedOption == self.sortByOptions[indexPath.row]))
        cell.initCellDesign()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // for dismiss the keyboard or the picker
        self.view.endEditing(true)
        
        self.sortBySelectedOption = self.sortByOptions[indexPath.row]
        self.sortByCollectionView.reloadData()
    }
    
    // adjust the collection view cell width according to the text on it
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.sortByOptions[indexPath.row].widthGivenFont(40.0, font: UIFont.systemFont(ofSize: 14))
        return CGSize(width: width + 40, height: 40.0)
    }
    
    
    // MARK: - Cancel button action
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        // dismiss this view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Filter button action
    @IBAction func filterButtonAction(_ sender: UIButton) {
        if delegate != nil {
            let query: String = self.movieTitleTextField.text ?? "" == "" ? "0" : self.movieTitleTextField.text!
            let genre: String = self.movieGenreTextField.text ?? "" == "" ? "All" : self.movieGenreTextField.text!
            let minRate: Int = Int(self.minRatingLabel.text ?? "0") ?? 0
            
            // pass the filter data to the delegate
            delegate?.userDidApplySomeFilter(query: query, genre: genre.lowercased(), minRate: minRate, quality: self.movieQuality, sortBy: self.sortBySelectedOption.replacingOccurrences(of: " ", with: "_"), orderBy: self.moviesOrderBy)
            
            // dismiss this view controller
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // this for dismiss the keyboard when the user press Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // for dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }

    // this is for preventiong the current view controller only from rotation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


