//
//  MainViewController.swift
//  AccountDays
//
//  Created by binyu on 2021/4/27.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    
    var numberOfDaysInThisMonth: Int{
        let dateComponents = DateComponents(year:currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        print(date)
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        print(range!)
        return range?.count ?? 0
    }
    
    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year: currentYear ,month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var yearMonthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setDate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextMonthButtonPress(_ sender: Any) {
        currentMonth += 1
        if currentMonth > 12 {
            currentMonth = 1
            currentYear += 1
        }
        setDate()
    }
    
    @IBAction func lastMonthButtonPress(_ sender: Any) {
        currentMonth -= 1
        if currentMonth == 0 {
            currentMonth = 12
            currentYear -= 1
        }
        setDate()
    }
    
    func setDate() {
        yearMonthLabel.text = months[currentMonth - 1] + "  \(currentYear)"
        print(currentMonth)
        print(currentYear)
        print(whatDayIsIt)
        calendar.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width
                      , height: 40)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath)
            if let dateLabel = cell.contentView.subviews[0] as? UILabel {
                if indexPath.row < howManyItemsShouldIAdd{
                            dateLabel.text = ""
                        }else{
                            dateLabel.text = "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
                        }
            }
            return cell
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
