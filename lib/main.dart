import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Buscador());
}
class Buscador extends StatefulWidget {
  const Buscador({ Key? key }) : super(key: key);

  @override
  _BuscadorState createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
        url: auxurl,
        withJavascript: true,
        withLocalStorage: true,
        withZoom: false,
        enableAppScheme: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,),
          actions:<Widget>[
            IconButton(onPressed: ()=>navegador.goBack(),
             icon: Icon(Icons.arrow_back)
            ),
            IconButton(onPressed: ()=>navegador.goForward(),
            icon: Icon(Icons.arrow_forward)
            ),
            IconButton(onPressed: ()=>webviewProcess(),
             icon: Icon(Icons.search),
            ),
          ],
           title: Padding(
             padding: const EdgeInsets.all(6.0),
             child: Container(
               height: 50,
              decoration: 
              BoxDecoration (
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(6.0),
              child: TextField(
                textInputAction: TextInputAction.go,
                controller: urlsearch,
                onSubmitted: (url)=>webviewProcess(),
                decoration: 
                  InputDecoration(
                    border: InputBorder.none,
                    hintText: "https://ejemplo.com",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
              ),
          ),
          ),  
        ),
      ),
      
    );
  }
  FlutterWebviewPlugin navegador = new FlutterWebviewPlugin();
  var urlsearch = TextEditingController();
  var auxurl="https://duckduckgo.com/?va=b&t=hc";
  void webviewProcess(){
    setState(() {
      if (urlsearch.text.contains('.')){
        auxurl="https://"+urlsearch.text;
        FocusScope.of(context).unfocus();
      }
      else{
        auxurl="https://duckduckgo.com/?q="+urlsearch.text;
        FocusScope.of(context).unfocus();
      }
      navegador.reloadUrl(auxurl);
    });
  }

}