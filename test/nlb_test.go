package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamplesTerraform(t *testing.T) {
  t.Parallel()
  terraformOpts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: "../examples/terratest/",
  })

  defer terraform.Destroy(t, terraformOpts)
  terraform.InitAndApply(t, terraformOpts)

  // Verify that the EIP NLB is created
  nlbEipUrl := terraform.Output(t, terraformOpts, "nlb_eip_url")
  assert.Contains(t, nlbEipUrl, "terratest-eip")

  // Verify that the S3 bucket is created
  lambdaS3Bucket := terraform.Output(t, terraformOpts, "s3_bucket_arn")
  assert.Contains(t, lambdaS3Bucket, "terratest")

  // Verify that the NOEIP NLB is created
  nlbNoEipUrl := terraform.Output(t, terraformOpts, "nlb_noeip_url")
  assert.Contains(t, nlbNoEipUrl, "terratest-noeip")

}
