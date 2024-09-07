document.addEventListener("turbo:load", function() {
  const radioButtons = document.querySelectorAll('input[name="rank_radio"]');
  const selectBox = document.getElementById("rank_number");

  // 「すべて」と「イベント」のIDを取得
  const allOptionId = '0'; // 「すべて」のID
  const eventOptionId = '2'; // 「イベント」のID

  // 初期表示で「すべて」を選択
  const selectedRankId = document.querySelector('input[name="rank_radio"]:checked')?.value || allOptionId;
  updateSelectBoxState(selectedRankId);

  if (selectedRankId) {
    updateSelectOptions(selectedRankId);
  }

  radioButtons.forEach(function(radio) {
    radio.addEventListener('change', function() {
      var selectedRankId = this.value;
      updateSelectOptions(selectedRankId);
      updateSelectBoxState(selectedRankId);
    });
  });

  function updateSelectOptions(selectedRankId) {
    if (selectedRankId === allOptionId) {
      selectBox.innerHTML = "";  // 「すべて」だけを表示
      var option = document.createElement("option");
      option.value = 0;
      option.text = "すべて";
      selectBox.appendChild(option);
      selectBox.value = 0;  // 自動的に「すべて」を選択
    } else {
      fetch(`/mhxx/quests/sub_quest_ranks?m_quest_rank_id=` + selectedRankId)
        .then(response => response.json())
        .then(data => {
          selectBox.innerHTML = "";  // 「すべて」を表示しない

          // 新しい選択肢を追加
          data.forEach(function(subRank) {
            var option = document.createElement("option");
            option.value = subRank.id;
            option.text = subRank.name;
            selectBox.appendChild(option);
          });

          // デフォルトで最初の項目を選択
          selectBox.value = selectBox.options[0].value;
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    }
  }

  function updateSelectBoxState(selectedRankId) {
    // 「すべて」または「イベント」が選択されたときにセレクトボックスを無効化
    if (selectedRankId === allOptionId || selectedRankId === eventOptionId) {
      selectBox.disabled = true;
    } else {
      selectBox.disabled = false;
    }
  }
});