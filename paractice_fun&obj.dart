import 'dart:io';

void main()
{

  print('welcome to dart');

  var classs = myCLass();     //object
  classs.sum(7,8);               //function calling
  classs.name("Ali");
  classs.sum(9,5);

}
class myCLass
{
  int sum(int no1,int no2)
  {

    int sum = no1 + no2;
    print(sum);

    return sum;

  }

  void name(String name) //para constructer
  {
    print(name);
  }

}


