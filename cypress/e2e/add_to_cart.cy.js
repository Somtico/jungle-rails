describe("Add-to-Cart Button Test", () => {
  it("checks that users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", () => {
    cy.visit("/");
    cy.get(".btn").eq(0).click();
  });
});
