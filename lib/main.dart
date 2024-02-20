import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}



class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Sign Lang Detect',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        home: MyHomePage(cameras: cameras),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}



class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MyHomePage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _selectedIndex == 0
          ? PredictPage(cameras: widget.cameras)
          : AccountPage(isLoggedIn: false),
      bottomNavigationBar: BottomAppBar(
        height: 100.0,
        color: Color.fromRGBO(255, 255, 255, 1),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            IconButton(
              iconSize: 35,
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt_rounded,
                      color: _selectedIndex == 0
                          ? Color.fromARGB(255, 0, 0, 128)
                          : Color.fromARGB(255, 133, 133, 133)),
                  Text('Predict',
                      style: TextStyle(
                          color: _selectedIndex == 0
                              ? Color.fromARGB(255, 0, 0, 128)
                              : Color.fromARGB(255, 133, 133, 133)))
                ],
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              iconSize: 35,
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_circle_outlined,
                      color: _selectedIndex == 1
                          ? Color.fromARGB(255, 0, 0, 128)
                          : Color.fromARGB(255, 133, 133, 133)),
                  Text('Account',
                      style: TextStyle(
                          color: _selectedIndex == 1
                              ? Color.fromARGB(255, 0, 0, 128)
                              : Color.fromARGB(255, 133, 133, 133))),
                ],
              ),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}



class AccountPage extends StatelessWidget {
  final bool isLoggedIn;

  const AccountPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 128))),
      ),
      body: Center(
        child: isLoggedIn
            ? _buildLoggedInContent(context)
            : _buildLoggedOutContent(context),
      ),
    );
  }

  Widget _buildLoggedInContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        CircleAvatar(
          radius: 50,
          
          backgroundImage: AssetImage('assets/yunus.png'),
        ),

        SizedBox(height: 20),

        Text(
          'Yunus Emre Koç',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),

        Container(
          width: 85,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color.fromARGB(255, 47, 47, 47),
              width: 1,
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(),
                ),
              );
            },

            child: Text(
              'History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 128), fontSize: 14),
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _buildLoggedOutContent(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn() {
    String email = emailController.text;
    String password = passwordController.text;

    // Giriş yapma işlemleri burada yapılacak
  }

  return Center(
    child: Container(
      width: 300, 
      height: 300, 
      padding: EdgeInsets.all(10), 
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.green],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [

          Icon(
            Icons.star,
            size: 70,
            color: Colors.white,
          ),

          SizedBox(height: 10),

          Text(
            'Get More Features',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),

          SizedBox(height: 8),

          Text(
            'Create an account and save photos in history',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: 170,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 30, 129),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },

                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Color.fromRGBO(248, 248, 248, 1),
                        fontSize: 14),
                  ),
                ),
              ),

              SizedBox(width: 10),

              Container(
                width: 85,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },

                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 128), fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  }

}

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _signIn() {
      String email = emailController.text;
      String password = passwordController.text;

      // Giriş yapma işlemleri burada yapılacak
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Sign in'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          // EMAIL
            Container(
              padding: EdgeInsets.all(5.0),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 67, 67, 67),
                      width: 1.0,
                    ),

              ),
              child: Center(
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              )
            ),  

            SizedBox(height: 20),

            //  PASSWORD
            Container(
              padding: EdgeInsets.all(5.0),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 67, 67, 67),
                      width: 1.0,
                    ),

              ),
              child: Center(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              )
            ),

            SizedBox(height: 30),

            // Sign in
            Container(
              width: 380,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 30, 129),
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to sign up page
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      fontSize: 14),
                ),
              ),
            ),
          
            SizedBox(height: 30),

            Text('or continue with', style: TextStyle(fontSize: 14.0, color: const Color.fromARGB(255, 30, 30, 129))),

            SizedBox(height: 15),


            //  Google and Apple
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // GOOGLE
                GestureDetector(
                  onTap: () {
                    // İzlenecek işlev
                  },
                  child: Container(
                    width: 60, 
                    height: 60, 
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, 
                      border: Border.all(
                        color: Colors.grey,
                        width: 1, 
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/google_logo.png', 
                        width: 25, 
                        height: 25, 
                      ),
                    ),
                  ),
                ),



                SizedBox(width: 30),

                // APPLE
                GestureDetector(
                  onTap: () {
                    // İzlenecek işlev
                  },
                  child: Container(
                    width: 60, 
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, 
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/apple_logo.png',
                        width: 25,
                        height: 25, 
                      ),
                    ),
                  ),
                ),



              ],
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Need an account?",
                style: TextStyle(color: Color.fromARGB(255, 30, 30, 129) )),

                SizedBox(width: 5.0),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 30, 30, 129), 
                    ),
                  ),
                )

              ]

            )
            
          ],
          ),
        ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _signIn() {
      String email = emailController.text;
      String password = passwordController.text;

      // Giriş yapma işlemleri burada yapılacak
    }


    return Scaffold(

      appBar: AppBar(
        title: Text('Sign up'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          // EMAIL
            Container(
              padding: EdgeInsets.all(5.0),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 67, 67, 67),
                      width: 1.0,
                    ),

              ),
              child: Center(
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              )
            ),  

            SizedBox(height: 20),

            //  PASSWORD
            Container(
              padding: EdgeInsets.all(5.0),
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 67, 67, 67),
                      width: 1.0,
                    ),

              ),
              child: Center(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              )
            ),

            SizedBox(height: 30),

            // Sign in
            Container(
              width: 380,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 30, 129),
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to sign up page
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      fontSize: 14),
                ),
              ),
            ),
          
            SizedBox(height: 30),

            Text('or continue with', style: TextStyle(fontSize: 14.0, color: const Color.fromARGB(255, 30, 30, 129))),

            SizedBox(height: 15),


            //  Google and Apple
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // GOOGLE
                GestureDetector(
                  onTap: () {
                    // İzlenecek işlev
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, 
                      border: Border.all(
                        color: Colors.grey, 
                        width: 1, 
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/google_logo.png', 
                        width: 25,
                        height: 25, 
                      ),
                    ),
                  ),
                ),



                SizedBox(width: 30),

                // APPLE
                GestureDetector(
                  onTap: () {
                    // İzlenecek işlev
                  },
                  child: Container(
                    width: 60, 
                    height: 60, 
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1, 
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/apple_logo.png', 
                        width: 25, 
                        height: 25, 
                      ),
                    ),
                  ),
                ),



              ],
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Already have an account?",
                style: TextStyle(color: Color.fromARGB(255, 30, 30, 129) )),

                SizedBox(width: 5.0),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 30, 30, 129), 
                    ),
                  ),
                )

              ]

            )
            
          ],
          ),
        ),
    );
  }
}



