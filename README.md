# Thrashcan


An iOS App writen using Swift, to manage the display of two major types of content: Documents and Receipts - they are
fundamentally different, but sometimes we want to show both in the same list - like the trashcan.

The trash can is sorted by date, oldest first; sectioned by month.

## Structure

- Currently the app is using a simple **MVVM** structure, having one main ```FileViewModel``` that will serve the information to the trash can,
and two ViewModels to manage specifically **documents** and **receipts**.

- In order to make it as maintainable as possible, a generic ```ItemType``` protocol was created, containing the shared logic between ```Receipts``` and ```Documents```, 
while also allowing us to extend specific logic for each one. This is really useful in order to have one ViewModel that will display all types of files.

- A layer of networking has been created as well, despite not using any API (just the provided JSON files).

- The UI is really simple as well, consisting on a simple TableView with two types of cells, and an activity indicator to simulate the network request.

### Future developments

We’re planning to expand to another country where we won’t have any receipt senders
for quite some time. If possible, we’d like to ship their app slimmed-down, with no
receipts code included.
How would you approach this? What are the considerations in terms of maintainability
etc.?

- Currently, and as the structure is setup, receiving or not any receipts on the JSON response wouldn't cause any problem (and no iOS code would have to be modified in
order to support that). 

- However, if the app is to be slimmed down removing all receipt related code, the changes would be minimal, since all the receipt logic is encapsulated in 
the ```ReceiptViewModel``` and ```Receipt``` objects. Our main ```FileViewModel``` would remain the same. The use of protocols and inheritance explained earlier allow us to
update the structure in a clead and solid way.


