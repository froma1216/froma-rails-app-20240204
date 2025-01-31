// 特殊能力セレクト（選択した要素と同様の背景色をセレクトボックスに適用）
// function setupSelectBox(selectBoxId) {
//   var selectBox = document.getElementById(selectBoxId);

//   // セレクトボックスの現在の選択肢に基づいて背景色を更新する関数
//   const updateSelectBoxBackground = () => {
//     var selectedOptionClass =
//       selectBox.options[selectBox.selectedIndex].className;
//     selectBox.className = "form-select " + selectedOptionClass;
//   };

//   // changeイベントに反応して背景色を更新
//   selectBox.addEventListener("change", updateSelectBoxBackground);

//   // ページ読み込み時にも背景色を適用
//   updateSelectBoxBackground();
// }

// FIXME: 関数名見直し
// 基礎能力入力（入力値でアルファベット＋背景色を変更）
function setupInputField(inputFieldId, displaySpanId) {
  const updateSpan = () => {
    const inputValue = document.getElementById(inputFieldId).value;
    let spanClass = "";
    let spanText = "";

    // 共通ロジック
    if (inputValue >= 1 && inputValue <= 19) {
      spanClass = "pawa-bg-g";
      spanText = "G";
    } else if (inputValue >= 20 && inputValue <= 39) {
      spanClass = "pawa-bg-f";
      spanText = "F";
    } else if (inputValue >= 40 && inputValue <= 49) {
      spanClass = "pawa-bg-e";
      spanText = "E";
    } else if (inputValue >= 50 && inputValue <= 59) {
      spanClass = "pawa-bg-d";
      spanText = "D";
    } else if (inputValue >= 60 && inputValue <= 69) {
      spanClass = "pawa-bg-c";
      spanText = "C";
    } else if (inputValue >= 70 && inputValue <= 79) {
      spanClass = "pawa-bg-b";
      spanText = "B";
    } else if (inputValue >= 80 && inputValue <= 89) {
      spanClass = "pawa-bg-a";
      spanText = "A";
    } else if (inputValue >= 90 && inputValue <= 100) {
      spanClass = "pawa-bg-s";
      spanText = "S";
    } else {
      // エラーケース
      spanClass = "";
      spanText = "";
    }

    // span要素の更新
    const spanElement = document.getElementById(displaySpanId);
    spanElement.className = `input-group-text text-white ${spanClass}`;
    spanElement.textContent = spanText;
  };

  updateSpan(); // 初期状態の設定
  document.getElementById(inputFieldId).addEventListener("input", updateSpan);
}

// 基礎能力入力：弾道（入力値で矢印の角度＋背景色を変更）
function setupInputFieldTrajectory(inputFieldId, displaySpanId) {
  const updateSpan = () => {
    const inputValue = parseInt(
      document.getElementById(inputFieldId).value,
      10
    );
    let spanClass = "";
    let rotationAngle = "";

    // 共通ロジック
    if (inputValue === 2) {
      spanClass = "pawa-bg-c";
      rotationAngle = "-10deg";
    } else if (inputValue === 3) {
      spanClass = "pawa-bg-b";
      rotationAngle = "-30deg";
    } else if (inputValue === 4) {
      spanClass = "pawa-bg-a";
      rotationAngle = "-45deg";
    } else {
      spanClass = "pawa-bg-d";
      rotationAngle = "0deg";
    }

    // span要素の更新
    const spanElement = document.getElementById(displaySpanId);
    spanElement.className = `input-group-text text-white ${spanClass}`;

    // アイコン要素を見つけて回転を適用する
    const iconElement = document.getElementById("fa-icon");
    if (iconElement) {
      iconElement.style.transform = `rotate(${rotationAngle})`;
    }
  };

  updateSpan(); // 初期状態の設定
  document.getElementById(inputFieldId).addEventListener("input", updateSpan);
}

// ストレート系のセレクト変更時にmovementフィールドを更新
function setupFastballSelectBox(selectBoxId, movementFieldId) {
  const selectBox = document.getElementById(selectBoxId);
  const movementField = document.getElementById(movementFieldId);

  // セレクトボックスの変更時にmovementフィールドを更新する関数
  const updateMovementField = () => {
    const selectedValue = selectBox.value; // 現在の選択値
    if (selectedValue === "") {
      // 「なし」が選択された場合
      movementField.value = 0;
    } else {
      // その他の選択肢が選択された場合
      movementField.value = 1;
    }
  };

  // changeイベントで動作するように設定
  selectBox.addEventListener("change", updateMovementField);

  // ページ読み込み時にも初期値を適用
  updateMovementField();
}

// ページが読み込まれたときに関数を実行
// TODO: 一個コケると全部死ぬ。mhxx.jsを参考に切り分ける
document.addEventListener("turbo:load", function () {
  // コントロール
  setupInputField("control-input", "control-alphabet-display");
  // スタミナ
  setupInputField("stamina-input", "stamina-alphabet-display");
  // 弾道
  setupInputFieldTrajectory("trajectory-input", "trajectory-alphabet-display");
  // ミート
  setupInputField("meat-input", "meat-alphabet-display");
  // パワー
  setupInputField("power-input", "power-alphabet-display");
  // 走力
  setupInputField("running-input", "running-alphabet-display");
  // 肩力
  setupInputField("arm-input", "arm-alphabet-display");
  // 守備力
  setupInputField("fielding-input", "fielding-alphabet-display");
  // 捕球
  setupInputField("catching-input", "catching-alphabet-display");
  // 第二ストレート系
  setupFastballSelectBox(
    "breaking-ball-fastball-2-select",
    "breaking-ball-fastball-2-movement"
  );

  // // 回復
  // setupSelectBox("kaifuku-select");
  // // ケガしにくさ
  // setupSelectBox("kegasinikusa-select");
  // // 対ピンチ
  // setupSelectBox("taipinch-select");
  // // 対左打者
  // setupSelectBox("taihidaridasya-select");
  // // 打たれ強さ
  // setupSelectBox("utarezuyosa-select");
  // // ノビ
  // setupSelectBox("nobi-select");
  // // クイック
  // setupSelectBox("quick-select");
  // // チャンス
  // setupSelectBox("chance-select");
  // // 対左投手
  // setupSelectBox("taihidaritousyu-select");
  // // キャッチャー
  // setupSelectBox("catcher-select");
  // // 盗塁
  // setupSelectBox("tourui-select");
  // // 走塁
  // setupSelectBox("sourui-select");
  // // 送球
  // setupSelectBox("soukyuu-select");
});