class PhotoManager {
  static final PhotoManager _instance = PhotoManager._internal();
  factory PhotoManager() => _instance;

  PhotoManager._internal();

  List<String> _imagePaths = [];
  
  void addPhoto(String path) {
    _imagePaths.add(path);
  }

  List<String> get imagePaths => _imagePaths;
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = PhotoManager().imagePaths;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),

      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          String imagePath = imagePaths[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.file(
                File(imagePath),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
              title: Text('Photo ${index + 1}'),
            ),
          );
        },
      ),


    );
  }
}


class PredictPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const PredictPage({required this.cameras, Key? key}) : super(key: key);

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  late CameraController _controller;
  int _selectedCameraIndex = 0;
  List<String> _imagePaths = [];
  XFile? _imageFile;
  PhotoManager _photoManager = PhotoManager();
  late String textContent = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    fetchTextFromAPI();
  }

  Future<void> fetchTextFromAPI() async {
    var url = Uri.parse('http://localhost:5000/model');

    try {
      var response = await http.get(url);
      
      if (response.statusCode == 200) {
        // If successful, parse the JSON response
        var jsonResponse = json.decode(response.body);

        setState(() {
          textContent = jsonResponse['text'];
          print('Text Content api: $textContent');
        });
      } else {
        // If not successful, print error message
        print('Failed to fetch text. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // If an exception occurs, print error message
      print('Exception occured while fetching text: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      _controller = CameraController(
        widget.cameras[_selectedCameraIndex],
        ResolutionPreset.max,
      );
      await _controller.initialize();
      _controller.setFlashMode(FlashMode.off); 
      setState(() {});
    }
  }


  void _takePicture() async {
    try {
      XFile picture = await _controller.takePicture();
      setState(() {
        _imageFile = picture; 
        _imagePaths.add(picture.path);
        _photoManager.addPhoto(picture.path);
      });
    } catch (e) {
      print("Fotoğraf çekimi başlatılamadı: $e");
    }
  }

  void _clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {


    if (widget.cameras.isEmpty) {
      return Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(), 
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Predict', style: TextStyle(color: Color.fromARGB(255, 0, 0, 128))),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ),
        body: Stack(
          children: [


            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   child: Transform.scale(
            //     scale: 1.0,
            //     child: CameraPreview(_controller),
            //   ),
            // ),
          
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CameraPreview(_controller),
              ),
            ),


            if (_imageFile != null)
              Positioned.fill(
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                ),
              ), 
            
            if (_imageFile != null) 
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width / 2 - 85,
                child: Container(
                  width: 170, 
                  height: 50, 
                  decoration: BoxDecoration(
                    color: Color.fromARGB(161, 0, 0, 0),
                    borderRadius: BorderRadius.circular(25.0),
                  )   ,

                  child: Center(
                    child: Text(
                      textContent,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                )
              )
            
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.5 - 35,
            child: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(50.0),

              ),
              child: IconButton(
                onPressed: () {
                  if (_imageFile == null) {
                    _takePicture();
                  } else {
                    _clearImage();
                  }
                },
                icon:
                    Icon(_imageFile == null ? Icons.camera : Icons.refresh),
                color: Color.fromARGB(255, 0, 0, 128), // Camera icon
                iconSize: 35.0,
              ),
            ),
          )
        ]
      )
    );
  }
}