const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { topic } = require('firebase-functions/lib/providers/pubsub');

admin.initializeApp(functions.config().functions);


exports.newOrderListener = functions.firestore.document('Order/{id}').onCreate(async (snapshot, context) => {
	var newData;

	if (snapshot.empty) {
		console.log('No Devices');
		return;
	}

	newData = snapshot.data();

	const deviceIdTokens = await admin
		.firestore()
		.collection('fcmTokens')
		.get();

	var tokens = [];

	for (var token of deviceIdTokens.docs) {
		tokens.push(token.data().device_token);
	}
	var payload = {
		notification: {
			title: 'طلب جديد',
			body: 'تم استقبال طلب جديد ! ',
			sound: 'default',
		},
		data: {
			click_action: 'FLUTTER_NOTIFICATION_CLICK',
			key1: newData.timeStamp,
		},
	};

	try {
		const response = await admin.messaging().sendToDevice(tokens, payload);
		console.log('Notification sent successfully');
	} catch (err) {
		console.log(err);
	}
});
exports.newOfferListener = functions.firestore.document('Items/{id}').onUpdate(async (change, context) => {
	var payload = {
		notification: {
			title: 'خصم جديد !' ,
			body:' يوجد لدينا خصم جديد',
			sound: 'default',
		},
		data: {
			click_action: 'FLUTTER_NOTIFICATION_CLICK',
			key1: 'data',
		},
	};
	try {
		const response = await admin.messaging().sendToTopic('offer',payload);
		console.log('Notification sent successfully');
	} catch (err) {
		console.log(err);
	}
});