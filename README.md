# Module 3. Solutions

## Kestra
    The project uses the same infrastructure setup as was used in the second module solution.
   **Kestra** is deployed using **GCP compute engine**. Allocation of GCP resources is done with **Terraform**. 
All the **.tf** files can be found in the <em>./terraform</em> directory.

   **docker-compose.yml** for the **Kestra** instance is in the <em>./terraform</em> dir. 

Project's **Kestra flows** are located in the <em>./kestra/flows</em> directory. Flows with the <em>\*gcp\*</em> in a filename are the only ones that are actually used and work in **cloud environment**, others rely on the Postgres instance and are there only for a reference.

   The flows are delivered to the GCP **Kestra** instance by the means of the **GitHub Actions workflows**(<em> ./.github</em> folder).

## Module Questions
  The answers along with the explanation and queries are in the <em>./answers</em> folder(<em>./answers/combined.md</em> for all the answers in a single file). The required data was uploaded to buckets using Kestra(the flow is in the <em>./kestra/flows</em> directory). 