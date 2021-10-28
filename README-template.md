# Thesis Toolbox Template

This is a template for writing your Bachelor, Master or PhD thesis.
It is loaded with a lot of tricks and magic to make sure your writing is enjoyable and your final document looks amazing.

<!---[A preview of the compiled pdf is available here!](https://gitlab.com/thesis-toolbox/template/-/jobs/artifacts/master/raw/main.pdf?job=make) --->

[A preview of the compiled pdf is available here! (Please pick the first job and find it under artefacts)](../../actions/workflows/thesis-pdf.yml)


## Main Feature Overview

* **Out of the Box Usage Without Configuration**
  Get your copy of this template and start writing. The only required config file (`./myconfig.sty`) asks for your name and thesis topic. No installations or further adjusted are needed to get your pdf.
* **Reliable Builds and Continuous Integration**
  No time or space to struggle with a full LaTeX installation? This template has a special Makefile to use docker for the compilation. If you prefer, you don't need to run and compile anything on your local machine and let cloud-based CI (Github or GitLab) do the job for you.
* **No LaTeX-Skills Required**
  Do not be afraid of using LaTeX. For writing your thesis, only a few minimal commands are enough and most of them can be copy pasted from existing snippets. You can even write most of your thesis in markdown (Requires Makefile usage.

## Quickstart

A good starting point for your exploration of the template is `main.tex` since it includes and calls all the other files consecutively.
Detailed instruction and backgrounds are given as comments directly inside the tex-files.

If you want to use the given Makefile, just use the `make` command to build the pdf and `make clean` to clean up the directory again.
For information about more advanced commands try `make help`.

Enjoy the template and happy thesis writing!

## Spread the Word!

As this template is most likely not approved by your university, there is no legal way for announcing the existence of this template.
Therefore, please tell your friends/colleagues/fellows/supervisors about this template.
Also a star for this git-repository increases visibility.
Thanks a lot for your help!

## FAQ, Problems and Workarounds

This section is a collection of the most frequent problems during the usage of this template and potential solutions.

### How do I set up my own git repo to be able to install updates on the template?

Unfortunately, there is no easy way to keep connected with the main repo.
For the most simple usage, you can just ignore all changes to the template.
Just copy all files here once and start your own git repo from scratch.

If you are a more advanced git user, you can try the following:

```sh
# Just set up an empty git repo, e.g. by
git init

# Add a remote link to this template git repo
git remote add template https://github.com/thesis-toolbox/template
```

```sh
### Repeat the following two commands whenever you want to do an update

# Get a local copy of the most recent version of the template
git fetch template master
# Merge all the template changes into your master. Maybe you have to fix some conflicts.
git merge template/master

# If this command is aborted with 'fatal: refusing to merge unrelated histories' try this
git merge template/master --allow-unrelated-histories
```

### TeXstudio does not compile my bibliography!

This bug is caused by TeXstudio missing another round of compilation including the bibliography in the final document.
Go to: `Options -> Configure TeXstudio... -> build -> Build&View -> Click on the Screw-Driver -> Cancel`
Then, put the following string into corresponding text field:

```sh
txs:///compile | txs:///bibliography | txs:///compile | txs:///view
```

If you still experience problems or weird error messages, please try using biber.

### TeXstudio has a broken navigation!

Most likely you have not enabled the necessary crawlers.
Go to: `Options -> Configure TeXstudio... -> Completion` and check `biblatex.cwl` and `subfiles.cwl` and whatever else you need.

Close and reopen TeXstudio to fully reload the config if needed.

### Some referenced files are not found - is their path wrong?

```
LaTeX Warning: File `./img/SomeName.pdf' not found on input line SomeLine.

! Package pdftex.def Error: File `./img/SomeName.pdf' not found: using draft setting.
```

Unfortunately, different versions of the subfiles package used in the template require different logics for the provided path name.
This template is configured for the most recent version, but thereby will fail for older versions.
Several of these error messages most likely indicate that your system is using and outdated version.
If you cannot update the LaTeX-Packages in your system, you can try the following workaround:

Copy this file into your main directory [subfiles.sty](https://raw.githubusercontent.com/gsalzer/subfiles/1.6/subfiles.sty)

## Customized Templates for Universities – Official and Unofficial

* We are working on that …

No matter if your university is listed here, please double check the official guidelines of your university/department before submitting and adjust your thesis if needed.
