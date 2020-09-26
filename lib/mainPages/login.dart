import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_fish/mainPages/signUp.dart';
import 'package:fresh_fish/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:fresh_fish/services/auth.dart';
import 'package:fresh_fish/utilities/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String _error = '';
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
 //Field of userEmail
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'البريد الالكتروني',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (val) => val.isEmpty ? 'ادخل بريدك الالكتروني' : null,
            onChanged: (val) {
              _email = val;
            },
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'ادخل بريدك الالكتروني',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
// Field of userPassword
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'الرقم السري',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            obscureText: true,
            validator: (val) => val.length < 6 ? 'الرقم السري قصير' : null,
            onChanged: (val) {
              _password = val;
            },
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'ادخل الرقم السري',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  // LoginButton to enter mainPage
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            setState(() => loading = true);
            dynamic result =
                await _auth.signInWithEmailAndPassword(_email, _password);
            print("result");
            print(result);
            if (result == null) {
              setState(() {
                loading = false;
                _error = 'خطأ في البريد الالكتروني او الرقم السري   ';
              });
            }
          }
        },

        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  //LoginButtton as aguest without needing of mails
  Widget _buildLoginAsGuest() {
    return Container(
      //alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () async {
          setState(() => loading = true);
          dynamic result =
          await _auth.signInAnon();
          if (result == null) {
            setState(() {
              loading = false;
              _error = 'Could not sign in with those credentials';
            });
          }
        },
        child: Text(
          'Login as a guest',
          style: kLabelStyle,
        ),
      ),
    );
  }
//text
  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'سجل دخولك بواسطة',
          style: kLabelStyle,
        ),
      ],
    );
  }
// design of socialButton
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
// Login with facebook and gmail
  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () async {
              setState(() => loading = true);
              dynamic result = await _auth.signInWithfacebook();
              if (result == null) {
                setState(() {
                  loading = false;
                  _error = "خطأ";
                });
              }
            },
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () async {
              setState(() => loading = true);
              dynamic result = await _auth.signInWithgoogle();
              if (result == null) {
                setState(() {
                  loading = false;
                  _error = 'خطأ';
                });
              }
            },
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }
//Make anew account
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => signUpScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '  لا تملك حساب ؟',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'انشئ حساب',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Make Loading till back to loginPage(if response failed) or enter mainPage (if response success)
    return loading
        ? Loading()
        : Scaffold(
            //backgroundColor: Colors.black12,
            body: Center(
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
               //Stack of buttons and textFields of LoginPage
                  child: Stack(
                    children: <Widget>[
               //View of background
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/background.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: double.infinity,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20,
                            ),
                            child: Form(
                              key: _formkey,
                              child: Padding(
                                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    _buildEmailTF(),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    _buildPasswordTF(),
                                    _buildLoginAsGuest(),
                                    _buildLoginBtn(),
                                    SizedBox(height: 8.0),
                                    Text(
                                      _error,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    ),
                                    SizedBox(height: 10.0),
                                    _buildSignInWithText(),
                                    _buildSocialBtnRow(),
                                    _buildSignupBtn(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
