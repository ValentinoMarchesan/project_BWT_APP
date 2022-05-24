import 'package:floor/floor.dart';
import 'package:project/database/entities/accountdata.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class AccountDataDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM AccountData')
  Future<List<AccountData>> findAllAccountData();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertAccountData(AccountData accountData);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteAccountData(AccountData task);
}//TodoDao