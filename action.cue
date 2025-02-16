name:        "Run Holos"
description: "Manage configuration with Holos"
inputs: {
	version: {
		description: "Holos version to execute (e.g. \(default))"
		required:    false
		default:     string @tag(version)
		default:     =~"^v"
	}
	command: {
		description: "Holos command to execute"
		required:    false
		default:     "holos render platform"
	}
	flags: {
		description: "flags for docker run (e.g. --env PASSWORD)"
		required:    false
		default:     ""
	}
}
runs: {
	using: "composite"
	steps: [{
		name:  "Setup Holos"
		shell: "bash"
		run:   "docker pull --quiet ghcr.io/holos-run/holos:${{ inputs.version }}"
	}, {
		name:  "Run Holos"
		shell: "bash"
		run: """
			# ${{ inputs.command }}
			docker run -v $(pwd):/app --workdir /app ${{ inputs.flags }} --rm ghcr.io/holos-run/holos:${{ inputs.version }} ${{inputs.command }}
			"""
	}]
}
