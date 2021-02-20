import 'package:accurate_doctor/screens/billing_payment.dart';
import 'package:accurate_doctor/screens/book_appointment.dart';
import 'package:accurate_doctor/screens/calendar.dart';
import 'package:accurate_doctor/screens/completed_consultation.dart';
import 'package:accurate_doctor/screens/ehr.dart';
import 'package:accurate_doctor/screens/health_summary.dart';
import 'package:accurate_doctor/screens/invoice_report.dart';
import 'package:accurate_doctor/screens/live_chat.dart';
import 'package:accurate_doctor/screens/loading_screen.dart';
import 'package:accurate_doctor/screens/manage.dart';
import 'package:accurate_doctor/screens/manage_doctor.dart';
import 'package:accurate_doctor/screens/manage_schedule.dart';
import 'package:accurate_doctor/screens/messages.dart';
import 'package:accurate_doctor/screens/my_reports.dart';
import 'package:accurate_doctor/screens/my_service_screen.dart';
import 'package:accurate_doctor/screens/my_visits.dart';
import 'package:accurate_doctor/screens/notification.dart';
import 'package:accurate_doctor/screens/subscription.dart';
import 'package:accurate_doctor/screens/upload_consultation.dart';
import 'package:accurate_doctor/widget/reschedule/appointment_reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './modal/Configuration.dart';
import './screens/booked_appointments.dart';
import './screens/my_health.dart';
import './screens/billing_and_payment.dart';
import './screens/second_opinion.dart';
import './screens/doctor_profile.dart';
import './provider/appointment_details.dart';
import 'package:provider/provider.dart';
import './screens/appointments.dart';
import './screens/my_profile.dart';
import './screens/dashboard.dart';
import './screens/forgot_password.dart';
import './screens/reset_password.dart';
import './screens/sign_in.dart';
import './screens/opt_Varification.dart';
import './screens/signup.dart';
import 'package:flutter/material.dart';
import './navigation/NavigationPage.dart';
import 'package:firebase_core/firebase_core.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppointmentDetails(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accurate Doctor',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Configuration.ColorFromHex('#31216F'),
        fontFamily: 'RobotoCondensed',
        canvasColor: Colors.white,
        dividerColor: Colors.blueGrey,
        backgroundColor: Color.fromRGBO(237, 235, 230, 1),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Configuration.ColorFromHex('#5A4A9E'),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Configuration.ColorFromHex('#5A4A9E'),
            fontSize: 72.0,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
              color: Colors.deepPurple,
              fontSize: 36.0,
              fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
            color: Colors.indigo,
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
          bodyText1: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        NavigationPage.SignUp: (_) => SignUp(),
        NavigationPage.OTPVarification: (_) => OTPVarification(),
        NavigationPage.SignIn: (_) => SignInPage(),
        NavigationPage.ForgotPassword: (_) => ForgotPassword(),
        NavigationPage.GenerateNewPassword: (_) => GeneratePassword(),
        NavigationPage.Dashboard: (_) => Dashboard(),
        NavigationPage.MyProfile: (_) => MyProfile(),
        NavigationPage.Appointment: (_) => Appointment(),
        NavigationPage.DoctorProfile: (_) => DoctorProfile(),
        NavigationPage.SecondOpinion: (_) => SecondOpinion(),
        NavigationPage.BillingAndPayment: (_) => BillingAndPayment(),
        NavigationPage.MyHealth: (_) => MyHealth(),
        NavigationPage.Reschedule: (_) => ManageReschedule(),
        NavigationPage.BookAppointment: (_) => BookAppointment(),
        NavigationPage.HealthSummary: (_) => HealthSummary(),
        NavigationPage.Subscription: (_) => Subscription(),
        NavigationPage.CaregiverCalendar: (_) => CaregiverCalendar(),
        NavigationPage.LoadingScreen: (_) => LoadingScreen(),
        NavigationPage.MyVisits: (_) => MyVisit(),
        NavigationPage.Manage: (_) => Manage(),
        NavigationPage.EHR: (_) => EhrPage(),
        NavigationPage.ManageDoctor: (_) => ManageDoctor(),
        NavigationPage.MyReport: (_) => MyReports(),
        NavigationPage.UploadConsultation: (_) => UploadConsultation(),
        NavigationPage.CompletedConsultation: (_) => CompletedConsultation(),
        NavigationPage.InvoiceReport: (_) => InvoiceReport(),
        NavigationPage.AppointentReport: (_) => AppointmentReports(),
        NavigationPage.Notification: (_) => NotificationPage(),
        NavigationPage.Messages: (_) => Messages(),
        NavigationPage.MyService: (_) => MyServicePage(),
        NavigationPage.BillingAngPaymentPage: (_) => BillingAndPaymentPage(),
        NavigationPage.ManageSchedule: (_) => ManageSchedulePage(),
        NavigationPage.LiveChatBox: (_) => LiveChat(),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (ctx) => LoadingScreen());
      },
    );
  }
}
