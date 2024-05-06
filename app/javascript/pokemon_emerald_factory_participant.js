document.addEventListener("turbo:load", function() {
  function updateOptions() {
    var selectedValue = $("[name='level_radio']:checked").val();
    var previousSelectedOption = $("#lap").val(); // 保存されている選択肢の値を取得
    var options;

    if (selectedValue == "50") {
      options = [
        ["指定なし", ""],
        ["1周目", 1],
        ["2周目", 2],
        ["3周目", 3],
        ["4周目", 4],
        ["5周目", 5],
        ["6周目", 6],
        ["7周目", 7],
        ["8周目以降", 8],
      ];
    } else {
      options = [
        ["指定なし", ""],
        ["1周目", 4],
        ["2周目", 5],
        ["3周目", 6],
        ["4周目", 7],
        ["5周目以降", 8],
      ];
    }

    // 既存のオプションを削除
    $("#lap").empty();
    // 新しいオプションを追加
    $.each(options, function (index, option) {
      // 現在の選択肢が前回の選択肢と同じかどうか確認
      var isSelected = previousSelectedOption === option[1].toString();
      $("#lap").append(new Option(option[0], option[1], isSelected, isSelected));
    });
  }

  // 初期ロード時、オプションを更新
  updateOptions();
  // ラジオ変更時
  $("[name='level_radio']").change(function() {
     // セレクトの選択を「指定なし」にリセット
    $("#lap").val("");
    // オプションを更新
    updateOptions();
  });
});