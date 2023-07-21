# Go Riverpod
This project is a POC for using `go_router` and `riverpod`. I wrote this to work through and solve my unique authentication needs. However, it nicely demonstrates how to use `go_router` and `riverpod` to do simple authentication more generally.

## Problem space
My sign up flow includes an additional step of asking for an physical address _before_ asking for sign up credentials. That address is verified _after_ the sign up credentials have been accepted which means there's an additional local validation step and error handling case that has to be handled.

### Sign Up
1. The app opens and the user is presented with a landing page where "Sign Up" and "Login" are the choices
2. The user taps/clicks the "Sign Up" button and is presented with a screen to enter an address
3. The user enters an address and taps the "Submit Address" button
4. The system stores the submitted address in a simple Riverpod provider
5. The user is presented with a sign up form to enter a username
6. The user enters a username and taps the "Submit Username" button
7. The system submits the username to the backend
8. If the username is accepted, the system then also submits the address to the backend
9. If the address is also accepted, the user is presented with a dashboard showing their name and button to "Logout"

> There are two (three) deviations from this flow as follows:
1. If the username is not accepted (duplicate email address, for example), then the system presents the "Sign Up" screen again so that the user can enter a different username
2. If the address is not accepted (duplicate address, already used, etc.), then the system presents the "Enter Address" screen again so that the user can enter a different address
3. If both of these cases are triggered, the "Sign Up" screen is presented first and then the "Enter Address" screen

## Implementation
This is written using `go_router` and `riverpod`. The providers are written using `riverpod_annotation` and so rely on `build_runner` to build. The general idea here is that the router has listeners that are paying attention to the necessary providers to then make routing decisions based on state. Then, in the root level `redirect`, a simple logic tree decides where to send the user.

## UI
The UI is extremely simple but demonstrates the steps used for sign up and login. There is a simple "debug" widget that shows the state of providers at any given time during the auth process.

## Other Things
I would improve this by breaking down the router to smaller parts and creating a better implementation for the decision logic (a state machine of some kind). I'm sure there are other viable implementations out there.

> NOTE: I wrote this so that I could work through my own problem space while also gaining a better understanding of these two technologies and how they can work together. I do not plan to actively maintain this nor do I plan to publish it or provide guidance about it. If you like it, use it; if you don't, use something else. :) With that said, I thought others might benefit so I made it public. Enjoy! (It should also have tests). :p