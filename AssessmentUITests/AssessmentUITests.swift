
import XCTest

class AssessmentUITests: XCTestCase {
  var app: XCUIApplication!
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavStyle() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
      
      let tabBarsQuery = app.tabBars
      tabBarsQuery.buttons["Location"].tap()
      let emptyListTable = app.tables["Empty list"]
      XCTAssertTrue(emptyListTable.exists)
      
      tabBarsQuery.buttons["Add"].tap()
      XCTAssertTrue(emptyListTable.exists)

      tabBarsQuery.buttons["Category"].tap()
      XCTAssertTrue(emptyListTable.exists)

      tabBarsQuery.buttons["Chat"].tap()
      XCTAssertTrue(emptyListTable.exists)

      tabBarsQuery.buttons["Home"].tap()
  }
  func testItembarStyle() throws {
         // UI tests must launch the application that they test.
         let app = XCUIApplication()
         app.launch()
       

      
      let channelsNavigationBar = app.navigationBars["Channels"]
      channelsNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 0).tap()
      channelsNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
      channelsNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
    XCTAssertTrue(channelsNavigationBar.exists)

  }
  func testCellActionsStyle() throws {
         // UI tests must launch the application that they test.
         let app = XCUIApplication()
         app.launch()
       
      app.tables/*@START_MENU_TOKEN@*/.buttons["more"]/*[[".cells.buttons[\"more\"]",".buttons[\"more\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      let cell = XCUIApplication().tables.children(matching: .cell).element(boundBy: 1)
      let cellColl = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 1)
      let likeButton = cell.buttons["like"]
     let button = cell.buttons["Button"]
    cell.children(matching: .button).matching(identifier: "share").element(boundBy: 0).tap()
    cell.children(matching: .button).matching(identifier: "share").element(boundBy: 1).tap()

    XCTAssertTrue(button.exists)
    XCTAssertTrue(cell.exists)
    XCTAssertTrue(cellColl.exists)
    XCTAssertTrue(likeButton.exists)
    
      likeButton.tap()
      button.tap()
      likeButton.tap()
      button.tap()
  }
  func testCharachterListStyle() throws {
         // UI tests must launch the application that they test.
         let app = XCUIApplication()
         app.launch()
    
    let collectionViewsQuery = XCUIApplication().tables/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element
    element.swipeLeft()
    element.swipeLeft()
    element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    element.swipeLeft()
    element.swipeLeft()
    element.swipeLeft()
    element.swipeLeft()
    element.swipeLeft()
    }
    func testComicListStyle() throws {
      let app = XCUIApplication()
          app.launch()

          // Opens a menu in my app which contains the table view
         

          // Get a handle for the tableView
          let listpagetableviewTable = app.tables["FeedTable"]

          // Get a handle for the not yet existing cell by its content text
          let cell = listpagetableviewTable.staticTexts["This text is from the cell"]

          // Swipe down until it is visible
          while !cell.exists {
           //   app.swipeUp()
          }

          // Interact with it when visible
          cell.tap()
      }
   func testForCellSelection()throws {
    
    let app = XCUIApplication()
                   app.launch()
       let detailstable = app.tables["FeedTable"]
       let firstCell = detailstable.children(matching: .cell).element(boundBy: 1).children(matching: .other).element
   // XCTAssertTrue(app.tables["FeedTable"].cells.containing(.staticText, identifier: "ComicCell").staticTexts["Some Text"].exists,
               //    "Failure: Something went wrong.")
//    XCTAssert(detailstable.children(matching: .cell).element(boundBy: 1))
       let predicate = NSPredicate(format: "isHittable == true")
       let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        print (expectationEval)
       let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 5.0)
//       XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
//       firstCell.tap()
   }
    func testCharachterSelectStyle() throws {
    
  }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
