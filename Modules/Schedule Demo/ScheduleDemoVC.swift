//
//  ScheduleDemoVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 26/08/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ScheduleDemoVC: UIViewController {

    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtMiddlename: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtNameOfCompany: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPoBox: UITextField!
    @IBOutlet weak var txtHowDoyouHear: UITextField!
    @IBOutlet weak var txtOtherHearReason: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!
    @IBOutlet weak var txtEndTime: UITextField!
    @IBOutlet weak var btnBuyerOut: UIButton!
    @IBOutlet weak var btnSupplierOut: UIButton!
    @IBOutlet weak var btnOtherOut: UIButton!
    @IBOutlet weak var btnCancelOut: UIButton!
    @IBOutlet weak var btnSubmitOut: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtNumofWarehouse: UITextField!
    @IBOutlet weak var txtOutlets: UITextField!
    @IBOutlet weak var txtNumofBuyers: UITextField!
    @IBOutlet weak var txtBusinessType: UITextField!
    @IBOutlet weak var vwStartTime: UIView!
    @IBOutlet weak var vwEndTime: UIView!
    @IBOutlet weak var vwOtherReason: UIView!
    @IBOutlet weak var vwNumberOfWarehouse: UIView!
    @IBOutlet weak var vwNumberOfBuyers: UIView!
    @IBOutlet weak var vwTypeOfBusiness: UIView!
    @IBOutlet weak var vwNumberOfOutlets: UIView!

    var arrParams                       = [ParameterResponse]()
    var arrCountry                      = [ParameterResponse]()
    var arrCity                         = [ParameterResponse]()
    var arrHearReason                   = ["Search Engine","Google Ads","Newspaper","Other"]
    var arrTimeSlot                     = ["8 AM to 12 PM (Gulf standard time)","12 PM to 4 PM (Gulf standard time)","4 PM to 8 PM (Gulf standard time)"]
    var pickerCountryCode               = UIPickerView()
    var pickerCountry                   = UIPickerView()
    var pickerCity                      = UIPickerView()
    var pickerHearReason                = UIPickerView()
    var pickerTimeSLot                  = UIPickerView()
    var strUser                         = ""
    var arrContryCode = [["name": "Afghanistan","dial_code": "+93","code": "AF"],["name": "Albania","dial_code": "+355","code": "AL"],["name": "Algeria","dial_code": "+213","code": "DZ"],["name": "American Samoa","dial_code": "+1 684","code": "AS"],["name": "Andorra","dial_code": "+376","code": "AD"],["name": "Angola","dial_code": "+244","code": "AO"],["name": "Anguilla","dial_code": "+809","code": "AI"],["name": "Antarctica","dial_code": "+672","code": "AQ"],["name": "Antigua and Barbuda","dial_code": "+268","code": "AG"],["name": "Argentina","dial_code": "+54","code": "AR"],["name": "Armenia","dial_code": "+374","code": "AM"],["name": "Aruba","dial_code": "+297","code": "AW"],["name": "Ascension Island","dial_code": "+247","code": "AI"],["name": "Australia","dial_code": "+61","code": "AU"],["name": "Australian External Territories","dial_code": "+672","code": "AUT"],["name": "Austria","dial_code": "+43","code": "AT"],["name": "Azerbaijan","dial_code": "+994","code": "AZ"],["name": "Bahamas","dial_code": "+242","code": "BS"],["name": "Barbados","dial_code": "+246","code": "BS"],["name": "Bahrain","dial_code": "+973","code": "BH"],["name": "Bangladesh","dial_code": "+880","code": "BD"],["name": "Belarus","dial_code": "+375","code": "BY"],["name": "Belgium","dial_code": "+32","code": "BE"],["name": "Belize","dial_code": "+501","code": "BZ"],["name": "Benin","dial_code": "+229","code": "BJ"],["name": "Bermuda","dial_code": "+809","code": "BM"],["name": "Bhutan","dial_code": "+975","code": "BT"],["name": "British Virgin Islands","dial_code": "+284","code": "VG"],["name": "Bolivia","dial_code": "+591","code": "BO"],["name": "Bosnia and Herzegovina","dial_code": "+387","code": "BA"],["name": "Botswana","dial_code": "+267","code": "BW"],["name": "Brazil","dial_code": "+55","code": "BR"],["name": "British Indian Ocean Territory","dial_code": "+246","code": "IO"],["name": "Brunei Darussalam","dial_code": "+673","code": "BN"],["name": "Bulgaria","dial_code": "+359","code": "BG"],["name": "Burkina Faso","dial_code": "+226","code": "BF"],["name": "Burundi","dial_code": "+257","code": "BI"],["name": "Cambodia","dial_code": "+855","code": "KH"],["name": "Cameroon","dial_code": "+237","code": "CM"],["name": "Canada","dial_code": "+1","code": "CA"],["name": "Cape Verde","dial_code": "+238","code": "CV"],["name": "Cayman Islands","dial_code": "+345","code": "KY"],["name": "Central African Republic","dial_code": "+236","code": "CF"],["name": "Chad","dial_code": "+235","code": "TD"],["name": "Chile","dial_code": "+56","code": "CL"],["name": "China","dial_code": "+86","code": "CN"],["name": "Christmas Island","dial_code": "+61","code": "CX"],["name": "Cocos (Keeling) Islands","dial_code": "+61","code": "CC"],["name": "Colombia","dial_code": "+57","code": "CO"],["name": "Comoros","dial_code": "+269","code": "KM"],["name": "Congo","dial_code": "+242","code": "CG"],["name": "Congo, The Democratic Republic of the Congo","dial_code": "+243","code": "CD"],["name": "Cook Islands","dial_code": "+682","code": "CK"],["name": "Costa Rica","dial_code": "+506","code": "CR"],["name": "Cote d'Ivoire","dial_code": "+225","code": "CI"],["name": "Croatia","dial_code": "+385","code": "HR"],["name": "Cuba","dial_code": "+53","code": "CU"],["name": "Cyprus","dial_code": "+357","code": "CY"],["name": "Czech Republic","dial_code": "+420","code": "CZ"],["name": "Denmark","dial_code": "+45","code": "DK"],["name": "Djibouti","dial_code": "+253","code": "DJ"],["name": "Dominica","dial_code": "+1 767","code": "DM"],["name": "Dominican Republic","dial_code": "+1 849","code": "DO"],["name": "Ecuador","dial_code": "+593","code": "EC"],["name": "Egypt","dial_code": "+20","code": "EG"],["name": "El Salvador","dial_code": "+503","code": "SV"],["name": "Equatorial Guinea","dial_code": "+240","code": "GQ"],["name": "Eritrea","dial_code": "+291","code": "ER"],["name": "Estonia","dial_code": "+372","code": "EE"],["name": "Ethiopia","dial_code": "+251","code": "ET"],["name": "Falkland Islands (Malvinas)","dial_code": "+500","code": "FK"],["name": "Faroe Islands","dial_code": "+298","code": "FO"],["name": "Fiji","dial_code": "+679","code": "FJ"],["name": "Finland","dial_code": "+358","code": "FI"],["name": "France","dial_code": "+33","code": "FR"],["name": "French Guiana","dial_code": "+594","code": "GF"],["name": "French Polynesia","dial_code": "+689","code": "PF"],["name": "Gabon","dial_code": "+241","code": "GA"],["name": "Gambia","dial_code": "+220","code": "GM"],["name": "Georgia","dial_code": "+995","code": "GE"],["name": "Germany","dial_code": "+49","code": "DE"],["name": "Ghana","dial_code": "+233","code": "GH"],["name": "Gibraltar","dial_code": "+350","code": "GI"],["name": "Greece","dial_code": "+30","code": "GR"],["name": "Greenland","dial_code": "+299","code": "GL"],["name": "Grenada","dial_code": "+1 473","code": "GD"],["name": "Guadeloupe","dial_code": "+590","code": "GP"],["name": "Guam","dial_code": "+1 671","code": "GU"],["name": "Guatemala","dial_code": "+502","code": "GT"],["name": "Guernsey","dial_code": "+44","code": "GG"],["name": "Guinea","dial_code": "+224","code": "GN"],["name": "Guinea-Bissau","dial_code": "+245","code": "GW"],["name": "Guyana","dial_code": "+595","code": "GY"],["name": "Haiti","dial_code": "+509","code": "HT"],["name": "Holy See (Vatican City State)","dial_code": "+379","code": "VA"],["name": "Honduras","dial_code": "+504","code": "HN"],["name": "Hong Kong","dial_code": "+852","code": "HK"],["name": "Hungary","dial_code": "+36","code": "HU"],["name": "Iceland","dial_code": "+354","code": "IS"],["name": "India","dial_code": "+91","code": "IN"],["name": "Indonesia","dial_code": "+62","code": "ID"],["name": "Iran, Islamic Republic of Persian Gulf","dial_code": "+98","code": "IR"],["name": "Iraq","dial_code": "+964","code": "IQ"],["name": "Ireland","dial_code": "+353","code": "IE"],["name": "Isle of Man","dial_code": "+44","code": "IM"],["name": "Israel","dial_code": "+972","code": "IL"],["name": "Italy","dial_code": "+39","code": "IT"],["name": "Jamaica","dial_code": "+1 876","code": "JM"],["name": "Japan","dial_code": "+81","code": "JP"],["name": "Jersey","dial_code": "+44","code": "JE"],["name": "Jordan","dial_code": "+962","code": "JO"],["name": "Kazakhstan","dial_code": "+7 7","code": "KZ"],["name": "Kenya","dial_code": "+254","code": "KE"],["name": "Kiribati","dial_code": "+686","code": "KI"],["name": "Korea, Democratic People's Republic of Korea","dial_code": "+850","code": "KP"],["name": "Korea, Republic of South Korea","dial_code": "+82","code": "KR"],["name": "Kuwait","dial_code": "+965","code": "KW"],["name": "Kyrgyzstan","dial_code": "+996","code": "KG"],["name": "Laos","dial_code": "+856","code": "LA"],["name": "Latvia","dial_code": "+371","code": "LV"],["name": "Lebanon","dial_code": "+961","code": "LB"],["name": "Lesotho","dial_code": "+266","code": "LS"],["name": "Liberia","dial_code": "+231","code": "LR"],["name": "Libyan Arab Jamahiriya","dial_code": "+218","code": "LY"],["name": "Liechtenstein","dial_code": "+423","code": "LI"],["name": "Lithuania","dial_code": "+370","code": "LT"],["name": "Luxembourg","dial_code": "+352","code": "LU"],["name": "Macao","dial_code": "+853","code": "MO"],["name": "Macedonia","dial_code": "+389","code": "MK"],["name": "Madagascar","dial_code": "+261","code": "MG"],["name": "Malawi","dial_code": "+265","code": "MW"],["name": "Malaysia","dial_code": "+60","code": "MY"],["name": "Maldives","dial_code": "+960","code": "MV"],["name": "Mali","dial_code": "+223","code": "ML"],["name": "Malta","dial_code": "+356","code": "MT"],["name": "Marshall Islands","dial_code": "+692","code": "MH"],["name": "Martinique","dial_code": "+596","code": "MQ"],["name": "Mauritania","dial_code": "+222","code": "MR"],["name": "Mauritius","dial_code": "+230","code": "MU"],["name": "Mayotte","dial_code": "+262","code": "YT"],["name": "Mexico","dial_code": "+52","code": "MX"],["name": "Micronesia, Federated States of Micronesia","dial_code": "+691","code": "FM"],["name": "Moldova","dial_code": "+373","code": "MD"],["name": "Monaco","dial_code": "+377","code": "MC"],["name": "Mongolia","dial_code": "+976","code": "MN"],["name": "Montenegro","dial_code": "+382","code": "ME"],["name": "Montserrat","dial_code": "+1664","code": "MS"],["name": "Morocco","dial_code": "+212","code": "MA"],["name": "Mozambique","dial_code": "+258","code": "MZ"],["name": "Myanmar","dial_code": "+95","code": "MM"],["name": "Namibia","dial_code": "+264","code": "NA"],["name": "Nauru","dial_code": "+674","code": "NR"],["name": "Nepal","dial_code": "+977","code": "NP"],["name": "Netherlands","dial_code": "+31","code": "NL"],["name": "Netherlands Antilles","dial_code": "+599","code": "AN"],["name": "New Caledonia","dial_code": "+687","code": "NC"],["name": "New Zealand","dial_code": "+64","code": "NZ"],["name": "Nicaragua","dial_code": "+505","code": "NI"],["name": "Niger","dial_code": "+227","code": "NE"],["name": "Nigeria","dial_code": "+234","code": "NG"],["name": "Niue","dial_code": "+683","code": "NU"],["name": "Norfolk Island","dial_code": "+672","code": "NF"],["name": "Northern Mariana Islands","dial_code": "+1 670","code": "MP"],["name": "Norway","dial_code": "+47","code": "NO"],["name": "Oman","dial_code": "+968","code": "OM"],["name": "Pakistan","dial_code": "+92","code": "PK"],["name": "Palau","dial_code": "+680","code": "PW"],["name": "Palestinian Territory, Occupied","dial_code": "+970","code": "PS"],["name": "Panama","dial_code": "+507","code": "PA"],["name": "Papua New Guinea","dial_code": "+675","code": "PG"],["name": "Paraguay","dial_code": "+595","code": "PY"],["name": "Peru","dial_code": "+51","code": "PE"],["name": "Philippines","dial_code": "+63","code": "PH"],["name": "Pitcairn","dial_code": "+872","code": "PN"],["name": "Poland","dial_code": "+48","code": "PL"],["name": "Portugal","dial_code": "+351","code": "PT"],["name": "Puerto Rico","dial_code": "+1 939","code": "PR"],["name": "Qatar","dial_code": "+974","code": "QA"],["name": "Romania","dial_code": "+40","code": "RO"],["name": "Russia","dial_code": "+7","code": "RU"],["name": "Rwanda","dial_code": "+250","code": "RW"],["name": "Reunion","dial_code": "+262","code": "RE"],["name": "Saint Barthelemy","dial_code": "+590","code": "BL"],["name": "Saint Helena, Ascension and Tristan Da Cunha","dial_code": "+290","code": "SH"],["name": "Saint Kitts and Nevis","dial_code": "+1 869","code": "KN"],["name": "Saint Lucia","dial_code": "+1 758","code": "LC"],["name": "Saint Martin","dial_code": "+590","code": "MF"],["name": "Saint Pierre and Miquelon","dial_code": "+508","code": "PM"],["name": "Saint Vincent and the Grenadines","dial_code": "+1 784","code": "VC"],["name": "San Marino","dial_code": "+378","code": "SM"],["name": "Sao Tome and Principe","dial_code": "+239","code": "ST"],["name": "Saudi Arabia","dial_code": "+966","code": "SA"],["name": "Senegal","dial_code": "+221","code": "SN"],["name": "Serbia","dial_code": "+381","code": "RS"],["name": "Seychelles","dial_code": "+248","code": "SC"],["name": "Sierra Leone","dial_code": "+232","code": "SL"],["name": "Singapore","dial_code": "+65","code": "SG"],["name": "Slovakia","dial_code": "+421","code": "SK"],["name": "Slovenia","dial_code": "+386","code": "SI"],["name": "Solomon Islands","dial_code": "+677","code": "SB"],["name": "Somalia","dial_code": "+252","code": "SO"],["name": "South Africa","dial_code": "+27","code": "ZA"],["name": "South Georgia and the South Sandwich Islands","dial_code": "+500","code": "GS"],["name": "Spain","dial_code": "+34","code": "ES"],["name": "Sri Lanka","dial_code": "+94","code": "LK"],["name": "Sudan","dial_code": "+249","code": "SD"],["name": "Suriname","dial_code": "+597","code": "SR"],["name": "Svalbard and Jan Mayen","dial_code": "+47","code": "SJ"],["name": "Swaziland","dial_code": "+268","code": "SZ"],["name": "Sweden","dial_code": "+46","code": "SE"],["name": "Switzerland","dial_code": "+41","code": "CH"],["name": "Syrian Arab Republic","dial_code": "+963","code": "SY"],["name": "Taiwan","dial_code": "+886","code": "TW"],["name": "Tajikistan","dial_code": "+992","code": "TJ"],["name": "Tanzania, United Republic of Tanzania","dial_code": "+255","code": "TZ"],["name": "Thailand","dial_code": "+66","code": "TH"],["name": "Timor-Leste","dial_code": "+670","code": "TL"],["name": "Togo","dial_code": "+228","code": "TG"],["name": "Tokelau","dial_code": "+690","code": "TK"],["name": "Tonga","dial_code": "+676","code": "TO"],["name": "Trinidad and Tobago","dial_code": "+1 868","code": "TT"],["name": "Tunisia","dial_code": "+216","code": "TN"],["name": "Turkey","dial_code": "+90","code": "TR"],["name": "Turkmenistan","dial_code": "+993","code": "TM"],["name": "Turks and Caicos Islands","dial_code": "+1 649","code": "TC"],["name": "Tuvalu","dial_code": "+688","code": "TV"],["name": "Uganda","dial_code": "+256","code": "UG"],["name": "Ukraine","dial_code": "+380","code": "UA"],["name": "United Arab Emirates","dial_code": "+971","code": "AE"],["name": "United Kingdom","dial_code": "+44","code": "GB"],["name": "United States","dial_code": "+1","code": "US"],["name": "Uruguay","dial_code": "+598","code": "UY"],["name": "Uzbekistan","dial_code": "+998","code": "UZ"],["name": "Vanuatu","dial_code": "+678","code": "VU"],["name": "Venezuela, Bolivarian Republic of Venezuela","dial_code": "+58","code": "VE"],["name": "Vietnam","dial_code": "+84","code": "VN"],["name": "Virgin Islands, U.S.","dial_code": "+1 340","code": "VI"],["name": "Wallis and Futuna","dial_code": "+681","code": "WF"],["name": "Western Samoa","dial_code": "+685","code": "WS"],["name": "Yemen","dial_code": "+967","code": "YE"],["name": "Zaire","dial_code": "+243","code": "ZM"],["name": "Zambia","dial_code": "+260","code": "ZM"],["name": "Zimbabwe","dial_code": "+263","code": "ZW"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmitOut.cornerRadius = 6
        self.btnCancelOut.cornerRadius = 6
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        pickerCity.dataSource = self
        pickerCity.delegate = self
        pickerHearReason.dataSource = self
        pickerHearReason.delegate = self
        pickerTimeSLot.dataSource = self
        pickerTimeSLot.delegate = self
        pickerCountry.reloadAllComponents()
        pickerCity.reloadAllComponents()
        pickerHearReason.reloadAllComponents()
        pickerTimeSLot.reloadAllComponents()
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        txtCountry.inputView = pickerCountry
        self.pickerViewSet(pickerCountry, txtCountry, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCountry))
        pickerCity.dataSource = self
        pickerCity.delegate = self
        txtCity.inputView = pickerCity
        self.pickerViewSet(pickerCity, txtCity, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCity))
        pickerCountryCode.dataSource = self
        pickerCountryCode.delegate = self
        pickerCountryCode.reloadAllComponents()
        txtCountryCode.inputView = pickerCountryCode
        self.pickerViewSet(pickerCountryCode, txtCountryCode, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCountryCode))
        self.pickerViewSet(pickerHearReason, txtHowDoyouHear, btnDoneSelector: #selector(ScheduleDemoVC.donePickerHearReson))
        self.pickerViewSet(pickerTimeSLot, txtEndTime, btnDoneSelector: #selector(ScheduleDemoVC.donePickerTimeSlot))
        txtStartDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        txtEndDate.addInputViewDatePicker(target: self, selector: #selector(doneEndDateButtonPressed))
        //        txtStartTime.addInputViewDatePickerWithTime(target: self, selector: #selector(doneStartTimeButtonPressed))
        //        txtEndTime.addInputViewDatePickerWithTime(target: self, selector: #selector(doneEndTimeButtonPressed))
        vwStartTime.isHidden = true
        wsParameters()
        // Do any additional setup after loading the view.
    }
    //This method is used for pick the country
    @objc func donePickerCountry() {
        if txtCountry.text == "" || arrCountry.count == 1{
            txtCountry.text = arrCountry[0].value
        }
        if txtCountry.text != "United Arab Emirates" {
            let alert = UIAlertController(title: "", message: "Sorry, we currently are not operating in your country. Please send an email to support@watermelon.market for enquiries.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
        self.arrCity.removeAll()
        for i in self.arrParams{
            print(i.dependentValue)
            if i.name
                == "city" && i.dependentValue == txtCountry.text{
                self.arrCity.append(i)
            }

        }
        print(self.arrCity)
        self.pickerCity.reloadAllComponents()

        self.txtCountry.resignFirstResponder()

    }
    @objc func donePickerCity() {
        if txtCity.text == "" || arrCity.count == 1{
            txtCity.text = arrCity[0].value
        }

        self.txtCity.resignFirstResponder()
    }
    @objc func donePickerCountryCode() {
        if txtCountryCode.text == "" {
            txtCountryCode.text = "\(arrContryCode[0]["name"]!)(\(arrContryCode[0]["dial_code"]!))"
        }
        self.txtCountryCode.resignFirstResponder()
    }
    @objc func donePickerHearReson() {
        if txtHowDoyouHear.text == "" {
            txtHowDoyouHear.inputView = pickerHearReason
            txtHowDoyouHear.text = arrHearReason[0]
            if self.txtHowDoyouHear.text == "Other" {
                self.vwOtherReason.isHidden = false
            } else {
                self.vwOtherReason.isHidden = true
            }
        }
        self.txtHowDoyouHear.resignFirstResponder()
    }
    @objc func donePickerTimeSlot() {
        if txtEndTime.text == "" {
            txtEndTime.inputView = pickerTimeSLot
            txtEndTime.text = arrTimeSlot[0]
        }
        self.txtEndTime.resignFirstResponder()
    }
    
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {

        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar

    }

    @objc func doneButtonPressed() {
        if let  datePicker = self.txtStartDate.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "YYYY/MM/dd"
            self.txtStartDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtStartDate.resignFirstResponder()
    }
    @objc func doneEndDateButtonPressed() {
        if let  datePicker = self.txtEndDate.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "YYYY/MM/dd"
            self.txtEndDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtEndDate.resignFirstResponder()
    }
    @objc func doneStartTimeButtonPressed() {
        if let  datePicker = self.txtStartTime.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "HH:mm"
            self.txtStartTime.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtStartTime.resignFirstResponder()
    }
    @objc func doneEndTimeButtonPressed() {
        if let  datePicker = self.txtEndTime.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "HH:mm"
            self.txtEndTime.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtEndTime.resignFirstResponder()
    }
    func wsParameters(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)

            return
        }

        APICall().post(apiUrl: Constants.WebServiceURLs.ParametersURL, requestPARAMS: "", isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{

                    let decoder = JSONDecoder()
                    do {

                        let dicResponseData = try decoder.decode(ParameterResponseModel.self, from: responseData as! Data)

                        if dicResponseData.success == "1" {
                            self.arrParams = dicResponseData.data!

                            for i in self.arrParams{
                                if i.name == "country" {
                                    self.arrCountry.append(i)
                                }
                            }
                            print(self.arrCountry)


                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    //This method is used for validation purpose
    func validationScheduleDemo(){

        if Validation().isEmpty(txtField: txtFirstname.text!){
            showToast(message:Constants.AlertMessage.firstName)
        } else  if !Validation().isValidateFirstName(fname: txtFirstname.text!){
            showToast(message:Constants.AlertMessage.validFirstName)
        }else if Validation().isEmpty(txtField: txtLastname.text!){
            showToast(message:Constants.AlertMessage.lastName)
        } else  if !Validation().isValidateFirstName(fname: txtLastname.text!){
            showToast(message:Constants.AlertMessage.validLastName)
        } else  if Validation().isEmpty(txtField: txtNameOfCompany.text!){
            showToast(message:Constants.AlertMessage.companyName)
        } else  if Validation().isEmpty(txtField: txtEmail.text!){
            showToast(message:Constants.AlertMessage.email)
        } else  if !txtEmail.text!.isEmail{
            showToast(message: Constants.AlertMessage.validEmail)
        } else  if Validation().isEmpty(txtField: txtCountryCode.text!){
            showToast(message:Constants.AlertMessage.countryCode)
        } else  if Validation().isEmpty(txtField: txtPhone.text!){
            showToast(message:Constants.AlertMessage.phoneNumber)
        } else  if !(Validation().checkMinAndMaxLength(txtField: txtPhone.text!, withMinLimit: 6, withMaxLimit: 12)){
            showToast(message:Constants.AlertMessage.phoneCharacter)
        }
        else if Validation().isEmpty(txtField: txtCountry.text!){
            showToast(message:Constants.AlertMessage.country)
        } else  if Validation().isEmpty(txtField: txtCity.text!){
            showToast(message:Constants.AlertMessage.city)
        }
        else if Validation().isEmpty(txtField: txtOtherHearReason.text!) && txtHowDoyouHear.text == "Other" {
            showToast(message:Constants.AlertMessage.field)
        }
        else if Validation().isEmpty(txtField: txtStartDate.text!){
            showToast(message:Constants.AlertMessage.startDate)
        } else  if Validation().isEmpty(txtField: txtEndDate.text!){
            showToast(message:Constants.AlertMessage.endDate)
        }
        else if Validation().isEmpty(txtField: txtEndTime.text!){
            showToast(message:Constants.AlertMessage.timeslot)
        }
        else if !(btnBuyerOut.isSelected || btnSupplierOut.isSelected || btnOtherOut.isSelected) {
            showToast(message:Constants.AlertMessage.selectUser)
        } else  {
            if btnBuyerOut.isSelected{
                if Validation().isEmpty(txtField: txtOutlets.text!){
                    showToast(message:Constants.AlertMessage.outlets)
                } else  if Validation().isEmpty(txtField: txtBusinessType.text!){
                    showToast(message:Constants.AlertMessage.business)
                } else {
                    wsScheduleDemo()
                }
            } else  if btnSupplierOut.isSelected{
                if Validation().isEmpty(txtField: txtNumofBuyers.text!){
                    showToast(message:Constants.AlertMessage.buyers)
                } else  if Validation().isEmpty(txtField: txtNumofWarehouse.text!){
                    showToast(message:Constants.AlertMessage.numberOfWarehouse)
                } else {
                    wsScheduleDemo()
                }
            } else {
                wsScheduleDemo()
            }
        }


    }
    //MARK: - API Call
    // This method is used for invoke the schedule demo API
    func wsScheduleDemo(){

        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message:Constants.AlertMessage.NetworkConnection as String)
            return
        }

        var paramDic = Dictionary<String, AnyObject>()

        paramDic [Constants.WebServiceParameter.paramFirstname] = txtFirstname.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMiddlename] = txtMiddlename.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramLastname] = txtLastname.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCompanyName] = txtNameOfCompany.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = txtEmail.text as AnyObject
        paramDic ["phone_number_code"] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPhoneNumber] = txtPhone.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = txtAddress.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = txtCountry.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = txtCity.text as AnyObject

        paramDic [Constants.WebServiceParameter.paramPobox] = txtPoBox.text as AnyObject

        paramDic [Constants.WebServiceParameter.paramAboutUs] = txtHowDoyouHear.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramOther] = txtOtherHearReason.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramStartDate] = txtStartDate.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEndDate] = txtEndDate.text as AnyObject
        //paramDic [Constants.WebServiceParameter.paramStartTime] = txtStartTime.text as AnyObject

        paramDic [Constants.WebServiceParameter.paramTimeSlot] = txtEndTime.text?.replacingOccurrences(of: " (Gulf standard time)", with: "") as AnyObject
        paramDic [Constants.WebServiceParameter.paramIam] = strUser as AnyObject
        paramDic [Constants.WebServiceParameter.paramNumOfOutlet] = txtOutlets.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramNumOfBuyers] = txtNumofBuyers.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramNumberOfWarehouse] = txtNumofWarehouse.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramBusinessType] = txtBusinessType.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        var arrFilePath = [String]()
        var arrFiles = Array<Dictionary<String, Any>>()

        MultiPart().callPostWebService1(Constants.WebServiceURLs.scheduleDemoURL, parameters: paramDic, filePathArr: arrFiles, model: GenralResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? GenralResponseModel {
                if (success){
                    if let responseData = responseData as? GenralResponseModel {
                        self.showToast(message:responseData.message)
                        //success = true = 1 , unsuccess = false = 0
                        if dicResponseData.success == "1" {
                        }
                    }
                    else{
                        self.showToast(message:responseData?.message ?? "")
                    }
                }

            }
        }
    }

    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBuyerAct(_ sender: Any) {
        self.strUser = "Buyer"
        self.btnBuyerOut.isSelected = true
        self.btnSupplierOut.isSelected = false
        self.btnOtherOut.isSelected = false

        self.vwNumberOfBuyers.isHidden = true
        self.vwNumberOfWarehouse.isHidden = true
        self.vwTypeOfBusiness.isHidden = false
        self.vwNumberOfOutlets.isHidden = false

    }
    @IBAction func btnSupplierAct(_ sender: Any) {
        self.strUser = "Supplier"
        self.btnBuyerOut.isSelected = false
        self.btnSupplierOut.isSelected = true
        self.btnOtherOut.isSelected = false
        self.vwNumberOfBuyers.isHidden = false
        self.vwNumberOfWarehouse.isHidden = false
        self.vwTypeOfBusiness.isHidden = true
        self.vwNumberOfOutlets.isHidden = true
    }
    @IBAction func btnOtherAct(_ sender: Any) {
        self.strUser = "Other"
        self.btnBuyerOut.isSelected = false
        self.btnSupplierOut.isSelected = false
        self.btnOtherOut.isSelected = true

        self.vwNumberOfBuyers.isHidden = true
        self.vwNumberOfWarehouse.isHidden = true
        self.vwTypeOfBusiness.isHidden = true
        self.vwNumberOfOutlets.isHidden = true
    }


    @IBAction func btnSubmitACt(_ sender: Any) {
        //wsScheduleDemo()
        validationScheduleDemo()
    }

    @IBAction func btnCancelAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCallACt(_ sender: Any) {
    }

    @IBAction func btnAddressAct(_ sender: Any) {
    }
    @IBAction func btnEmailAct(_ sender: Any) {
        let email = "support@watermelon.market"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}
