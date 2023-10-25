// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:firebase_core/firebase_core.dart';

const REGISTER_NEAR_WALLET = "https://wallet.near.org/create";
const API_REALITY_NEAR = "https://api.realitynear.org/api/v1/";
const API_REALITY_NEAR_IMGs = "https://api.realitynear.org";
const NEAR_RPC_TESTNET = "https://rpc.testnet.near.org";
const NEAR_RPC = "https://rpc.testnet.near.org";
const NEAR_RPC_MAINNET = "https://rpc.mainnet.near.org";
// const MAPBOX_ACCESS_TOKEN = "sk.eyJ1IjoicmVhbGl0eS1uZWFyLWRldnMiLCJhIjoiY2w1cjN5enZ2MDcxazNjb2VlOGU5ZXpsZyJ9.BeuV7flx6u-odZyySFJNmQ";
const MAPBOX_ACCESS_TOKEN =
    "pk.eyJ1IjoicmVhbGl0eS1uZWFyLWRldnMiLCJhIjoiY2w1cjZucXgzMjNvNzNlbndhbjhrYzBxNSJ9.H1Qazb-WKbVB3necwmEFqQ";
const PLAY_STORE_URL =
    "https://play.google.com/store/apps/details?id=org.realitynear.reality_near";
const MAP_BOX_V2 =
    "sk.eyJ1IjoicmVhbGl0eS1uZWFyLWRldnMiLCJhIjoiY2xkc2NwMDUxMWxuMDNvcXJuNDdxZTU1NCJ9.DqJQ5lX7Wmrva6leP8FaEQ";

//GET PATHS FROM FIRESTORE
class FirestorePaths {
  getMainPathsFromFirestore() async {
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var doc = await firestore.collection('app').doc('info').get();
    doc.data()?.forEach((key, value) {
      setPreference(key, value);
    });
  }
}
