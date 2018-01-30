# Remote Gist Bash Script Runner

Very similar to the [Remote Gist Bash Script Runner](https://github.com/bitrise-io/steps-remote-script-runner) step, except that this one explicitly takes a main Gist URL, as opposed to a *raw* URL. This script scrapes the raw URL(s) of your Gist from the content of the main URL, and then runs each of the scripts located those URLs.

You must provide a valid Gist URL (*not* the raw URL).

For example, a main URL may look like this:

```
https://gist.github.com/jsauve/dec05365cdf201637b9e1545852abe25
```

...whereas its raw URL may look look this:

```
https://gist.githubusercontent.com/jsauve/dec05365cdf201637b9e1545852abe25/raw/d7bdd21f5f1cddd5342f5804173967a4bff414fc/HelloWorld1.sh
```

You should be providing the *NON*-raw URL.


Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.
