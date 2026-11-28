export default {
  section: "liteparse",
  label: "Docvanta",
  content: [
    { src: "./docs/src/content/docs/liteparse", dest: "liteparse" },
  ],
  sidebar: [{
    label: "Docvanta",
    content: { type: "autogenerate", directory: "liteparse", collapsed: true },
  }],
};
