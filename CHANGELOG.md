# Changelog

This is the changelog for the `oversee` gem. For now, most of the updates will be reflected here.

### Unreleased

- Introducing `Oversee::Entity` and `Oversee::Record` classes
- Componentizing associated resources
- Adding `essence` component library to make the UI streamlined
- Making boolean input friendlier - using toggle switch
- Fixing incorrect linking for has_many associations
- Removing away `Phlex::Kit`. We'll write it out by hand.

### 0.3.1

- Adding JSON field support
- Adding flash notifications
- Adding ability to copy field value to clipboard
- Refactoring field components
- Refactoring pagination to be more user friendly
- Taking away `rails` as a dependency

### 0.3.0

- Adding rich text editor - via Trix. It automatically picks up on Rails' `has_rich_text`
- Adding support for Stimulus
- Adding importmaps
- Adding validation errors when creating records
- Adding a very basic dummy app for testing and development
