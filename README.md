# Remote Gist Bash Script Runner

Very similar to the [Remote Gist Bash Script Runner](https://github.com/bitrise-io/steps-remote-script-runner) step, except that this one explicitly takes a main Gist URL, as opposed to a *raw* URL. This script infers the raw URL of your Gist from the main URL.

Step that downloads the content of the Gist url and runs it as a bash script.
You must provide a valid Gist URL (*not* the raw URL).
For example, a main URL may look like this:

```
https://gist.github.com/jsauve/999de8763292147e465bed3203f42342
```

...whereas its raw URL may look look this:

```
https://gist.githubusercontent.com/jsauve/999de8763292147e465bed3203f42342/raw/346b16b1048452680511379f435aee574dbb6d23/PrepareAppBundles.sh
```

You should be providing the *NON*-raw URL.


Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*