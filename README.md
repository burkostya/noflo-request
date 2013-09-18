# noflo-request [![Build Status](https://secure.travis-ci.org/burkostya/noflo-request.png?branch=master)](http://travis-ci.org/burkostya/noflo-request)

**WIP**

NoFlo components for making requests.
It's all around [superagent](http://visionmedia.github.io/superagent/)

## Components

### MakeRequest

Creates `request` ( _superagents's_ `request` ) object

#### In ports

- IN: url
- METHOD: method (GET by default)

#### Out ports

- OUT: `request` object

### SendRequest

#### In ports

- IN: `request` object

#### Out ports

- OUT: `response` object
- ERROR: error

### SetRequestHeader

### SetRequestQuery

### SetRequestType

### SetRequestBody

### SetRequestTimeout

### SetRequestAuth

### AbortRequest
