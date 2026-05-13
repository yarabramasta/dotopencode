import test from "node:test";
import assert from "node:assert/strict";

import { formatName } from "../src/format-name.js";

test("formats first and last name", () => {
  assert.equal(formatName("Yara", "Bramasta"), "Yara Bramasta");
});

test("trims missing last name without trailing spaces", () => {
  assert.equal(formatName("Yara", undefined), "Yara");
});
