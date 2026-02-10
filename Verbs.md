
# Approved Verbs Reference

## Common Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Add | Adds resource to container | Append, Attach, Concatenate, Insert |
| Clear | Removes all resources from container without deleting it | Flush, Erase, Release, Unmark, Unset, Nullify |
| Close | Makes resource inaccessible or unavailable | - |
| Copy | Copies resource to another name or container | Duplicate, Clone, Replicate, Sync |
| Enter | Moves user into a resource | Push, Into |
| Exit | Returns to most recently used context | Pop, Out |
| Find | Looks for an object in a container | Search |
| Format | Arranges objects in a specified form or layout | - |
| Get | Retrieves a resource | Read, Open, Cat, Type, Dir, Obtain, Dump, Acquire, Examine, Find, Search |
| Hide | Makes a resource undetectable | Block |
| Join | Combines resources into one resource | Combine, Unite, Connect, Associate |
| Lock | Secures a resource | Restrict, Secure |
| Move | Moves a resource from one location to another | Transfer, Name, Migrate |
| New | Creates a resource | Create, Generate, Build, Make, Allocate |
| Open | Makes resource accessible, available, or usable | - |
| Optimize | Increases the effectiveness of a resource | - |
| Pop | Removes an item from the top of a stack | - |
| Push | Adds an item to the top of a stack | - |
| Redo | Resets a resource to the state that was undone | - |
| Remove | Deletes a resource from a container | Clear, Cut, Dispose, Discard, Erase |
| Rename | Changes the name of a resource | Change |
| Reset | Sets a resource back to its original state | - |
| Resize | Changes the size of a resource | - |
| Search | Creates a reference to a resource in a container | Find, Locate |
| Select | Locates a resource in a container | Find, Locate |
| Set | Replaces data on existing resource or creates resource with data | Write, Reset, Assign, Configure, Update |
| Show | Makes a resource visible to the user | Display, Produce |
| Skip | Bypasses one or more resources or points in a sequence | Bypass, Jump |
| Split | Separates parts of a resource | Separate |
| Step | Moves to the next point or resource in a sequence | - |
| Switch | Alternates between two resources, locations, or states | - |
| Undo | Sets a resource to its previous state | - |
| Unlock | Releases a resource that was locked | Release, Unrestrict, Unsecure |
| Watch | Continually inspects or monitors a resource for changes | - |

## Idempotent Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Apply | Applies a configuration or specification declaratively to achieve desired state | Deploy |
| Ensure | Guarantees a desired state exists, creates if missing or updates if needed | Guarantee |
| Plan | Previews changes without applying them (dry-run simulation) | Preview, Simulate, DryRun |
| Scale | Adjusts the number of instances or replicas of a resource | Resize |

## Communications Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Connect | Creates a link between a source and a destination | Join, Telnet, Login |
| Disconnect | Breaks the link between a source and a destination | Break, Logoff |
| Read | Acquires information from a source | Acquire, Prompt, Get |
| Receive | Accepts information sent from a source | Read, Accept, Peek |
| Send | Delivers information to a destination | Put, Broadcast, Mail, Fax |
| Write | Adds information to a target | Put, Print |

## Data Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Backup | Stores data by replicating it | Save, Burn, Replicate, Sync |
| Checkpoint | Creates a snapshot of the current state of data or configuration | Diff |
| Compare | Evaluates the data from one resource against another | Diff |
| Compress | Compacts the data of a resource | Compact |
| Convert | Changes data from one representation to another (bidirectional) | Change, Resize, Resample |
| ConvertFrom | Converts one primary input type to one or more output types | Export, Output, Out |
| ConvertTo | Converts from one or more input types to a primary output type | Import, Input, In |
| Dismount | Detaches a named entity from a location | Unmount, Unlink |
| Edit | Modifies existing data by adding or removing content | Change, Update, Modify |
| Expand | Restores compressed data to its original state | Explode, Uncompress |
| Export | Encapsulates primary input into persistent data store or interchange format | Extract, Backup |
| Group | Arranges or associates one or more resources | - |
| Import | Creates a resource from data in persistent store or interchange format | BulkLoad, Load |
| Initialize | Prepares a resource for use and sets it to a default state | Erase, Init, Renew, Rebuild, Reinitialize, Setup |
| Limit | Applies constraints to a resource | Quota |
| Merge | Creates a single resource from multiple resources | Combine, Join |
| Mount | Attaches a named entity to a location | Connect |
| Out | Sends data out of the environment | - |
| Publish | Makes a resource available to others | Deploy, Release, Install |
| Restore | Sets a resource to a predefined state | Repair, Return, Undo, Fix |
| Save | Preserves data to avoid loss | - |
| Sync | Assures that two or more resources are in the same state | Replicate, Coerce, Match |
| Unpublish | Makes a resource unavailable to others | Uninstall, Revert, Hide |
| Update | Brings a resource up-to-date to maintain state, accuracy, or compliance | Refresh, Renew, Recalculate, Re-index |

## Diagnostic Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Debug | Examines a resource to diagnose operational problems | Diagnose |
| Measure | Identifies resources consumed by an operation or retrieves statistics | Calculate, Determine, Analyze |
| Repair | Restores a resource to a usable condition | Fix, Restore |
| Resolve | Maps a shorthand representation to a more complete representation | Expand, Determine |
| Test | Runtime operational/functional check | Check, Diagnose, Analyze, Salvage, Verify |
| Trace | Tracks the activities of a resource | Track, Follow, Inspect, Dig |
| Validate | Pre-flight syntax/structure check before use | Check |
| Verify | Post-operation integrity/authenticity check | Check |

## Lifecycle Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Approve | Confirms or agrees to the status of a resource or process | - |
| Assert | Affirms the state of a resource | Certify |
| Build | Creates an artifact from input files | - |
| Complete | Concludes an operation | - |
| Confirm | Acknowledges, verifies, or validates the state of a resource or process | Acknowledge, Agree, Certify, Validate, Verify |
| Deny | Refuses, objects, blocks, or opposes the state of a resource or process | Block, Object, Refuse, Reject |
| Deploy | Sends an application or solution to remote target for consumer access | - |
| Disable | Configures a resource to an unavailable or inactive state | Halt, Hide |
| Enable | Configures a resource to an available or active state | Start, Begin |
| Install | Places a resource in a location and optionally initializes it | Setup |
| Invoke | Performs an action such as running a command or method | Run, Start |
| Register | Creates an entry for a resource in a repository | - |
| Request | Asks for a resource or asks for permissions | - |
| Restart | Stops an operation and then starts it again | Recycle |
| Resume | Starts an operation that has been suspended | - |
| Start | Initiates an operation | Launch, Initiate, Boot |
| Stop | Discontinues an activity | End, Kill, Terminate, Cancel |
| Submit | Presents a resource for approval | Post |
| Suspend | Pauses an activity | Pause |
| Uninstall | Removes a resource from an indicated location | - |
| Unregister | Removes the entry for a resource from a repository | Remove |
| Wait | Pauses an operation until a specified event occurs | Sleep, Pause |

## Security Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Block | Restricts access to a resource | Prevent, Limit, Deny |
| Grant | Allows access to a resource | Allow, Enable |
| Protect | Safeguards a resource from attack or loss | Encrypt, Safeguard, Seal |
| Revoke | Specifies an action that doesn't allow access to a resource | Remove, Disable |
| Unblock | Removes restrictions to a resource | Clear, Allow |
| Unprotect | Removes safeguards from a resource | Decrypt, Unseal |

## Other Verbs

| Verb | Action | Avoid |
| ---- | ------ | ----- |
| Use | Uses or includes a resource to do something | - |
