#!/bin/bash
# SessionStart hook: detect active OpenSpec change and inject context

CHANGES_DIR="openspec/changes"

# Exit silently if no changes directory
if [ ! -d "$CHANGES_DIR" ]; then
  exit 0
fi

# Find the most recently modified non-archived change directory
latest_change=""
latest_mtime=0

for dir in "$CHANGES_DIR"/*/; do
  # Skip archive directory
  [ "$(basename "$dir")" = "archive" ] && continue

  # Skip if directory doesn't exist (glob matched nothing)
  [ ! -d "$dir" ] && continue

  # Get modification time of the most recently changed file in the directory
  mtime=$(find "$dir" -type f -printf '%T@\n' 2>/dev/null | sort -rn | head -1)

  if [ -n "$mtime" ]; then
    # Compare as integers (strip decimal)
    mtime_int=${mtime%.*}
    if [ "$mtime_int" -gt "$latest_mtime" ]; then
      latest_mtime=$mtime_int
      latest_change=$(basename "$dir")
    fi
  fi
done

# Exit silently if no active change found
if [ -z "$latest_change" ]; then
  exit 0
fi

change_dir="$CHANGES_DIR/$latest_change"

# Count tasks
total_tasks=0
done_tasks=0
if [ -f "$change_dir/tasks.md" ]; then
  total_tasks=$(grep -cE '^\s*- \[' "$change_dir/tasks.md" 2>/dev/null || echo 0)
  done_tasks=$(grep -cE '^\s*- \[x\]' "$change_dir/tasks.md" 2>/dev/null || echo 0)
fi

# Calculate time since last modification
now=$(date +%s)
diff_seconds=$((now - latest_mtime))
if [ $diff_seconds -lt 3600 ]; then
  time_ago="$((diff_seconds / 60)) minutes ago"
elif [ $diff_seconds -lt 86400 ]; then
  time_ago="$((diff_seconds / 3600)) hours ago"
else
  time_ago="$((diff_seconds / 86400)) days ago"
fi

# Output context block
echo "Active OpenSpec change detected: \`$latest_change\`"
if [ "$total_tasks" -gt 0 ]; then
  echo "Tasks: $done_tasks/$total_tasks done"
fi
echo "Last modified: $time_ago"
