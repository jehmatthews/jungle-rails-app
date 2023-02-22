describe('add-to-cart', () => {

  it("should visit home", () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("should click on shopping cart", () => {
    cy.contains("Add")
      .first()
      .click({force: true});
  });

  it("should update the items in shopping cart", () => {
    cy.contains("My Cart (1)").should("exist")
  });

});