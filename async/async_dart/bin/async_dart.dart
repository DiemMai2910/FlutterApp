void main(List<String> arguments) async {
  print('Hello world!');
  getDataFromDatabase().then((value){
    print (value);
  });
   print('Done!');
}
//Future<T>
//async/ await => đánh dấu hàm bất đồng bộ
//await => đợi 1 qt bất đồng bộ kết thúc
//then


// Hàm lấy dữ liệu 
Future<String> getDataFromDatabase() async{
  print('Start!');

// xử lý lấy dữ liệu từ csdl
final result = await Future.delayed(
  Duration(seconds: 3),(){
    return 'Data';
  }
  );


//
 return result;
print('end!');
}
