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

// 新規作成・編集フォーム：武器種セレクト・属性ボタンによって、武器セレクトを動的に生成
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

// HACK: 武器種を変更したとき、共通の狩技もリセットされるようにする。
// 新規作成・編集フォーム：武器種セレクトによって、狩技セレクトを動的に生成。
document.addEventListener("turbo:load", () => {
  const weaponTypeSelect = document.getElementById("m_weapon_type");
  const artSelects = [
    document.getElementById("artSelect1"),
    document.getElementById("artSelect2"),
    document.getElementById("artSelect3")
  ];
  const hiddenFields = [
    document.getElementById("hiddenArtSelect1"),
    document.getElementById("hiddenArtSelect2"),
    document.getElementById("hiddenArtSelect3")
  ];
  const styleSelect = document.getElementById("styleSelect");
  const huntingStyles = JSON.parse(styleSelect.dataset.huntingStyles);

  // 狩技セレクトボックスを更新する関数
  function updateHunterArtsSelect(weaponTypeId, selectedArts = []) {
    fetch(`/mhxx/times/filtered_hunter_arts?m_weapon_type=${weaponTypeId}`)
      .then(response => response.json())
      .then(data => {
        artSelects.forEach((select, index) => {
          const currentSelectedArt = selectedArts[index]; // 現在の選択状態を保持
          select.innerHTML = ''; // オプションをクリア
          select.appendChild(createDefaultOption()); // "なし" を追加

          // グループ化されたオプションを追加
          Object.keys(data).forEach(group => {
            const optgroup = document.createElement('optgroup');
            optgroup.label = group;
            data[group].forEach(art => {
              const option = createOption(art, currentSelectedArt);
              optgroup.appendChild(option);
            });
            select.appendChild(optgroup);
          });
        });
      })
      .catch(error => console.error('Error fetching hunter arts:', error));
  }

  // デフォルトの "なし" オプションを作成する関数
  function createDefaultOption() {
    const option = document.createElement('option');
    option.value = '';
    option.text = 'なし';
    return option;
  }

  // オプションを作成する関数
  function createOption(art, currentSelectedArt) {
    const option = document.createElement('option');
    option.value = art.id;
    option.text = art.name;
    if (String(art.id) === String(currentSelectedArt)) {
      option.selected = true;
    }
    return option;
  }

  // 狩猟スタイルに応じて狩技セレクトを無効化/有効化する関数
  function updateHunterArtsSelects(quantity) {
    artSelects.forEach((select, index) => {
      const artIndex = index + 1;
      select.disabled = quantity < artIndex;
      if (select.disabled) {
        select.value = "";  // 無効化されたときにリセット
        hiddenFields[index].value = "";  // 隠しフィールドにも反映
      } else {
        hiddenFields[index].value = select.value;  // 有効化されている場合は隠しフィールドに値を反映
      }
    });
  }

  // 狩技セレクトの変更時に隠しフィールドを更新
  artSelects.forEach((select, index) => {
    select.addEventListener('change', () => {
      hiddenFields[index].value = select.value;
    });
  });

  // 武器種セレクトの変更時に狩技セレクトを更新
  weaponTypeSelect.addEventListener('change', (event) => {
    const selectedWeaponTypeId = event.target.value;
    const selectedArts = artSelects.map(select => select.value); // 現在の選択状態を保持
    if (selectedWeaponTypeId) {
      updateHunterArtsSelect(selectedWeaponTypeId, selectedArts);
    } else {
      artSelects.forEach(select => {
        select.innerHTML = '';
        select.appendChild(createDefaultOption()); // "なし" を追加
      });
    }
  });

  // 狩猟スタイルセレクトの変更時に狩技セレクトを無効化/有効化
  styleSelect.addEventListener("change", (event) => {
    const selectedStyleId = event.target.value;
    const quantity = huntingStyles[selectedStyleId] || 0;
    updateHunterArtsSelects(quantity);
  });

  // ページ読み込み時の初期化
  const selectedWeaponTypeId = weaponTypeSelect.value;
  const selectedArts = artSelects.map(select => select.value); // 初期選択状態を保持
  if (selectedWeaponTypeId) {
    updateHunterArtsSelect(selectedWeaponTypeId, selectedArts);
  }
  const initialStyleId = styleSelect.value;
  updateHunterArtsSelects(huntingStyles[initialStyleId]);
});
