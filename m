Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCD1BD4E5
	for <fstests@vger.kernel.org>; Tue, 10 Dec 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842252; cv=fail; b=lXDuXIwNKnCKrrxX/Mgz+26w/odqs8B/7wPJ2+9ERYCIDpNe+E7wEgYi2sdXBVsIzv2JLMQJAtNEIPcU88dtMD73OTxV/p/kdPpoBfJMio5FE2+5W5kdTtjI2kauFOK3nlcma2nXT+Gw+TISp/bDF1EYganJVST35bqx6dqBzms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842252; c=relaxed/simple;
	bh=cXIVe/4cUnBbjzhsz/PZJ8jn5LHJPMYwI8pGfiRl2PE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qTtY4S0UOMjsix6HPycDRI9j81cQSHx7IH5KdDZT4yLzeBQpyQRfjRuNV+7Hh3ppX7htg1RFbSTPqI29aft/L9sgtjaoK0yX4BgmntjFVLgfV2AiYnHu70SO6JBWe916Sza3Xpjy/SGEkE6G6Tc1URn3zzZOjIg5rI+L+KuNSgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oWDs/XSt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H4vnNEjK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWDs/XSt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H4vnNEjK"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAHi3R015925;
	Tue, 10 Dec 2024 14:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hf9WLf5HjI9E7X9Q+JDsVM0O84z2EPCqxRObfjPwMN4=; b=
	oWDs/XStNtTE0zEgyKj85MRprELv8cWM9GsJHUrEjuCs2Xbhy5pIbRv61huR1Euu
	N+IqCaQPyZSCnLvYLiVzdULtnkt3SD/EGhLyuaoR9NIeoPF59tplwDuKBrX30V8D
	uBM5h2JIUuLhno27oHZR3yqWi1F2KgUvi7MC/YK3oY7NCGktc66YYYZ8MisHLykN
	7/+QgEFLZp7awdbjUwrdHVlKE38Z8i/U3WNJQCKOhqbBYmXT/ZSYoqVujMHxJfEj
	0K9KcKpZE2aCiWNKqdC2tYX7F+TlEk7WgAAVhVoJTL/y4D0ZFDf3pqOqlOT8gw0p
	t2th0kf5wqP/PUesTDRpgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc5yve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 14:50:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADOR6V035611;
	Tue, 10 Dec 2024 14:50:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8quy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 14:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1TKxkRsg9NjH6/8akl+siRdTcnqyawo7qq/Wne7nEtBk8QHOtmbuoc7Tfj4JpFxd2usjw+e88OCI9tNz/Gf902qt1v0CK3zB+DDogf//hQDb86zVt+RwscuF/Jppw9tI8TGrolDmY+ourlwmpi29EpzbfzmBtTU1+8nlKh3oDK9LSjiewTWfsqG/h6ap1pcDn0lEuEi1tvwx1/4Bk8koFudATCzygTtkbbrCo4XJRqNqAwcWFJggacJqmXp12JMU9yy32uvj485eHIGwBvpw1MAim4FLGaCApzpRPp04eu64agmVTardfMqnJU3nJeOHx9D7wX5RyvLxGlQImNRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf9WLf5HjI9E7X9Q+JDsVM0O84z2EPCqxRObfjPwMN4=;
 b=ND4rcy973qzniGYe5GuAfy3fBtNiJw7relggWUXMFIlHpV5D0C6jsQ4uDxAtBYmsvUBSmCchpn9JzadQkHKt44CenzABpOSpMOQ8+xzMVsGBOMdFEHEvTzeBMhs0nXakXGd1cZJ/W1CTdRIhCQmsvaJ7PL3zGQGD1wpR0o4aqgp5EXMKEEP6qpZiM+r3hsJapb/tpfweZp6yJyiEgi8Jal5R0Da+4qDrCBTsUxkoTWTJjDR+bMQYlfpp76zVGqyfl7bRZsYvB3hSdiIXUVcE1VlehIxGq9Y+LWl0nhIuTN2iGYz/KYr8HtvkyXwuomqGHBwsViXsfc0OtS6m/5CFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf9WLf5HjI9E7X9Q+JDsVM0O84z2EPCqxRObfjPwMN4=;
 b=H4vnNEjKMKRWg0neNtP34jXrTH59shIL1qvtCEhUAk1UocK0sD8xEvfiNiy1rpwBdYdabgi7/QKe/utUxrExDXPO2uAf4UNKdadvlVUOQGmq6DdXmXvV9tVshGUFrGY9stm9wAuE6nd2YSw4s+N9K5P2hVEmsikV0O6nV/r4yuM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 10 Dec
 2024 14:50:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:50:40 +0000
