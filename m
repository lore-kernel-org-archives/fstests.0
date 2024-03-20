Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967940866
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934451; cv=fail; b=Rkp5imF/zwQwHuZXQKZK3NpLaDp6wSYztOyajDJHQ1Lt2tRiF51KHrq29j30OcHNC3ch0w9KUgU1QAryVPRE6Cuslr2PuCTpiD9NCuXpOgZoJLi9A3984aBvMDHdI7UYvPpzf3jlQEwfuK2hKJmz5N5hR1QVVfk9/ivjgd8Cncw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934451; c=relaxed/simple;
	bh=Fe5xgn8b0FawVrFd5D1SpH8x5W8z8f8ifF7BILvhsGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRrSjsvH2Pvc1fvjCT3uJzx5krYXVKKm/4otNeZK+B9yVq1KVe1f4tTozB8bWEZKvEnjyEO+dI0aoBJfwfqFLJPpTetjWKA/09nn58Rz96LvxjGxCSEKA+oGZBlJFhEcpdZjdvfcoI+RyIzQfh1AYCFJp+pNsNLmoxoKFyHJSes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShN5p8QJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0J1/Hp/A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShN5p8QJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0J1/Hp/A"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K7xLQt009325;
	Wed, 20 Mar 2024 11:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZBiOE1SY0dIidyGaR4NQT6wOBBbwNzPTpKzORK2Ed0s=;
 b=ShN5p8QJIwk2l4QUYvBfHfrTAi0le5axvjcL1dGWcx85e2w/EdG6kmoPuG/l5RtxcFH4
 s2Va7vKgC1YS+PhCWpQEenm0k5+DMfJ071s0SlbCqc8cHMbqKMvfSkG7dBbDe1O1DAY+
 AiTQwDlDBW7WKK/uk4PpVPbhAC9LI8YyasvmTpZ56657EEXsdRwkC9sQWTev+t4JCfNZ
 dLGFcV4PRNkghqYX2Y34OLKoWoVJ5trNW+EPRgowZHjgZMTwM6BQcXAcwATMBDQz+rNL
 jWiXUtkE7Hs0y9BDTtFBlw9pOrG28VQ9XOoEOqCM2K6Ol+XCpMJSFDzsRGARSGww/Zoi GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aafs00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:34:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAM8Vk015756;
	Wed, 20 Mar 2024 11:34:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v86nqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLj9CD765myoeFBKXpUYS/CgA5yeJyDZSbu0DkmsZ7Df0opyGm2+mXtbVgiMN/v9ZMOZJ5oov/PvPb3Rov3nI4PeBulyFga8AuZfEOG4ORClRuZ+jySqsb4MQbBESJwuYCswyPAmY1crVwWsrfc3dre15UgrCWxdtVChJtWR5awEBPXDXGp3mBv76N38I1I7vkRhuCzCKKq3oRqIY5hdqwfye8o6U0KqHkk2sNOEGQiWpbKGZL8bneXFr09z/RabA4VUCp4/IifQwkZ6kbS6g0A9ufBZeYuCsQ/rcW70ID7F8/O79DLZ40t2lRhs+Vn/fNeRBeyV1RUueXoXJ91OtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBiOE1SY0dIidyGaR4NQT6wOBBbwNzPTpKzORK2Ed0s=;
 b=aDWcyyo+2PjuVUoRKyM5sZd5x781bIbmWo4cEOdWEQRoUGWDPw2+J5qmHOreosTa/wVk2n19aS8qqKYXVS9FnepWVAL/uGuoydcBSjfRXVqxkQ7ZaDfTb/Lh5JXdsulaJItv5+5Sldj8y3aU/T/y5tY/AJ3Sb8QkTpfzJZlyvCnkiFejr7p0f8TU+J8zdfQ73Q11BrvtPwN0Ysk4P7dfsZkvojHOU42KSeX60NUqyyI89G8yiY64AvaTo4XynVGgIgpVoOnrC5me8JJro3pIL/ZHfAzLURyPSzw3q7/m+W43lG+kf+kalBpq2kXrWNSOcrOuicrgL0uUe1VW8N8c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBiOE1SY0dIidyGaR4NQT6wOBBbwNzPTpKzORK2Ed0s=;
 b=0J1/Hp/AkMsIb+Gr6fE3hcKYRaLSyIGY5/kxWJcBqV8L/5WZMSREagLQJCALcQ75h0IO/O228QL3joEtFSeDmw9EpQ80AxXKWDcq3ZUpRKNGdWhMKGPLxPYkpDHE4x/lKKTlsW3NzE1W+A/jMmbbCGI3tQkth2gw0ai6SmLIIs4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 11:34:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:34:02 +0000
