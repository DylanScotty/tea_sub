# Tea Service

## What does this API do?
it allows customers to subscribe to a tea subscription where they are able to view all their subscriptions, subscribe to a subscription, or cancel.

## Table of Contents
- [Database](#database-schema)
- [Endpoints](#endpoints)

## Database Schema
![Schema Setup, includes customers, subscription_customers, subscriptions, tea_subscrptions, and teas](<database.png>)

**Do rails db:{drop,create,migrate,seed} before use!**

## Endpoints

### Subscribe a Customer to a Tea Subscription
Request:
```
POST /api/v1/customers/:customer_id/subscriptions/:subscription_id
```

Regular Response:
```
{
  "success": "Customer has been successfully subscribed."
}
```

Error Response:
```
{

  "error": "Customer was not able to be subscribed. Please make sure the customer or subscription id is correct."
}
```

### Cancel a Customer's Tea Subscription
Request:
```
PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id
```

Regular Response:
```
{
  "success": "Customer has been successfully unsubscribed."
}
```

Error Response:
```
{
  "error": "Customer was not able to be unsubscribed. Please make sure the customer or subscription id is correct."
}
```

### See all of a Customer's Subscriptions
Request:
```
GET /api/v1/customers/:customer_id/subscriptions
```

Regular Response:
```
{
  "data": [
    {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "title": "Starter Pack",
        "price": 15.0,
        "frequency": "3 weeks"
      }
    },
    {...}.
    {...}
  ]
}
```

Invalid Customer Response:
```
  {
    "error": "Couldn't find Customer with 'id'=2"
  }
```

Customer has no Subscriptions Response:
```
{
  "data": []
}
```
