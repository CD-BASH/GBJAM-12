# GBJAM-12

## Contributing

We use a lightweight convention on top of commit messages.  
This easy set of rules helps us create an explicit commit history.

When merging a pull request, always squash your commits, and use the title of the merge request as commit message.

When opening a pull request, the title should have the following format.

```
scope: [#n] lorem ipsum nuage
^---^  ^--^ ^---------------^
|      |    |
|      |    +---> Lowercase summary in present tense.
|      |
|      +---> Issue number.
|
+---> Appropriate scope.
```

Use the following scopes.

| scope        | description |
| :----------- | :---------- |
| **feat**     | Files represent a new workable feature. |
| **art**      | Files contain new assets to be used for upcoming features. |
| **wip**      | Work in progress. Files aren’t ready to be published. |
| **fix**      | It’s Tide to go. Bugs fixing. |
| **refactor** | When you feel smarter than your peers. |
| **chore**    | Files are directed for system improvements, plugins, dishes, etc. |
| **docs**     | Concerned files are for documentation purposes. |
| **lab**      | When you go crazy on your branches. |

For more information on the contributing guidelines for this repository, please refer to the [Git](https://github.com/charlesDouc/GBJAM-12/wiki/Git) article in this project's wiki.
