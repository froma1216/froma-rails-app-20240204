// ページが読み込まれたときに関数を実行
// TODO: 一個コケると全部死ぬ。mhxx.jsを参考に切り分ける
document.addEventListener("turbo:load", function () {
  // 投/野能力表示切り替え
  changeDisplayAbility();
  document
    .getElementById("form-radio-pitcher")
    .addEventListener("change", changeDisplayAbility);
  document
    .getElementById("form-radio-fielder")
    .addEventListener("change", changeDisplayAbility);
});

// 投/野能力表示切り替え
function changeDisplayAbility() {
  const pitcherRadio = document.getElementById("form-radio-pitcher");
  const fielderRadio = document.getElementById("form-radio-fielder");
  const pitcherContents = document.querySelectorAll('[id^="pitcher-content"]');
  const fielderContents = document.querySelectorAll('[id^="fielder-content"]');

  if (pitcherRadio.checked) {
    pitcherContents.forEach((content) => {
      content.classList.remove("d-none");
      content.classList.add("d-flex");
    });
    fielderContents.forEach((content) => {
      content.classList.remove("d-flex");
      content.classList.add("d-none");
    });
  } else if (fielderRadio.checked) {
    pitcherContents.forEach((content) => {
      content.classList.remove("d-flex");
      content.classList.add("d-none");
    });
    fielderContents.forEach((content) => {
      content.classList.remove("d-none");
      content.classList.add("d-flex");
    });
  }
}
