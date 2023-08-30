# -*- mode: fish -*-

function gitiles --description "Show gitiles URL of a commit"
    # repo command ins not installed
    if not type -q repo
        echo "fatal: no repo command installed" > /dev/stderr
        return 1
    end

    # executed in not repo repository
    if not test -d ".repo"
        echo "fatal: not a repo repository: .repo" > /dev/stderr
        return 1
    end

    # no GITILES_URL defined
    if not set -q GITILES_URL
        echo "fatal: no GITILES_URL defined" > /dev/stderr
        return 1
    end

    set -l project (repo list . | cut -d":" -f 2 | string trim)
    set -l hash (git rev-parse HEAD)
    if test (count $argv) -ne 0
        set hash $argv[1]
    end

    echo "$GITILES_URL/$project/+/$hash"
end
