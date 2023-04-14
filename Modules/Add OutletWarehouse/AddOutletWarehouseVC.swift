//
//  AddOutletWarehouseVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 21/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class AddOutletWarehouseVC: UIViewController {
    
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtBillingAddress: UITextField!
    @IBOutlet weak var txtBillingCountry: UITextField!
    @IBOutlet weak var txtBillingCity: UITextField!
    @IBOutlet weak var txtBillingArea: UITextField!
    @IBOutlet weak var txtStatus: UITextField!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var successview: UIView!
    @IBOutlet weak var btnBillingAddress: UIButton!
    @IBOutlet weak var btnSaveOut: UIButton!
    @IBOutlet weak var stackBillingAddress: UIStackView!
    @IBOutlet weak var nameAlertLabel: UILabel!
    @IBOutlet weak var emailAlertLabel: UILabel!
    @IBOutlet weak var deliveryAddressAlertLabel: UILabel!
    @IBOutlet weak var countryAlertLabel: UILabel!
    @IBOutlet weak var cityAlertLabel: UILabel!
    @IBOutlet weak var areaAlertLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var mobileAlertLabel: UILabel!
    @IBOutlet weak var billingAlertLabel: UILabel!
    @IBOutlet weak var billingCountryAlertLabel: UILabel!
    @IBOutlet weak var billingCityAlertLabel: UILabel!
    @IBOutlet weak var billingAlertAreaLabel: UILabel!
    @IBOutlet weak var statusAlertLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var deliveryaddressTitleLabel: UILabel!
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var areaTitleLabel: UILabel!
    @IBOutlet weak var countryCodeTitleLabel: UILabel!
    @IBOutlet weak var mobileTitleLabel: UILabel!
    @IBOutlet weak var billingaddressTitleLabel: UILabel!
    @IBOutlet weak var billingcityTitleLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var billingAreaTitleLabel: UILabel!
    @IBOutlet weak var billingcountryTitleLabel: UILabel!
    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var successResponseLabel: UILabel!
    
    var pickerStatus = UIPickerView()
    var pickerBuisnessType = UIPickerView()
    var pickerCuisineType = UIPickerView()
    var pickerSpecialFeature = UIPickerView()
    var pickerUsers = UIPickerView()
    var pickerCountry = UIPickerView()
    var pickerCity = UIPickerView()
    var pickerArea = UIPickerView()
    var pickerCountryCode = UIPickerView()
    var pickerMobileCountryCode = UIPickerView()
    var imageData : Data!
    var pickerTimeZone = UIPickerView()
    var pickerBillingCountry = UIPickerView()
    var pickerBillingCity = UIPickerView()
    var pickerBillingArea = UIPickerView()
    var statusCode = "1"
    var dicStatus : [[String:Any]] = []
    var arrBuisnessType = ["Fast Food","Take Out","Dine In","Gourmet","Bistro","Buffet","Cafe","Healthy Foods","Artisan","Others"]
    var arrCuisineType = ["Arabic","American","Indian","Mexican","Mediterranean","Chinese","Others"]
    var arrSpecialFeature = ["Halal","Pure Veg.","Farm Fresh","Gluten Free","Others"]
    var arrContryCode = [["name": "Afghanistan","dial_code": "+93","code": "AF"],["name": "Albania","dial_code": "+355","code": "AL"],["name": "Algeria","dial_code": "+213","code": "DZ"],["name": "American Samoa","dial_code": "+1 684","code": "AS"],["name": "Andorra","dial_code": "+376","code": "AD"],["name": "Angola","dial_code": "+244","code": "AO"],["name": "Anguilla","dial_code": "+809","code": "AI"],["name": "Antarctica","dial_code": "+672","code": "AQ"],["name": "Antigua and Barbuda","dial_code": "+268","code": "AG"],["name": "Argentina","dial_code": "+54","code": "AR"],["name": "Armenia","dial_code": "+374","code": "AM"],["name": "Aruba","dial_code": "+297","code": "AW"],["name": "Ascension Island","dial_code": "+247","code": "AI"],["name": "Australia","dial_code": "+61","code": "AU"],["name": "Australian External Territories","dial_code": "+672","code": "AUT"],["name": "Austria","dial_code": "+43","code": "AT"],["name": "Azerbaijan","dial_code": "+994","code": "AZ"],["name": "Bahamas","dial_code": "+242","code": "BS"],["name": "Barbados","dial_code": "+246","code": "BS"],["name": "Bahrain","dial_code": "+973","code": "BH"],["name": "Bangladesh","dial_code": "+880","code": "BD"],["name": "Belarus","dial_code": "+375","code": "BY"],["name": "Belgium","dial_code": "+32","code": "BE"],["name": "Belize","dial_code": "+501","code": "BZ"],["name": "Benin","dial_code": "+229","code": "BJ"],["name": "Bermuda","dial_code": "+809","code": "BM"],["name": "Bhutan","dial_code": "+975","code": "BT"],["name": "British Virgin Islands","dial_code": "+284","code": "VG"],["name": "Bolivia","dial_code": "+591","code": "BO"],["name": "Bosnia and Herzegovina","dial_code": "+387","code": "BA"],["name": "Botswana","dial_code": "+267","code": "BW"],["name": "Brazil","dial_code": "+55","code": "BR"],["name": "British Indian Ocean Territory","dial_code": "+246","code": "IO"],["name": "Brunei Darussalam","dial_code": "+673","code": "BN"],["name": "Bulgaria","dial_code": "+359","code": "BG"],["name": "Burkina Faso","dial_code": "+226","code": "BF"],["name": "Burundi","dial_code": "+257","code": "BI"],["name": "Cambodia","dial_code": "+855","code": "KH"],["name": "Cameroon","dial_code": "+237","code": "CM"],["name": "Canada","dial_code": "+1","code": "CA"],["name": "Cape Verde","dial_code": "+238","code": "CV"],["name": "Cayman Islands","dial_code": "+345","code": "KY"],["name": "Central African Republic","dial_code": "+236","code": "CF"],["name": "Chad","dial_code": "+235","code": "TD"],["name": "Chile","dial_code": "+56","code": "CL"],["name": "China","dial_code": "+86","code": "CN"],["name": "Christmas Island","dial_code": "+61","code": "CX"],["name": "Cocos (Keeling) Islands","dial_code": "+61","code": "CC"],["name": "Colombia","dial_code": "+57","code": "CO"],["name": "Comoros","dial_code": "+269","code": "KM"],["name": "Congo","dial_code": "+242","code": "CG"],["name": "Congo, The Democratic Republic of the Congo","dial_code": "+243","code": "CD"],["name": "Cook Islands","dial_code": "+682","code": "CK"],["name": "Costa Rica","dial_code": "+506","code": "CR"],["name": "Cote d'Ivoire","dial_code": "+225","code": "CI"],["name": "Croatia","dial_code": "+385","code": "HR"],["name": "Cuba","dial_code": "+53","code": "CU"],["name": "Cyprus","dial_code": "+357","code": "CY"],["name": "Czech Republic","dial_code": "+420","code": "CZ"],["name": "Denmark","dial_code": "+45","code": "DK"],["name": "Djibouti","dial_code": "+253","code": "DJ"],["name": "Dominica","dial_code": "+1 767","code": "DM"],["name": "Dominican Republic","dial_code": "+1 849","code": "DO"],["name": "Ecuador","dial_code": "+593","code": "EC"],["name": "Egypt","dial_code": "+20","code": "EG"],["name": "El Salvador","dial_code": "+503","code": "SV"],["name": "Equatorial Guinea","dial_code": "+240","code": "GQ"],["name": "Eritrea","dial_code": "+291","code": "ER"],["name": "Estonia","dial_code": "+372","code": "EE"],["name": "Ethiopia","dial_code": "+251","code": "ET"],["name": "Falkland Islands (Malvinas)","dial_code": "+500","code": "FK"],["name": "Faroe Islands","dial_code": "+298","code": "FO"],["name": "Fiji","dial_code": "+679","code": "FJ"],["name": "Finland","dial_code": "+358","code": "FI"],["name": "France","dial_code": "+33","code": "FR"],["name": "French Guiana","dial_code": "+594","code": "GF"],["name": "French Polynesia","dial_code": "+689","code": "PF"],["name": "Gabon","dial_code": "+241","code": "GA"],["name": "Gambia","dial_code": "+220","code": "GM"],["name": "Georgia","dial_code": "+995","code": "GE"],["name": "Germany","dial_code": "+49","code": "DE"],["name": "Ghana","dial_code": "+233","code": "GH"],["name": "Gibraltar","dial_code": "+350","code": "GI"],["name": "Greece","dial_code": "+30","code": "GR"],["name": "Greenland","dial_code": "+299","code": "GL"],["name": "Grenada","dial_code": "+1 473","code": "GD"],["name": "Guadeloupe","dial_code": "+590","code": "GP"],["name": "Guam","dial_code": "+1 671","code": "GU"],["name": "Guatemala","dial_code": "+502","code": "GT"],["name": "Guernsey","dial_code": "+44","code": "GG"],["name": "Guinea","dial_code": "+224","code": "GN"],["name": "Guinea-Bissau","dial_code": "+245","code": "GW"],["name": "Guyana","dial_code": "+595","code": "GY"],["name": "Haiti","dial_code": "+509","code": "HT"],["name": "Holy See (Vatican City State)","dial_code": "+379","code": "VA"],["name": "Honduras","dial_code": "+504","code": "HN"],["name": "Hong Kong","dial_code": "+852","code": "HK"],["name": "Hungary","dial_code": "+36","code": "HU"],["name": "Iceland","dial_code": "+354","code": "IS"],["name": "India","dial_code": "+91","code": "IN"],["name": "Indonesia","dial_code": "+62","code": "ID"],["name": "Iran, Islamic Republic of Persian Gulf","dial_code": "+98","code": "IR"],["name": "Iraq","dial_code": "+964","code": "IQ"],["name": "Ireland","dial_code": "+353","code": "IE"],["name": "Isle of Man","dial_code": "+44","code": "IM"],["name": "Israel","dial_code": "+972","code": "IL"],["name": "Italy","dial_code": "+39","code": "IT"],["name": "Jamaica","dial_code": "+1 876","code": "JM"],["name": "Japan","dial_code": "+81","code": "JP"],["name": "Jersey","dial_code": "+44","code": "JE"],["name": "Jordan","dial_code": "+962","code": "JO"],["name": "Kazakhstan","dial_code": "+7 7","code": "KZ"],["name": "Kenya","dial_code": "+254","code": "KE"],["name": "Kiribati","dial_code": "+686","code": "KI"],["name": "Korea, Democratic People's Republic of Korea","dial_code": "+850","code": "KP"],["name": "Korea, Republic of South Korea","dial_code": "+82","code": "KR"],["name": "Kuwait","dial_code": "+965","code": "KW"],["name": "Kyrgyzstan","dial_code": "+996","code": "KG"],["name": "Laos","dial_code": "+856","code": "LA"],["name": "Latvia","dial_code": "+371","code": "LV"],["name": "Lebanon","dial_code": "+961","code": "LB"],["name": "Lesotho","dial_code": "+266","code": "LS"],["name": "Liberia","dial_code": "+231","code": "LR"],["name": "Libyan Arab Jamahiriya","dial_code": "+218","code": "LY"],["name": "Liechtenstein","dial_code": "+423","code": "LI"],["name": "Lithuania","dial_code": "+370","code": "LT"],["name": "Luxembourg","dial_code": "+352","code": "LU"],["name": "Macao","dial_code": "+853","code": "MO"],["name": "Macedonia","dial_code": "+389","code": "MK"],["name": "Madagascar","dial_code": "+261","code": "MG"],["name": "Malawi","dial_code": "+265","code": "MW"],["name": "Malaysia","dial_code": "+60","code": "MY"],["name": "Maldives","dial_code": "+960","code": "MV"],["name": "Mali","dial_code": "+223","code": "ML"],["name": "Malta","dial_code": "+356","code": "MT"],["name": "Marshall Islands","dial_code": "+692","code": "MH"],["name": "Martinique","dial_code": "+596","code": "MQ"],["name": "Mauritania","dial_code": "+222","code": "MR"],["name": "Mauritius","dial_code": "+230","code": "MU"],["name": "Mayotte","dial_code": "+262","code": "YT"],["name": "Mexico","dial_code": "+52","code": "MX"],["name": "Micronesia, Federated States of Micronesia","dial_code": "+691","code": "FM"],["name": "Moldova","dial_code": "+373","code": "MD"],["name": "Monaco","dial_code": "+377","code": "MC"],["name": "Mongolia","dial_code": "+976","code": "MN"],["name": "Montenegro","dial_code": "+382","code": "ME"],["name": "Montserrat","dial_code": "+1664","code": "MS"],["name": "Morocco","dial_code": "+212","code": "MA"],["name": "Mozambique","dial_code": "+258","code": "MZ"],["name": "Myanmar","dial_code": "+95","code": "MM"],["name": "Namibia","dial_code": "+264","code": "NA"],["name": "Nauru","dial_code": "+674","code": "NR"],["name": "Nepal","dial_code": "+977","code": "NP"],["name": "Netherlands","dial_code": "+31","code": "NL"],["name": "Netherlands Antilles","dial_code": "+599","code": "AN"],["name": "New Caledonia","dial_code": "+687","code": "NC"],["name": "New Zealand","dial_code": "+64","code": "NZ"],["name": "Nicaragua","dial_code": "+505","code": "NI"],["name": "Niger","dial_code": "+227","code": "NE"],["name": "Nigeria","dial_code": "+234","code": "NG"],["name": "Niue","dial_code": "+683","code": "NU"],["name": "Norfolk Island","dial_code": "+672","code": "NF"],["name": "Northern Mariana Islands","dial_code": "+1 670","code": "MP"],["name": "Norway","dial_code": "+47","code": "NO"],["name": "Oman","dial_code": "+968","code": "OM"],["name": "Pakistan","dial_code": "+92","code": "PK"],["name": "Palau","dial_code": "+680","code": "PW"],["name": "Palestinian Territory, Occupied","dial_code": "+970","code": "PS"],["name": "Panama","dial_code": "+507","code": "PA"],["name": "Papua New Guinea","dial_code": "+675","code": "PG"],["name": "Paraguay","dial_code": "+595","code": "PY"],["name": "Peru","dial_code": "+51","code": "PE"],["name": "Philippines","dial_code": "+63","code": "PH"],["name": "Pitcairn","dial_code": "+872","code": "PN"],["name": "Poland","dial_code": "+48","code": "PL"],["name": "Portugal","dial_code": "+351","code": "PT"],["name": "Puerto Rico","dial_code": "+1 939","code": "PR"],["name": "Qatar","dial_code": "+974","code": "QA"],["name": "Romania","dial_code": "+40","code": "RO"],["name": "Russia","dial_code": "+7","code": "RU"],["name": "Rwanda","dial_code": "+250","code": "RW"],["name": "Reunion","dial_code": "+262","code": "RE"],["name": "Saint Barthelemy","dial_code": "+590","code": "BL"],["name": "Saint Helena, Ascension and Tristan Da Cunha","dial_code": "+290","code": "SH"],["name": "Saint Kitts and Nevis","dial_code": "+1 869","code": "KN"],["name": "Saint Lucia","dial_code": "+1 758","code": "LC"],["name": "Saint Martin","dial_code": "+590","code": "MF"],["name": "Saint Pierre and Miquelon","dial_code": "+508","code": "PM"],["name": "Saint Vincent and the Grenadines","dial_code": "+1 784","code": "VC"],["name": "San Marino","dial_code": "+378","code": "SM"],["name": "Sao Tome and Principe","dial_code": "+239","code": "ST"],["name": "Saudi Arabia","dial_code": "+966","code": "SA"],["name": "Senegal","dial_code": "+221","code": "SN"],["name": "Serbia","dial_code": "+381","code": "RS"],["name": "Seychelles","dial_code": "+248","code": "SC"],["name": "Sierra Leone","dial_code": "+232","code": "SL"],["name": "Singapore","dial_code": "+65","code": "SG"],["name": "Slovakia","dial_code": "+421","code": "SK"],["name": "Slovenia","dial_code": "+386","code": "SI"],["name": "Solomon Islands","dial_code": "+677","code": "SB"],["name": "Somalia","dial_code": "+252","code": "SO"],["name": "South Africa","dial_code": "+27","code": "ZA"],["name": "South Georgia and the South Sandwich Islands","dial_code": "+500","code": "GS"],["name": "Spain","dial_code": "+34","code": "ES"],["name": "Sri Lanka","dial_code": "+94","code": "LK"],["name": "Sudan","dial_code": "+249","code": "SD"],["name": "Suriname","dial_code": "+597","code": "SR"],["name": "Svalbard and Jan Mayen","dial_code": "+47","code": "SJ"],["name": "Swaziland","dial_code": "+268","code": "SZ"],["name": "Sweden","dial_code": "+46","code": "SE"],["name": "Switzerland","dial_code": "+41","code": "CH"],["name": "Syrian Arab Republic","dial_code": "+963","code": "SY"],["name": "Taiwan","dial_code": "+886","code": "TW"],["name": "Tajikistan","dial_code": "+992","code": "TJ"],["name": "Tanzania, United Republic of Tanzania","dial_code": "+255","code": "TZ"],["name": "Thailand","dial_code": "+66","code": "TH"],["name": "Timor-Leste","dial_code": "+670","code": "TL"],["name": "Togo","dial_code": "+228","code": "TG"],["name": "Tokelau","dial_code": "+690","code": "TK"],["name": "Tonga","dial_code": "+676","code": "TO"],["name": "Trinidad and Tobago","dial_code": "+1 868","code": "TT"],["name": "Tunisia","dial_code": "+216","code": "TN"],["name": "Turkey","dial_code": "+90","code": "TR"],["name": "Turkmenistan","dial_code": "+993","code": "TM"],["name": "Turks and Caicos Islands","dial_code": "+1 649","code": "TC"],["name": "Tuvalu","dial_code": "+688","code": "TV"],["name": "Uganda","dial_code": "+256","code": "UG"],["name": "Ukraine","dial_code": "+380","code": "UA"],["name": "United Arab Emirates","dial_code": "+971","code": "AE"],["name": "United Kingdom","dial_code": "+44","code": "GB"],["name": "United States","dial_code": "+1","code": "US"],["name": "Uruguay","dial_code": "+598","code": "UY"],["name": "Uzbekistan","dial_code": "+998","code": "UZ"],["name": "Vanuatu","dial_code": "+678","code": "VU"],["name": "Venezuela, Bolivarian Republic of Venezuela","dial_code": "+58","code": "VE"],["name": "Vietnam","dial_code": "+84","code": "VN"],["name": "Virgin Islands, U.S.","dial_code": "+1 340","code": "VI"],["name": "Wallis and Futuna","dial_code": "+681","code": "WF"],["name": "Western Samoa","dial_code": "+685","code": "WS"],["name": "Yemen","dial_code": "+967","code": "YE"],["name": "Zaire","dial_code": "+243","code": "ZM"],["name": "Zambia","dial_code": "+260","code": "ZM"],["name": "Zimbabwe","dial_code": "+263","code": "ZW"]
    ]
    var arrUsers = [UsersResponse]()
    var arrParams = [ParameterResponse]()
    var arrCountry = [ParameterResponse]()
    var arrCity = [ParameterResponse]()
    var arrcity = ["Dubai", "Abu Dhabi", "Ajman", "Umm Al Quwain", "Sharjah", "Ras Al Khaimah", "Fujairah"]
    var arrArea = [ParameterResponse]()
    var titleName = "Add Address"
    var countryCode = ""
    var countryName = "United Arab Emirates"
    var arrDetail = [OutletListResponse]()
    var arrDetailWarehouse = [WarehouseListResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtCountryCode.text = "United Arab Emirates(+971)"
        successview.cornerRadius = 8
        btncontinue.cornerRadius = 8
        bgview.isHidden = true
        successview.isHidden = true
        stackBillingAddress.isHidden = true
        tabBarController?.tabBar.isHidden = true
        uielementsSeetup()
        self.statusStackView.isHidden = true
        self.screenTitle.text = titleName
        self.txtCountry.text = countryName
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            self.btnBillingAddress.isHidden = true
            if self.arrDetailWarehouse.count > 0{
                self.txtName.text = self.arrDetailWarehouse[0].warehouseName
                self.txtEmail.text = self.arrDetailWarehouse[0].email
                self.txtAddress.text = self.arrDetailWarehouse[0].address
                self.txtCountry.text = "United Arab Emirates"//self.arrDetailWarehouse[0].country
                self.txtCity.text = "Dubai"//self.arrDetailWarehouse[0].city
                self.txtArea.text = self.arrDetailWarehouse[0].area
                self.txtCountryCode.text = "United Arab Emirates(+971)"//self.arrDetailWarehouse[0].countryCode
                self.txtMobileNumber.text = self.arrDetailWarehouse[0].mobileNumber
                self.txtStatus.text = self.arrDetailWarehouse[0].statusName
            }
        } else {
            self.btnBillingAddress.isHidden = false
            if self.arrDetail.count > 0{
                self.txtName.text = self.arrDetail[0].outletName
                self.txtEmail.text = self.arrDetail[0].email
                self.txtAddress.text = self.arrDetail[0].address
                self.txtCountry.text = "United Arab Emirates"//self.arrDetail[0].country
                self.txtCity.text = "Dubai"//self.arrDetail[0].city
                self.txtArea.text = self.arrDetail[0].area
                self.txtCountryCode.text = "United Arab Emirates(+971)"//self.arrDetail[0].mobileCountryCode
                self.txtMobileNumber.text = self.arrDetail[0].mobileNumber
                if self.arrDetail[0].billingAddress != "" {
                    self.stackBillingAddress.isHidden = false
                    self.btnBillingAddress.isSelected = true
                    self.txtBillingAddress.text = self.arrDetail[0].billingAddress
                    self.txtBillingCountry.text = self.arrDetail[0].billingCountry
                    self.txtBillingCity.text = self.arrDetail[0].billingCity
                    self.txtBillingArea.text = self.arrDetail[0].billingArea
                }
                txtStatus.selectedID = "\(self.arrDetail[0].status)"
                self.txtStatus.text = self.arrDetail[0].statusName
            }
        }
        
        self.wsUsers()
        dicStatus.append(["Title": "Active", "id" : "1"])
        dicStatus.append(["Title": "Inactive", "id" : "0"])
        self.btnSaveOut.cornerRadius = 6
        pickerStatus.dataSource = self
        pickerStatus.delegate = self
        pickerStatus.reloadAllComponents()
        txtStatus.inputView = pickerStatus
        self.pickerViewSet(pickerStatus, txtStatus, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerStatus))
        pickerBuisnessType.dataSource = self
        pickerBuisnessType.delegate = self
        pickerCuisineType.dataSource = self
        pickerCuisineType.delegate = self
        pickerSpecialFeature.dataSource = self
        pickerSpecialFeature.delegate = self
        pickerBuisnessType.reloadAllComponents()
        pickerCuisineType.reloadAllComponents()
        pickerSpecialFeature.reloadAllComponents()
        pickerUsers.dataSource = self
        pickerUsers.delegate = self
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        txtCountry.inputView = pickerCountry
        self.pickerViewSet(pickerCountry, txtCountry, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCountry))
        pickerCity.dataSource = self
        pickerCity.delegate = self
        txtCity.inputView = pickerCity
        self.pickerViewSet(pickerCity, txtCity, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCity))
        pickerArea.dataSource = self
        pickerArea.delegate = self
        txtArea.inputView = pickerArea
        self.pickerViewSet(pickerArea, txtArea, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerArea))
        pickerCountryCode.dataSource = self
        pickerCountryCode.delegate = self
        pickerCountryCode.reloadAllComponents()
        txtCountryCode.inputView = pickerCountryCode
        self.pickerViewSet(pickerCountryCode, txtCountryCode, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerCountryCode))
        pickerMobileCountryCode.dataSource = self
        pickerMobileCountryCode.delegate = self
        pickerMobileCountryCode.reloadAllComponents()
        pickerBillingCountry.dataSource = self
        pickerBillingCountry.delegate = self
        txtBillingCountry.inputView = pickerBillingCountry
        self.pickerViewSet(pickerBillingCountry, txtBillingCountry, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerBillingCountry))
        pickerBillingCity.dataSource = self
        pickerBillingCity.delegate = self
        txtBillingCity.inputView = pickerBillingCity
        self.pickerViewSet(pickerBillingCity, txtBillingCity, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerBillingCity))
        pickerBillingArea.dataSource = self
        pickerBillingArea.delegate = self
        txtBillingArea.inputView = pickerBillingArea
        self.pickerViewSet(pickerBillingArea, txtBillingArea, btnDoneSelector: #selector(AddOutletWarehouseVC.donePickerBillingArea))
    }
    func uielementsSeetup(){
        hideAlert(bool: true)
        nameTitleLabel.addRequiredAsterisk()
        emailTitleLabel.addRequiredAsterisk()
        deliveryaddressTitleLabel.addRequiredAsterisk()
        countryTitleLabel.addRequiredAsterisk()
        cityTitleLabel.addRequiredAsterisk()
        areaTitleLabel.addRequiredAsterisk()
        countryCodeTitleLabel.addRequiredAsterisk()
        mobileTitleLabel.addRequiredAsterisk()
        billingaddressTitleLabel.addRequiredAsterisk()
        billingcityTitleLabel.addRequiredAsterisk()
        statusTitleLabel.addRequiredAsterisk()
        billingAreaTitleLabel.addRequiredAsterisk()
        billingcountryTitleLabel.addRequiredAsterisk()
    }
    
    func hideAlert(bool:Bool){
        [self.nameAlertLabel,  self.emailAlertLabel, self.deliveryAddressAlertLabel,self.countryAlertLabel,self.cityAlertLabel,  self.areaAlertLabel, self.countryCodeLabel,self.billingAlertLabel,self.billingCountryAlertLabel,self.billingCityAlertLabel, self.billingAlertAreaLabel,self.mobileAlertLabel].forEach({ (label) in
            label?.textColor = .red
            label?.isHidden = bool
        })
    }
    
    @objc func donePickerStatus() {
        if txtStatus.text == "" {
            let objCommonModel = CommonModel(data : dicStatus[0] as NSDictionary)
            txtStatus.text = objCommonModel.strTitle
            txtStatus.selectedID = objCommonModel.strID
        }
        self.txtStatus.resignFirstResponder()
    }
    
    
    @objc func donePickerCountry() {
        self.txtCountry.text = "United Arab Emirates"
        if arrCountry.count > 0{
            if txtCountry.text == "" || arrCountry.count == 1{
                txtCountry.text = arrCountry[0].value
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
        }
        self.txtCountry.resignFirstResponder()
    }
    
    @objc func donePickerCity() {
        if arrCity.count > 0{
            if txtCity.text == "" || arrCity.count == 1{
                txtCity.text = arrcity[0]/*.value*/
            }
            self.arrArea.removeAll()
            for i in self.arrParams{
                print(i.dependentValue)
                if i.name
                    == "area" && i.dependentValue == txtCity.text{
                    self.arrArea.append(i)
                }
            }
            self.pickerArea.reloadAllComponents()
            print(self.arrArea)
        }
        self.txtCity.resignFirstResponder()
        
    }
    @objc func donePickerArea() {
        if arrArea.count > 0 {
            if txtArea.text == "" || arrArea.count == 1{
                txtArea.text = arrArea[0].value
            }
            self.txtArea.resignFirstResponder()
        }
    }
    
    
    @objc func donePickerCountryCode() {
        if txtCountryCode.text == "" {
            txtCountryCode.text = "\(arrContryCode[0]["name"]!)(\(arrContryCode[0]["dial_code"]!))"
        }
        self.txtCountryCode.resignFirstResponder()
    }
    
    
    @objc func donePickerBillingCountry() {
        if arrCountry.count > 0 {
            if txtBillingCountry.text == "" || arrCountry.count == 1{
                txtBillingCountry.text = arrCountry[0].value
            }
            self.arrCity.removeAll()
            for i in self.arrParams{
                print(i.dependentValue)
                if i.name
                    == "city" && i.dependentValue == txtBillingCountry.text{
                    self.arrCity.append(i)
                }
                
            }
            print(self.arrCity)
            self.pickerBillingCity.reloadAllComponents()
        }
        self.txtBillingCountry.resignFirstResponder()
    }
    
    @objc func donePickerBillingCity() {
        if arrCity.count > 0 {
            if txtBillingCity.text == "" || arrCity.count == 1{
                txtBillingCity.text = arrCity[0].value
            }
            self.arrArea.removeAll()
            for i in self.arrParams{
                print(i.dependentValue)
                if i.name
                    == "area" && i.dependentValue == txtBillingCity.text{
                    self.arrArea.append(i)
                }
                
            }
            self.pickerBillingArea.reloadAllComponents()
            print(self.arrArea)
        }
        self.txtBillingCity.resignFirstResponder()
    }
    
    @objc func donePickerBillingArea() {
        if arrArea.count > 0{
            if txtBillingArea.text == "" || arrArea.count == 1{
                txtBillingArea.text = arrArea[0].value
            }
        }
        self.txtBillingArea.resignFirstResponder()
    }
    
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {
        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK: - validation check
    
    func validationAddWarehouse(){
        if Validation().isEmpty(txtField: txtEmail.text!){
            showToast(message:Constants.AlertMessage.email)
        } else  if !txtEmail.text!.isEmail{
            showToast(message: Constants.AlertMessage.validEmail)
        } else  if Validation().isEmpty(txtField: txtMobileNumber.text!){
            showToast(message:Constants.AlertMessage.mobileNumber)
        } else  if !(Validation().checkMinAndMaxLength(txtField: txtMobileNumber.text!, withMinLimit: 6, withMaxLimit: 12)){
            showToast(message:Constants.AlertMessage.phoneCharacter)
        } else {
            if self.arrDetailWarehouse.count == 1 && self.arrDetailWarehouse[0].id != "" {
                wsUpdateWarehouse()
            } else {
                wsAddWarehouse()
                bgview.isHidden = true
                successview.isHidden = true
            }
        }
    }
    //This method is used for valliadtion purpose
    func validationAddOutlet(){
        var namerror  = true
        var emailError = true
        var deliveryAddressError = true
        var countryError = true
        var cityError = true
        var areaError = true
        var countryCodeError = true
        var mobileError = true
        var billingaddressError = true
        var billingCountryError = true
        var billingCityError = true
        var billingAreaError = true
        var statusError = true
        
        if Validation().isEmpty(txtField: txtName.text!){
            nameAlertLabel.text = Constants.AlertMessage.name
            nameAlertLabel.isHidden  = false
            namerror = true
        }else{
            namerror = false
            nameAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtEmail.text!){
            emailAlertLabel.text = Constants.AlertMessage.email
            emailAlertLabel.isHidden  = false
            emailError = true
        }else if !txtEmail.text!.isEmail{
            emailAlertLabel.text = Constants.AlertMessage.validEmail
            emailAlertLabel.isHidden  = false
            emailError = true
        }else{
            emailError = false
            emailAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtAddress.text!){
            deliveryAddressAlertLabel.text = Constants.AlertMessage.deliveryAddress
            deliveryAddressAlertLabel.isHidden = false
            deliveryAddressError = true
        }else {
            deliveryAddressError = false
            deliveryAddressAlertLabel.isHidden = true
        }
        
        
        if Validation().isEmpty(txtField: txtCountry.text!){
            countryAlertLabel.text = Constants.AlertMessage.country
            countryAlertLabel.isHidden = false
            countryError = true
        }else {
            countryError = false
            countryAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtCity.text!){
            cityAlertLabel.text = Constants.AlertMessage.city
            cityAlertLabel.isHidden = false
            cityError = true
        }else {
            cityError = false
            cityAlertLabel.isHidden = true
        }
        
        
        if Validation().isEmpty(txtField: txtArea.text!){
            areaAlertLabel.text = Constants.AlertMessage.area
            areaAlertLabel.isHidden = false
            areaError = true
        }else {
            areaError = false
            areaAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtCountryCode.text!){
            countryCodeLabel.text = Constants.AlertMessage.countryCode
            countryCodeLabel.isHidden = false
            countryCodeError = true
        }else {
            countryCodeError = false
            countryCodeLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtMobileNumber.text!){
            mobileAlertLabel.text = Constants.AlertMessage.mobileNumber
            mobileAlertLabel.isHidden = false
            mobileError = true
        }else if !(Validation().checkMinAndMaxLength(txtField: txtMobileNumber.text!, withMinLimit: 6, withMaxLimit: 12)){
            mobileAlertLabel.text = Constants.AlertMessage.phoneCharacter
            mobileAlertLabel.isHidden = false
            mobileError = true
        }else{
            mobileError = false
            mobileAlertLabel.isHidden = true
        }
        
        if btnBillingAddress.isSelected{
            if Validation().isEmpty(txtField: txtBillingAddress.text!){
                billingAlertLabel.text = Constants.AlertMessage.billingAddress
                billingAlertLabel.isHidden = false
                billingaddressError = true
            }else {
                billingaddressError = false
                billingAlertLabel.isHidden = true
            }
            
            if Validation().isEmpty(txtField: txtBillingCountry.text!){
                billingCountryAlertLabel.text = Constants.AlertMessage.billingCountry
                billingCountryAlertLabel.isHidden = false
                billingCountryError = true
            }else {
                billingCountryError = false
                billingCountryAlertLabel.isHidden = true
            }
            if Validation().isEmpty(txtField: txtBillingCity.text!){
                billingCityAlertLabel.text = Constants.AlertMessage.billingCity
                billingCityAlertLabel.isHidden = false
                billingCityError = true
            }else {
                billingCityError = false
                billingCityAlertLabel.isHidden = true
            }
            if Validation().isEmpty(txtField: txtBillingArea.text!){
                billingAlertAreaLabel.text = Constants.AlertMessage.billingArea
                billingAlertAreaLabel.isHidden = false
                billingAreaError = true
            }else {
                billingAreaError = false
                billingAlertAreaLabel.isHidden = true
            }
        }
        
        statusError = false
        if btnBillingAddress.isSelected{
            if  namerror  == false && emailError == false && deliveryAddressError == false && countryError == false && cityError == false && areaError == false && countryCodeError == false && mobileError == false  && statusError == false && billingaddressError == false  && billingCountryError == false && billingCityError == false && billingAreaError == false  && statusError == false && countryCodeError == false{
                
                if self.arrDetail.count > 0{
                    wsUpdateOutlet()
                } else {
                    wsAddOutlet()
                }
                hideAlert(bool: true)
            }
            
        }else  {
            
            if namerror  == false && emailError == false && deliveryAddressError == false && countryError == false && cityError == false && areaError == false && countryCodeError == false && mobileError == false  && statusError == false && countryCodeError == false{
                hideAlert(bool: true)
                if self.arrDetail.count > 0{
                    wsUpdateOutlet()
                } else {
                    wsAddOutlet()
                }
            }
        }
        
    }
    //This methods are used for country city and area
    func wsParameters(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        APICall().post(apiUrl: Constants.WebServiceURLs.ParametersURL, requestPARAMS: "", isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ParameterResponseModel.self, from: responseData as! Data)
                        hideLoader()
                        if dicResponseData.success == "1" {
                            self.arrParams = dicResponseData.data!
                            for i in self.arrParams{
                                if i.name == "country" {
                                    self.arrCountry.append(i)
                                    if i.name == "city" {
                                        self.arrCity.append(i)
                                        if i.name == "area" {
                                            self.arrArea.append(i)
                                        }
                                    }
                                }
                            }
                            print(self.arrCountry)
                            print(self.arrCity)
                            print(self.arrArea)
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoke the used API
    func wsUsers(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        
        APICall().post(apiUrl: Constants.WebServiceURLs.UsersURL, requestPARAMS: "", isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UsersResponseModel.self, from: responseData as! Data)
                        
                        if dicResponseData.success == "1" {
                            self.arrUsers = dicResponseData.data!
                            self.pickerUsers.reloadAllComponents()
                            
                        }
                        self.wsParameters()
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                    
                }
            }
        }
    }
    //  This method is used for to add outlet
    func wsAddOutlet() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramOutletName] = txtName.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = txtEmail.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileCountryCode] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPhoneNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = txtAddress.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = txtCountry.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = txtCity.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramArea] = txtArea.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountryCode] = txtCountryCode.text as AnyObject
        if btnBillingAddress.isSelected{
            paramDic [Constants.WebServiceParameter.paramBillingAddress] = txtBillingAddress.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCountry] = txtBillingCountry.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCity] = txtBillingCity.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingArea] = txtBillingArea.text as AnyObject
        } else {
            paramDic [Constants.WebServiceParameter.paramBillingAddress] = txtAddress.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCountry] = txtCountry.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCity] = txtCity.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingArea] = txtArea.text as AnyObject
        }
        
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        paramDic [Constants.WebServiceParameter.paramBuyerId] = (USERDEFAULTS.getDataForKey(.user_type_id)) as AnyObject
        paramDic [Constants.WebServiceParameter.paramStatus] = statusCode as AnyObject
        var arrFilePath = [String]()
        var arrFiles = Array<Dictionary<String, Any>>()
        if (imageData != nil) { // image
            arrFilePath.append(saveImage(data: imageData)?.path ?? "")
            arrFiles = [
                [multiPartFieldName: "outlet_logo",
                  multiPartPathURLs: arrFilePath]
            ]
        }
        
        print(paramDic)
        MultiPart().callPostWebService1(Constants.WebServiceURLs.addOutletURL, parameters: paramDic, filePathArr: arrFiles, model: AddOutletResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? AddOutletResponseModel {
                if (success){
                    if let responseData = responseData as? AddOutletResponseModel {
                        if dicResponseData.success == "1" {
                            self.bgview.isHidden = false
                            self.successview.isHidden = false
                            self.successResponseLabel.text = "Address created successfully"
                        }
                    }
                    else{
                        self.showCustomAlert(message:responseData?.message ?? "")
                    }
                }
                
            } else {
                self.showCustomAlert(message:responseData?.message ?? "",isSuccessResponse: false)
            }
        }
        print(paramDic)
    }
    //This method is used for edit the address
    func wsUpdateOutlet() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramOutletName] = txtName.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = txtEmail.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileCountryCode] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = txtAddress.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = txtCountry.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = txtCity.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramArea] = txtArea.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountryCode] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPhoneNumber] = txtMobileNumber.text as AnyObject
        paramDic ["country_code"] = txtCountryCode.text as AnyObject
        
        if btnBillingAddress.isSelected{
            paramDic [Constants.WebServiceParameter.paramBillingAddress] = txtBillingAddress.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCountry] = txtBillingCountry.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCity] = txtBillingCity.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingArea] = txtBillingArea.text as AnyObject
        } else {
            paramDic [Constants.WebServiceParameter.paramBillingAddress] = txtAddress.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCountry] = txtCountry.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingCity] = txtCity.text as AnyObject
            paramDic [Constants.WebServiceParameter.paramBillingArea] = txtArea.text as AnyObject
        }
        
        
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        paramDic [Constants.WebServiceParameter.paramBuyerId] = (USERDEFAULTS.getDataForKey(.user_type_id)) as AnyObject
        
        paramDic ["id"] = arrDetail[0].id as AnyObject
        paramDic [Constants.WebServiceParameter.paramStatus]  = statusCode as AnyObject
        
        var arrFilePath = [String]()
        var arrFiles = Array<Dictionary<String, Any>>()
        if (imageData != nil) { // image
            arrFilePath.append(saveImage(data: imageData)?.path ?? "")
            arrFiles = [
                [multiPartFieldName: "outlet_logo",
                  multiPartPathURLs: arrFilePath]
            ]
        }
        var dicAssignUser : [[String:Any]] = []
        print(paramDic)
        print(Constants.WebServiceURLs.updateOutletURL)
        MultiPart().callPostWebService1(Constants.WebServiceURLs.updateOutletURL, parameters: paramDic, filePathArr: arrFiles, model: AddOutletResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? AddOutletResponseModel {
                if (success){
                    if let responseData = responseData as? AddOutletResponseModel {
                        if dicResponseData.success == "1" {
                            self.bgview.isHidden = false
                            self.successview.isHidden = false
                            self.successResponseLabel.text = "Address updated successfully"
                        }
                    }
                    else{
                        self.showCustomAlert(message:responseData?.message ?? "")
                    }
                }
                
            } else {
                self.showCustomAlert(message:responseData?.message ?? "",isSuccessResponse: false)
            }
        }
    }
    //This method is used for invoke add warehouse API
    func wsAddWarehouse() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramWarehouseName] = txtName.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = txtEmail.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = txtAddress.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = txtCountry.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = txtCity.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramArea] = txtArea.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountryCode] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        paramDic [Constants.WebServiceParameter.paramSupplierId] = (USERDEFAULTS.getDataForKey(.user_type_id)) as AnyObject
        paramDic [Constants.WebServiceParameter.paramStatus] = statusCode as AnyObject
        print(paramDic)
        var arrFilePath = [String]()
        var arrFiles = Array<Dictionary<String, Any>>()
        if (imageData != nil) { // image
            arrFilePath.append(saveImage(data: imageData)?.path ?? "")
            arrFiles = [
                [multiPartFieldName: "warehouse_logo",
                  multiPartPathURLs: arrFilePath]
            ]
        }
        MultiPart().callPostWebService1(Constants.WebServiceURLs.addWarehouseURL, parameters: paramDic, filePathArr: arrFiles, model: AddWarehouseResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? AddWarehouseResponseModel {
                if (success){
                    if let responseData = responseData as? AddWarehouseResponseModel {
                        self.showToast(message:responseData.message)
                        if dicResponseData.success == "1" {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    else{
                        self.showCustomAlert(message:responseData?.message ?? "")
                    }
                }
                
            } else {
                self.showCustomAlert(message:responseData?.message ?? "",isSuccessResponse: false)
            }
        }
    }
    //This method is used for invoke the updateware house API
    func wsUpdateWarehouse() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramId] = self.arrDetailWarehouse[0].id as AnyObject
        paramDic [Constants.WebServiceParameter.paramWarehouseName] = txtName.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = txtEmail.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = txtAddress.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = txtCountry.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = txtCity.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramArea] = txtArea.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountryCode] = txtCountryCode.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNumber] = txtMobileNumber.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        paramDic [Constants.WebServiceParameter.paramSupplierId] = (USERDEFAULTS.getDataForKey(.user_type_id)) as AnyObject
        paramDic [Constants.WebServiceParameter.paramStatus] = statusCode as AnyObject
        print(paramDic)
        var arrFilePath = [String]()
        var arrFiles = Array<Dictionary<String, Any>>()
        if (imageData != nil) { // image
            arrFilePath.append(saveImage(data: imageData)?.path ?? "")
            arrFiles = [
                [multiPartFieldName: "outlet_logo",
                  multiPartPathURLs: arrFilePath]
            ]
        }
        var dicAssignUser : [[String:Any]] = []
        MultiPart().callPostWebService1(Constants.WebServiceURLs.updateWarehouseURL, parameters: paramDic, filePathArr: arrFiles, model: AddWarehouseResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? AddWarehouseResponseModel {
                if (success){
                    if let responseData = responseData as? AddWarehouseResponseModel {
                        self.showToast(message:responseData.message)
                        if dicResponseData.success == "1" {
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                    }
                    else{
                        self.showCustomAlert(message:responseData?.message ?? "")
                    }
                }
                
            } else {
                self.showCustomAlert(message:responseData?.message ?? "",isSuccessResponse: false)
            }
        }
    }
    
    @IBAction func btnBillingAddressAct(_ sender: Any) {
        btnBillingAddress.isSelected = !btnBillingAddress.isSelected
        if btnBillingAddress.isSelected{
            self.stackBillingAddress.isHidden = false
        } else {
            self.stackBillingAddress.isHidden = true
        }
    }
    
    @IBAction func btnSaveAct(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            validationAddWarehouse()
        } else {
            validationAddOutlet()
        }
    }
    @IBAction func btnCancelAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btncontinue(_ sender: Any) {
        self.successview.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackTitleAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

//MARK: - UITextField Delegate Methods

extension AddOutletWarehouseVC {
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if(textField.returnKeyType==UIReturnKeyType.next) {
            textField.superview?.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        }
        else if(textField.returnKeyType==UIReturnKeyType.done){
            textField.resignFirstResponder()
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                validationAddWarehouse()
            } else {
                validationAddOutlet()
            }
        }
        return true
    }
}

