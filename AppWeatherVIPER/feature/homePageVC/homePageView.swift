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
        showUsername()
        presenterView?.getWeatherAPI()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupIconNewsButton()
    }
    
    func setupIconNewsButton() {
        iconNews.setImage(UIImage(named: "iconNews"), for: .normal) // Gambar icon
//        iconNews.setTitle("News", for: .normal) // Teks di bawah icon
//        iconNews.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        iconNews.setTitleColor(.white, for: .normal)

        // Atur posisi teks dan gambar agar vertikal dan rata tengah
        iconNews.contentVerticalAlignment = .center
        iconNews.contentHorizontalAlignment = .center
        iconNews.imageView?.contentMode = .scaleAspectFit

        // Sesuaikan posisi teks terhadap gambar
//        iconNews.titleEdgeInsets = UIEdgeInsets(top: 8, left: -iconNews.imageView!.frame.size.width, bottom: -40, right: 0)
        iconNews.imageEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right:0)
        iconNews.addTarget(presenterView, action: #selector(homePagePresenter.getInfoTapped), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        // Atur scrollBox untuk menggulir horizontal
        scrollBox.showsHorizontalScrollIndicator = true
        scrollBox.showsVerticalScrollIndicator = false
        
        // Tambahkan contentView ke dalam scrollBox
        scrollBox.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Atur constraint agar contentView mengikuti ukuran scrollBox
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollBox.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollBox.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollBox.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollBox.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollBox.heightAnchor) // Sesuaikan tinggi
        ])
    }

    func showUsername() {
        let usernames = presenterView?.fetchUsername()
        usernameLabel.text = usernames?.last ?? "Tidak ada username"
    }

    func showScrollBox(weatherData: [WeatherInfo]?) {
        // Hapus semua subviews sebelum menambahkan item baru
        contentView.subviews.forEach { $0.removeFromSuperview() }

        let items: [UIView]
        if let data = weatherData, !data.isEmpty {
            // Tambahkan item berdasarkan data cuaca
            items = data.map { weatherInfo in
                presenterView?.itemContent(weatherInfo: weatherInfo, index: 0) ?? UIView()
            }
        } else {
            // Jika tidak ada data, tambahkan placeholder
            let placeholderCount = 22
            items = (0..<placeholderCount).map { index in
                presenterView?.itemContentPlaceholder(index: index) ?? UIView()
            }
        }

        // Tambahkan item-item ke contentView dan atur constraint dinamis
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

            // Menambahkan Gesture Recognizer
            let tapGesture = UITapGestureRecognizer(target: presenterView, action: #selector(homePagePresenter.itemTapped(_:)))
            item.addGestureRecognizer(tapGesture)
            item.isUserInteractionEnabled = true  // Pastikan item dapat berinteraksi

            previousView = item
        }

        if let lastView = previousView {
            // Set trailing agar contentView menyesuaikan panjang total item
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
