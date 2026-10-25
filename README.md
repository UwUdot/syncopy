# syncopy

> Two machines, one repo. Counter-based git sync, last-writer-wins.

**syncopy** is a tiny bash script for seamlessly syncing a Git repository between two computers. 

Instead of dealing with complex merge conflicts, `syncopy` uses a simple revision counter file (`.syncopy`). Whoever syncs last wins. 

## Quick Install (Recommended)

Run this single command from the root of the repository you want to sync:

    bash <(curl -s https://raw.githubusercontent.com/UwUdot/syncopy/main/install.sh)

This will automatically pull the script, set it up, make it executable, and run your first sync.

## How it works

The script checks the `.syncopy` file on the remote branch vs your local branch:

1. **Remote is newer?** (e.g., you just sat down at Computer B) 
   → It runs `git reset --hard` to download the latest files.
2. **Local is newer or equal?** (e.g., you are leaving Computer A) 
   → It bumps the counter, commits everything, and pushes.

That's it. One `if` statement. 

## Manual Setup

If you prefer to install it manually:

1. **Copy the files** into the root of your repo:
   - `syncopy` (the script)
   - `.syncopy` (the counter file)

2. **Make the script executable** (required before the first run):

        chmod +x ./syncopy

3. **Initialize the counter** (if you are starting fresh):

        echo 0 > .syncopy
        git add .syncopy syncopy
        git commit -m "0"
        git push

*(On your second machine, just `git pull` to get the files, and remember to run `chmod +x ./syncopy` again).*

## Usage

Always run the script from the root of the repository:

    ./syncopy

**Daily workflow:**
- **When you arrive at a machine:** `./syncopy` (downloads the other machine's work)
- **When you leave a machine:** `./syncopy` (uploads your new work)

## Caveats

- **Don't edit on both machines simultaneously.** This is a "last writer wins" script, not a merge tool. 
- **Add a `.gitignore`.** Because the script runs `git add -A`, any untracked build files, `node_modules`, or `.venv` folders will be committed unless you ignore them.