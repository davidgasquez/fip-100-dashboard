# Rules

- Fully static site served via GitHub Pages.
- Use semantic HTML and keep things vanilla when possible. No react.
- Only hydrate where needed (Astro islands).
- Keep things fast. Load only required data, render charts appropiately, ...
- `datasets` hosts Python scripts that emit JSON into `public/`. Chart.js loads at buildtime and renders charts.
- Follow [Chart.js best practices](https://www.chartjs.org/docs/) for charts (reponsive, clean, ...).
  - Chart.js color options must be concrete color strings (no CSS custom properties or `var(...)` values into config).
- Run `npx astro check` and `npm run build` after each change.
- Keep things simple. No need for defensive programming, reuse useful packages, ...
