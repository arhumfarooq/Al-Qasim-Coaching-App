/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// const functions = require("firebase-functions");
// const admin = require("firebase-admin");

// admin.initializeApp();

// async function sendNotificationToStudent(studentId, title, body) {

//   const studentDoc = await admin
//     .firestore()
//     .collection("students")
//     .doc(studentId)
//     .get();

//   if (!studentDoc.exists) {
//     console.log("Student not found");
//     return;
//   }

//   const token = studentDoc.data().fcmToken;

//   if (!token) {
//     console.log("FCM token not found");
//     return;
//   }

//   await admin.messaging().send({
//     token: token,
//     notification: {
//       title: title,
//       body: body,
//     },
//   });

//   console.log("Notification sent");
// }


// // FEES PAID
// exports.notifyFeesPaid = functions.firestore
//   .document("fees/{feeId}")
//   .onUpdate(async (change, context) => {

//     const before = change.before.data();
//     const after = change.after.data();

//     if (before.status !== "paid" && after.status === "paid") {

//       await sendNotificationToStudent(
//         after.studentId,
//         "Fees Update",
//         "Your fees has been paid now"
//       );
//     }
//   });


// // RESULT UPLOADED
// exports.notifyResultUploaded = functions.firestore
//   .document("results/{resultId}")
//   .onCreate(async (snap, context) => {

//     const data = snap.data();

//     await sendNotificationToStudent(
//       data.studentId,
//       "Result Uploaded",
//       `Your ${data.chapterName} score has been uploaded`
//     );
//   });


// // ABSENT ONLY
// exports.notifyAbsentOnly = functions.firestore
//   .document("attendance/{attendanceId}")
//   .onCreate(async (snap, context) => {

//     const data = snap.data();

//     if (data.status === "absent") {

//       await sendNotificationToStudent(
//         data.studentId,
//         "Attendance Alert",
//         "You're absent today"
//       );
//     }
//   });