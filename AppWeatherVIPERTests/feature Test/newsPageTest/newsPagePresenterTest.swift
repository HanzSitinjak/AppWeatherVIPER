//
//  newsPagePresenterTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 06/11/24.
//

import XCTest
import Nimble
import Quick
@testable import AppWeatherVIPER

final class newsPagePresenterTest: QuickSpec {
    override class func spec() {
        describe("Unit Testing for newsPage feature"){
            var sut: newsPagePresenter!
            var mockViewController: mockView!
            var mockInteractorController: mockInteractor!
            
            beforeEach {
                sut = newsPagePresenter()
                mockViewController = mockView()
                mockInteractorController = mockInteractor()
                
                sut.view = mockViewController
                sut.interactor = mockInteractorController
                mockViewController.presenterToView = sut
            }
            
            context("Menguji apakah data berita berhasil diambil") {
                beforeEach {
                    let dataBerita = [
                        Item(id: 1, judul_berita: "Inainiadidinnif", news_desc: "njauanduadnva", jumlah_like: 12, tanggal_update: "12 Okoavjv 29293", url_newsImg: "http:/kkska", penerbit: "jadjjdjva", desc_detail_news: "kjafahjfadk"),
                        Item(id: 2, judul_berita: "jsnvujadnjav", news_desc: "n dfka dcakd vhjadckanck", jumlah_like: 1345, tanggal_update: "23 jianfya 2993", url_newsImg: "jdhsfhbchad", penerbit: "jfhvsvhajcniaeiva", desc_detail_news: "jadnvajdfuaneunvuaenuaeunvua")
                    ]
                    
                    mockInteractorController.dataNewsJSON = dataBerita
                    mockViewController.loadNewsData()
                }
                
                it("Berhasil menguji banyak data yang diambil") {
                    waitUntil { done in
                        DispatchQueue.main.async {
                            expect(mockViewController.items.count).to(equal(2))
                            done()
                        }
                    }
                }
                
                it("Berhasil menguji data yang di ambil oleh getNewsData!") {
                    expect(mockViewController.items.contains{$0.judul_berita == "Inainiadidinnif"}).to(beTrue())
                }
            }
        }
    }
}

class mockInteractor: newsPageInteractorProtocol {
    var dataNewsJSON: [Item]?
    
    func getDataJSON() -> [AppWeatherVIPER.Item]? {
        return dataNewsJSON
    }
}

class mockView: newsPageViewProtocol {
    var items: [Item] = []
    var presenterToView: AppWeatherVIPER.newsPagePreProtocol?
    
    func loadNewsData() {
        items = presenterToView?.getDataNews() ?? []
    }
}
