# Run the ecommerce app

## install the dependencies

Run this command 
```bash
flutter pub get
```

## Set up your own Firebase

- Create your own project on firebase.
- download google-services.json
- Place it in the app folder
- Setup Realtime database in firebase and enable the database by setting true to read & write in the rules tab of relatime database.
- Setup Storage in firebase and enable it by setting true to read and write in the rules of storage.
- Setup authentication in firebase and enable email/password authentication.


## Set up env vars for the flutter app

- [Get your test Stripe API keys](https://stripe.com/docs/keys)
- create a file .env and set your Stripe publishable key and secret key in the
- STRIPE_PUBLISHABLE_KEY="YOU_PUBLISHABLE_KEY_HERE";
- STRIPE_SECRET_KEY="YOU_SECRET_KEY_HERE";
