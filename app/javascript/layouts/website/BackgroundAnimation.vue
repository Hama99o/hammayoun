<template>
  <div class="background-animation">
    <div class="cloud"></div>
    <div class="mountain fixed" :class="getClass('whiteBorderBottomInDark')"></div>
    <div class="ground fixed" :class="getClass('whiteBgInDark')"></div>
  </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { usePortfolioStore } from '@/stores/portfolio.store';

const { lightDarkClasses, hasNightMood, getTheme } = storeToRefs(usePortfolioStore());


const getClass = (attribute) => {
  return lightDarkClasses.value[attribute][hasNightMood.value];
};

</script>

<style lang="scss" scoped>

.fixed {
  bottom: 0;
  position: fixed;
}

.circle {
  border-radius: 100vw;
}

.cloud {
	width: 350px; height: 120px;
  animation:slide ease-in 70s infinite;

	background: #d0cccc;
	border-radius: 100px;
	-webkit-border-radius: 100px;
	-moz-border-radius: 100px;
  top: 40vh;
  clear: both;
  opacity: .5;
	position: absolute;
	margin: 140px auto 20px;
}

.cloud:after, .cloud:before {
	content: '';
	position: absolute;
	background: #d0cccc;
	z-index: -1
}

.cloud:after {
	width: 100px; height: 100px;
	top: -50px; left: 50px;

	border-radius: 100px;
	-webkit-border-radius: 100px;
	-moz-border-radius: 100px;
}

.cloud:before {
	width: 180px; height: 180px;
	top: -90px; right: 50px;
	border-radius: 200px;
	-webkit-border-radius: 200px;
	-moz-border-radius: 200px;
}

.mountain {
  border: 40vh solid transparent;
  left: 15em;
}

.mountain:before,.mountain:after {
  border: 30vh solid transparent;
  bottom: 0;
  content: "";
  display: block;
  left: 0;
  position: absolute;
  top: -10vh;
}

.mountain:before {
  left: -55vh;
  top: -15vh;
}

.ground {
  height: 4vh;
  width: 100vw;
  z-index: -99;
}

@keyframes slide {
  0% {
    transform: translateX(15vw);
  }
  50% {
    transform: translateX(50vw);
  }
  100% {
    transform: translateX(15vw);
  }
}

.dark-bottom-border {
  border-bottom-color: #292b2c;
}

.white-bottom-border {
  border-bottom-color: white;
}

.dark-bottom-border:before,.dark-bottom-border:after {
  border-bottom-color: #292b2c;
}

.white-bottom-border:before,.white-bottom-border:after {
  border-bottom-color: white;
}

@media (max-width: 868px) {
  .cloud, .mountain, .ground  {
    display: none;
  }
}
</style>
