import functions from 'firebase-functions';
import admin from 'firebase-admin';
import fetch from 'node-fetch';

admin.initializeApp();

export const darajaStkPush = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'POST') {
    res.status(405).send('Method not allowed');
    return;
  }
  try {
    const { phone, amount, description } = req.body || {};
    if (!phone || !amount) {
      res.status(400).json({ error: 'phone and amount are required' });
      return;
    }

    // Placeholder: Call Safaricom Daraja API
    // In production, securely store consumerKey and consumerSecret in env config
    // and implement proper timestamp/password generation and STK push request.
    // For now, simulate success.

    // const response = await fetch('https://sandbox.safaricom.co.ke/mpesa/...', { ... })
    // const data = await response.json();

    res.json({ status: 'queued', phone, amount, description: description ?? 'Tickets' });
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});
