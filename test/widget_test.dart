import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:toxisense/main.dart';

void main() {
  testWidgets('MyHomePage widget test', (WidgetTester tester) async {
    // Initialize cameras
    final cameras = await availableCameras();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          home: MyHomePage(cameras: cameras),
        ),
      ),
    );

    // Verify that the widgets are rendered.
    expect(find.byType(AppBar), findsNothing); // AppBar should not be rendered initially
    expect(find.byType(PredictPage), findsOneWidget); // PredictPage should be rendered initially
    expect(find.byType(AccountPage), findsNothing); // AccountPage should not be rendered initially

    // Tap the Account IconButton and trigger a frame.
    await tester.tap(find.byIcon(Icons.account_circle_outlined));
    await tester.pump();

    // Verify that AccountPage is rendered after tapping the IconButton.
    expect(find.byType(AccountPage), findsOneWidget);
    expect(find.byType(PredictPage), findsNothing);
  });

  testWidgets('CustomButton widget test', (WidgetTester tester) async {
    // Initialize cameras
    final cameras = await availableCameras();
    final controller = CameraController(
      cameras[0], // You might want to check the length of the cameras list to ensure it's not empty
      ResolutionPreset.max,
    );
    
    // Initialize the controller
    await controller.initialize();

    // Build our app and trigger a frame.
    // await tester.pumpWidget(
    //   MaterialApp(
    //     home: Scaffold(
    //       body: CustomButton(controller: controller),
    //     ),
    //   ),
    // );

    // Verify that the CustomButton is rendered with the correct initial state.
    expect(find.byIcon(Icons.circle), findsOneWidget); // Verify that the initial icon is correct
    expect(find.text('Stop'), findsNothing); // Verify that the initial text is correct

    // Tap the CustomButton and trigger a frame.
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verify that the CustomButton updates its state correctly after tapping.
    expect(find.byIcon(Icons.square), findsOneWidget); // Verify that the icon updates correctly
    expect(find.text('Stop'), findsOneWidget); // Verify that the text updates correctly
  });
}
