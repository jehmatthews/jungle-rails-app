describe('Home', () => {
  
  it("should visit the home page", () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Should click on the first article", () => {
    cy.get(".products article")
      .first()
      .click()
      .contains("Scented Blade").should("exist")
  });  
  
})