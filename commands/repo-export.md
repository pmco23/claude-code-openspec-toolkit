---
description: Export a full repomix XML snapshot to disk
allowed-tools: ["Bash"]
---

Export the current working directory with the Repomix CLI.

If `$ARGUMENTS` is provided, use it as the output path; otherwise default to `./repomix-output.xml`.

Ensure the destination directory exists, then run:

```
npx -y repomix@latest --style xml -o <path>
```

Report the final output path and the key metrics from the Repomix CLI summary.
