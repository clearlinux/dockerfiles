// @apiVersion 0.1
// @name io.intel.pkg.dlaas-resnet50
// @description dlaas multi-node benchmark
// @shortDescription A multi-node DLaaS benchmark
// @param name string Name for the job.

local k = import "k.libsonnet";

local name = params.name;
local namespace = env.namespace;
local image = "hub.docker.com/clearlinux/stacks-dlaas-kubeflow:latest";
local replicas = 3;

local tfjob = {
  apiVersion: "kubeflow.org/v1alpha2",
  kind: "TFJob",
  metadata: {
    name: name,
    namespace: namespace,
  },
  spec: {
    tfReplicaSpecs: {
      Worker: {
        replicas: replicas,
        template: {
          spec: {
            containers: [
              {
                args: [
                  "python",
                  "tf_cnn_benchmarks.py",
                  "--batch_size=32",
                  "--model=resnet50",
                  "--variable_update=parameter_server",
                  "--local_parameter_device=cpu",
                  "--init_learning_rate=0.0001",
                  "--tf_random_seed=8286",
                  "--device=cpu",
                  "--data_format=NHWC",
                ],
                image: image,
                name: "tensorflow",
                workingDir: "/opt/tf-benchmarks/scripts/tf_cnn_benchmarks",
              },
            ],
            restartPolicy: "OnFailure",
          },
        },
      },
      Ps: {
        template: {
          spec: {
            containers: [
              {
                args: [
                  "python",
                  "tf_cnn_benchmarks.py",
                  "--batch_size=32",
                  "--model=resnet50",
                  "--variable_update=parameter_server",
                  "--local_parameter_device=cpu",
                  "--init_learning_rate=0.0001",
                  "--tf_random_seed=8286",
                  "--device=cpu",
                  "--data_format=NHWC",
                ],
                image: image,
                name: "tensorflow",
                workingDir: "/opt/tf-benchmarks/scripts/tf_cnn_benchmarks",
              },
            ],
            restartPolicy: "OnFailure",
          },
        },
        tfReplicaType: "PS",
      },
    },
  },
};

k.core.v1.list.new([
  tfjob,
])
