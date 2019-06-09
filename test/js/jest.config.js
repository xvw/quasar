module.exports = {
  clearMocks: true,
  coverageDirectory: "coverage",
  roots: [
    "<rootDir>",
    "<rootDir>/../../_build/default/test/js"
  ],
  testEnvironment: "node",
  testMatch: [
    "**/__tests__/**/*.[jt]s?(x)",
    "**/?(*.)+(spec|test|bc).[tj]s?(x)"
  ]
};
