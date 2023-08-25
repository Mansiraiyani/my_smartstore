class CategoryModel{
  String ? name,image;
  int ? position;

  CategoryModel(this.name, this.image, this.position);
  CategoryModel.fromJson(dynamic json){
    name = json['name'];
    image = json['image'];
    position = json['position'];
  }


  Map<String,dynamic> toJson(){
    var map = <String,dynamic>{};
    map['name']=name;
    map['image']=image;
    map['position']=position;
    return map;
  }


}