// MARK: - Pickerview Methods

extension AddOutletWarehouseVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == pickerStatus{
            return dicStatus.count
            
        } else  if pickerView == pickerCuisineType{
            return arrCuisineType.count
            
        } else  if pickerView == pickerBuisnessType{
            return arrBuisnessType.count
            
        } else  if pickerView == pickerSpecialFeature{
            return arrSpecialFeature.count
            
        } else  if pickerView == pickerUsers{
            return arrUsers.count
            
        } else  if pickerView == pickerCountry || pickerView == pickerTimeZone || pickerView == pickerBillingCountry{
            return arrCountry.count
        } else  if pickerView == pickerCity || pickerView == pickerBillingCity{
            return arrCity.count
        } else  if pickerView == pickerArea || pickerView == pickerBillingArea{
            return arrArea.count
        } else  if pickerView == pickerCountryCode{
            return arrContryCode.count
        } else {
            return arrContryCode.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerStatus{
            let objCommonModel = CommonModel(data : dicStatus[row] as NSDictionary)
            return objCommonModel.strTitle
        } else  if pickerView == pickerCuisineType{
            return arrCuisineType[row]
        } else  if pickerView == pickerBuisnessType{
            return arrBuisnessType[row]
        } else  if pickerView == pickerSpecialFeature{
            return arrSpecialFeature[row]
        } else  if pickerView == pickerUsers{
            return "\(arrUsers[row].firstname) \(arrUsers[row].lastname)"
        } else  if pickerView == pickerCountry || pickerView == pickerTimeZone || pickerView == pickerBillingCountry{
            return arrCountry[row].value
        } else  if pickerView == pickerCity || pickerView == pickerBillingCity{
            return arrcity[row]/*.value*/
        } else  if pickerView == pickerArea || pickerView == pickerBillingArea{
            return arrArea[row].value
        } else  if pickerView == pickerCountryCode{
            return "\(arrContryCode[row]["name"]!)(\(arrContryCode[row]["dial_code"]!))"
        } else {
            return "\(arrContryCode[row]["name"]!)(\(arrContryCode[row]["dial_code"]!))"
        }
    }
    //This method to select any country city and area
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == pickerStatus{
            let objCommonModel = CommonModel(data : dicStatus[row] as NSDictionary)
            txtStatus.text = objCommonModel.strTitle
            txtStatus.selectedID = objCommonModel.strID
        } else  if pickerView == pickerCountry{
            txtCountry.text = arrCountry[row].value
        } else  if pickerView == pickerCity{
            txtCity.text = arrcity[row]/*.value*/
        } else  if pickerView == pickerArea{
            txtArea.text = arrArea[row].value
        } else  if pickerView == pickerCountryCode{
            txtCountryCode.text = "\(arrContryCode[row]["name"]!)(\(arrContryCode[row]["dial_code"]!))"
        } else  if pickerView == pickerBillingCountry{
            txtBillingCountry.text = arrCountry[row].value
        } else  if pickerView == pickerBillingCity{
            txtBillingCity.text = arrcity[row]/*.value*/
        } else  if pickerView == pickerBillingArea{
            txtBillingArea.text = arrArea[row].value
        }
    }
}