//MARK: - UITextField Delegate Methods

extension ScheduleDemoVC {

    override func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if(textField.returnKeyType==UIReturnKeyType.next) {
            textField.superview?.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        }
        else if(textField.returnKeyType==UIReturnKeyType.done){
            textField.resignFirstResponder()
            validationScheduleDemo()

        }
        return true
    }
}
// MARK: - Pickerview Methods

extension ScheduleDemoVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
         if pickerView == pickerCountry {
            return arrCountry.count

        } else  if pickerView == pickerCity{
            return arrCity.count
        } else  if pickerView == pickerHearReason{
            return arrHearReason.count

        } else  if pickerView == pickerCountryCode{
            return arrContryCode.count
        } else  {
            return arrTimeSlot.count

        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if pickerView == pickerCountry{
            return arrCountry[row].value

        } else  if pickerView == pickerCity{

            return arrCity[row].value
        } else  if pickerView == pickerCountryCode{
            return "\(arrContryCode[row]["name"]!)(\(arrContryCode[row]["dial_code"]!))"
        } else  if pickerView == pickerHearReason{
            return arrHearReason[row]

        } else {
            return arrTimeSlot[row]

        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == pickerCountry{
            txtCountry.text = arrCountry[row].value

        } else  if pickerView == pickerCity{
            txtCity.text = arrCity[row].value
        } else  if pickerView == pickerCountryCode{
            txtCountryCode.text = "\(arrContryCode[row]["name"]!)(\(arrContryCode[row]["dial_code"]!))"
        } else  if pickerView == pickerHearReason{
            txtHowDoyouHear.text = arrHearReason[row]
            if self.txtHowDoyouHear.text == "Other" {
                self.vwOtherReason.isHidden = false
            } else {
                self.vwOtherReason.isHidden = true
            }
        } else {
            txtEndTime.text = arrTimeSlot[row]

        }

    }
}
extension UITextField {
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
    func addInputViewDatePickerTo(target: Any, selector: Selector, dateTo: Date) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date

        self.inputView = datePicker
        datePicker.minimumDate = dateTo
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }
    func addInputViewDatePicker(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date

        self.inputView = datePicker

        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }
    func addInputViewDatePickerWithTime(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .time

        self.inputView = datePicker

        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }
}
