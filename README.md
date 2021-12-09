# Widoo App
A project management mobile app

## Install
### Backend
This project requires a connection to the [widoo-back](https://github.com/Poulpinou/widoo-back) API in order to work correctly.

### Classes generation
Some classes have to be generated with this command :
```
flutter pub run build_runner build --delete-conflicting-outputs
```
or if you want them to be generated while editing code:
```
flutter pub run build_runner watch --delete-conflicting-outputs
```
or you can add [this script](/scripts/build_watch.sh) to your run configurations if you are using IntelliJ.

### Run the app
To run this app, run one of those files *lib/main_{env}_{target}.dart* (if none of those files is matching your config, you can create your own).