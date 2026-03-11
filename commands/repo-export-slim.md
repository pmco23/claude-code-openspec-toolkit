---
description: Export a compressed repomix XML snapshot to disk
allowed-tools: ["Bash"]
---

Export the current working directory with the Repomix CLI in compressed mode.

If `$ARGUMENTS` is provided, use it as the output path; otherwise default to `./repomix-output-slim.xml`.

Ensure the destination directory exists, then run:

```
npx -y repomix@latest --compress --style xml -o <path>
```

Report the final output path and the key metrics from the Repomix CLI summary, including any visible compression savings.
