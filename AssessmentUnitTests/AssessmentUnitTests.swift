
import XCTest
@testable import Assessment

class AssessmentUnitTests: XCTestCase {


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetchComics_ParsesData() {
      // given
      let promise = expectation(description: "Status code: 200")
      
      // when
      guard let url = URL(string:"https://gateway.marvel.com/v1/public/characters/1009146/comics?ts=1&apikey=8157ad875ed81104cd0e0ff54b2f44a3&hash=b66668787b7f4645f596a8fdc2266d2f") else {return}
      let dataTask = URLSession.shared.dataTask(with: url) {
        data, response, error in
        // if HTTP request is successful, define comicResult which parses the response data into Tracks
        if let _ = error {
        } else if let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 {
          guard let decodedResponse = try? JSONDecoder().decode(ResponseJson<ResultComic>.self, from: data!) else {return}
          XCTAssertTrue(!decodedResponse.data.results.isEmpty)
        }
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }
  func test_fetchCharachter_ParsesData() {
       // given
       let promise = expectation(description: "Status code: 200")
       
       // when
       let url = URL(string:"https://gateway.marvel.com:443/v1/public/characters?limit=20&offset=0&ts=1&apikey=8157ad875ed81104cd0e0ff54b2f44a3&hash=b66668787b7f4645f596a8fdc2266d2f")
       let dataTask = URLSession.shared.dataTask(with: url!) {
         data, response, error in
         // if HTTP request is successful, define charachterResult which parses the response data into Tracks
         if let error = error {
           print(error.localizedDescription)
         } else if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
           let decodedResponse = try! JSONDecoder().decode(ResponseJson<ResultCharachter>.self, from: data!)
           XCTAssertTrue(!decodedResponse.data.results.isEmpty)
          XCTAssertFalse(decodedResponse.data.results[0].name.isEmpty)
         }
         promise.fulfill()
       }
       dataTask.resume()
       wait(for: [promise], timeout: 5)
     }
  
  func testDecodingChar() throws {
      /// When the Data initializer is throwing an error, the test will fail.
    let path = Bundle.main.path(forResource: "CharactersSampleData", ofType: "json")
    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)

      /// The `XCTAssertNoThrow` can be used to get extra context about the throw
      XCTAssertNoThrow(try JSONDecoder().decode(ResponseJson<ResultCharachter>.self, from: jsonData))
  }
  func testDecodingComic() throws {
      /// When the Data initializer is throwing an error, the test will fail.
    let path = Bundle.main.path(forResource: "ComicsSampleData", ofType: "json")
    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)

      /// The `XCTAssertNoThrow` can be used to get extra context about the throw
      XCTAssertNoThrow(try JSONDecoder().decode(ResponseJson<ResultComic>.self, from: jsonData))
  }
  // Performance
  func test_StartDownload_Performance() {
    let image = CustomUIImageView()
    let url = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/e0/59fa489ec405b.jpg")

    measure {
       image.downloadedFrom(url: url!, path: "photo/temp/Comics/")
    }
  }
}
