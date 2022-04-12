import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itzcord/Model/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen {
  static List<Account> accounts = [];
  static String selectedAccount = "";
  static bool fetched = false;

  static Stream<Account> fetchAccount() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? account = prefs.getString("account.selected");
    if (account != null) {
      selectedAccount = account;
    }

    List<String>? ss = prefs.getStringList("accounts");
    if (ss != null) {
      for (String s in ss) {
        try {
          yield await Account.fromToken(s);
        } catch (e) {}
      }
    }
  }

  static Widget accountButton(Account account, {VoidCallback? onPressed}) {
    return MaterialButton(
      child: Text(account.name),
      color: account.token == selectedAccount ? Colors.blue : Colors.white,
      onPressed: onPressed,
    );
  }

  static Widget build(BuildContext context) {
    Stream<Account> accountStream = fetchAccount();
    List<Widget> children = [];
    for (Account account in accounts) {
      children.add(accountButton(account, onPressed: () {
        selectedAccount = account.token;
      }));
    }
    if (fetched) {
      return Column(
        children: children,
      );
    }

    return StreamBuilder<Account>(
      stream: accountStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Account? account = snapshot.data;
          if (account != null) {
            accounts.add(account);
            children.add(accountButton(account));
          }
        }
        if (snapshot.connectionState == ConnectionState.done) {
          fetched = true;
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen.buildAddAccount(context)));
            },
          ),
          body: Column(
            children: [
              for (Widget child in children) child,
              if (snapshot.connectionState == ConnectionState.waiting)
                const CircularProgressIndicator(),
              if (snapshot.hasError) Text(snapshot.error.toString()),
            ],
          ),
        );
      },
    );
  }

  static buildAddAccount(BuildContext context) {
    return SimpleDialog(
      title: const Text("Add Account"),
      children: [
        MaterialButton(
          child: const Text("Add By Token"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return buildAddToken(context);
            }));
          },
        ),
        MaterialButton(
          child: const Text("Add By Login"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen.buildAddLogin(context);
            }));
          },
        ),
      ],
    );
  }

  static buildAddToken(BuildContext context) {
    return SimpleDialog(
      title: const Text("Add Account"),
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Token"),
          onSubmitted: (token) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static buildAddLogin(BuildContext context) {
    return SimpleDialog(
      title: const Text("Add Account"),
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Login"),
          onSubmitted: (login) {
            Navigator.pop(context);
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Password"),
          onSubmitted: (password) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
