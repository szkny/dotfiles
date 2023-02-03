#!/usr/bin/env node
"use strict";
import { Configuration, OpenAIApi } from "openai";
const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);
const postai = async (input) => {
  const res = await openai.createCompletion({
    model: "text-davinci-003",
    prompt: input,
    temperature: 0,
    max_tokens: 500,
  });
  console.log(res.data.choices[0].text);
};
// postai('fizzbuzz in python');
process.stdin.resume();
process.stdin.setEncoding("utf8");
process.stdin.on("data", async (inputData) => {
  var input = inputData.slice(0, -1);
  await postai(input);
  process.exit(0);
});
process.on("SIGINT", function () {
  process.exit(0);
});
process.on("exit", function () {});
