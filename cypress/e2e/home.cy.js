describe('Home Page Test', () => {
  it('should visit the home page', () => {
    cy.visit('/')

    cy.contains('The Jungle')
  });

  it("should find products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("should find 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
})