Message-ID: <f9dc2fdf-e468-4525-bb74-47d5bc30dcc0@oracle.com>
Date: Wed, 20 Mar 2024 17:03:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] btrfs/330: add test to validate ro/rw subvol mounting
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <cover.1710871719.git.dsterba@suse.com>
 <d61b8bd818a8f9403982f532ac21586f6c96269c.1710871719.git.dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d61b8bd818a8f9403982f532ac21586f6c96269c.1710871719.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: a324655b-c2cf-44e6-bc2b-08dc48d1a42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YrpRD2Eh1D+15PM6srGq8CGx+eVfDobtXzv7raPmFdvuvmdtDiFfKjdJb8AnbFZZU/21XHjjBCUMYTOkSCiR4LOWC0h77gtIIaIeAYXyUst8oC5/Fsw0BX94Hw2/OMozqGWU0tQhxX0ZlaB6iUwanNITjaEZsABf00CP6ydLY5iXLTOMGTUC4n+Zq97V2zjWFksibsKpCMUQ+2ZhaVPAQ1wSqs+iRHyEYNcmoKnfyt4uoXEVhgdIWbLEk8d0dn6OdVlim3CMxUIu8WAvNAfxjVfxuxugXEyHuUbFlw99XM1gcc65joRrn9Cyxkn3BPhwC460hmo+1tezV6JhhtbYH8HYEY8gFYsPbpwQnjmLLNmD5aj3txjoy5Oy5Y3PaRyZJb1Q7caihjTkPigpbm7MiNdaIURxBigiB6cgyFJGKKn8zErvnJA14s2KdX9zLgzH5jnQzjilKqS27pfxnVIqnVYLYj/SfZb3EcznCYQmyy7Zvbs010ZbHbKB5HmuecJMUC0Y/HGtNhtfwY44MtLoWj9A2VyjFhit9523HXdIjSCo4EX6Y9PAsQp9CTPec0xhPblC1/IfOti44b2ZfYXXAq4WB9pTpLaRtOW41AzbVPr+VKdoMd0lJtBZFplF6hWHlzSGvZfdrXW8RiYrEEq93bEOTnI1N7zT77qMF7Cmvos=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUxlVG9ZSStaWjUyL0ZwS1VDbnVYWmZBNHpYZXBURks2bytWVTI2YlZiZkp5?=
 =?utf-8?B?NXArWU9TNmljYS9BQVRvaDZ0OXNRK0djN29ibnkrLzlPQTAwZUtQWm1LZFo2?=
 =?utf-8?B?aXgrY0drZ21HTWd0NzlXR21EaUpIZ2ZlZU5nbXFOY0NublFHOUZkM2xXVStx?=
 =?utf-8?B?RWtyRk4rQ0U4Q3F2T1l3Qk5RaUtBOFVVcnhBNHBhNTA5clE3YVkxelZNdFhx?=
 =?utf-8?B?bFpkMlZCb2xHZk5CaC9xNlVDa0RDRC9FWGx0RFI5SFd3c2tLaVJua1NYdU1B?=
 =?utf-8?B?NjRGNGJteGFxS0tXM0NkY1RJUUdlOEJHeFZLZFpHa1hhbThTa0I5NytaTDRo?=
 =?utf-8?B?OGtDd203VzNjWWZYSnNhVGFrTTVWTnZwUlNlT3lXVXMzVUtMd0hXOGlXWmRo?=
 =?utf-8?B?dlVaSVFqV096TWdqbEJDbTNKQ09UTFlRRnBObWl6MSt2T0duMkIzQUVqYnlw?=
 =?utf-8?B?Q2tSUmx1Y253Y3VkcUVjYUhXdGY0M21xcGtkNE1uMkxMVGxFRTAxU0l5YkJm?=
 =?utf-8?B?NXBjMUxONjNkY1dQL2JyVHFjRkhDZExONXN1YUZMTGpCWlJlUi9MTXp6YzVF?=
 =?utf-8?B?VUNiVjA1QjM5ZXRQa2pRYzRNbWh5eFVEZ1g5MUtJS0o1Y0tiVmJhNlNkTGMz?=
 =?utf-8?B?a0sxSHlyeGZCTE5HbXo5YlJrcG1XQS8xYXdNdlBXSDF4dHJYeWYwSWorUUhk?=
 =?utf-8?B?eTIzeUhUTG9GNFF1aExWKy84bnIzR2Jpd2ExVjVmRSs1c3hsY0JRcjVRdENt?=
 =?utf-8?B?dysyUzZxSEpZODhWbFU5UTJFQ2NubXp1cThTMEdIM0hCWVlTWFZxUnp4UGF0?=
 =?utf-8?B?VDh3cWdGblhsLzlISnFFS0k3NmpQSC9pb2Z4c2lLWTBteDZDRzRKcG9yWnlw?=
 =?utf-8?B?N0NURklSRTlsZ1RBMHpGZFZwUUdJNkV6NXNGbFRMOFRFTEsyL1ZFcDY4WkFl?=
 =?utf-8?B?ODJ0dktUckkxRHFEVHFvS2owOEY5NHRoL3dIY0Z6QlRyeWY0SjMxK1JnT2o0?=
 =?utf-8?B?QzZCdDFjajBXbmJYYWlOd0YrdDQydXZXa01CSURDL1QvZDBLNHZWZk1NVktN?=
 =?utf-8?B?NXVGR2hmaTVFckxoMDJvL1E1OC9RNWozRUJmUGl2NnBGcm1pK3RJZVAvZEZN?=
 =?utf-8?B?eitsU3M4WC81S2FhR2VnbFNBa1ZXa0lPbW5MdW1QQ0VKT0w1RWJvek1IOWI1?=
 =?utf-8?B?MkFJKzZMRjdLSzhvS0lLQVhKQm0vMUhhSXRNNkNaaFM3MUswVDlsakF6WW5M?=
 =?utf-8?B?aDladHJzZktQYWlvKzVyd2tVd0ErTExqVDA3NGNPRkRFVnE5clBBRkpFczZy?=
 =?utf-8?B?QXRzMVdIVWg2cDRKUTlnM3R4MkV0d0hxSWdUaGl6Q3NIOWJvc2tYdGdTOGts?=
 =?utf-8?B?RmhOUjF0QXVlSGV6TVBmczRhRTNPUjlKS2pTeGh1NWt6bFNaNlNlZndVbjVq?=
 =?utf-8?B?SzdjVk53RkI2UEFKbDY1aTRVL212OGY2RVBiaDhrYWNDczNOcGM3M3F6WVpp?=
 =?utf-8?B?UHVDcVQ0OGV1THcrZmRlOTc4OFZtbHp1NCtPTTl0UHNBemFvTkhVRmhhNzBN?=
 =?utf-8?B?UVdmWE1rT242R3Jaa0lpT0xhODBQYVZseFg5eXZpQzlwYVFWa1liY2s4aUhl?=
 =?utf-8?B?TGxXcExGeVhyODQ1bzVJRjYwSnByWjVTOUZoaXc2QWlXem1NdnJUVDZuZW9q?=
 =?utf-8?B?Y0ptZDI4OEFsbG11bnovd1ZrWUdrWHRlOWRmTWc5djhpckZYb1ZYanhTMENM?=
 =?utf-8?B?OXRZMVFDZk5nQjFjbm80N05XaTMySm1uMGJDTnNubkNXb2JhLzlBNllxUnhL?=
 =?utf-8?B?TURFT1hOYWlWQ2twbDFLaHBuQnVpS1dCK0NWY01reWtSZVpFL0ZjMjU3QVg3?=
 =?utf-8?B?R29XK0hqZlk0d3J4dDJYVUpKZHltQzV1dVJaRmVvcXd1d29xbnh5azIweTYv?=
 =?utf-8?B?REVHNkxkZ2VGMWFzcVl3NWxJbzRmVXVlODU2U0thWjJtdWFSTjhFSUhHdmJi?=
 =?utf-8?B?TzQ3b2dVVWR3WEg3UWgxaTkvRHdJV3pZNk5MQW5qajVpWVZrZWRSU1ROMmd0?=
 =?utf-8?B?Zis5R0ZLQ3JEMUtVREVQNndtMVR2MVUwZ0ZnY2t4eVJPOGNzOFVDS2hkNWFW?=
 =?utf-8?B?dkppWHZoclNtZTRUeFNjMlY3VFU0TmMreUFPUlR4ZWpmbloyWDFZMUI3ait4?=
 =?utf-8?B?UWFScnlQd0Z4VlVxSFpicW9CYWFnUjNQUk54bS9pRkRHVXJ6Q1I3QlZJME94?=
 =?utf-8?B?em1Fa3pjNmlpK2RwZ2Q0NzVPc1BRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QxyIhOvqgLH2sHCO2sK+7X6riyq3zIoGKXBMbAdR48YuSEXAVOIdqbVLq2lh6Goae5qbzCRNJbleDFsszpWgbZMxGVQcAfTHvgCgKJCCWy7kp+gBszYekivtNBHZKbweAeATXGx+UUuYZNU5vpOpXG2IVPjvYvvi7voE1AG369mVrfazDNsJmjXWq6lqH1ZuWvIgYTU8bznJ1ZwoGkkO02VBnW/DGH9Dya2PG89WSux7NF0RHD+pHC/LEDWVBNM/OIElEab5/QU4l2n2zN75wteVlKfqpTaLqgnfHDomW9jo4a2s22gtvK60qsQYYsq2fDUe0/WZ1cCYCzu9FKLxiaDWOYqLjLbCHhUykztRhKGjqOAlrVq72Z3ZIMYjw+mH0Gsc1Db73VNjrlP+rEmljS2ekRC2SwI8qawRMNhXBY/PJ6lM4w58nmciJZ0HtroQl81uoBLLBYwRPVrpJH8ziipYs4CyWmSjj8RjqdaTCpTdfiliCtxt0uCFiTipzPyw5tR3a215RMVI4wBcyxAumB8d863328QR/DBQHv4eXHkdoRRo4ZigQ+frzlRIhp+7MZWd/Gt0UH0rSlC7AVflrBjzKiBj4eShbVeB8tmv2OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a324655b-c2cf-44e6-bc2b-08dc48d1a42c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:34:02.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzZ7xj3YgjTBq+/+zbvdvMRcHVSK2/ccg4hTbs7a1Gizd4ZWcpbL0hyxBTVTnr3FYmvTCSoikANZufL5RJ6yiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200092
