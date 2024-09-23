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

// 新規作成・編集フォーム：武器種セレクトによって、狩技セレクトを動的に生成。
document.addEventListener("turbo:load", () => {
  const weaponTypeSelect = document.getElementById("m_weapon_type");
  const artSelects = [
    document.getElementById("artSelect1"),
    document.getElementById("artSelect2"),
    document.getElementById("artSelect3")
  ];

  // すでに選択されている狩技のIDを取得
  const selectedArts = artSelects.map(select => select.value);

  // 武器種が変更された際に狩技のセレクトボックスを更新する関数
  function updateHunterArtsSelect(weaponTypeId, selectedArts = []) {
    fetch(`/mhxx/times/filtered_hunter_arts?m_weapon_type=${weaponTypeId}`)
      .then(response => response.json())
      .then(data => {
        artSelects.forEach((select, index) => {
          const currentSelectedArt = selectedArts[index]; // 現在の選択状態を保持

          select.innerHTML = ''; // 現在のオプションをクリア

          // なしのオプションを追加
          const defaultOption = document.createElement('option');
          defaultOption.value = '';
          defaultOption.text = 'なし';
          select.appendChild(defaultOption);

          // グループ化されたデータを反映（共通→武器種の順）
          Object.keys(data).forEach(group => {
            const optgroup = document.createElement('optgroup');
            optgroup.label = group;

            data[group].forEach(art => {
              const option = document.createElement('option');
              option.value = art.id;
              option.text = art.name;

              // 初期表示時に選択済みの値を選択状態にする
              if (String(art.id) === String(currentSelectedArt)) {
                option.selected = true;
              }

              optgroup.appendChild(option);
            });

            select.appendChild(optgroup);
          });
        });
      })
      .catch(error => console.error('Error fetching hunter arts:', error));
  }

  // ページ読み込み時に武器種が既に選択されている場合に狩技を更新
  const selectedWeaponTypeId = weaponTypeSelect.value;
  if (selectedWeaponTypeId) {
    updateHunterArtsSelect(selectedWeaponTypeId, selectedArts); // 初期表示時に現在の選択状態を渡す
  }

  // 武器種が変更された際に狩技を更新
  weaponTypeSelect.addEventListener('change', (event) => {
    const selectedWeaponTypeId = event.target.value;
    if (selectedWeaponTypeId) {
      updateHunterArtsSelect(selectedWeaponTypeId, selectedArts);
    } else {
      // 武器種が未選択の場合、狩技をリセット
      artSelects.forEach(select => {
        select.innerHTML = '';
        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.text = 'なし';
        select.appendChild(defaultOption);
      });
    }
  });
});

// 新規作成・編集フォーム：狩猟スタイルセレクトによって、狩技セレクトをdisableにする。
document.addEventListener("turbo:load", () => {
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

  function updateHunterArtsSelects(quantity) {
    artSelects.forEach((select, index) => {
      const artIndex = index + 1;
      select.disabled = quantity < artIndex;

      if (select.disabled) {
        select.value = "";  // 無効化されたときにセレクトの値をリセット
        hiddenFields[index].value = "";  // 隠しフィールドにもリセットを反映
      } else {
        hiddenFields[index].value = select.value;  // 隠しフィールドに選択状態を反映
      }
    });
  }

  // セレクトボックスが変更されたときにhidden_fieldの値を更新
  artSelects.forEach((select, index) => {
    select.addEventListener('change', () => {
      hiddenFields[index].value = select.value;  // セレクトボックスの変更に応じてhidden_fieldを更新
    });
  });

  // スタイルセレクト変更時の処理（スタイルの数量に応じて）
  const styleSelect = document.getElementById("styleSelect");
  const huntingStyles = JSON.parse(styleSelect.dataset.huntingStyles);

  styleSelect.addEventListener("change", (event) => {
    const selectedStyleId = event.target.value;
    const quantity = huntingStyles[selectedStyleId] || 0;
    updateHunterArtsSelects(quantity);
  });

  // 初期状態での処理
  const initialStyleId = styleSelect.value;
  updateHunterArtsSelects(huntingStyles[initialStyleId]);
});
