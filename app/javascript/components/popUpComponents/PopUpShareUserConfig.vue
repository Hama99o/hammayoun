<template>
  <v-dialog max-width="500" v-model="data.open">
    <template #default>

      <div class="w-full flex flex-col p-6 gap-8 bg-white">
        <!-- Icon and text -->


        <div class="flex flex-col  align-center">
          <p
            v-for="text in title"
            :key="text"
            class="text-center font-medium text-xl"
          >
            {{ $t(text) }}
          </p>
        </div>

        <!-- Buttons -->
        <div class="flex flex-col items-start gap-3 self-stretch lg:!flex-row">
          <div
            v-if="data.textClose && data.textConfirm"
            class="w-full flex flex-col justify-center sm:flex-row gap-x-3 px-1.5"
          >
            <v-btn
              variant="outlined"
              color="black"
              class="text-fakeBlack border-darkGrey border-1 normal-case font-medium w-full sm:w-1/2 text-xs mb-3 sm:!mb-0"
              @click="data.sendWithoutEmail ? data.sendWithoutEmail() : closePopUp()"
            >
              {{ $t(data.textClose) }}
            </v-btn>

            <v-btn
              v-if="data.color === 'blue'"
              variant="outlined"
              class="text-white bg-primary normal-case font-medium w-full sm:w-1/2 text-xs"
              :color="data.color"
              @click="data.sendWithEmail ? data.sendWithEmail() : confirmPopUp()"
            >
              {{ $t(data.textConfirm) }}
            </v-btn>

            <v-btn
              v-else-if="data.color === 'red'"
              variant="outlined"
              class="text-white bg-negativeRed normal-case font-medium w-full sm:w-1/2 text-xs"
              :color="data.color"
              @click="confirmPopUp"
            >
              {{ $t(data.textConfirm) }}
            </v-btn>

            <v-btn
              v-else
              variant="flat"
              class="text-white normal-case font-medium w-full sm:w-1/2 text-xs"
              :color="data.color"
              @click="confirmPopUp"
            >
              {{ $t(data.textConfirm) }}
            </v-btn>
          </div>
        </div>
      </div>
    </template>
  </v-dialog>
</template>

<script setup>
import { storeToRefs } from "pinia";
import { usePopUpStore } from "@/stores/pop-up.store";
import PopUpSkeleton from "./PopUpSkeleton.vue";

const { data } = storeToRefs(usePopUpStore());
const { confirmPopUp, closePopUp } = usePopUpStore();

const title = data.value.title.split("<br/>")
const subtitle = data.value.subtitle?.split("<br/>")
</script>
