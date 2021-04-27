const Election = artifacts.require("Election");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Election", function (/* accounts */) {
  let election = null;
  before(async () => {
    election = await Election.deployed();
  });

  it("should assert true", async function () {
    return assert.isTrue(true);
  });
});
