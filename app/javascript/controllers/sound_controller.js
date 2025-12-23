import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "backgroundMusic",
    "gameOver",
    "gameCompleted",
    "backgroundMusicVolumeSlider",
    "soundEffectsVolumeSlider",
    "treat",
    "hole",
    "levelUp",
    "backgroundMusicButton",
    "soundEffectsButton"
  ];

  static values = {
    backgroundMusicVolume: { type: Number, default: 1 },
    backgroundMusicMuted: { type: Boolean, default: true },
    soundEffectsVolume: { type: Number, default: 1 },
    soundEffectsMuted: { type: Boolean, default: false }
  };

  static classes = ["playing"];

  connect() {
    this.backgroundMusicVolumeValue = parseFloat(localStorage.getItem("backgroundMusicVolume")) || this.backgroundMusicVolumeValue;
    this.backgroundMusicMutedValue = (localStorage.getItem("backgroundMusicMuted") === "true") || this.backgroundMusicMutedValue;
    this.soundEffectsVolumeValue = parseFloat(localStorage.getItem("soundEffectsVolume")) || this.soundEffectsVolumeValue;
    this.soundEffectsMutedValue = (localStorage.getItem("soundEffectsMuted") === "true") || this.soundEffectsMutedValue;

    if (this.hasBackgroundMusicVolumeSliderTarget) {
      this.backgroundMusicVolumeSliderTarget.value = this.backgroundMusicVolumeValue;
    }

    if (!this.backgroundMusicMutedValue && this.hasBackgroundMusicButtonTarget) {
      this.backgroundMusicButtonTarget.classList.add(...this.playingClasses);
    }

    if (this.hasSoundEffectsVolumeSliderTarget) {
      this.soundEffectsVolumeSliderTarget.value = this.soundEffectsVolumeValue;
    }

    if (!this.soundEffectsMutedValue && this.hasSoundEffectsButtonTarget) {
      this.soundEffectsButtonTarget.classList.add(...this.playingClasses);
    }
  }

  toggleBackgroundMusic() {
    this.backgroundMusicMutedValue = !this.backgroundMusicMutedValue;
    localStorage.setItem("backgroundMusicMuted", this.backgroundMusicMutedValue);

    if (this.hasBackgroundMusicTarget) {
      if (this.backgroundMusicMutedValue) {
        this.backgroundMusicTarget.pause();
        this.backgroundMusicButtonTarget.classList.remove(...this.playingClasses);
        this.backgroundMusicTarget.fastSeek(0);
      } else {
        this.backgroundMusicTarget.play().catch(e => console.error("Could not play background music", e));
        this.backgroundMusicButtonTarget.classList.add(...this.playingClasses);
      }
    }
  }

  setBackgroundMusicVolume() {
    if (this.hasBackgroundMusicTarget && this.hasBackgroundMusicVolumeSliderTarget) {
      const newVolume = this.backgroundMusicVolumeSliderTarget.value;
      this.backgroundMusicTarget.volume = newVolume;
      this.backgroundMusicVolumeValue = newVolume;
      localStorage.setItem("backgroundMusicVolume", newVolume);
    }
  }

  toggleSoundEffects() {
    this.soundEffectsMutedValue = !this.soundEffectsMutedValue;
    this.streamActionsSoundEffects().forEach((soundEffect) => {
      soundEffect.muted = this.soundEffectsMutedValue;
    });

    if (this.hasSoundEffectsButtonTarget) {
      if (this.soundEffectsMutedValue) {
        this.soundEffectsButtonTarget.classList.remove(...this.playingClasses);
      } else {
        this.soundEffectsButtonTarget.classList.add(...this.playingClasses);
      }
    }

    localStorage.setItem("soundEffectsMuted", this.soundEffectsMutedValue);
  }

  setSoundEffectsVolume() {
    if (this.hasSoundEffectsVolumeSliderTarget) {
      this.soundEffectsVolumeValue = this.soundEffectsVolumeSliderTarget.value;
      this.streamActionsSoundEffects().forEach((soundEffect) => {
        soundEffect.volume = this.soundEffectsVolumeValue;
      });
      localStorage.setItem("soundEffectsVolume", this.soundEffectsVolumeValue);
    }
  }

  streamActionsSoundEffects() {
    return [this.holeTarget, this.treatTarget, this.levelUpTarget];
  }

  playSound(soundName) {
    if (this.soundEffectsMutedValue) return;

    const soundTarget = this[`${soundName}Target`];
    if (soundTarget) {
      soundTarget.volume = this.soundEffectsVolumeValue;
      soundTarget.play().catch(e => console.error(`Could not play ${soundName}`, e));
    }
  }

  gameOverTargetConnected(element) {
    this.playSound("gameOver");
  }

  gameCompletedTargetConnected(element) {
    this.playSound("gameCompleted");
  }
}
