[Aircall backend test](https://github.com/aircall/backend-test-2) - Romain Vigo Benia
=============

## Requirements
* ruby (v2.0+)
* bundle


## Setup
```
bundle install
```

## Notes

Most of the interaction with Plivo lives in the following workers (called by `PlivoCallsController`):
* `DialCall`: simultaneous dials `user_number` of the users registered for the `CompanyNumber` called.
* `HangupCall`: Updates call with hangup information provided by Plivo
* `LookupCallee`: Once a call finished, lookup through Plivo API who took the call (it's a bit of a hack but I haven't found a more direct way to do it).
* `Voicemail`: Persists voicemail information.
* `FallbackCall`: Flags a call as falty.

Sideqik is used to manage aboce workers. However some workers are called synchronously due to the nature of the business logic (dealing with calls).

Possible bottlenecks regarding scalability:
* Queries made to lookup user numbers (huge tables). Possible solution:
  * Database replication using a slave to read `user_numbers` and `company_numbers` tables.
* PlivoCallsController endpoint (huge load). Possible solution:
 * Set up load balancers


