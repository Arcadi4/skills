---
name: configure-opencode-custom-providers
description: Use when configuring custom providers for OpenCode.
license: CC-BY-SA-4.0
---

# Configuring OpenCode Custom Providers

This skill guides you on how to configure custom providers for OpenCode.

## Before You Begin

The user must provide one or multiple pairs of provider API base url and API key. If they didn't, do nothing and ask the user to provide them.

## What is OpenCode

[OpenCode](https://github.com/anomalyco/opencode) is an open-source coding agent. It relies on <https://models.dev> ([Repo](https://github.com/anomalyco/models.dev)) to provide a catalogue of available models and providers, which is also maintained by Anomaly.

## The Workflow

### 1. Locate the config file

Use `opencode debug paths`. If this fails, stop immediately.

### 2. Discover models from provided APIs

Fetch each provider API base url with the provided API key:

```bash
curl -H "Authorization: Bearer <API_KEY>" <API_BASE_URL>/v1/models
curl -H "x-api-key: <API_KEY>" <API_BASE_URL>/v1/models
```

If both returns 404, first retry without `v1`. If 404 persists, this might mean the API does not provide a models endpoint. You should ask the user to provide a model list instead before proceeding. Report accordingly if the error is not 404 (e.g., permission denied).

### 3. Get metadata of seen models

First, fetch <models.dev>'s API: <https://models.dev/models.json>. The JSON is extremely large, never `curl` is barely. You must gate the output through `jq` first. Then, for each model seen in the previous step, check if it exists in <models.dev>. If it does, get the metadata of the model. Model IDs from <models.dev> and the custom provider does not have to match exactly. You are allowed to make reasonable inferences.

If you cannot find a model on <models.dev>, do not add it to the config file in the next step. Report the models you cannot determine to the user in the final task report.

### 4. Determine API type

This determines the `npm` field to use. Try POST on `/v1/chat/completions` and `/v1/messages` WITHOUT keys (otherwise you might spend the user's API quota). If `/v1/chat/completions` exists, the API is OpenAI-style, use `@ai-sdk/openai-compatible`. If `/v1/messages` exists, the API is Anthropic-style, use `@ai-sdk/anthropic`. If both are available or both fails, prefer `@ai-sdk/openai-compatible`. In the case of failure, you should include this is the task report.

### 5. Edit the config file

Read these docs before you start, they will tell you the shape of custom providers and models configuration: <https://opencode.ai/docs/providers> <https://opencode.ai/docs/models>. Then, write the config file with valid models, and fill in the metadata with the information you got from <models.dev>. Note that you must use the id from the custom provider, not the id from <models.dev>.
