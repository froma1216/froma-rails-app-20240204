// クエストランクラジオ・サブクエストランクラジオの制御
document.addEventListener("turbo:load", () => {
  const radioButtons = document.querySelectorAll('input[name="rank_radio"]');
  const selectBox = document.getElementById("rank_number");

  const options = {
    all: { id: "0", label: "すべて" },
    favorite: { id: "99", label: "お気に入り" },
  };

  const selectedRankId =
    document.querySelector('input[name="rank_radio"]:checked')?.value ||
    options.all.id;

  updateSelectOptions(selectedRankId);

  radioButtons.forEach((radio) => {
    radio.addEventListener("change", function () {
      updateSelectOptions(this.value);
    });
  });

  function updateSelectOptions(selectedRankId) {
    selectBox.innerHTML = ""; // セレクトボックスをクリア

    if (
      selectedRankId === options.all.id ||
      selectedRankId === options.favorite.id
    ) {
      // 「すべて」または「お気に入り」が選択された場合
      const option = document.createElement("option");
      option.value = selectedRankId;
      option.text =
        selectedRankId === options.all.id
          ? options.all.label
          : options.favorite.label;
      selectBox.appendChild(option);
      selectBox.value = selectedRankId;
    } else {
      // その他のランクが選択された場合
      fetch(`/mhxx/quests/sub_quest_ranks?m_quest_rank_id=` + selectedRankId)
        .then((response) => response.json())
        .then((data) => {
          data.forEach((subRank) => {
            const option = document.createElement("option");
            option.value = subRank.id;
            option.text = subRank.name;
            selectBox.appendChild(option);
          });
          selectBox.value = selectBox.options[0].value;
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });
    }
  }
});
