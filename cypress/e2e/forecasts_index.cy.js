describe("Forecasts index page", () => {
  it("loads successfully", () => {
    cy.visit("/");
    cy.contains("Weather Forecasts");
    cy.contains("Enter address to see forecast information");
  });
});