Message-ID: <c2963c1b-bc5d-4f7a-91cf-91fe84b15fbc@oracle.com>
Date: Tue, 10 Dec 2024 09:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: call _require_scratch_dedupe from
 _require_scratch_duperemove
To: Christoph Hellwig <hch@lst.de>, zlang@kernel.org
Cc: fstests@vger.kernel.org, cel@kernel.org
References: <20241210065346.1234550-1-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241210065346.1234550-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: b69a674b-3f33-494b-e5aa-08dd192a03fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNMajRlVWs1RVNZOHdWYU42anI3Q3d0M0lzZE5SajNGNWJ6b3BTaERqSTB1?=
 =?utf-8?B?Z3FqcVBWSGU1Vm1CMjQxWFVRekNqQS81S3pMTU1KbHJWeS9nd1BJYVhLeW1l?=
 =?utf-8?B?R3IvMG5YR21TaTE4dlB5WVhtR0RLNmNpcWtKdlg5WWZQSG1LM3kyN1NYQTNx?=
 =?utf-8?B?VDNldXdDVy91d0gyNjBZeXc5bnRtdkM3K3lnMVVkdzNkaXlMY1VkVE4rU2gy?=
 =?utf-8?B?L0c4Z3UwbG9PZnM5cjMxditJVEUrY0NtRnhJSlEzVmVxcFJnS0pYTWFXQlo0?=
 =?utf-8?B?dXZTZC9va3g3QzNDM211QncvRkk0U2VtbkIyMUkxQkU0dVJXK1ZsYzdoQkpN?=
 =?utf-8?B?M3liN1lpczJkNm1xT2J1cG9XcWFJMXNZU2lVUjcwd1hmTDJ6b1czVTNXTWZE?=
 =?utf-8?B?WmVLK3JoclB0SmdyWk9ncjBVY2s4TTA0djljVk5RUzUxbE53dGxuSEZrcVNl?=
 =?utf-8?B?aWg2bFZhbTJRU2dWb2xpdjJuelVNQXM0TFlIZkxjVHBmb1BobXJ0QlRIODJu?=
 =?utf-8?B?VjkyamFTck8rRWFRUHAzeXp1TmJzQlFFaW9LdENzdGk2TGQzUEtRcHdCWSs4?=
 =?utf-8?B?V1hMVEVGUXZLU3pqVFBtaDlMR0hXQzFFRWRCYzIya1N5U2sxbmFFZWhJRWhF?=
 =?utf-8?B?UDBFd0sxUXF0MWlWTkVMYkd4L3k2QVh6WUhubWJVTWp0dmkyaEVNaDJZTk9p?=
 =?utf-8?B?eGJnM1hmNGNIK1ZBVmlYbmtTV2pOeXJRVlk0c3dTVWQxV1dreFZDV3pIYmEz?=
 =?utf-8?B?YmF6d0h0NEt6N1FPaVc2eW5sOEp0UjVhWlFWOFBhaE9VM0xLK21xUEQ4SnNI?=
 =?utf-8?B?Q1FnYnFxSXcwUi9wNWVBQU9sOHdNNk4xNGtmNlRPTVpnNE8veXhFTHp5cndp?=
 =?utf-8?B?R3JreUhUSDI3SU45anVrbURhQzZiZmJKUHFKSEN4bm1yV2FQN2RUQ3UxUlhF?=
 =?utf-8?B?Sm11VWZObWQwcytTVko0YnBDa1hjR2JVRTlUSEZ3R1U0UE1DRWxMc0c1Y3Av?=
 =?utf-8?B?dnRydzN1ZEx4VVdka0d1ZmhQaE1kUVhneHdKR2poS3ZlNEdkWnNlRnBmZjh5?=
 =?utf-8?B?ZVIwSzJKeS9EZHUrc2h1MkorcXZ1K1RzWXpvc3NqQkQ3VWRxdXViNkYxZGpD?=
 =?utf-8?B?ditkNk14dzlsck1za01ZRUdpNTVZdlBlNTZBR0Z5aDIyZnFDWks0cnlidGtM?=
 =?utf-8?B?V3Y5SXBCaXJyZ1duV0dHaXlFbnFoRzFhNzh2cWU1eEJaYnBZaTUvV1lBWTRN?=
 =?utf-8?B?ZUFrdDdISVBWc3RXOHFzR2JIRnZGdjZLM0QyZnJETmdsYUo0VFV6RHJpbXpz?=
 =?utf-8?B?dHZxS2dIcHZ0b2ZzTVF3bWZzZGlDS2ozMEtMQSsvRXBQMTRjdU8wcGI2QnhQ?=
 =?utf-8?B?UFlCM0V5aktIOWVXNjFUbkk1TmlZaFJTNVFOMkFKRDdid1JsRUtid3h1d2dI?=
 =?utf-8?B?U2ZaMXdwZUhBcGFSQnNtVG9NVWJsSmVZb3orWXRxaGNDOTBhZkhDTmlpWDR2?=
 =?utf-8?B?cmozUUU3SUhoZ0RMbmN5NitNOVBLVHRUZ2xtTXJKNVNVWmFZK1lkLzF5YVUv?=
 =?utf-8?B?S2xWQTFnYk9RVVgrczlZTkJhcGE3SHRDY0k1dmY1UWlrZGhFek1HMU55emtS?=
 =?utf-8?B?SlRnbHdpd1JyR0FvL01rM3dUNkkyT0hGYy9JUjBqZnRBUVNha0dhV3c4blkr?=
 =?utf-8?B?eHkzK0loV3lOWHpPMnczNmtRSEE1K1lONDA0MFMxQk9XcE9Oanl5eldVTTZ3?=
 =?utf-8?B?eGdlRlVsMFM5S1ZPTC9CQkFLRWZCRmtKa0xDZFBFT0QwVDNQalRSOE5zeE9B?=
 =?utf-8?B?L2wrazMwYVZmd0xRR21tUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzlQMXEzczR2MUtxSVhNV25BUGR2ODR2VmZ5T0pSc3BwRndyWkhvN2tOWGRT?=
 =?utf-8?B?dFlqTmJ1QldlNmFBQVRmdEJjUFZ1ZEgzWGlobHFTRmJvNEg0QVFrS01TWFdO?=
 =?utf-8?B?NG5Lcy85YWQ0NVRLV0pVQk5WSE1HMjJpdXQ4MEVSZ0RuaVI2M1MwWlJ0OFI2?=
 =?utf-8?B?aG9aZm5qU0J1ZHptTERMTnMwUzhHNG02NTRjNUpieTJVanpyaGZsMjBPa1FU?=
 =?utf-8?B?cUJNOUcwenpsN09Cc3FFVjh1OUEzdmJPWmZJbDFHN2xNRW1HMGZEM2dGd1VU?=
 =?utf-8?B?QjRieUdsVWFVNXZoNXAxWi93QU45THAzKy9QLzlVUkVzM01YV2M5ejdqU0kx?=
 =?utf-8?B?Q1IvZDBOVmw1dmZNSWVzbmRQYWFsd2Jkam45akJVSU1XUS90Tm5lMDhVMkZB?=
 =?utf-8?B?THlLVTZDZTl1Ulk2enBRVWsxUzVnY1RUVkxJR1Z0VE1BRDVkK2hIUGMxZFRB?=
 =?utf-8?B?TXdBK09vR1hLdnpJcHpGWUk3aXBVZXJNMnJDekVBbmR4cC9HOUkwK2dzSTdX?=
 =?utf-8?B?M3lRcUFXcy9MaXZkaGxwc2RqQTVNV0ZmNFc4QXVmT1FZdnFMTXV1OEFPL0t2?=
 =?utf-8?B?RnlFUU5iemwwMStCUEh3YXhBbXpHVzNUNWtOdU5oNmxGTHR6d1hWTWk2U1lw?=
 =?utf-8?B?d2hKUGhmd2JNbXFpR0JoOGt5OFk1UUQrQmo2NlM3MDZ3YzcxZkVrbng2aGFz?=
 =?utf-8?B?eVhTSlBuZkxSOXh5Z001LzUwNWZzNWZLMSt1MXAreDBvaERRUDNDTXFSU05Z?=
 =?utf-8?B?clQ5YkprTzVWT0hVVTRsSmtWQ1BLeitwR3lScVF2Q3BHWHpseTZVenAzS2xa?=
 =?utf-8?B?b0tQSFRPSFNuWXNVRVozcTR0dTZGR2VTRGQzY0I2VnJUa3RIU3FINTAxb3dv?=
 =?utf-8?B?V2ZNZnNEbyt4b1IzOFdVMzhJTjdXcklLRzVWTnZoVzBaVm1wOXJibXd1ZTdy?=
 =?utf-8?B?VzluNXllZlJOZ1FyazFJNFhMaVJQL3loNXRrbDlYTjQ2ZDZCRkdLSzUrc1hl?=
 =?utf-8?B?UTFpdnhhM1dRMi96R3RFQUlkMXJmM08raE5VN3pzM0VkL3UwVHc4cjZJeUNp?=
 =?utf-8?B?QU10MGxHTlVjMC9oU0J6SmpmZE5aOVdwZlF2T2lBbEhKdDFiQ3hDeE8yUU9L?=
 =?utf-8?B?aWFpcTltN1oxQ2NNNFlMeUI2amFUQWI2ZmlIZGs0ZlNYZUhUNEN4S1JHWE9Y?=
 =?utf-8?B?VU1oVCtENVpMQk1RRnF3WkJaejU1dUo3UnliOFdkYWpoaGl0T21ReWduNHVr?=
 =?utf-8?B?V1VVM1hQbmFKeEw3UkduQ2t5Rk80d2loOHdkb1ozdmJ2bDN3aTVrdGdSVjlM?=
 =?utf-8?B?QlI1U2JUdmxDeWxIQUhWZ2NsUy94MVo1WHZZUkQ3Y0xyZXBxTWR5VmRQOWE3?=
 =?utf-8?B?QWZBaDQvSU1FcWw5OTcrMnpDMDZHa0prK1RrU2UyZXYrblovQjA4NTdXYXlF?=
 =?utf-8?B?ZmsvNXBqVVdDMk9ORmRMVFpSYktDMkZhcVQ0a2hDREE0TnpEWWhxSXVNNXU0?=
 =?utf-8?B?T3ZuNFJLNUp0TFFqTkdGUko0SGRwNkhTWWk2Ym5neG53ai92ZGo0Wk92cnVi?=
 =?utf-8?B?R3VXU0QvNU4zNlhCUDh5R2NVNVlpdEFsMGd2am5YUlByemNXSlBQNk9VMFor?=
 =?utf-8?B?LzVPdDBzVUdjNWhOTERpbVI3M0Vvd09DdTA0WWR6dWVwRVB6aEJmRThYZnNT?=
 =?utf-8?B?QVJ1ckNML2ZRMnFyQmQwTmtObXR4N0FLYldjVVc5dlF2akQ4ekpNZ2NnSnJ2?=
 =?utf-8?B?RHkyd3BBSEZvRDlmYm9XRkU5d093Q2xBZlNZcjAxM21UYTdQbVU2a01jQ0Vt?=
 =?utf-8?B?UzUzdUR2MnArR3hiekl2VU10cmJSL0s1TUd5Rm1OdnFnMU5sUmFwSWFPcWx5?=
 =?utf-8?B?LzdBQi85dlQwREtlRUdIcCtuS056K1FLcmNOVzRuaC9BYmVpK2tYdERJSW1t?=
 =?utf-8?B?NUFUNUhtK1R0WTVUM2x3NzhHbEMvV0NOY1VtaERrRUlRMFUzbmxrcEVUTWJR?=
 =?utf-8?B?SyswTmE2T1VwVDhYWGtNM1NLY2l5L0lML2pLSHlkL2wzakNXY1VuWkxhbWxU?=
 =?utf-8?B?NGhUcUY4WTBTdmFIckxmNXZzY0dQSjlwS0ExZFdkTlpoSzg0WnM5OWY1cC9D?=
 =?utf-8?B?TktpZGZDT00rSU1IVk1jNUNzWFF3VGZMQVp4L3BjSU83QzFXL3B2RWNrdE93?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	34XmfXj+zNJemMRie0sTvfSGdaKYeIt3Tf9JB4UiX1v6m4Jd0cQezvxpHQ8XMUoedv/hmbT7jgeYCOCsEXupjr0Tbq6QZAiMTJ9qV2ibzeI0c4INVT83krFvF9EDJtRw3U+iyayJsk0ltto3gFLtkdSbCL9d2uOEXu62NpXSjq22S+UD0LJnB4+lNz3gV7z0kbj4+0Ndjr2COjqzHccOhmlzOPka0HW8ZXXwZfykgQDG3HU0kPMZ1NJguEs4Jam+o4w85tdidv28qNHolA93p7aJBvWGDpDrN/k/JBcyY+Dp6ZrRlmHGlFsXreLOg1c5yTORmN8QN1fAN7/2owsNv8kj+e73ABCEEZvx2rf5jOzGE9gfJICoDbHmct0F9/g4vUuFS/q7+qfoYGQS7Eqkp/HsYiMuxeTS3dle/3P7kl/Mx50d9Cykdt3+Ug5y26vn9MDSJrag1zBV1ZVcofL5yT6Tw/OL3RdSUyNP5qd+T8+vlM+crgBUCf8BUReuX+x7HfY8vfOLpHABe6OdBVutE6wMYNnGpBqbGFZnGitfZIdeuokDG9BW4cmMjhI4Yp5ZZscPZ5WxPiG0kzoGM2pss1eztxlknsVIyDExdTKHC0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69a674b-3f33-494b-e5aa-08dd192a03fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:50:40.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7QlX1JC4J1pOVacTnEQc4KygwGlrxpyUGUa8/7MR3TOV0I7Dn5LnPVJZuudsZfXv4eBUf2tVqqr02042FBCOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100110
X-Proofpoint-ORIG-GUID: 9P4CZtge3H0JLP2Sx8fN0C3nBBpsE09U
X-Proofpoint-GUID: 9P4CZtge3H0JLP2Sx8fN0C3nBBpsE09U

On 12/10/24 1:53 AM, Christoph Hellwig wrote:
> _require_scratch_duperemove doesn't check if the scratch file system
> actually supports dedup, so add the proper call for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Btw, I wonder if we should simply stop using dupremove in favor of the
> xfs_io dedup command which seems lot less cumbersome?  For now this is
> a quick fix, though.
> 
>   common/reflink | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/common/reflink b/common/reflink
> index 22adc4449bc6..9177c45e70bb 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -83,6 +83,8 @@ _require_scratch_duperemove()
>   
>   	_scratch_mkfs > /dev/null
>   	_scratch_mount
> +	_require_scratch_dedupe
> +
>   	dd if=/dev/zero of="$SCRATCH_MNT/file1" bs=128k count=1 >& /dev/null
>   	dd if=/dev/zero of="$SCRATCH_MNT/file2" bs=128k count=1 >& /dev/null
>   	if ! "$DUPEREMOVE_PROG" -d "$SCRATCH_MNT/file1" \

Tested-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever
