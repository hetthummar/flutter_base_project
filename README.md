# baseproject

Base setup which requires in all the projects(Includes authantication, notification, crash reporting and configuration files for color and designs)

## Getting Started

Step to convert it to your own project
1. change file name of project
2. Change package name of project
3. Change import statement with global replacment
  e.g :- import 'package:baseproject/config/size_config.dart';
  In above statement change baseproject with appropiate name
4. if firebase is added then add service.json file in android > app folder and if not then remove
   plugin: 'com.google.gms.google-services' from app level build gradle




