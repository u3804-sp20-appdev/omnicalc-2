# Omnicalc 2

In this project, we'll again practice building forms, fundamentally. Forms are _that_ important to us.

But — between getting some input (via the query string and `params` hash) and displaying some output (via instance variables and view templates), instead of something boring like doing some multiplication, let's do something more interesting — leverage **machine learning APIs**.

In this project we'll explore [Google's Cloud Vision APIs](https://cloud.google.com/vision). Fortunately for us, Google maintain's a first-party Ruby gem that makes surprisingly straightforward to access their cutting edge machine learning models. We don't even have to parse the JSON ourselves; Google's gem does all the heavy-lifting, and we just call a method.

## Target

Here's our target, roughly:

[https://omnicalc-2.matchthetarget.com/](https://omnicalc-2.matchthetarget.com/)

## Standard Workflow

 1. Set up the project: `bin/setup`
 1. Start the web server by clicking "Run Project".
 1. Navigate to your live application preview.
 1. As you work, remember to navigate to `/git` and **commit often as you work.**
 1. There are no automated tests, and no `rails grade` for this project. You don't need to match the target exactly; follow along with the video, experiment, and turn in a snapshot of your workspace when you're done, in whatever state it's in.

## Credentials

You'll need credentials to use the Cloud Vision API. [Create an environment variable](https://chapters.firstdraft.com/chapters/792) named _exactly_:

```
VISION_CREDENTIALS
```

You can find my credentials on Canvas to paste in as the value — it's really long, be careful to copy the whole thing.

In the future, you can [sign up for your own](https://cloud.google.com/vision/overview/docs/get-started). Initially you'll get $300 of credits for free to use within your first year.


## Your tasks

Primarily, our goal is to practice building forms. You will add three forms, as seen in the target; they should be located at the URLs:

 - `/text`
 - `/label`
 - `/web`

Something a little new is that these forms will have file upload fields in them. In order to make that work,

 - use the `type="file"` attribute on your `<input>`
 - add the `enctype="multipart/form-data"` to your `<form>`
 - add the `method="post"` attribute to your `<form>`

```
<form action="/process_text" method="post" enctype="multipart/form-data">
  <div>
    <label>Image</label>
    <input type="file">
  </div>

  <br>
  
  <button>Magic</button>
</form>
```

In `config/routes.rb`, the route that processes the form will need to use the `post()` method instead of the `get()` method:

```
post("/process_text", # etc )
```

You will need to wire up the rest of the form as usual, as we've been practicing.

## The logic

To find out how to actually make the magic work, use the Cloud Vision Explorer found on the home page.

It will let you try out images and see the API response, as well as show you the code required to get the data in your own code.

Have fun!
