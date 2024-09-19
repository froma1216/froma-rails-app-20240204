// クエスト一覧：クエストランクラジオ・サブクエストランクラジオの制御
document.addEventListener("turbo:load", () => {
  const radioButtons = document.querySelectorAll('input[name="rank_radio"]');
  const selectBox = document.getElementById("rank_number");

  // 「すべて」と「イベント」のIDを取得
  const allOptionId = '0'; // 「すべて」のID
  const eventOptionId = '2'; // 「イベント」のID

  // 初期表示で「すべて」を選択
  const selectedRankId = document.querySelector('input[name="rank_radio"]:checked')?.value || allOptionId;
  updateSelectBoxState(selectedRankId, selectBox, allOptionId, eventOptionId);

  if (selectedRankId) {
    updateSelectOptions(selectedRankId, selectBox, allOptionId);
  }

  // ラジオボタンにイベントリスナーを追加
  radioButtons.forEach(radio => {
    radio.addEventListener('change', function() {
      const selectedRankId = this.value;
      updateSelectOptions(selectedRankId, selectBox, allOptionId);
      updateSelectBoxState(selectedRankId, selectBox, allOptionId, eventOptionId);
    });
  });

  /**
   * セレクトボックスの状態を更新
   */
  function updateSelectBoxState(selectedRankId, selectBox, allOptionId, eventOptionId) {
    // `selectBox`が存在しない場合は処理を終了
    if (!selectBox) {
      console.error("セレクトボックスが見つかりません。");
      return;
    }

    // 「すべて」または「イベント」が選択されたときにセレクトボックスを無効化
    selectBox.disabled = selectedRankId === allOptionId || selectedRankId === eventOptionId;
  }

  /**
   * ランクに応じたセレクトボックスのオプションを更新
   */
  function updateSelectOptions(selectedRankId, selectBox, allOptionId) {
    if (selectedRankId === allOptionId) {
      selectBox.innerHTML = "";  // 「すべて」だけを表示
      const option = document.createElement("option");
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
          data.forEach(subRank => {
            const option = document.createElement("option");
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
});

// 新規作成・編集フォーム：武器セレクトを動的に生成
document.addEventListener("turbo:load", () => {
  // 最初に作成されたセレクトボックスをクローンして保存
  const originalWeaponSelect = $('#weaponSelect').clone();

  // セレクトボックスを更新する処理
  const updateWeaponSelect = (categoryVal) => {
    $('#weaponSelect').remove(); // 既存のセレクトボックスを削除
    if (categoryVal) {
      const selectedTemplate = $(`#m-weapon-of-weapon-type${categoryVal}`);
      $('#weaponSelectWrap').prepend(selectedTemplate.html()); // 新しいセレクトボックスを追加
    } else {
      $('#weaponSelectWrap').prepend(originalWeaponSelect.clone()); // デフォルトのセレクトボックスを追加
    }
  };

  // ページ読み込み時の初期化処理
  const initialCategoryVal = $('#m_weapon_type').val();
  updateWeaponSelect(initialCategoryVal); // 初期表示のセレクトボックスを設定

  // 武器種セレクトが変更された時の処理
  // TODO: 選択を初期化する
  $('#m_weapon_type').on('change', function() {
    const categoryVal = $(this).val();
    updateWeaponSelect(categoryVal); // セレクトボックスを更新
  });
});