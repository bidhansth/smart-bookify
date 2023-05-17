### README

# Smart Bookify
Appointment Booking App

&nbsp;

### Ruby Version
3.1.3

&nbsp;

### Gems Used
* devise
* simple_calendar
* ransack
* pagy

&nbsp;

### Email Configuration
create **/config/gmail_creds.rb**
```
ENV['GMAIL_EMAIL'] = "your gmail address"
ENV['GMAIL_APP_PASSWORD'] = "your gmail app password"
```
your gmail app password is **NOT** your gmail password

&nbsp;

### To create an admin account
Create an account as a client, and using rails console:
```
Client.update(is_admin: true)
```
