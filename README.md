# TestAutoGrader

This is a repository for testing auto-grading utilizing Travis-CI w/diffs and PRs.

# Prerequisites

This project is intended for a repository that will integrate with a Travis CI
system.

Locally, you will need the following installed:

- Git
- Bash

# Local Testing Process

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