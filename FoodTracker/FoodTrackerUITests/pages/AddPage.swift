import XCTest

final class AddPage: Page {
    lazy var saveButton = app.buttons["Save"].firstMatch
    lazy var textField = app.textFields.firstMatch
    
    required init(_ app: XCUIApplication) {
        super.init(app)
        
        waitFor(element: textField, status: .hittable)
    }
    
    @discardableResult
    func addMeal(name: String, stars: Int = 0) -> MainPage {
        tap(element: textField)
        typeText(element: textField, text: name + "\n")
        if stars != 0{
           let starButton = app.buttons["Set " + String(stars) + " star rating"].firstMatch
            tap(element: starButton)
        }
        tap(element: saveButton)

        return MainPage(app)
    }
}
