//
//  FAQViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class FAQViewController: UITableViewController {
    
    // Data source
    var dataSource = [FAQItem]()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Add the FAQs
        dataSource.append(FAQItem(question: "Will the operation relieve my knee pain? What are the benefits?", answer: "The goal of surgery is to relieve pain, improve function and increase activities of daily living. You will have discomfort related to the surgery, but while hospitalized, you will be on a pain control program. This pain should decrease as healing progresses. Your doctor will prescribe pain medication. Your progress will vary depending upon the severity of your condition, general health and activity level prior to surgery, and your ability to carry out the instructions after surgery."))
        dataSource.append(FAQItem(question: "How long is the surgery?", answer: "The surgery time can range from 1.5 to 2.5 hours."))
        dataSource.append(FAQItem(question: "How soon will I get out of bed? When can I use the toilet or commode?", answer: "Depending on your physician’s orders, you will be assisted to sit at the edge of the bed and helped out of bed the day of surgery. Early mobilization is the best defense for preventing complications following joint replacement. Staff will get you up day of surgery and help you walk to the bathroom as your comfort level allows. You will continue to be assisted by staff as needed."))
        dataSource.append(FAQItem(question: "How long will I be in the hospital?", answer: "You can expect to be in the hospital approximately 2 to 3 days."))
        dataSource.append(FAQItem(question: "Can my family visit me in the hospital?", answer: "Yes, there are no limitations for families visiting. They are encouraged to participate and learn about your care to be comfortable with the instructions for your recovery. They are your best help at home."))
        dataSource.append(FAQItem(question: "Will I be able to return to my home directly from the hospital?", answer: "Most patients return home with family or friends to help for a week or so. Some require a short stay in a Skilled Nursing Facility (SNF) or Acute Rehabilitation Unit before going home. Our case manager will work with you and your family to confirm your discharge plans"))
        dataSource.append(FAQItem(question: "What kind of assistance will be needed?", answer: "Initially you may need help with cooking, housework, shopping, laundry, bathing, and transportation. If you do not have family or friends to assist you, you may need to arrange for home care from a private home care agency or arrange for a short stay in a SNF, Acute Rehab Unit, or an extended care facility. The case manager in the hospital will assist you with this."))
        dataSource.append(FAQItem(question: "Should I exercise before the surgery?", answer: "Yes, keeping your muscles \"fit\" will promote a better and faster recovery. This packet offers a few exercises that you can do at home prior to your surgery to help keep your muscles in shape. You may also enroll in our Pre-Op Total Hip and Knee Exercise Class."))
        dataSource.append(FAQItem(question: "What else can I do to improve my recovery from surgery?", answer: "Stop smoking, avoid alcoholic beverages, eat a nutritious diet, and follow your doctor's orders."))
        dataSource.append(FAQItem(question: "Will my insurance pay for help at home?", answer: "Talk with a representative from your insurance health plan, prior to hospitalization to understand your benefits. The case manager will assist you during your stay in the hospital with your home care and equipment needs."))
        dataSource.append(FAQItem(question: "What equipment is typically covered by most insurance plans?", answer: "Most insurance plans cover a wheeled walker and a bedside commode. In the rare event you need a wheelchair or hospital bed, special authorization will be required by your insurance carrier and the case manager will be able to assist."))
        dataSource.append(FAQItem(question: "How will I get in and out of a car with my new knee?", answer: "Prior to discharge, the therapist will show you ways to get in and out of a car."))
        dataSource.append(FAQItem(question: "How long will I need the use of a walker? Crutches? A cane?", answer: "Typically individuals recuperating from joint replacement use assistive devices for 6 to 8 weeks, or as long as the doctor or therapist recommends for safety. Walkers are safer than crutches and crutches are safer than canes."))
        dataSource.append(FAQItem(question: "Will I be able to kneel after my knee replacement?", answer: "The majority of persons do have difficulty kneeling although some are able to eventually. Many can kneel for short periods but do find it uncomfortable."))
        dataSource.append(FAQItem(question: "When can I shower?", answer: "When the wound is closed, no longer draining, and you are safe entering and exiting the shower area. Some surgeons allow their patients to shower 2 to 3 days after surgery. Please ask your surgeon to clarify this for you."))
        dataSource.append(FAQItem(question: "What will happen if I put more weight than allowed on my leg?", answer: "Most surgeons allow weight bearing as tolerated. Weight bearing may be limited and you may cause damage or increased pain if you exceed your doctor’s recommendations."))
        dataSource.append(FAQItem(question: "How long can I safely sit in a chair or car?", answer: "One should never sit still for longer than 2 hours without getting up and exercising. Long periods of immobility increase the risk of blood clots in the legs and other complications."))
        dataSource.append(FAQItem(question: "When can I resume recreational activities?", answer: "In most cases you are encouraged to participate in low-impact activities such as walking, swimming, dancing, and easy golfing fairly early in recovery, at the discretion of your physician (around 2 to 3 months)."))
        dataSource.append(FAQItem(question: "How soon can I drive or use a clutch with the operated leg?", answer: "Typically, 6 to 8 weeks after the operation or when your physician clears you for driving. You can use a clutch if you have adequate range-of-motion, strength and you are allowed to bear full weight on the operated leg. You will not be allowed to drive while taking prescription pain medications; this is \"driving under the influence.\""))
        dataSource.append(FAQItem(question: "How soon may I travel by airplane?", answer: "You should not travel on an airplane for 6 weeks after surgery. If you cannot avoid airplane travel, discuss your plans with your doctor."))
        dataSource.append(FAQItem(question: "What does the minimally invasive knee replacement involve?", answer: "Instruments and equipment specifically designed for minimally invasive knee replacement allow a physician to perform the surgery with a smaller incision than typically done with traditional knee replacement surgery. Your orthopedic physician will decide if this type of procedure is appropriate for you."))
        dataSource.append(FAQItem(question: "What is traditional knee replacement surgery?", answer: "The procedure for traditional total knee replacements typically requires an incision down the front of the knee. This allows the physician to fully see the joint, the diseased bone, and the implants. During the operation, the arthritic portion of the upper thighbone (femur) and lower leg bone (tibia) is removed as well as damaged cartilage from the underside of the kneecap (patella). The affected areas are replaced with implants on the bone ends and the underside of the kneecap. This results in a smooth surface for joint movement."))
        dataSource.append(FAQItem(question: "What is a uni vs. a total knee replacement?", answer: "A uni knee replacement means that only one compartment of the knee joint is being replaced. It is most commonly the medial (inside) compartment. A total knee replacement means that both the medial and lateral compartments are being replaced."))
        dataSource.append(FAQItem(question: "I have heard that my kneecap will be numb, is this true?", answer: "Numbness along the incision or below the kneecap may be experienced. It often resolves over time, but can be permanent."))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        // Customize the table view
        self.tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Hide the footer
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Table View Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the data source and cell
        let data = dataSource[indexPath.row]
        
        // Return cell's height, based on expanded state
        return data.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source
        let data = dataSource[indexPath.row]
        
        // Get the cell
        let cell: FAQTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FAQTableViewCell
        cell.question.text = data.question
        cell.answer.text = data.answer
        cell.selectionStyle = .none
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the data source and cell
        let data = dataSource[indexPath.row]
        let cell = (self.tableView.cellForRow(at: indexPath) as! FAQTableViewCell)
        
        // Toggle the cell
        data.expanded = !data.expanded
        data.height = cell.getHeight(data.expanded)
        if data.expanded! {
            cell.select()
        }
        else {
            cell.deselect()
        }
        
        // Perform table view updates
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
