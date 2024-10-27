import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="pawapuro-details-modal"
export default class extends Controller {
  //ターゲットの定義
  static targets = ["modal"];
  //connectメソッドは、コントローラに繋がれた時に呼ばれるアクション（モーダルが開かれた時）
  connect() {
    this.modal = new bootstrap.Modal(this.element);
    this.modal.show();

    // モーダルが開かれた後にタブイベントを設定
    this.setupTabEvents();
  }

  // モーダルを開く
  open() {
    this.modal.show();
  }
  // モーダルを閉じる
  close() {
    this.modal.hide();
  }

  // モーダルのボーダーを変更
  setupTabEvents() {
    const modalBox = this.element.querySelector(".modal-content");
    const tabLinks = this.element.querySelectorAll(".nav-tabs .nav-link");

    if (modalBox && tabLinks.length > 0) {
      // 各タブの色を指定
      const tabColors = {
        playerBasic: "#0054A2", // "選手能力" タブの色
        playerPitcher: "#C30621", // "投手能力" タブの色
        playerFielder: "#0884E6", // "野手能力" タブの色
        playerPromotion: "#D79E05", // "守備・起用" タブの色
        playerProfile: "#0DAD0D", // "プロフィール" タブの色
      };

      tabLinks.forEach((tab) => {
        tab.addEventListener("shown.bs.tab", (event) => {
          const targetId = event.target
            .getAttribute("data-bs-target")
            .substring(1);
          const newColor = tabColors[targetId];

          if (modalBox && newColor) {
            modalBox.style.borderColor = newColor;
          }
        });
      });
    }
  }
}
