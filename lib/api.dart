import 'amino.dart' as amino;

class Account {
  amino.Client client = amino.Client();
  String login = '';
  String password = '';
  int enterState = 0;
  List<String> currentCommunity = [];
  List<String> currentChat = [];
  List<String> currentPost = [];

  void enter(String? login, String? password){
    /*this.login = login ?? '';
    this.password = password ?? '';
    enterState = 200;*/
  }
  List<List<String>> getCommunities() {
    return [['Сообщество 1', '1'], ['Сообщество 2', '2'], ['Сообщество 3', '3']];
  }
  List<List<String>> getChats() {
    switch(currentCommunity[1]){
      case '1': return [['Чат 1', '1'], ['Чат 2', '2'], ['Чат 3', '3']];
      case '2': return [['Чат 4', '4'], ['Чат 5', '5'], ['Чат 6', '6']];
      case '3': return [['Чат 7', '7'], ['Чат 8', '8'], ['Чат 9', '9']];
      default: return [];
    }
  }
  List<List<String>> getMessages() {
    switch(currentChat[1]){
      case '1': return [['Сообщение 1', '1'], ['Сообщение 2', '2'], ['Сообщение 3', '3']];
      case '2': return [['Сообщение 4', '4'], ['Сообщение 5', '5'], ['Сообщение 6', '6']];
      case '3': return [['Сообщение 7', '7'], ['Сообщение 8', '8'], ['Сообщение 9', '9']];
      case '4': return [['Сообщение 10', '10'], ['Сообщение 11', '11'], ['Сообщение 12', '12']];
      case '5': return [['Сообщение 13', '13'], ['Сообщение 14', '14'], ['Сообщение 15', '15']];
      case '6': return [['Сообщение 16', '16'], ['Сообщение 17', '17'], ['Сообщение 18', '18']];
      case '7': return [['Сообщение 19', '19'], ['Сообщение 20', '20'], ['Сообщение 21', '21']];
      case '8': return [['Сообщение 22', '22'], ['Сообщение 23', '23'], ['Сообщение 24', '24']];
      case '9': return [['Сообщение 25', '25'], ['Сообщение 26', '26'], ['Сообщение 27', '27']];
      default: return [];
    }
  }
  List<List<String>> getPosts() {
    switch(currentCommunity[1]){
      case '1': return [['Пост 1', '1'], ['Пост 2', '2'], ['Пост 3', '3']];
      case '2': return [['Пост 4', '4'], ['Пост 5', '5'], ['Пост 6', '6']];
      case '3': return [['Пост 7', '7'], ['Пост 8', '8'], ['Пост 9', '9']];
      default: return [];
    }
  }
  List<String> getPostInformation() {
   switch(currentPost[1]){
     case '1': return ['Пост 1', '123'];
     case '2': return ['Пост 4', '123'];
     case '3': return ['Пост 7', '123'];
     case '4': return ['Пост 10', '123'];
     case '5': return ['Пост 13', '123'];
     case '6': return ['Пост 16', '123'];
     case '7': return ['Пост 19', '123'];
     case '8': return ['Пост 22', '123'];
     case '9': return ['Пост 25', '123'];
     default: return [];
   }
  }
}
