const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
exports.myFunction = functions.firestore.document('Order/{order}').onCreate((snapshot, context) => {
    return admin.messaging().sendToDevice('token', { notification: { title: 'يوجد طلب جديد', body: 'يوجدطلب جديد', clickAction: 'FLUTTER_NOTIFICATION_CLICK' } });
});