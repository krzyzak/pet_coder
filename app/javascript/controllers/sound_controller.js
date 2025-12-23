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
    const backgroundMusicVolume = localStorage.getItem("backgroundMusicVolume");
    if (backgroundMusicVolume !== null) {
      this.backgroundMusicVolumeValue = parseFloat(backgroundMusicVolume);
    }
    const soundEffectsVolume = localStorage.getItem("soundEffectsVolume");
    if (soundEffectsVolume !== null) {
      this.soundEffectsVolumeValue = parseFloat(soundEffectsVolume);
    }
    const soundEffectsMuted = localStorage.getItem("soundEffectsMuted");
    if (soundEffectsMuted !== null) {
      this.soundEffectsMutedValue = soundEffectsMuted === "true";
    }

    if (this.hasBackgroundMusicVolumeSliderTarget) {
      this.backgroundMusicVolumeSliderTarget.value = this.backgroundMusicVolumeValue;
    }

    if (this.hasBackgroundMusicTarget) {
      this.backgroundMusicTarget.volume = this.backgroundMusicVolumeValue;
    }

    if (this.hasSoundEffectsVolumeSliderTarget) {
      this.soundEffectsVolumeSliderTarget.value = this.soundEffectsVolumeValue;
    }

    if (!this.soundEffectsMutedValue && this.hasSoundEffectsButtonTarget) {
      this.soundEffectsButtonTarget.classList.add(...this.playingClasses);
    }

    this.streamActionsSoundEffects().forEach((soundEffect) => {
      soundEffect.volume = this.soundEffectsVolumeValue;
      soundEffect.muted = this.soundEffectsMutedValue;
    });
  }

  toggleBackgroundMusic() {
    if (this.hasBackgroundMusicTarget) {
      if (this.backgroundMusicTarget.paused) {
        this.backgroundMusicTarget.play().catch(e => console.error("Could not play background music", e));
        this.backgroundMusicButtonTarget.classList.add(...this.playingClasses);
      } else {
        this.backgroundMusicTarget.pause();
        this.backgroundMusicButtonTarget.classList.remove(...this.playingClasses);
        this.backgroundMusicTarget.fastSeek(0);
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
    if (this.hasHoleTarget && this.hasTreatTarget && this.hasLevelUpTarget) {
      return [this.holeTarget, this.treatTarget, this.levelUpTarget];
    }
    else {
      return [];
    }
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

  backgroundMusicTargetConnected(element) {
    if (this.hasBackgroundMusicTarget && !this.backgroundMusicTarget.paused && this.hasBackgroundMusicButtonTarget) {
      this.backgroundMusicButtonTarget.classList.add(...this.playingClasses);
    }
  }
}
