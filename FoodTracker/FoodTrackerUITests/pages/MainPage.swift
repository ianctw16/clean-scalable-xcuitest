import XCTest

final class MainPage: Page {
    lazy var addButton = app.buttons["Add"].firstMatch
    lazy var deleteButton = app.buttons["Delete"].firstMatch
    lazy var title = app.navigationBars["Your Meals"].firstMatch
    lazy var meals = app.tables.cells.staticTexts
    lazy var table = app.tables.cells

    required init(_ app: XCUIApplication) {
        super.init(app)
        
        waitFor(element: title, status: .exist)
    }
    
    @discardableResult
    func checkHasMeal(name: String, expected: Bool = true,  stars: Int = 0) -> Self {
        let meal = meals[name].firstMatch
        
        if stars == 0{
            switch expected {
            case true:
                XCTAssertEqual(meal.label, name)
            case false:
                waitFor(element: meal, status: .notExist)
            }
        }
        else{
            let lastRowIndex = table.allElementsBoundByIndex.endIndex
            let lastRow = table.allElementsBoundByIndex[lastRowIndex-1].buttons["Set " + String(stars) + " star rating"]
            XCTAssertEqual(lastRow.value as! String, String(stars) + " stars set.")
            XCTAssertEqual(meal.label, name)
        }
        

        return self
    }
    
    @discardableResult
    func deleteMeal(name: String) -> Self {
        let meal = meals[name].firstMatch
        meal.swipeLeft()
        tap(element: deleteButton)
        
        return self
    }
    
    @discardableResult
    func openAdd() -> AddPage {
        tap(element: addButton)

        return AddPage(app)
    }
}
