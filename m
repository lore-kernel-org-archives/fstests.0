Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA132E973C
	for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040691; cv=fail; b=HTkVhOzAqQe4157VoJ4bJdn/ABPYvgpwqauNUgAuA3JxOuf3Lusi5UtAWkKIrVw7dXIulH2F2PiMOiiTA9Q91LIS4Zay5rvnkSDkevUV1IfrDe+FXMra6t2Hl8ui5E8nI/yNTpzENgre8cMW48j1xdJo+NpV4WypqGk/Oyvv7ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040691; c=relaxed/simple;
	bh=lNqPgDwplt8FZqyw2wA1EJCOKIF39/i2P15dDYFHlBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AJgprKfKda5NzV9n0hvDQ66LLh3lERAwLoj3qDC2pRpFWgfRNfyoLBYe5nINnD02R5Q2RW1RKcMb4OcBkay3g50pFpSdyEigTgo/DcePRQPK7GxaeL3i3U6vE/OJCqlPjnxyJ7Fjyj1rJwo0BxsdqpNznYta/s6bevq0t4lVhVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AAE1D0UQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r67xMYlI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAE1D0UQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r67xMYlI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RFdruD018560;
	Fri, 27 Jun 2025 16:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bXeSe/exDx1lnG/sE9thsx4zWmhTfHfDAk8J1rCmwIo=; b=
	AAE1D0UQy7jcYjOgPxGFUo21lk/FFmyHQKyQ1gcWWRwWA5QkPVgkNlWuy0bUiJSV
	Rl2iQ1EeluhSL47Fdbzn3pZs1Q+w4DcZk9zeopS384COuxQ+VHNqy/7eAxPNmmkp
	uqKxbhgRixfbcg4zqxC33KrVLbm0bCdrEYc+2f4jAxdW1kfCE5z79N38dqNwwpkI
	TkcEWv7ijd8uA2sV/prFEbgN55rMdn6sVMynHoIObJXYcXhGB7xkWSpWbJCBC7ks
	aIabWsHEeU54Pw330QkM/+nuj2imOuE1Ha0H1vmt0gMu1440M2tRSyC/5LNjm3Ze
	PBBj/DDlGZyFKoTx9eRupg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7v4bmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 16:11:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55RF7wI8034129;
	Fri, 27 Jun 2025 16:11:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpuh2jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 16:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r305DySHZ3gSSPzXTpHgpXxpZ8z/+HD34thJse/YhigJ0gXkgqC3siS50fp5djfMZBvyb/FBxS+nAOufebHBVmMRfwKqz/RKwn85fsjEIwU5DKPWNs+m4hSUo/iOcbTwkuRTKL1jGh11NhpnbUP5oprDGlCfwbObS0XpxaUEkyiEAkUdW9y1m78QqVZp8XNnkYv32BgFuuDqvoyX7bWyT1RzLxSO+M0V21mOH4ei0lcG5QMsv4MWrU1XfgNTcguKheFE4bazPQ+OILZiTJDb4aaKBkrXAt9+ztax3fRqf7ea3NqzZtiWgXUjKsrhUFrtnrUpMwoZaCMOkj3bkQDqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXeSe/exDx1lnG/sE9thsx4zWmhTfHfDAk8J1rCmwIo=;
 b=VCr98P7kk4Ug3IHkmQJmb4TSDl4q1SNm9Sj1vfSw/wW5zIPI/4kBxCEV1WWPO/oEKHKfs8SMtPGW4nQUrpSjsQh3exLNUa96BOwl5X8sqIaQc9e2CGsNqSebKYDaD4svGaPhUiR2D199mRneXx/SX0EPvDIMix2Z/FtGzm6ch0xiKhOLAlxrLXcKT+RH2ZwYabgqOm3ckHYaWCzGX6iVOYfDaZut+cz0nnRdpHIeJenyVrX1+Fp6wyOaBKcE3x7q4t26kJPiBeScmmFnyOCmhYI+TpPDA6OMlVb177egMQe57VRK0kyb5nIo4kAvizK9uOehjy9clNtoFgOoBxbLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXeSe/exDx1lnG/sE9thsx4zWmhTfHfDAk8J1rCmwIo=;
 b=r67xMYlI+V1FgasxLRBAJM6+VZEgvLucK2BJThm5pwjV/tSi3mIx0J6IXdWrJmQCLlqNGpIvT9aal9kRhQiXkLmcQaHmzaJuQ+QWwLcw58pc06lDaU3RADC6u+MqA1Zkt8PmJeYwBg5ugze/VbvUR3hdmCIOUtbFrjKuElLwT44=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 16:11:16 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 16:11:16 +0000
