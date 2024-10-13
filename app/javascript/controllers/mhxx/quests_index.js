$(document).on("turbo:load", function () {
  const $radioButtons = $('input[name="rank_radio"]');
  const $selectBox = $("#rank_number");

  const options = {
    all: { id: "0", label: "すべて" },
    favorite: { id: "99", label: "お気に入り" },
  };

  const selectedRankId =
    $('input[name="rank_radio"]:checked').val() || options.all.id;
  updateSelectOptions(selectedRankId);

  $radioButtons.on("change", function () {
    updateSelectOptions($(this).val());
  });

  function updateSelectOptions(selectedRankId) {
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
      $selectBox.val(selectedRankId);
    } else {
      // その他のランクが選択された場合
      $.getJSON(
        `/mhxx/quests/sub_quest_ranks?m_quest_rank_id=${selectedRankId}`,
        function (data) {
          $.each(data, function (_, subRank) {
            $selectBox.append(new Option(subRank.name, subRank.id));
          });
          // セレクトの一番上の項目を選択
          $selectBox.val($selectBox.find("option:first").val());
        }
      ).fail(function () {
        console.error("Error fetching data");
      });
    }
  }
});
