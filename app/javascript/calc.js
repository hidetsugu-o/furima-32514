function calc (){
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  itemPrice.addEventListener("keyup", () => {
    const taxCalc = Math.floor(parseInt(itemPrice.value) * 0.1);
    const profitCalc = parseInt(itemPrice.value) - taxCalc;
    addTaxPrice.innerHTML = taxCalc;
    profit.innerHTML = profitCalc;
  });
}

window.addEventListener('load', calc);