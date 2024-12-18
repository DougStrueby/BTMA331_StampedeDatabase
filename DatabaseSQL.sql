-- Dim_Artist Table
CREATE TABLE Dim_Artist (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(255),
    Genre VARCHAR(100),
    NumberOfSongsInSet INT
);

-- Dim_Tent Table
CREATE TABLE Dim_Tent (
    TentID INT PRIMARY KEY,
    TentName VARCHAR(255),
    TentAddress VARCHAR(255)
);

-- Dim_TentArtist Table (Bridge Table between Tent and Artist)
CREATE TABLE Dim_TentArtist (
    TentID INT,
    ArtistID INT,
    PRIMARY KEY (TentID, ArtistID),
    FOREIGN KEY (TentID) REFERENCES Dim_Tent(TentID),
    FOREIGN KEY (ArtistID) REFERENCES Dim_Artist(ArtistID)
);

-- Dim_Event Table
CREATE TABLE Dim_Event (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255),
    EventTime DATETIME
);

-- Dim_Seat Table
CREATE TABLE Dim_Seat (
    SeatID INT PRIMARY KEY,
    SeatSection VARCHAR(100),
    SeatRow VARCHAR(100),
    SeatNumber VARCHAR(100)
);

-- Fact_Rodeo Table
CREATE TABLE Fact_Rodeo (
    RodeoTicketSaleNumber INT PRIMARY KEY,
    SeatID INT,
    VisitorID INT,
    EventID INT,
    PriceOfTicket DECIMAL(10, 2),
    FOREIGN KEY (SeatID) REFERENCES Dim_Seat(SeatID),
    FOREIGN KEY (VisitorID) REFERENCES Dim_Visitor(VisitorID),
    FOREIGN KEY (EventID) REFERENCES Dim_Event(EventID)
);

-- Dim_Drinks Table
CREATE TABLE Dim_Drinks (
    DrinkID INT PRIMARY KEY,
    DrinkName VARCHAR(255),
    DrinkType VARCHAR(100),
    DrinkPrice DECIMAL(10, 2),
    DrinkVolume DECIMAL(10, 2)
);

-- Dim_TentDrinks Table (Bridge Table between Tent and Drinks)
CREATE TABLE Dim_TentDrinks (
    TentID INT,
    DrinkID INT,
    PRIMARY KEY (TentID, DrinkID),
    FOREIGN KEY (TentID) REFERENCES Dim_Tent(TentID),
    FOREIGN KEY (DrinkID) REFERENCES Dim_Drinks(DrinkID)
);

-- Fact_TentAdmission Table
CREATE TABLE Fact_TentAdmission (
    TentAdmissionSalesNumber INT PRIMARY KEY,
    TentID INT,
    AdmissionCost DECIMAL(10, 2),
    VisitorID INT,
    FOREIGN KEY (TentID) REFERENCES Dim_Tent(TentID),
    FOREIGN KEY (VisitorID) REFERENCES Dim_Visitor(VisitorID)
);

-- Dim_Visitor Table
CREATE TABLE Dim_Visitor (
    VisitorID INT PRIMARY KEY,
    VisitorFirstName VARCHAR(100),
    VisitorLastName VARCHAR(100),
    Gender VARCHAR(10),
    VisitorAge INT,
    AgeGroup VARCHAR(50),
    VisitorEmail VARCHAR(255),
    CityVisitingFrom VARCHAR(255),
    ProvinceVisitingFrom VARCHAR(255)
);

-- Dim_Entrance Table
CREATE TABLE Dim_Entrance (
    EntranceID INT PRIMARY KEY,
    LocationName VARCHAR(255),
    EntranceAddress VARCHAR(255)
);

-- Dim_Rates Table
CREATE TABLE Dim_Rates (
    RateID INT PRIMARY KEY,
    DiscountName VARCHAR(255),
    DiscountDescription VARCHAR(255),
    Price DECIMAL(10, 2),
    Bundle CHAR(1)
);

-- Fact_ParkAdmission Table
CREATE TABLE Fact_ParkAdmission (
    AdmissionID INT PRIMARY KEY,
    VisitorID INT,
    EntranceID INT,
    RateID INT,
    AdmissionSaleAmount DECIMAL(10, 2),
    VisitorEntryTime DATETIME,
    VisitorExitTime DATETIME,
    DurationOfVisit INT,
    NumberOfVisitorsUnderPurchase INT,
    FamilyPass CHAR(1),
    FOREIGN KEY (VisitorID) REFERENCES Dim_Visitor(VisitorID),
    FOREIGN KEY (EntranceID) REFERENCES Dim_Entrance(EntranceID),
    FOREIGN KEY (RateID) REFERENCES Dim_Rates(RateID)
);

-- Dim_Vendor Table
CREATE TABLE Dim_Vendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(255),
    Rating DECIMAL(3, 2)
);

-- Dim_Food Table
CREATE TABLE Dim_Food (
    FoodID INT PRIMARY KEY,
    Name VARCHAR(255),
    Category VARCHAR(100),
    ProductPrice DECIMAL(10, 2),
    VendorID INT,
    FOREIGN KEY (VendorID) REFERENCES Dim_Vendor(VendorID)
);

-- Fact_Foodsales Table
CREATE TABLE Fact_Foodsales (
    FoodSaleNumber INT PRIMARY KEY,
    VisitorID INT,
    FoodID INT,
    QuantitySold INT,
    Sales DECIMAL(10, 2),
    FOREIGN KEY (VisitorID) REFERENCES Dim_Visitor(VisitorID),
    FOREIGN KEY (FoodID) REFERENCES Dim_Food(FoodID)
);
