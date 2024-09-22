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
  // セレクトボックスの初期化関数
  const clearAndAddDefaultOption = (selectBox) => {
    selectBox.innerHTML = ""; // 既存の選択肢をクリア

    // "--武器を選択--" オプションを最初に追加
    const defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.textContent = "--武器を選択--";
    defaultOption.disabled = true;
    defaultOption.selected = true; // デフォルトで選択状態にする
    selectBox.appendChild(defaultOption);
  };

  // 武器セレクトの更新処理
  const updateWeaponSelect = (weaponType, element) => {
    if (!weaponType && !element) return; // 初期表示の際に既存セレクトを保持

    fetch(`/mhxx/times/filtered_weapons?m_weapon_type=${weaponType}&element=${element}`)
      .then(response => response.json())
      .then(data => {
        const weaponSelectBox = document.getElementById("weaponSelect");
        clearAndAddDefaultOption(weaponSelectBox); // セレクトボックスをクリアし、デフォルトオプションを追加

        // フィルタ結果をセレクトボックスに反映
        data.forEach(weapon => {
          const option = document.createElement("option");
          option.value = weapon.id;
          option.textContent = weapon.name;
          weaponSelectBox.appendChild(option);
        });
      })
      .catch(error => console.error('Error fetching filtered weapons:', error));
  };

  // フィルタ変更時の処理
  const weaponTypeSelect = document.getElementById("m_weapon_type");
  const elementButtons = document.querySelectorAll("button[data-element]");

  const applyFilters = () => {
    const selectedWeaponType = weaponTypeSelect.value;
    const activeElementButton = document.querySelector("button[data-element].active");
    const selectedElement = activeElementButton ? activeElementButton.dataset.element : "";
    
    updateWeaponSelect(selectedWeaponType, selectedElement);
  };

  // 武器種セレクトが変更された時の処理
  weaponTypeSelect.addEventListener("change", applyFilters);

  // 属性ボタンがクリックされた時の処理
  elementButtons.forEach(button => {
    button.addEventListener("click", function() {
      elementButtons.forEach(btn => btn.classList.remove("active")); // 全てのボタンからactiveを削除
      this.classList.add("active"); // クリックされたボタンにactiveを追加
      applyFilters(); // フィルタを適用
    });
  });
});
