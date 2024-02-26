$(function () {
  // ラジオボタンが変更されたときの処理
  $(".level-radio").change(function () {
    var selectedValue = $(this).val();
    var options;

    // 選択されたラジオボタンの値に応じてセレクトボックスのオプションを変更
    if (selectedValue == "50") {
      options = [
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
      $("#lap").append(new Option(option[0], option[1]));
    });
  });
});
