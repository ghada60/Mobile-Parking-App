import 'package:flutter/material.dart';
import 'package:motah/models/local_user.dart';
import 'package:motah/services/firebase_auth_admin.dart';
import 'package:motah/views/create_user_form.dart';
import 'package:motah/views/update_user_form.dart';
import 'package:motah/widgets/custom_widgets.dart';

class UserManageView extends StatefulWidget {
  const UserManageView({super.key});

  @override
  State<UserManageView> createState() => _UserManageViewState();
}

class _UserManageViewState extends State<UserManageView> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthAdminService firebaseAuthAdminService =
        FirebaseAuthAdminService();
    Future<List<LocalUser>>? users;
    // init state
    @override
    void initState() {
      super.initState();

      users = firebaseAuthAdminService.getAllUsers();
    }

    // height of the screen
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MotahAppBar(context, "User Management", height * 0.15, false),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            // navigate to create form
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateUserForm()));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            FutureBuilder<List<LocalUser>>(
              future: firebaseAuthAdminService.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: height * 0.7,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // customize the list item with card and dissmissible
                        return Card(
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {},
                            // show a confirmation dialog
                            confirmDismiss: (direction) async {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm'),
                                      content: const Text(
                                          'Are you sure you wish to delete this item?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () async {
                                              bool isDeleted =
                                                  await firebaseAuthAdminService
                                                      .deleteUser(snapshot
                                                          .data![index].uid
                                                          .toString());
                                              // remove the item from the data source.
                                              setState(() {
                                                snapshot.data!.removeAt(index);
                                              });
                                              if (isDeleted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'User deleted')));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'User not deleted')));
                                              }
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('DELETE')),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('CANCEL'),
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            },
                            background: Container(
                              color: Colors.red,
                            ),
                            child: ListTile(
                                title: Text(
                                    snapshot.data![index].email.toString()),
                                // edit on trail
                                trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // navigate to edit form
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateUserForm(
                                                      user: snapshot
                                                          .data![index])));
                                    })),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ],
        ));
  }
}
