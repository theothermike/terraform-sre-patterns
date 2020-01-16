# terraform-sre-patterns

# C.A.M.P. Pattern - Configuration Adapted to Models and Pieces

## Abstract

Managing many similar environments across multiple locations and/or clouds can be very cumbersome and result 
in a lot of duplication between Terraform code, modules, states and configuration values.
   
The CAMP Pattern combines best practices and production experience from seasoned
SREs along with utilizing great new features from Terraform 0.12.x+ in an attempt solve these issues

## Design

![CAMP Pattern](CAMP%20Pattern.png)

## Environments

An environment is the top level structure where all the terraform states are kept.  In general, it encapsulates an 
operating plane (ie. Production) by organizing all components for that plane (ie Network, Infrastructure, Platform, 
Middleware, Application) together under that structure into micro-states called [Models](#Models)

### Configurations


Since this pattern prefers micro-states over monolithic states, often sharing of configurations is required
to each state, as they may consume part of the whole configuration for the environment.  

#### Shared Variables

In order to reduce duplication due to the fact that we may be passing Configuration data
from Environment to Models to Pieces, we can utilize Symbolic Links on the filesystem to share 
the Terraform Variable definitions of the Models and Pieces. 

#### Shared Locals (Constants)

#### Shared Values


### Versioning

## Models

![Model](Model%20Focus.png)


Models are Cloud Specific Terraform Modules that only call (provider-specific) Pieces.  Models are meant
to encapsulate entire declarations of related components, roughly, in Layers.  You should have a model for each of the following:

- Account Organization / IAM
- VPC
- Shared Infrastructure (ie Platforms - Kubernetes, Databases - RDS)
- Application (Deployment, Dependencies, Security)

### Layer Patterns

### Account Organization / IAM

This is where you define the account and organization structure.  This will be highly specific you and your 
company and how your role is defined

#### VPC

The foundation of everything is the Virtual Private Cloud.  Peering to other Networks, Clouds, Accounts
should be done in this Model, along with all other Network functionality (NAT, VPN, IGW)

#### Shared Infrastructure

Shared Infrastructure can refer to several things, and each should have its own Model:

- Shared Databases
- Shared Filestores/Buckets
- Shared Clusters (Map Reduce, Kubernetes, etc)
- Other Middleware (Message Queues, Pub/Sub etc)

#### Application

The Application Model should, in general, encapsulate each Micro Service and their specific dependencies
in your environment.  This includes Service specific Load Balancers, DNS Names, Security Groups
Object Buckets, etc.

### Revisioning

## Pieces

Pieces are Provider specific Terraform Modules. In order to preserve maximum re-usability
of Pieces in Models, each piece uses only a _single provider_.  An exception can be made in the case
a second Provider is a sub-set of the main Provider, for example the Helm provider is a sub-provider
of the Kubernetes provider (it can be configured entirely by the Kubernetes provider)

## Directory and File Structure