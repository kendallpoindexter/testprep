## Build tools & versions used
I utilized SDWebImage and swift package manager in order to handle image loading and caching. 
This app utilizes ios 15 but given the minimum deployment target of Square is ios 12 I tried to only use apis available up to ios 13 (utilizing UITableViewDiffableDataSource and NSDiffableDataSourceSnapshot)

## Steps to run the app
1) Unzip the xcode project 
2) Tap on the DirectoryApp.xcodeproj to open it 
3) Simply run the project in an iphone simulator

## What areas of the app did you focus on?
I focused mostly on architecture and code cleanliness.
I also had a phone focus here when building the project.

## What was the reason for your focus? What problems were you trying to solve?
I focused on app architecture in order to make sure that my code was easily testable and modular. Testing is much easier if certain objects can be given mock implementations. In order to achieve mockability I decided to use protocols to abstract away concrete implementations. This also gives an added benefit of making refactoring a bit easier if need be because you can change concrete implementations without having to update call sites. 
I also wanted to make sure that I separated concerns as best I could so I utilized the MVVM pattern. This allowed me to not crowd my viewcontroller with business logic. 

## How long did you spend on this project?
I spent approximately about 5 hours cumulatively on this project

## Did you make any trade-offs for this project? What would you have done differently with more time?
I chose to utilize interface builder for the project UI for speed. Given more time I would have built the UI programmatically and created a coordinator to handle presenting the intial screens in the app.

## What do you think is the weakest part of your project?
The weakest aspect of my project is UI and potentially navigation. If we needed to add more screens, navigation using segues can become a bit messy and complicated to use.

## Did you copy any code or dependencies? Please make sure to attribute them here!
The code in the TableViewExtension was inspired by a stack overflow post about handling Tableview empty states. I liked the idea of adding this code to an extension in order to make my code more reusable without over engineering given the scope of the project.

## Is there any other information you’d like us to know?
I would love any and all feedback on this project and I am excited to discuss it with other engineers. I had a lot of fun building this.
