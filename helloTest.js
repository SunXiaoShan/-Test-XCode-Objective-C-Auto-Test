
var target = UIATarget.localTarget();

var app = target.frontMostApp();

var window = app.mainWindow();

target.logElementTree();
UIALogger.logStart("== Log History ==");

// message log
UIALogger.logMessage("Message Log");

// handle time
// target.pushTimeout(10);
// target.popTimeout();

// main page
UIATarget.localTarget().delay(1);

target.captureScreenWithName("myscreenshot");

window.textViews()["mainPageText"].setValue("Hi. This it auto test");
UIATarget.localTarget().delay(1);
var navigationRightButton = UIATarget.localTarget().frontMostApp().navigationBar().buttons()["mainPageBarRight"];
navigationRightButton.tap();

// [Easy Sample] test fill text & show context
UIATarget.localTarget().delay(1);
target.logElementTree();
var btnEasySample = window.buttons()["EasySampleButton"];
var textEasySample = window.textFields()["EasySampleText"];
btnEasySample.tap();
textEasySample.setValue("auto rebot");
btnEasySample.tap();
navigationRightButton = UIATarget.localTarget().frontMostApp().navigationBar().buttons()["EasySampleBarRight"];
navigationRightButton.tap();

// [Auto Scroll View] test
UIATarget.localTarget().delay(1);
target.logElementTree();
var scrollAutoScrollView = window.scrollViews()["AutoScrollViewScrollview"];
var labelAutoScrollView = scrollAutoScrollView.elements()["AutoScrollViewLabelView"];
scrollAutoScrollView.scrollUp();
UIATarget.localTarget().delay(1);
scrollAutoScrollView.scrollLeft();
UIATarget.localTarget().delay(1);
scrollAutoScrollView.scrollRight();
UIATarget.localTarget().delay(1);
scrollAutoScrollView.scrollDown();
UIATarget.localTarget().delay(1);
scrollAutoScrollView.scrollToElementWithName(labelAutoScrollView.name());
navigationRightButton = UIATarget.localTarget().frontMostApp().navigationBar().buttons()["AutoScrollViewScrollviewBarRight"];
navigationRightButton.tap();

// [Auto Table View] test
UIATarget.localTarget().delay(1);
target.logElementTree();
var tableAutoTableView = window.tableViews()["AutoTableViewTable"];
var cell01AutoTableView = tableAutoTableView.cells()[0];
var cell10AutoTableView = tableAutoTableView.cells()[10];
var cell30AutoTableView = tableAutoTableView.cells()[30];
var cell40AutoTableView = tableAutoTableView.cells()[40];

cell01AutoTableView.tap();
tableAutoTableView.scrollUp();
UIATarget.localTarget().tap({x:210,y:80});

UIATarget.localTarget().delay(1);
tableAutoTableView.scrollToElementWithName(cell30AutoTableView.name());
UIATarget.localTarget().delay(1);
tableAutoTableView.scrollToElementWithName(cell10AutoTableView.name());
cell10AutoTableView.tap();
UIATarget.localTarget().delay(1);
tableAutoTableView.scrollToElementWithName(cell40AutoTableView.name());
cell40AutoTableView.textFields()["AutoTableViewTableCellText"].setValue("hello");
UIATarget.localTarget().delay(1);

UIATarget.localTarget().frontMostApp().navigationBar().buttons()["AutoTableViewBarRight"].tap();
UIATarget.localTarget().delay(1);

// [Auto wait view appear] test
var btnWaitView = window.buttons()["WaitViewAppearButton"];
var alertWaitView = window.elements()["alertWaitViewAppear"];

UIALogger.logMessage("Wait View");
btnWaitView.waitForInvalid();
if (btnWaitView.isValid())
{
    UIALogger.logMessage("Click button");
    btnWaitView.tap();
}

UIATarget.localTarget().delay(10); 
target.logElementTree();
var se = alertWaitView.waitForInvalid();
UIALogger.logMessage(""+se);
if (alertWaitView.isValid() && alertWaitView.isVisible()) {
    alertWaitView.defaultButton().tap();
}


UIATarget.localTarget().frontMostApp().navigationBar().buttons()["WaitViewAppearBarRight"].tap();
UIATarget.localTarget().delay(1);

// [Auto AutoDragView] test
target.logElementTree();
var redAutoDragView = window.images()["MagentaSquare.png"];
var blueAutoDragView = window.images()["CyanSquare.png"]
var yellowAutoDragView = window.images()["YellowSquare.png"];
var redX = redAutoDragView.rect().origin.x + 5;
var redY = redAutoDragView.rect().origin.y + 5;
var blueX = blueAutoDragView.rect().origin.x + 5;
var blueY = blueAutoDragView.rect().origin.y + 5;
var yellowX = yellowAutoDragView.rect().origin.x + 5;
var yellowY = yellowAutoDragView.rect().origin.y + 5;

UIATarget.localTarget().dragFromToForDuration({x:blueX,y:blueY},{x:150,y:260},1);
UIATarget.localTarget().dragFromToForDuration({x:redX,y:redY},{x:160,y:500},1);
UIATarget.localTarget().dragFromToForDuration({x:yellowX,y:yellowY},{x:50,y:50},2);



/**/







