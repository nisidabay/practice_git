# Group 07 — reflog: Your safety net

## Quick Start

```bash
bash 01_reflog_basics.sh
bash 02_recover_reset.sh
bash 03_recover_deleted_branch.sh
bash 04_timed_references.sh
bash 05_reflog_expire.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_reflog_basics.sh` | everything HEAD did | `git reflog` = audit trail, not commit history |
| `02_recover_reset.sh` | undo a hard reset | `git reset HEAD@{1}` jumps back before the mistake |
| `03_recover_deleted_branch.sh` | branches aren't really gone | The commit hash still exists — checkout from reflog |
| `04_timed_references.sh` | time-based lookups | `HEAD@{2.hours.ago}` = "what was I doing 2 hours ago?" |
| `05_reflog_expire.sh` | danger zone | Don't expire reflog unless you know you won't need recovery |

## Common Patterns

```bash
git reflog                        # see everything you've done
git reset HEAD@{1}                # undo the last operation
git log -g                        # log through reflog (every commit you ever had)
git reflog show main              # reflog for a specific branch
HEAD@{5.minutes.ago}              # where was HEAD 5 minutes ago?
HEAD@{yesterday}                  # where was HEAD yesterday?
```

## Now Build Your Own

Create 3 commits, then `git reset --hard HEAD~2`. Use `git reflog` to find
the lost commit hash, then `git reset HEAD@{1}` to recover. The reflog is
the only reason this works — without it, those commits are gone forever.
