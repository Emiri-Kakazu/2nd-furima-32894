window.addEventListener('load', function(){
  // 金額を入力した数値をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", function() {
    const inputValue = priceInput.value;
    const addtaxDom = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addtaxDom.innerHTML = Math.floor(inputValue * 0.1);
    profit.innerHTML = inputValue - Math.floor(inputValue * 0.1);
  })
})