// for real payments, replace the test key with
// your live key from the Stripe dashboard and
// integrate with cloud functions to create payment
// intents securely on the server side
// This example is simplified for demonstration purposes
// and should not be used in production without proper security measures.

const functions = require("firebase-functions");
const stripe = require("stripe")("sk_test_xxxxxxxxxxxxxxxxx");

exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "please log in to make a payment",
    );
  }

  const { amount, currency = "usd" } = data;
  // check if amount is a positive number
  if (typeof amount !== "number" || amount <= 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "amount must be a positive number",
    );
  }

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: Math.round(amount * 100), // convert to cents
      currency: currency.toLowerCase(),
      automatic_payment_methods: { enabled: true },
    });

    return { clientSecret: paymentIntent.client_secret };
  } catch (error) {
    throw new functions.https.HttpsError("internal", error.message);
  }
});
