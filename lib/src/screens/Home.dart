import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:urlshortner/src/controllers/HomeController.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static final formKey = GlobalKey<FormState>();
  static final urlTextEditingController = TextEditingController();

  static HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: myBody(context),
    );
  }

  PreferredSizeWidget myAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        children:  [
          Image.asset(
            'assets/images/logo.png',
            height: AppBar().preferredSize.height * 80 / 100,
            fit: BoxFit.fill,
          ),
          const Text(
            'Encurtador de URL',
            style: TextStyle(
              fontFamily: 'URL',
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF182A50),
    );
  }

  Widget myCircularProgressIndicator(BuildContext context, Color color) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  Widget myButtonCreateShortenedUrl(BuildContext context) {
    return ElevatedButton(
      child: Text(
        'Encurtar URL',
        style: TextStyle(
          fontFamily: 'URL',
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFFFFFF),
          fontSize: MediaQuery.of(context).size.height * 2 / 100,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: const Color(0xFF182A50),
        onSurface: const Color(0xFFEDDECD),
        shadowColor: const Color(0xFFEDDECD),
      ),
      onPressed: () {
        if (formKey.currentState.validate() == true) {
          homeController.isProcessingUrl.value = true;
          homeController.createShortenedUrl(urlTextEditingController.text).whenComplete(() {
            urlTextEditingController.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          });
        }
      },
    );
  }

  Widget myBody(BuildContext context) {
    return RxBuilder(
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: const Text(
                          "Encurte ou personalize suas URL's facilmente!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'URL',
                            color: Color(0xFF182A50),
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/people.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 0,
                child: Container(
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'URL',
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF182A50),
                        fontSize: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      cursorColor: const Color(0xFF182A50),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Encurte sua URL',
                        hintStyle: TextStyle(
                          fontFamily: 'URL',
                          color: const Color(0xFF747f96),
                          fontSize: MediaQuery.of(context).size.height * 1.5 / 100,
                        ),
                        fillColor: const Color(0xFFFFFFFF),
                        labelStyle: TextStyle(
                          fontFamily: 'URL',
                          color: const Color(0xFF182A50),
                          fontSize: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF182A50),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF182A50)
                          ),
                        ),
                        errorStyle: TextStyle(
                          fontFamily: 'URL',
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFC4302B),
                          fontSize: MediaQuery.of(context).size.height * 1.5 / 100,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC4302B),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '* Campo obrigatório';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.url,
                      controller: urlTextEditingController,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: homeController.isProcessingUrl.value
                    ?
                  myCircularProgressIndicator(context, const Color(0xFF182A50))
                    :
                  myButtonCreateShortenedUrl(context)
                ),
              ),
              const Divider(
                indent: 5,
                endIndent: 5,
                color: Color(0xFF182A50),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'URL Encurtada:',
                          style: TextStyle(
                            fontFamily: 'URL',
                            color: Color(0xFF182A50),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: homeController.showData.value
                          ?
                        TextButton.icon(
                          icon: const Icon(
                            Icons.language,
                            color: Color(0xFF182A50),
                          ),
                          label: Text(
                            homeController.shortenedUrl.value.toString(),
                            style: const TextStyle(
                              fontFamily: 'URL',
                              color: Color(0xFF182A50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: ()  {
                            homeController.openShortenedUrl(
                              homeController.shortenedUrl.value.toString(),
                            );
                          }
                        )
                          :
                        Container()
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Redireciona Para:',
                          style: TextStyle(
                            fontFamily: 'URL',
                            color: Color(0xFF182A50),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: Text(
                          homeController.originalUrl.value.toString(),
                          style: const TextStyle(
                            fontFamily: 'URL',
                            color: Color(0xFF182A50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
