#!/usr/bin/env bash

# Copyright (c) 2019 StackRox Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# delete.sh
#
# Deletes the environment for the admission controller webhook demo in the active cluster.

echo "Deleting Kubernetes objects ..."
kubectl delete namespace webhook-demo

echo "Deleting the Mutating Webhook Configuration ..."
kubectl delete MutatingWebhookConfiguration demo-webhook

echo "The webhook server and MutatingWebhookConfiguration have been deleted!"

kubectl delete -f examples/pod-with-conflict.yaml
kubectl delete -f examples/pod-with-defaults.yaml
kubectl delete -f examples/pod-with-override.yaml

echo "example pods deleted!"