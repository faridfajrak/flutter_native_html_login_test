import 'dart:html';
import 'dart:js' as js;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:playground/html_components/second_page.dart';

class HtmlForm extends StatelessWidget {
  const HtmlForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomString = getRandomString(17);
    ui.platformViewRegistry.registerViewFactory(
      "link_image_instance$randomString",
      (int viewId) {
        DivElement divTxt = DivElement();

        final userName = InputElement(type: 'text');
        final password = InputElement(type: 'password');
        final form = FormElement();
        final button = SubmitButtonInputElement();

        divTxt.innerHtml = "login form";

        userName.required = true;
        userName.autocomplete = 'username';
        userName.name = 'id';

        password.required = true;
        password.autocomplete = 'current-password';
        password.name = 'password';

        form.id = 'my-form';

        button.innerText = 'Login!';

        form.append(userName);
        form.append(password);
        form.append(button);
        button.onClick.listen((event) {
          print('click on login!!');
          if (form.checkValidity()) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const SecondPage()));
          }
          return;
        });

        DivElement div = DivElement();
        div.append(divTxt);
        div.append(form);
        return div;
      },
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 103,
          width: 177,
          child: HtmlElementView(
            viewType: "link_image_instance$randomString",
            onPlatformViewCreated: (_) {
              js.context.callMethod("savePassword");
            },
          ),
        ),
      ),
    );
  }

  static getRandomString(len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
