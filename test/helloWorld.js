const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", () => {
    it("Hello World Testing", async () => {
        const helloWorld = await HelloWorld.deployed();
        await helloWorld.setName("Tushar");
        const result = await helloWorld.name();
        assert(result == "Tushar");
    });
});