Message-ID: <b8bd60eb-c926-44f4-a0ff-b5de75803d85@oracle.com>
Date: Fri, 27 Jun 2025 17:11:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] generic/1230: Add sudden shutdown tests for
 multi block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <eabfa4691ac822af276c900f0cc7502ad62ea768.1750924903.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <eabfa4691ac822af276c900f0cc7502ad62ea768.1750924903.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0129.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::26) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: a37aa821-ca53-408e-cbca-08ddb5953e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YitvS0tVNWZpYm9lNmNwT0xsOWhuT2NtblB0YnJxaXBiTWk0eXU2WVZyZVFZ?=
 =?utf-8?B?NU94YUJ3ckU5dmsvZFBJVkUzOWQ1ODlhN0dGTHUwaG9xVk1lQ3kwVGtJd0Mr?=
 =?utf-8?B?dFlnNlVXNkwzVmxKR29tQTc4blJiaFc0ZVVuVGlxOU9WNDlzQ29CcFErT05i?=
 =?utf-8?B?S2crbjZjOHBvd3JRMnV3L0lPUTFoRm9hSzI1alNzSFFUMjN6czZJVG8xWHJx?=
 =?utf-8?B?TW5ERkJNUkF6dWJEMTNUTXlYWkgxYXJDd25pc1JpTFcyWkVXSEhlZFBpWDN4?=
 =?utf-8?B?L3A2SmZsUjFjbGZTd2E5UGEvSWVJZVBhS29zREJaMzFOMEZHVXg4YUJnaTVr?=
 =?utf-8?B?by9IU0d3M1VqS3hlbk9IL1F3dEpBZHV5em1PTlZ5QkhGMEFkV3lvU0cwcG90?=
 =?utf-8?B?TXFveElSK3RXcGxMd2V5TVRZM1hQbDJyVFhPTWkyRElCelBJYkxzN2hjNkVF?=
 =?utf-8?B?QU5RZXVkNk1OOUNFQXN0UG5vazdnZWJJUERHTDRYeDQ2ODZkMExkLzJ3WG5q?=
 =?utf-8?B?QmE0d0NRb0w1SmhjOTF5SSt3emRoMVdMM0lTVFdNaUNHUnpUM0RtcmczdXpU?=
 =?utf-8?B?VVp4Q2FPM3dsVUo3Y01kMitvMGJMZDd6YlJxRXdzRUgvNXdZZ0NVcFk0TE8w?=
 =?utf-8?B?UDRicHdiVXJPL3ZZa0txNEk3RnRQWThLTHFmb0JUNUJRQVV0anFpQ0d3WDlt?=
 =?utf-8?B?ZjhvMXAvRGl1NkNJa3lTdGppUEc1NTNWS2xDSGgyTXJqY01pQkhxZWpTYUR2?=
 =?utf-8?B?K1h0SGFsNGVWYWZseks5NG1rOEYyQXkyeWlGV3NKVFFRZVBkV2tvMlQvY1NB?=
 =?utf-8?B?UGFJUnNYTHJCL3kvT2dHNklZei9OUjZXcFYwS3FlRG04RUNiVTc2dUVBc0xh?=
 =?utf-8?B?UUFDY1A1MFBPeVdxaU5ZYkdIMThXUXBMMnJwRldmS3lrV0FwU2NyaE9vNlJw?=
 =?utf-8?B?VkpZQ2VQZEtTUG9aTThBNWFPc2F6d1pwQVI5N1Y3dzZrdHB3U1JET2Vrdy9s?=
 =?utf-8?B?blFQQXdzbFRMeHpVRWI1dmhaejk2SDdFUkREVk84b1dVbDBER1o0d0dMdGtB?=
 =?utf-8?B?MUtvNytkQm81YkZKRHJzVmxjUEJxcjVneVFNRW5VWnRvUVpsMDBFVWFoclJi?=
 =?utf-8?B?b2pCY1MzYTREZVNVVmppczNjVmIrSzdsU1VISjkrYWJobDdCSzRBUlhEc1Iy?=
 =?utf-8?B?N3hyVmoxaFdpQ095ZXhNQlpjeFNJQk92TVcxa0JFWUNMQWVQL3ZUZVVEQjFZ?=
 =?utf-8?B?QXJoMGp0WjVycW01endWdDJRZ3VrZllHQUlBeWFPTThoR0NDc05YTlhQYzU5?=
 =?utf-8?B?U3RmbFF5emJqWG1xTG9NbkJMRk1hZ0lhOHczMlNjNTFmVEhQZjQ4TlYyd1l1?=
 =?utf-8?B?SnhGUDF4Mm1rclNrUnF5YkRvOHBsVjRYTVFnSXRkeHVSSWFMVE5NcjNJNGp1?=
 =?utf-8?B?N3ZRTEVGbWc5NWxqKzlKMlFHVEdNK2NkQ0RMb0VrTU9jdVM3QUNYRmZvM3Ja?=
 =?utf-8?B?Tmg1amk2SHJRRVdWWFdRZnI2elNQVnJvNVJOYllWT0pWaFFienNsOUpDbnZW?=
 =?utf-8?B?YTQyQmFVMGFpeUExbi9lQ2RFZ096bXhwUDMzV3Iza0Q4NVlSelA5R0kvQmg0?=
 =?utf-8?B?Lyt4QmF4Y2lQUDk3dit4VEFJb2VMbkFvaXNGWGZkS0c1c3lZblRyeWZ4QkZY?=
 =?utf-8?B?Nndzdk04bUlrMGNhTUE5d0hUdk5SSTZlSzVwbGk4eFJ5aVZKdnpDZ0xJTEdT?=
 =?utf-8?B?dWk2QVF2bytpcFUvSDA0WG1jUXJiYWRRLzhOSDZkSHVBbUNvZ1hQWVhKZjRD?=
 =?utf-8?B?bTd0ZzU5L2xiajBxWUp5YmhDdmNLaVdoYVNNY3pabEdrZWtzSUxBTVZ0Z05x?=
 =?utf-8?B?MW01c3JDcGpCbjM5UVBkNHhSSklLK0tiaitJUXNkREJmRG9TQ1dyVENJZ1Vx?=
 =?utf-8?Q?cT91kQq0Xa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0wzV1M4MndpL0VjM2N6OC91aFBRaG1BVzA0cVk5SHZ4YzFQbjZESUpIOXhY?=
 =?utf-8?B?Q2hNbWhmZ1VVazhzbUxzb3cvS0g1VTZQN1U4ZU9HVFAxTFNrckdEMlFKc0xa?=
 =?utf-8?B?UnFpUVQvbnZvVlRuVkRlNm9JSFYySDB2Q0JqQ0hOZ045eEVpVzJqazRNc2Fn?=
 =?utf-8?B?V3k3dHVCNGd4MkdvUXNhSCtjZXN5RGFBSE1yVGFjQ2JmK21kQk1ucmxML3cw?=
 =?utf-8?B?bWlXUmhnRzRxSmNkdng4ajhUTVEzditnZ0FwcjBNWGJlek1DQ0cyL0ZrTFQ2?=
 =?utf-8?B?QXkxNitRUThtL1hYYlhRK3V3SGNsYWpIaTFGRWFHQ0N6UVlRUWozSE5UZHhV?=
 =?utf-8?B?SHRqbnJvNENMcGJUZGFkb1AySTdqUTNDZlVrRlNhT2gwWVlQQy9MVVBJTyta?=
 =?utf-8?B?bWsyS25Yd0RCUzBQMDRzWm5WZmMrVTFlYkNhbnhtUlZBUW02RG5OOWFQY0E5?=
 =?utf-8?B?eC9uVVBlRTIreU1aZVpHV3RMNmlJWGxjYjQyR3NzYjRVUm13Tm8rNUh4VkJs?=
 =?utf-8?B?d3puQWpndnhDWk94bkdaaXpqOEozU3hHQU1vcTJBYW15NmplVmZWQjJBUFkz?=
 =?utf-8?B?NlNjM1RtSHhIN2lmYktTdG1xb1FMK1dDd3Y2UlB1NVVLWXZFZjc4R1gzWFZL?=
 =?utf-8?B?Vk54R2lQeWVKRXd3ZENDTm1WdXh6NXlKQ1MvYkczbEsyZHRXMXN4UmwrUjlC?=
 =?utf-8?B?YXZCdjNsaDJIdk9Zd1ErUTRQSTErdVNGaklFRlowVE5jSVNlUEVSUEthM3Rw?=
 =?utf-8?B?Mnh2RGRadFE0S0ZzQjlURndSR2RNYXN0ZHpKRWErQU5uaW5EdElqdzlzemZp?=
 =?utf-8?B?eXpVR1FkVXF5N2NJMkdJYkRuYzBvaTFmWkNwc3NnaXFqMVYyQUVCUXgybzBn?=
 =?utf-8?B?dTRnSEZvdnFkRllrRDkxZzdrWGIwR3huaExsZkdIV1J5TFBSaVJlUTZZamxW?=
 =?utf-8?B?R0c1MjdYTGNubW9KZjcyYllnNWFvZWhnRE5WWGJuTUpFMjdoVU90Q3JWNUJG?=
 =?utf-8?B?Y25MaVdyVUZBV1BQVWhPeXhnSU04Y1d2UHVBNjRTQmtVbzE5U0ZRbzdKTEdv?=
 =?utf-8?B?VkdIdVF5bWU4UFh6VmJHM0o1TkZ0czJPelJpUFQ4K25TWXR4ZG5QUFk4NzBl?=
 =?utf-8?B?c01SRWJBMmFMUWdkOHR6M0hGcEtPQjFvMEt3RGJYRXhmRVhZa2x0aWxzMk9L?=
 =?utf-8?B?ZDBERGZ6SnFqNVJvU09Ga2UwWFpKN2FLaFBQR2R2Y3grcHBPbW5UM0lXM2h4?=
 =?utf-8?B?U1dTOGhtTHptWHpQWXZ2MnBpNXlSTjVDYXE0elh5Ly9PNDI1Q3ZOUDVJcE9R?=
 =?utf-8?B?RVBTVXo0M29UQ21CUEo0bE44SVJIelp6UmVGK0Jma3JXa2Z6cGxMYVdrUlc4?=
 =?utf-8?B?MkpoVnR1dURCeURFQnYreTlXaitzbUFiUjBpcnNoNkNBQy9PcUY4Z01WNzlq?=
 =?utf-8?B?YUFDQWFrU0tBbWVBZy9pdloybHJNNnpiRk5GSFVPcW01OHRBK0pnQis1UjRp?=
 =?utf-8?B?UWJSSnUxUkhZVW45WXFFYlhham5zSXJDK2ZTV0hUb2pJZlN5VWV2SldVaVIv?=
 =?utf-8?B?RmJnY0FoQlQrYWJoeWUrMUJ5bU9IVDJZSzRuc1UrZFQxTVlqaDVYbHFlZDFL?=
 =?utf-8?B?blJvNitzYWtZN2pManF5TC9TbHJ6RWUrL215aVh1QmNyOGRiWlFCa1JzR0g4?=
 =?utf-8?B?cWVvRXh0SkRWRU1YWm5pa1FCOGtLL01zVVNMdVRkampKTnZjS0EyajdsTlhK?=
 =?utf-8?B?Q2RRVWphMHJuOEQxL2pHNHNZWGpXRThOWTRBOW5YZVUrL1Yxb1Z5U2tLeWpy?=
 =?utf-8?B?V3p1d0kwZkZUZW1kcTRQQ1g4UDI2STRhTG1CbVJZcW80aUhpSXhXTjBxeXc1?=
 =?utf-8?B?dWQydGpGNzdHSWxhcVFVak9Ldjk1WXR0WURpa0daZ2RnaEpXUU52emhHcVhN?=
 =?utf-8?B?TG16L3JwdHluK2lRcTRJZUZTS0tXb01NU2FmN1FmaGxVSlJKOXRCdnhhZWxS?=
 =?utf-8?B?ZHIyUGVKa2ZVMnpMZTBSckVtY3d6VVdLL2x6VnNhWW80QXRRZmU5NCtlVlRD?=
 =?utf-8?B?QlFXZkRhYkt1QlFCMkFQQTQyT2UzR1k2MnMvaFJSYlpSQVRJbGMwTkExN2Za?=
 =?utf-8?Q?+HDSaIP1+EvuTci6NNw0/xJEf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NzP+mBQB+ut/dsRVi0xz5Ubaos83GYUnbsHbYxuHZTwHF3E+TlxTzgc0hDnqOvTww47a6lxBzNSWCPAjK/Ey1zP2nUm3DVXgfRHzF/CabKP4r67BDLJMogFJMXHgqlWWkPYB51KCslkk0D5Ld+DTKNjcklQ27+IaVuFHN0hccv+w3n47/Ts2aOHwMSz+TS3ks2D/FV1B+t8kCNCT0dOKV6C9l7/jn25Rhr+VQr3mKY7p69FJV4Oyw1ECoH+MlY/J4O42KIiyU8iI/uT5WMmfyOTxn/Txm2RJZVPbUBjH4iN4xGe4Q17ULFU7X+GyzllFu7QfX6lhGXqHBTHdk234Qmhwe5LRq368OkX0OO+OI1sOJBKQB+iSXXPNvSWnpVXmg2XwSKQGMVAoWjDmhpgZXJ5Aet/SV3EgJnPdwMismfpF9pK3Ok4WRroi4s0JJocq9dCLW6SpItSsrSKX0hdN+MqgQfawQk9E5NaRAvlk5iMmltDEisK8CFTIL6p5k3x80kVPCwz+uUgICO7pQifRIL7vY2BFs9Cj+xVJ9FpvoFmhgIDnv0K9lXxj3g8Q17CJ3aApMp42wM5QjZEs2grlkyc9zX7OlkB0EDaooHwz11U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37aa821-ca53-408e-cbca-08ddb5953e83
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:11:16.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A70NR3hkxqxt2m45oVmRK01QZeNo3G83Km7DKG2NheLV6HdlY6s5lFn965WAT0dZNVo65PWEHDGZSfJBJqPZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=901
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270131
X-Proofpoint-GUID: 26FeAh4uzo2XW1RH77uztT59banIEJMp
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ec2a9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=LctOniYhYpxmoBfWMj8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 26FeAh4uzo2XW1RH77uztT59banIEJMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMSBTYWx0ZWRfX4DGDnh2ua1X4 Pkl6OeNncW25sUHYZjTcnKvTu9bLO74l8gOgBXIcbTcLXlXw+QKH4dBAnSDRTi1J5eybOMO9Kt5 oaHLiwKvQAMT/NicIWlIjdave/U2+jZoYbFc+yPhqR7CdcqEzeXyjvOuu8tFmBf/usfuMM5sXRB
 9kRxGdawi5SQ5cTZHA9Aw5tz8lrdOOBen/AUyI8IewMiGGj7ArkrPLbjnisvX8JZZWzSa7KK57j ctToRJI6dbUTtpOa1SLd0/MRpdT7LB7Pk8o8fMlcXJqV+AaXoByYXZxcB29dC2yC29njxGjJkDp 3aT4Tpe4/2DxmOcEH/cAoih0GbzVZHILNXtFQEgkkyYgTZ7ezyCUw5v/NJMgyrEzY66noILheH6
 tkcdOfqhurHWTlGnuxB4B+jjt3wwEsjrLEXnqyET8hcwl2m5p3C6ZeHzMB/4A0FJH3+NB1RO

