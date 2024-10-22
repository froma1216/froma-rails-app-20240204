$(document)
  .off("turbo:load")
  .on("turbo:load", function () {
    const $radioButtons = $('input[name="rank_radio"]');
    const $selectBox = $("#rank_number");
    const options = { favorite: { id: "99", label: "お気に入り" } };

    // 初期表示で選択された値を保持
    const previousValue = $selectBox.data("selected") || $selectBox.val();
    const selectedRankId =
      $('input[name="rank_radio"]:checked').val() || options.favorite.id;

    // 初期表示のオプションを更新
    updateSelectOptions(selectedRankId, previousValue);

    // ラジオボタン変更時のオプション更新
    $radioButtons.on("change", function () {
      updateSelectOptions($(this).val());
    });

    function updateSelectOptions(selectedRankId, previousValue = null) {
      $selectBox.empty(); // セレクトボックスをクリア

      if (selectedRankId === options.favorite.id) {
        // お気に入りの場合の処理
        $selectBox.append(new Option(options.favorite.label, selectedRankId));
        $selectBox.val(selectedRankId);
      } else {
        // その他のランクが選択された場合の処理
        fetchSubQuestRanks(selectedRankId, previousValue);
      }
    }

    function fetchSubQuestRanks(rankId, previousValue) {
      $.getJSON(
        `/mhxx/quests/sub_quest_ranks?m_quest_rank_id=${rankId}`,
        function (data) {
          // サブクエストランクをセレクトボックスに追加
          data.forEach((subRank) =>
            $selectBox.append(new Option(subRank.name, subRank.id))
          );

          // 選択状態を復元または最初のオプションを選択
          $selectBox.val(
            previousValue || $selectBox.find("option:first").val()
          );
        }
      ).fail(function () {
        console.error("Error fetching data");
      });
    }
  });