X-Proofpoint-ORIG-GUID: n8x4v-zsoZay6jqfuTUNl46NbZNUmr3o
X-Proofpoint-GUID: n8x4v-zsoZay6jqfuTUNl46NbZNUmr3o

On 3/19/24 23:42, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Btrfs has had the ability for almost a decade to allow ro and rw
> mounting of subvols.  This behavior specifically
> 
> mount -o subvol=foo,ro /some/dir
> mount -o subvol=bar,rw /some/other/dir
> 
> This seems simple, but because of the limitations of how we did mounting
> in ye olde days we would mark the super block as RO and the mount if we
> mounted RO first.  In the case above /some/dir would instantiate the
> super block as read only and the mount point.  So the second mount
> command under the covers would convert the super block to RW, and then
> allow the mount to continue.
> 
> The results were still consistent, /some/dir was still read only because
> the mount was marked read only, but /some/other/dir could be written to.
> 
> This is a test to make sure we maintain this behavior, as I almost
> regressed this behavior while converting us to the new mount API.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Nits below.

> ---
>   tests/btrfs/330     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/330.out |  6 +++++
>   2 files changed, 60 insertions(+)
>   create mode 100755 tests/btrfs/330
>   create mode 100644 tests/btrfs/330.out
> 
> diff --git a/tests/btrfs/330 b/tests/btrfs/330
> new file mode 100755
> index 00000000000000..3ce9840e76d028
> --- /dev/null
> +++ b/tests/btrfs/330
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/330
> +#
> +# Test mounting one subvolume as ro and another as rw
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol
> +
> +_cleanup()
> +{
> +	rm -rf $TEST_DIR/$seq
> +}
> +
> +# Import common functions.

