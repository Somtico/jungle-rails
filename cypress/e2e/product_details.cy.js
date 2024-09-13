describe("Product Details Page Test", () => {
  
  it("should visit the product details page from the home page", () => {
    cy.visit("/");
    cy.get(".products article").eq(0).click()
  })
});
