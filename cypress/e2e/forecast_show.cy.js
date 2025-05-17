describe("Forecasts index page", () => {
  it("loads successfully", () => {
    cy.visit("/forecasts/8130 Branch Rd%2C Los Angeles%2C CA 90019");
    cy.contains("Forecast Details");
    cy.contains("City: Los Angeles");
  });
});
