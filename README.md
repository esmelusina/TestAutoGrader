# TestAutoGrader

This is a repository for testing auto-grading utilizing Travis-CI w/diffs and PRs.

## Prerequisites

This project is intended for a repository that will integrate with a Travis CI
system.

To test locally, you will need the following installed:

- Git
- Bash
- GCC

## Branch Structure

Branch  | Modified By | Purpose
--------|-------------|---------------------------------------------------
master  | Instructors | Houses all of the exercise texts
student | A Student   | Working branch for students to commit work to*
key     | Instructors | Contains all of the test I/O and expected answers

Note that `key` is virtually unrelated to `master`, though it should be safe to
merge or rebase `key` with `master` to create a branch that contains both the
exercise and answer key information.

The student branch is expected to be very messy and full of WIP commits.

A one-liner git log graph could look like something below:

```text
* (master) Add exr for Intro to C++/Variables
* Add exr for Intro to C++/HelloWorld

* (key) Add key for exr for Intro to C++/Variables
* Add key for exr for Intro to C++/HelloWorld

* (student) Add retry for exercises for Intro to C++/Variables
* Add answer for exercises for Intro to C++/Variables
* Add answer for exercises for Intro to C++/Hello World
```

## Local Testing Process

You can try to test your work by running a local script that attempts to
mimic the process that Travis CI goes through to perform the test.

_AutoGraderLocalGist_ via [GitHub Gist][AutoGraderLocalGist]

[AutoGraderLocalGist]:https://gist.github.com/terryn-aie/c83c5ef7e9138c2984807575a78a5fa3

## Roadmap

1. Validate and output results for 100% matches between answers and keys
2. Create database for managing results 
3. Determine and document output schema for easy machine parsing in the future
4. Acquire more ice cream
5. Document branching scheme and folder conventions
6. Document setup process and intended workflow for usage