void main()
{
  var list = [10,20,30,40];
  list.add(50); //adding element is list
  list.insert(0, 0); //inserting elements in indexes
  print("list->$list");
  list.replaceRange(0, 3, [0,1,2,3]); //replacing ele in list
  print("updated list->$list");
  list.removeAt(4); //remove index from list 
  print("2nd updated list->$list");

}