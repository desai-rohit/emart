import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const userCOllection = "devusers";
const productCollection = "devproduct";
const cartCollection = "devcart";
const chatsCollection = "devchats";
const messageCollection = "devmessage";
const orderCollection = "devorders";
const addAddressCollection = "devaddAddress";
const reviewCollection = "devreview";
