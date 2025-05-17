describe("Forecasts index page", () => {
  it("loads successfully", () => {
    cy.visit("/forecasts/82 Cartier Aisle%2C Irvine CA%2C 92620");
    cy.contains("Forecast Details");
    cy.contains("City: Irvine");
  });
});
