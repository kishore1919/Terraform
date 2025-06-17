## Ollama Installation Guide v2

This guide outlines the steps to install Ollama using Helm on a Kubernetes cluster.

### Prerequisites

Before proceeding, ensure you have the following installed:

*   Helm (version >= 3.0)
*   kubectl (compatible with your Kubernetes cluster)

### Installation Steps

1.  **Add the Ollama Helm repository:**

    ```bash
    helm repo add otwld https://helm.otwld.com/
    ```

2.  **Update your Helm repositories:**

    ```bash
    helm repo update
    ```

3.  **Install Ollama using Helm:**

    ```bash
    helm upgrade --install ollama otwld/ollama --namespace ollama --create-namespace --wait
    ```

4.  **Verify the installation:**

    ```bash
    kubectl get pods -n ollama
    ```

### GPU Requirements

To leverage GPU acceleration for running models with Ollama, your Kubernetes nodes must have compatible GPUs and the necessary drivers and container runtimes installed (e.g., NVIDIA drivers, NVIDIA Container Toolkit).

The Helm chart may require specific configuration values to enable GPU support. You typically need to:

*   Ensure your nodes are labeled appropriately for scheduling pods onto GPU nodes.
*   Configure the Helm chart to request GPU resources (e.g., `resources.limits.nvidia.com/gpu: 1`).
*   Potentially configure node selectors or affinity rules to target GPU nodes.

**Example (Illustrative - check chart values for specifics):**

You might need to add a values file or set parameters like this during installation:

```bash
helm upgrade --install ollama otwld/ollama --namespace ollama --create-namespace --wait \
  --set ollama.resources.limits."nvidia\.com/gpu"=1 \
  --set ollama.nodeSelector."gpu"="true" # Example node selector
```

**Note:** The exact configuration depends heavily on the specific Helm chart version and your Kubernetes cluster setup (e.g., how GPU nodes are labeled and configured). Refer to the official `otwld/ollama` Helm chart documentation for precise GPU configuration options.

### Testing the Installation

Once installed, you can test by generating a response from a model. You might need to port-forward or expose the Ollama service to access it.

Assuming you can access the service (e.g., via `localhost:8080` with a Host header):

```bash
curl -H "Host: ollama.ollama" \
  http://localhost:8080/api/generate \
  -d '{ "model": "gemma:7b", "prompt": "Hello!", "stream":"false" }'
```

This command sends a request to the Ollama service to generate text using the `gemma:7b` model.