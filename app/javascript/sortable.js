// NOTE: https://qiita.com/kakita-yzrh/items/16ab36c29828b493c728
document.addEventListener("turbo:load", function () {
  const sortElement = document.getElementById("sort-table");

  Sortable.create(sortElement, {
    onEnd: function (evt) {
      let order = [];
      // 並び替えられたクエストの順番を取得
      document.querySelectorAll("#sort-table li").forEach((element, index) => {
        order.push({
          id: element.dataset.id,
          display_order: index + 1, // 順番を1から開始して保存
        });
      });

      // 新しい順序をサーバーへ送信
      fetch("/mhxx/bookmark_quests/update_order", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ order: order }),
      }).then((response) => {
        if (response.ok) {
          console.log("順序が正常に更新されました！");
        } else {
          console.error("順序の更新中にエラーが発生しました。");
        }
      });
    },
  });
});
