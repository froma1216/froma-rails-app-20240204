import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pawapuro-details-modal"
export default class extends Controller {
  //ターゲットの定義
  static targets = ["modal"]
  //connectメソッドは、コントローラに繋がれた時に呼ばれるアクション（モーダルが開かれた時）
  connect() {
    this.modal = new bootstrap.Modal(this.element)
    this.modal.show()
  }
  // モーダルを開く
  open() {
    this.modal.show()
  }
  // モーダルを閉じる
  close() {
    this.modal.hide()
  }
}
