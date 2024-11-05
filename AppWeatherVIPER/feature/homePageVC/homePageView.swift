import UIKit
import CoreData

class homePageView: UIViewController, homePageViewProtocol {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scrollBox: UIScrollView!
    let contentView = UIView()

    // IBOutlet untuk data lokasi dan cuaca
    @IBOutlet weak var labelProvinsi: UILabel!
    @IBOutlet weak var labelKabupaten: UILabel!
    @IBOutlet weak var labelKecamatan: UILabel!
    @IBOutlet weak var containerDetailWeather: UIView!
    @IBOutlet weak var imgWeatherDetails: UIImageView!
    @IBOutlet weak var lblWeatherTemp: UILabel!
    @IBOutlet weak var lblWeatherData: UILabel!
    @IBOutlet weak var lblCuacaData: UILabel!
    @IBOutlet weak var lblDateWeather: UILabel!
    @IBOutlet weak var containerDataWeather: UIView!
    @IBOutlet weak var lblRainfallData: UILabel!
    @IBOutlet weak var lblTCCData: UILabel!
    @IBOutlet weak var lblArahAnginData: UILabel!
    @IBOutlet weak var lblKecAnginData: UILabel!
    @IBOutlet weak var lblKelembapanData: UILabel!

    @IBOutlet weak var iconNews: UIButton!
    var presenterView: homePagePreProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupScrollView()
        presenterView?.getUsername()
        presenterView?.getWeatherAPI()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupIconNewsButton()
    }
    
    func setupIconNewsButton() {
        iconNews.setImage(UIImage(named: "iconNews"), for: .normal)
        iconNews.contentVerticalAlignment = .center
        iconNews.contentHorizontalAlignment = .center
        iconNews.imageView?.contentMode = .scaleAspectFit
        iconNews.imageEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right:0)
        iconNews.addTarget(presenterView, action: #selector(homePagePresenter.getInfoTapped), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        scrollBox.showsHorizontalScrollIndicator = true
        scrollBox.showsVerticalScrollIndicator = false
        scrollBox.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollBox.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollBox.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollBox.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollBox.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollBox.heightAnchor) // Sesuaikan tinggi
        ])
    }

    func showUsername(usernames: [String]) {
        usernameLabel.text = usernames.last ?? "Tidak ada username"
    }

    func showScrollBox(weatherData: [WeatherInfo]?) {
        contentView.subviews.forEach { $0.removeFromSuperview() }

        let items: [UIView]
        if let data = weatherData, !data.isEmpty {
            // Tambahkan item berdasarkan data cuaca
            items = data.map { weatherInfo in
                presenterView?.itemContent(weatherInfo: weatherInfo, index: 0) ?? UIView()
            }
        } else {
            let placeholderCount = 22
            items = (0..<placeholderCount).map { index in
                presenterView?.itemContentPlaceholder(index: index) ?? UIView()
            }
        }

        var previousView: UIView?
        for (index, item) in items.enumerated() {
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                item.widthAnchor.constraint(equalToConstant: 73.0),
                item.heightAnchor.constraint(equalToConstant: 103.0),
                item.leadingAnchor.constraint(equalTo: previousView?.trailingAnchor ?? contentView.leadingAnchor, constant: index == 0 ? 0 : 10),
                item.topAnchor.constraint(equalTo: contentView.topAnchor)
            ])

            let tapGesture = UITapGestureRecognizer(target: presenterView, action: #selector(homePagePresenter.itemTapped(_:)))
            item.addGestureRecognizer(tapGesture)
            item.isUserInteractionEnabled = true  // Pastikan item dapat berinteraksi

            previousView = item
        }

        if let lastView = previousView {
            contentView.trailingAnchor.constraint(equalTo: lastView.trailingAnchor).isActive = true
        }
    }

    func updateData(lokasiInfo: [LokasiInfo], cuacaInfo: [WeatherInfo]) {
        guard let lokasi = lokasiInfo.first else { return }
        DispatchQueue.main.async {
            self.hideSkeletons()
            self.labelProvinsi.text = lokasi.provinsi
            self.labelKabupaten.text = lokasi.kabupaten
            self.labelKecamatan.text = lokasi.kecamatan
        }
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }

    func updateDataCuaca(with weatherInfo: WeatherInfo) {
        DispatchQueue.main.async {
            self.hideSkeletons()
            self.lblRainfallData.text = "\(weatherInfo.rainfall) mm"
            self.lblTCCData.text = "\(weatherInfo.totalCloudCover) %"
            self.lblArahAnginData.text = "\(weatherInfo.arahAngin)°"
            self.lblKecAnginData.text = "\(weatherInfo.kecAngin) m/s"
            self.lblKelembapanData.text = "\(weatherInfo.humidity) %"

            self.containerDetailWeather.backgroundColor = .white
            
            switch weatherInfo.weather {
            case 0, 1:
                self.imgWeatherDetails.image = UIImage(named: "cerah")
            case 2:
                self.imgWeatherDetails.image = UIImage(named: "cerahBerawan")
            case 3:
                self.imgWeatherDetails.image = UIImage(named: "berawan")
            case 61:
                self.imgWeatherDetails.image = UIImage(named: "hujan")
            default:
                print("Cuaca tidak ditemukan.")
            }

            self.lblWeatherTemp.text = "\(weatherInfo.temperature) °C"
            self.lblWeatherData.text = weatherInfo.desCuaca
            self.lblCuacaData.text = weatherInfo.ketCuaca
            self.lblDateWeather.text = weatherInfo.date
        }
    }

    func showSkeletons() {
        labelProvinsi.showSkeletonLoader()
        labelKabupaten.showSkeletonLoader()
        labelKecamatan.showSkeletonLoader()
        containerDetailWeather.showSkeletonLoader()
    }

    func hideSkeletons() {
        labelProvinsi.hideSkeletonLoader()
        labelKabupaten.hideSkeletonLoader()
        labelKecamatan.hideSkeletonLoader()
        containerDetailWeather.hideSkeletonLoader()
    }
}
