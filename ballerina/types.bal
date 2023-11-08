// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Options which can be provided when opening an IBM MQ topic.
public type OPEN_TOPIC_OPTION OPEN_AS_SUBSCRIPTION|OPEN_AS_PUBLICATION;

# Header types that are provided in the IBM MQ message.
public type Header MQRFH2|MQRFH|MQCIH;

# IBM MQ queue manager configurations.
#
# + name - Name of the queue manager
# + host - IBM MQ server host
# + port - IBM MQ server port 
# + channel - IBM MQ channel  
# + userID - IBM MQ userId  
# + password - IBM MQ user password
public type QueueManagerConfiguration record {|
    string name;
    string host;
    int port = 1414;
    string channel;
    string userID?;
    string password?;
|};

# IBM MQ get message options.
#
# + options - Get message option 
# + waitInterval - The maximum time (in seconds) that a `get` call waits for a suitable message to 
# arrive. It is used in conjunction with `ibmmq.MQGMO_WAIT`.
public type GetMessageOptions record {|
    int options = MQGMO_NO_WAIT;
    int waitInterval = 10;
|};

# Represents an IBM MQ message property.
#
# + descriptor - Property descriptor  
# + value - Property value
public type Property record {|
    map<int> descriptor?;
    boolean|byte|byte[]|float|int|string value;
|};

# Represents an IBM MQ message.
#
# + properties - Message properties
# + format - Format associated with the header
# + messageId - Message identifier
# + correlationId - Correlation identifier
# + expiry - Message lifetime
# + priority - Message priority
# + persistence - Message persistence
# + messageType - Message type
# + putApplicationType - Type of application that put the message
# + replyToQueueName - Name of reply queue
# + replyToQueueManagerName - Name of reply queue manager
# + headers - Headers to be sent in the message
# + payload - Message payload
public type Message record {|
    map<Property> properties?;
    string format?;
    byte[] messageId?;
    byte[] correlationId?;
    int expiry?;
    int priority?;
    int persistence?;
    int messageType?;
    int putApplicationType?;
    string replyToQueueName?;
    string replyToQueueManagerName?;
    Header[] headers?;
    byte[] payload;
|};

# Record defining the common fields in headers.
#
# + flags - Flag of the header 
# + strucId - Structure identifier
# + strucLength - Length of the structure
# + version - Structure version number
public type MQHeader record {|
    int flags = 0;
    string strucId = "RFH ";
    int strucLength;
    int version;
|};

# Header record representing the MQRFH2 structure.
#
# + folderStrings - Contents of the variable part of the structure
# + nameValueCCSID - Coded character set for the NameValue data
# + nameValueData - NameValueData variable-length field
# + strucLength - Length of the structure
# + version - Structure version number
# + fieldValues - Table containing all occurrences of field values matching 
#                 the specified field name in the folder
public type MQRFH2 record {|
    *MQHeader;
    string[] folderStrings = [];
    int nameValueCCSID = 1208;
    byte[] nameValueData = [];
    int strucLength = 36;
    int version = 2;
    table<MQRFH2Field> key(folder, 'field) fieldValues = table [];
|};

# Record defining a field in the MQRFH2 record.
#
# + folder - The name of the folder containing the field
# + 'field - The field name
# + value - The field value
public type MQRFH2Field record {|
    readonly string folder;
    readonly string 'field;
    boolean|byte|byte[]|float|int|string value;
|};

# Header record representing the MQRFH structure.
#
# + strucLength - Length of the structure
# + version - Structure version number
# + nameValuePairs - Related name-value pairs
public type MQRFH record {|
    *MQHeader;
    int strucLength = 32;
    int version = 1;
    map<string> nameValuePairs = {};
|};

# Header record representing the MQCIH structure.
#
# + strucLength - Length of the structure
# + strucId - Structure version number
# + version - Structure version number
# + returnCode - Return code from bridge
# + compCode - MQ completion code or CICS EIBRESP
# + reason - MQ reason or feedback code, or CICS EIBRESP2
# + UOWControl - Unit-of-work control
# + waitInterval - Wait interval for MQGET call issued by bridge task
# + linkType - Link type
# + facilityKeepTime - Bridge facility release time
# + ADSDescriptor - Send/receive ADS descriptor
# + conversationalTask - Whether task can be conversational
# + taskEndStatus - Status at end of task
# + facility - Bridge facility token
# + 'function - MQ call name or CICS EIBFN function
# + abendCode - Abend code
# + authenticator - Password or passticket
# + reserved1 - Reserved
# + reserved2 - Reserved
# + reserved3 - Reserved
# + replyToFormat - MQ format name of reply message
# + remoteSysId - Remote CICS system Id to use
# + remoteTransId - CICS RTRANSID to use
# + transactionId - Transaction to attach
# + facilityLike - Terminal emulated attributes
# + attentionId - AID key
# + startCode - Transaction start code
# + cancelCode - Abend transaction code
# + nextTransactionId - Next transaction to attach
# + inputItem - Reserved
public type MQCIH record {|
    *MQHeader;
    int strucLength = 180;
    string strucId = "CIH ";
    int version = 2;
    int returnCode = 0;
    int compCode = 0;
    int reason = 0;
    int UOWControl = 273;
    int waitInterval = -2;
    int linkType = 1;
    int facilityKeepTime = 0;
    int ADSDescriptor = 0;
    int conversationalTask = 0;
    int taskEndStatus = 0;
    byte[] facility = [];
    string 'function = "";
    string abendCode = "";
    string authenticator = "";
    string reserved1 = "";
    string reserved2 = "";
    string reserved3 = "";
    string replyToFormat = "";
    string remoteSysId = "";
    string remoteTransId = "";
    string transactionId = "";
    string facilityLike = "";
    string attentionId = "";
    string startCode = "";
    string cancelCode = "";
    string nextTransactionId = "";
    int inputItem = 0;
|};
