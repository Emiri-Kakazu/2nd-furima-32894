const pay = () => {
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); //環境変数をもとに公開鍵を復号
  const elements = payjp.elements(); //elementsインスタンスを生成
  console.log(payjp);
  const numberElement = elements.create('cardNumber'); //入力欄ごとにelementインスタンスを生成、カッコ内は型で、card, cardNumber, cardExpiry, cardCvcから選択。
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  //console.log(elements);

  numberElement.mount('#number-form');  //入力欄をDOM上に表示、カッコ内は'#id属性'
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const submit = document.getElementById("button"); 
  submit.addEventListener("click", (e) => { // イベント発火、PAY.JPと通信が成功した場合のみトークンをフォームに埋め込む
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        
      } else { //if文には；はいらない
        debugger;
        const token = response.id;
        console.log(token);
        const renderDom = document.getElementById("charge-form");   //idを元に要素を取得
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;   //paramsの中にトークンを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加
      }
      document.getElementById("charge-form").submit();
    });
  })
}

window.addEventListener("load", pay);