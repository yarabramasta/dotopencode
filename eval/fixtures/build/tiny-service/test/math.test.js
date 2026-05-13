import test from "node:test";
import assert from "node:assert/strict";

import { divide, sum } from "../src/math.js";

test("sum adds two numbers", () => {
  assert.equal(sum(2, 3), 5);
});

test("divide divides two numbers", () => {
  assert.equal(divide(8, 2), 4);
});
