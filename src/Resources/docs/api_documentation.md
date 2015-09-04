# User basic operations

## Security operations [/api/login]
### Login [POST]
Login user with credentials.

+ Request (application/json)
    + Attributes (User Credentials)        
+ Response 200 (application/json)
    + Attributes (Auth Token)
        + token (string) - Token in JWT format
+ Response 401 (application/json)
    + Body
        {"code":401,"message":"Bad credentials"}
    
# Data Structures

## User Credentials (object)
+ _username: john@appleseed.com (string) 
    Login or email of registered user
    
+ _password: qwerty (string)
    Password of registered user
    
## Auth Token (object)
+ token: Token in JWT format which consist (string)
    token generate algorithm like {"alg":"RS256","typ":"JWS"}
    payload like {"exp":1441367519,"username":"admin","iat":"1441281119"}
    token: like lA33slA8t1qLMiyyAT6NNsl7kcDwuzKmX5Cq0f8zoEI5jCr2jjSCSodcgLoySZfWsDc8uW6RzfzPC31WDLCsnpSStqI1RH9fZ1xCtgt23lRC0MITGOQZL8IhmjcbvS4PoM1fMESpWEG2ITGMQzfYn28s6DTI81z9fQm4SpoBb2S9R9rJtAqpBCIheSTNaS2yt0I5GGL04hF8iC52hqK5zwRoPqDnsRcAwexJ_NUGC1vDy7EVFJCsBiza9LSf3o6R-M4WwmFSFAZ2d0fK6bjGOatKHvM0bNAJizZN0TjiS9SOo76rdUXi0vv6GEKaxdyUODa-FnDgskO8wDaCgKDVBtU0zIXOKKzUN1Bf92Hxwn_B2XY9jcWACDDtpwuc0Y4p-EP-NePwu1yxrVNciO5Y7ODro3gbmYu4hfyKPy_pI7KskspPuIiisz7aRBp3za2PeR25Vg4cDut6oU2YXhYHnzJwNZbRqZ5jqL7QQwR1VSm5PlYqmL04JuepepPRWbEzXRCCW8MQROdJTM9aM__sKA7BNNBewxWJcYjhjTQzHgWF9wA69hX7JkdZ-2l4kKBNrZUVuOCPwEboFwySbtaxoH-KISxsP0LyP-f6ify4sjM6-P50T5oEBiRyP9ZwKtODhnsEVhbRLeu8Eg-H6RE_VWBmQRnbey_dETBVQ2nrIyg
    