> +. ./common/filter

This can be deleted, as the filter.btrfs also calls the filter.

> +. ./common/filter.btrfs


> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch
> +
> +$MOUNT_PROG -V | grep -q 'fd-based-mount'
> +[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
> +
> +_scratch_mkfs > /dev/null 2>&1

_scratch_mkfs >> $seqres.full

Errors, if any, go to stdout.

Thanks, Anand

> +_scratch_mount
> +
> +# Create our subvolumes to mount
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/foo | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/bar | _filter_scratch
> +
> +_scratch_unmount
> +
> +mkdir -p $TEST_DIR/$seq/foo
> +mkdir -p $TEST_DIR/$seq/bar
> +
> +_mount -t btrfs -o subvol=foo,ro $SCRATCH_DEV $TEST_DIR/$seq/foo
> +_mount -t btrfs -o subvol=bar,rw $SCRATCH_DEV $TEST_DIR/$seq/bar
> +
> +echo "making sure foo is read only"
> +touch $TEST_DIR/$seq/foo/baz > /dev/null 2&>1
> +ls $TEST_DIR/$seq/foo
> +
> +echo "making sure bar allows writes"
> +touch $TEST_DIR/$seq/bar/qux
> +ls $TEST_DIR/$seq/bar
> +
> +$UMOUNT_PROG $TEST_DIR/$seq/foo
> +$UMOUNT_PROG $TEST_DIR/$seq/bar
> +
> +status=0 ; exit
> diff --git a/tests/btrfs/330.out b/tests/btrfs/330.out
> new file mode 100644
> index 00000000000000..4795a2ccc8cb62
> --- /dev/null
> +++ b/tests/btrfs/330.out
> @@ -0,0 +1,6 @@
> +QA output created by 330
> +Create subvolume 'SCRATCH_MNT/foo'
> +Create subvolume 'SCRATCH_MNT/bar'
> +making sure foo is read only
> +making sure bar allows writes
> +qux

