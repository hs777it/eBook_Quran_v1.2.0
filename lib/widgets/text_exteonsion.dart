extension TextExtension on String{
  String titleCustom(){
    return this.length > 15 ? '${this.substring(0, 15)}...' : this;
  }
  String titleHead(){
    return this.length > 35 ? '${this.substring(0, 35)}...' : this;
  }

  String bookDescription(){
    return this.length > 300 ? '${this.substring(0, 300)}...' : this;
  }

}