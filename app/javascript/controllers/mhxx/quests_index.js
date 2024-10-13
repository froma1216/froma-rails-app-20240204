$(document).on("turbo:load", function () {
  const $radioButtons = $('input[name="rank_radio"]');
  const $selectBox = $("#rank_number");

  const options = {
    all: { id: "0", label: "すべて" },
    favorite: { id: "99", label: "お気に入り" },
  };

  // data-*属性を使って値を取得
  const previousValue = $selectBox.data("selected") || $selectBox.val(); // 検索後の選択値を保持
  const selectedRankId =
    $('input[name="rank_radio"]:checked').val() || options.all.id;

  updateSelectOptions(selectedRankId, previousValue); // 初期表示で呼び出し

  $radioButtons.on("change", function () {
    updateSelectOptions($(this).val(), null); // ラジオボタン変更時にはpreviousValueを無視
  });

  function updateSelectOptions(selectedRankId, previousValue) {
    $selectBox.empty(); // セレクトボックスをクリア

    if (
      selectedRankId === options.all.id ||
      selectedRankId === options.favorite.id
    ) {
      // 「すべて」または「お気に入り」が選択された場合
      const label =
        selectedRankId === options.all.id
          ? options.all.label
          : options.favorite.label;
      $selectBox.append(new Option(label, selectedRankId));
      // その値を選択
      $selectBox.val(selectedRankId);
    } else {
      // その他のランクが選択された場合
      $.getJSON(
        `/mhxx/quests/sub_quest_ranks?m_quest_rank_id=${selectedRankId}`,
        function (data) {
          $.each(data, function (_, subRank) {
            $selectBox.append(new Option(subRank.name, subRank.id));
          });

          // ラジオボタンの切り替え時は最初のオプションを選択
          if (previousValue === null) {
            $selectBox.val($selectBox.find("option:first").val());
          } else {
            // 検索後の場合は以前の選択状態を復元
            $selectBox.val(previousValue);
          }
        }
      ).fail(function () {
        console.error("Error fetching data");
      });
    }
  }
});
