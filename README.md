# App Screenshots


<table>
  <tr>
    <td>Login Page</td>
    <td>Reset Password</td>
    <td>Home Page</td>
    <td>Home Salad Page</td>
    <td>Détails of Item</td>
    <td>Food Cart</td>
    <td>Wallet Page</td>
    <td>Add Money</td>
  </tr>
  <tr>
    <td><img src="images/image_app/Login%20Page.png" width="250"> </td> 
    <td><img src="images/image_app/Reset%20Password.png" width="250"> </td>   
    <td><img src="images/image_app/Home%20Page.png" width="250"> </td> 
    <td><img src="images/image_app/Home%20Page_salad.png" width="250"> </td>
    <td><img src="images/image_app/Detail%20of%20Item.png" width="250"> </td>
    <td><img src="images/image_app/Food%20Cart.png" width="250"> </td>
    <td><img src="images/image_app/Wallet%20Page.png" width="250"> </td>
    <td><img src="images/image_app/Add%20Money.png" width="250"> </td>
  </tr>
 </table>

<table>
    <tr> 
        <td>Profile of User</td>
        <td>Admin Home</td>
        <td>Add Item</td>
    </tr>
    <tr>
        <td><img src="images/image_app/User%20Profile.png" width="250"> </td>
        <td><img src="images/image_app/Home%20Admin.png" width="250"> </td>
        <td><img src="images/image_app/Add%20an%20Item.png" width="250"> </td>
    </tr>
</table>

# Run the delivery food app

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