On 26/06/2025 12:59, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.
> 
> The way we work is that we lay out a file with random mix of written,
> unwritten and hole extents. Then we start performing atomic writes
> sequentially on the file while we parallely shutdown the FS. Then we
> note the last offset where the atomic write happened just before shut
> down and then make sure blocks around it either have completely old
> data or completely new data, ie the write was not torn during shutdown.
> 
> We repeat the same with completely written, completely unwritten and completely
> empty file to ensure these cases are not torn either.  Finally, we have a
> similar test for append atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>

this seems to work ok for xfs, as I get data verify errors when I remove 
the -A arg to xfs_io when doing the atomic writes.

But I see this (always):

@@ -1,2 +1,83 @@
  QA output created by 1230
+/home/opc/xfstests-dev/tests/generic/1230: line 13: 
_require_scratch_write_atomic_multi_fsblock: command not found
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (535173) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (535256) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (535339) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (535419) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (560146) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (560229) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (560312) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (560392) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (585304) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (585387) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (585470) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (585550) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (610300) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (610384) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (610468) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (610548) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (635276) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (635359) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (635442) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (635523) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (660400) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (660483) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (660566) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (660646) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (685377) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (685460) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (685543) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (685624) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (710361) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (710444) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (710527) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (710607) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (735333) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (735417) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (735500) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (735580) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (760306) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (760390) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (760473) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (760553) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (785276) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (785359) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (785442) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (785522) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (810249) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (810332) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (810415) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (810495) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (835221) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (835304) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (835388) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (835469) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (860199) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (860282) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (860365) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (860445) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (885169) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (885253) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (885336) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (885416) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (910140) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (910223) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (910307) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (910387) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (935110) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (935193) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (935276) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (935356) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (960079) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (960162) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (960245) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (960326) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (985052) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (985135) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (985218) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (985299) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (1010026) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (1010109) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (1010192) - 
No such process
+/home/opc/xfstests-dev/tests/generic/1230: line 247: kill: (1010272) - 
No such process
  Silence is golden
[root@jgarry-ol9new xfstests-dev]#


any idea (apart from _require_scratch_write_atomic_multi_fsblock)?
