import 'package:flutter/material.dart';
import 'package:insta/screen/add_post.dart';
import 'package:insta/screen/profile.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Text("feed"),
  Text("search"),
  AddPostScreen(),
  Text("notifications"),
  Profile(),
];
