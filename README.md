# devops-lamp

The purpose of this project is to experiment the ways to apply DevOps best practice to a LAMP stack project.

Currently, it can generate a basic source code structure for a LAMP project with Vagrant and Puppet managing the development environment.

For example, run below command to create a project called 'drupal' in 'Drupal' directory, then follow the README.md in the project directory.

```bash
make build PROJECT=drupal WORKSPACE=Drupal
```
