# Reality Near

This project is a application for IOS and Android, that is part of the Reality Near project, made up of the metaverse NURUK and the web app realitynear.
With this app our users will be able to interact using augmented reality with objects from the Nuruk world and special events of the organization. In addition, they will be able to have a chat with friends, check their near walet or make transfers from it, among other things.


## Features
- CleanArchitecture
- Bloc 8
- View near wallet status
- Token transactions on near blockchain
- View NFTs in wallet
- Chat with friends
- Different languages
- Dark mode
- Implementation of maps
- Use of localization
- AR implementation
- internationalization

## Screenshoots
<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/initScreen.jpeg" alt="drawing" width="200"/>
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/registerScreen.jpeg" alt="drawing" width="200"/>
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/loginScreen.jpeg" alt="drawing" width="200"/>
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/guideScreen.jpeg" alt="drawing" width="200"/> 
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/loginNearScreen.jpeg" alt="drawing" width="200"/> 
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/mapScreen.jpeg" alt="drawing" width="200"/>
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/AR.jpeg" alt="drawing" width="200"/> 
  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/bugScreen.jpeg" alt="drawing" width="200"/>

</p>


## More details
## _Wallet_
*In this section the user will be able to view information about his Realitys and NFTs in his NEAR Wallet.*

### NFT
By querying a smartcontract through the NEAR API we show the user the NFTs achieved in Reality Near (Lands, Patchas and Prizes won).

### Transfer
With this option the user will be able to transfer Realitys to his contacts.

### Movements
We query a smartContract through our API to display the user's movement data.

## _Augmented reality (AR)_
*This section refers to how we make the user see and interact with augmented reality objects placed around the world.*

### Asset
To display the augmented reality asset we use the [ar_flutter_plugin](https://pub.dev/packages/ar_flutter_plugin) library, which allows us to bring an image from the cloud and render it in the augmented reality engines of each operating system such as ArCore (Android) and ArKit (IOS). 

### Tap
When touching the augmented reality asset on the screen, we show a dialog concerning it where we give the user the option to redeem the prize obtained by capturing the asset.


## _Multi language_
*Our purpose is to make more people have access to this app, so we implemented the relevant translations for the moment in Spanish and English. This is possible by making use of internationalization concepts and the [flutter_localizations](https://docs.flutter.dev/development/accessibility-and-localization/internationalization) package.
With this add support in other languages and change the language according to the region of the user's device.*

## _Map_
*To show the location of the user, his friends and nearby events, we make use of maps inside the app. we rely on libraries like location to get the users position and flutter_map to show the map.*

### Mapbox
It is the service chosen for the development of the project, we obtain an api of the same one to be able to have access to visualize the maps and we pass them together with a url of consumption to the [flutter_map](https://pub.dev/packages/flutter_map) library.

<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/mapScreen.jpeg" alt="drawing" width="200"/> 

</p>

## _Chat_
*Users will be able to chat with their friends, see their friends' online status and send and receive text messages in the app.
This feature will be implemented soon.*

## _Contacts_
*Here users can have access to other users by forming a community and adding their friends.*

### List
By querying the RealityNear API we get the user's contact list.

### Send request
The user will be able to send friend requests to his friends, this will be communicated to the API and it will send a notification to the friend.

### Search
Users will be able to search for any user registered in the application using the search bar, it will query the API and return only users with matching names.


<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/searchUser.jpeg" alt="drawing" width="200"/> 

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/requestScreen.jpeg" alt="drawing" width="200"/>

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/searchUser.jpeg" alt="drawing" width="200"/> 

</p>

## _QR_
*Section implemented to generate and scan QRs for user coupons or prizes.*

### Scan
Only users with administrator role will be able to make use of this functionality, so they can validate and redeem the QR coupons of their events. This is possible using the [qr_code_scanner](https://pub.dev/packages/qr_code_scanner) library.


### Cupons
The winning users of a coupon will see in the notifications section a screen where we show them the information of their coupon as well as the QR code to redeem it. The QR code is generated using the [qr_flutter](https://pub.dev/packages/qr_flutter) library.

<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/qrScanScreen.jpeg" alt="drawing" width="200"/> 

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/qrViewScreen.jpeg" alt="drawing" width="200"/>

</p>

## _News & Events_
*To keep the community informed about news and events we show these in the initial window, this way they will have easy access to them and to their detail by touching any of these. This is done by querying our API*

<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/homeScreenWithNear.jpeg" alt="drawing" width="200"/> 

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/newsScreen.jpeg" alt="drawing" width="200"/>

</p>

## _Notifications_
*This section notifies users of new friend requests or new coupons purchased.*

## _NEAR Protocol_
*For the integration with the NEAR bolckchain we use the near_flutter library, this allows us to login with the user's NEAR wallet and thus obtain the token and wallet information to perform the queries needed in the blockchain. The queries are made mainly through the NEAR API calling contracts developed for the project that allow us to make transfers, query for the user's balance, query for the NFTs that belong to the user, etc.*

<p align="center" margin="20px">

  <img src="https://github.com/RealityNearFoundation2022/App-Movil/blob/main/APP-Screenshoots/loginNearScreen.jpeg" alt="drawing" width="200"/> 


</p>

# Download
<a href='https://play.google.com/store/apps/details?id=org.realitynear.reality_near&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width="50%"/></a>


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
