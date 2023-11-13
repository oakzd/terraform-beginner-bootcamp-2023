package main
// package main: Declares the package name.
// The main package is special in Go, its where the execution of the program starts

// import "fmt" imports the fmt package
import (
	"fmt"
	//"log"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)
//func main(): Defines the main function
func main() {

	plugin.Serve(&plugin.ServeOpts {
		ProviderFunc: Provider,
	})


	// Call the HelloWorld function from the hello package
	fmt.Println("Hello, World!")
}

func Provider() *schema.Provider{
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint" : {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // mark it has sensitive to hide it in the logs
				Required: true,
				Description: "Bearer token for authorization",				
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUId for configuration",
				//ValidFunc: validateUUID
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//	log.Print("validateUUID:start")
//	value := v.(string)
//	if _, err := uuid.Parse(value); err != nil {
//		errors = append(errors, fmt.Errorf("invalid UUID format"))
//	}
//	log.Print("validateUUID:end")
//	return
//}