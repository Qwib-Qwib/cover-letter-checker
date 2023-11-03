import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'charLine', 'charCount', 'charCountExplanation'];

  static values = {
    min: Number,
    max: Number
  }

  charCountTargetConnected() {
    this.charCountTarget.innerText = this.inputTarget.value.length;

    if (parseInt(this.charCountTarget.innerText) < this.minValue) {
      this.charLineTarget.style.color = 'red';
      this.charCountExplanationTarget.innerText = ' Trop court !';
    } else if (parseInt(this.charCountTarget.innerText) > this.maxValue) {
      this.charLineTarget.style.color = 'red';
      this.charCountExplanationTarget.innerText = ' Trop long !';
    } else {
      this.charLineTarget.style.color = 'black';
      this.charCountExplanationTarget.innerText = '';
    }
  }

  countChars() {
    this.charCountTarget.innerText = this.inputTarget.value.length;

    if (parseInt(this.charCountTarget.innerText) < this.minValue) {
      this.charLineTarget.style.color = 'red';
      this.charCountExplanationTarget.innerText = ' Trop court !';
    } else if (parseInt(this.charCountTarget.innerText) > this.maxValue) {
      this.charLineTarget.style.color = 'red';
      this.charCountExplanationTarget.innerText = ' Trop long !';
    } else {
      this.charLineTarget.style.color = 'black';
      this.charCountExplanationTarget.innerText = '';
    }
  }
}
