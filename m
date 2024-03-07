Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB67161
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827151; cv=fail; b=SO+Zgh6Y3ys5z3nQJVrBm9YgHnFrTGjUJ2F31qCzwAAEBwjZU2oQ4+wpwM5gQjSHg11FQ4TQhHZ6KQP1yG3bHVHIA4SpLShOXXaSGKovps+CJBl0YyD5FLZslxGd8TE68H8tMohOUpBMOWmdVvsaGUW/dYTKw6wIFUBnAIrcg2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827151; c=relaxed/simple;
	bh=58RUiwVmRTeoArUhsXZEQLUir2+ww8Q63mvFOCS814I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGNoukc7arEa4fg7YXv/yKwFaslcjnEJ/aJ03b+z0NsxFVu2/GRfPkRjcM0zA6+aybpEBgCBSeYq3u0ccRr2pNt1rTese23ZfDPPENBNwN1lLhgmlIC0cf8x6p90qTGNvfcUi+RExx+RTsEEuR8u+sdVkBgUo9tVX5mR6TWwPcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbpqeYdu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i53EuDOF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbpqeYdu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i53EuDOF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427Fwc2n020933;
	Thu, 7 Mar 2024 15:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pr3C8iXvwVnvsLJ7m7ybTB/YuLL0AmPpOHu+PfknnZI=;
 b=JbpqeYdu2CUB81I0I/zWLjPOC1rJZfiD1H4zsbqCqX31gGHJltx01XLhh1qs0K5UaCl2
 ycD6sh5zN20PS31YAkaqCYopIQoBZUGFN2qHfmA/uY2BMnTIJUKos5wX+Efdg87bmVJl
 RJ4/v+rbzI1tHaw5N0aaSujaxtfp/FvKEoHVuWhLiDHTO+hcDy8J7iIUZaqZCBhi/6pM
 zTHX1SWeiLNNOZeLAMGZ5kwZyfMKpnQUQP9aTG7lm8SJT9/0vaCMknbw5j6Rb1QxlnqG
 +U0vQVWYDMucp34686I7EKxKZutJ/vsrzVVLu5RwzeomFoDkrIlo+ZJvHFvOXWcP4LhV XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cks4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 15:59:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427EGadJ031816;
	Thu, 7 Mar 2024 15:59:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbcvyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 15:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXQVAxgsHTqgVHTCv3tAFlmhLcwTw+A+zGNz7aXi6m2ywcePS8l97261EvVW1y76N5WtdM4KZr6Zpe2jbarcygZCIu/JehVbktw19zDzCwmmFWzy2kiAzRck9L3DoZoRUawEgK+xXNgfS5XhKKhtdlSoR0ySCygFEN0HKMDimN/n17p29Cbh0a1OlOoEcM8r3pZQQJeZfC3ATxm0+Io3mBa+cDlUJ9/HMRikz3oAYjv/Xb4MmeQiuHLizRa5EDThFJ7/e5vIe1461pGCI01mXqnaa0TRjy5T+B1ulHoKV9g+cb1VOsswLCpz/cz3ww335z+YVlfsbreklX3C/T9G2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr3C8iXvwVnvsLJ7m7ybTB/YuLL0AmPpOHu+PfknnZI=;
 b=XTmJe/MInl7078hJP031wtHSzqPPHD1S+QO6/Eubp0z4nsb6NrnTOTd8+ppzECcd0k9r3hbWF7IhU/hA5Peyi8vvLIjOukHNS3jNb5f8yvTT5XqgSjCzVjc/+7FeUX6qPpM/kAP9TdXyckU0SS//Qy8y8DWXdPHyBbLgjpdFDFEtCoHN7kPp56LYlOWCxbz48ic59hG/0gqSt+zs60clRIAjV3PVXo9nBEQrZnJvb9Z1dJz2r4cl4lHV2G9fAvfeC+v2ItPt0P8nYF6v88jcgaDLBwKTnmiYheFbmTToSInRLaieY2s9VJCpWFOQ3QD7od4OpzX090RJA7cemup8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr3C8iXvwVnvsLJ7m7ybTB/YuLL0AmPpOHu+PfknnZI=;
 b=i53EuDOFelAhch/boBn4Oxu7k+EoY5Wz84jjQv8U7Q5BZeJ7/TEhJuni8D8YOHIj5qQmPz4eH/U3T960ADu/Ld1wyq3pMFNCHG5ekSohU63XWV0aoIsX7wxxSxJ+zmdUGMEx3FIFeVQbxZF2hFDmnrV6gU5CIvtHUvtNGOfgr+4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7400.namprd10.prod.outlook.com (2603:10b6:8:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 15:58:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 15:58:57 +0000
Message-ID: <4f6f6087-24d3-4650-9985-622b43eb592e@oracle.com>
Date: Thu, 7 Mar 2024 21:28:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Content-Language: en-US
To: Alexander Aring <aahringo@redhat.com>, fstests@vger.kernel.org
Cc: zlang@redhat.com, gfs2@lists.linux.dev, jlayton@kernel.org
References: <20230925201827.1703857-1-aahringo@redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230925201827.1703857-1-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: f903fa3f-9528-4243-ff3b-08dc3ebf7f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F6ttEcHcyr2qsNYlQjE/28wmULwiow5H0EWpg3iefDlTC7VsWtSCNIXvxIYq1Ek5uxoww1Vwx0RPcetWyJobdHdGMTpc4hQIhPVA8N53JV5eYESvmlRH5Bd1veGuuWnWU4oNdgFye6TFQrnhJ6Nk7VY8kw7YdcoXCH2Arh1DQfIlP5zuy0KUi5pGX4DNlKBvA580euwf4G2+CmuV5rsedv2wrCTyjmK69zKLwVLOxym1TJLhe0K2K1RxgW38AoVcn+Jo2s/UY5z8+FGsEiN2azJzHE/yuVr8wGBWrSN0b0VgAs8Cy1J8n2I3lR/R3VcyzL597IgF9YsPz/MhzZc97gK+jy1IL4IhcFslxIQPnSP6KuxfELduuCVL85cvBOU8AS8iwP12dp9ViX/irdDNnFf5T4ggU6yJIQRoWj+62oeYl39BNWgxlm2XWdKvhv5xnlSLqx4ln26rh+oHOSFMR38GexZDdUdvneyveivuLD2InuTTMx2nwnzTQf/0nX7ZZsENIdMqgYQrf6e2+eNzGJG5Rnfje/wBPXAbLFP3mO2JENOEBvB3mmO8RicBkkmPSdHQhMAJ6nTC0AIzE4Gl8WW2rh3xV/g0ukHiifEDfXM4jSk+2gZnuFLt9YWxMTYc04EiI/HFfh8NbRxZMvsqXSTaWZzFo44+hwcP4ASMr68=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWZpNk9UcjZwclI5WXBQTy91WFlsQ0dMWm50MWc5SklkRjNKZVlxdUFZVmh3?=
 =?utf-8?B?amJsTmxmaEtqeHE2TUlsL3liQ0lCZlNlWWNaZkRENFNvT3lrK0xXQzVTOGVI?=
 =?utf-8?B?dXR0dnNUTTZIRWptelkrT01GWEtXV25NRTllR1RyWFpyYlhNbFJQVm1yNDQ5?=
 =?utf-8?B?K28rVDBOcjZZRDZ0a09YWTFhSXZkV3hkNk40WmdZc2FRWHlBbDJGME55SjJ5?=
 =?utf-8?B?Q2UyK3RlVWprQ2dualdlRkpydXg4dW5wRFpVNXlFTlcvQi9qQVFhcStCVkFt?=
 =?utf-8?B?NFlGZm5FTi84aHlQZk5XYlE3d1NwZmVCUzdtMktmZXpOM25rZHVkUlovcWxC?=
 =?utf-8?B?YVpzMithR1UwcE5wRTJDZU9WVmNFc2VCV0FNSmZDaEFWL2dzUUF2N0ZxWVdG?=
 =?utf-8?B?cDFFTmtJSEJVQkQzYUdNdGMwNFEyMjdNaWFTa05DTm5QWWF2UEovRGY5TzlV?=
 =?utf-8?B?VnEvRG92SlVLQlVSSmUvU3dJMC9yUGZZWTMyTkNDYThSMkwxMk1vem83Q3hl?=
 =?utf-8?B?LzJxR1pIQy91d1JBdGswNTR6Tlc3ZkZ2VEpQelZDMTBCOFRkZ0ZoMXdTakVS?=
 =?utf-8?B?ZWFjTEdrNUF5V1picSt6WTkwMVMybGtTa2hNS0pFdE5Xb0puSjdpemV1dGdK?=
 =?utf-8?B?ZWV1WlkycGF6d0pBeUJxZE5aR2VNdkVUbzlEV3pFVzFRc3BVWnd3R3g4Mm9R?=
 =?utf-8?B?ZDlPdkdsaUk5SjQvL3pkaUNjWW1SRkxBMVQ4Z3pnM1dLUElhK29QRkdkdmlY?=
 =?utf-8?B?bUF3dklZem9RWnVJZGtoZERYWDlRT01DSHF4cjFpVzQxMisxZHYydzBNb0t2?=
 =?utf-8?B?L0JKNmgyOEF2MEo2OTJ2ZEJkT3dSTzIxYkU5elg1dUYrZzk5SUdsbzA5Yk1H?=
 =?utf-8?B?NHRDTUJNaGtzeUEyQ1dpc3pWeE85VjRxWCtUUWNTOXBZNEk5TzFwVEpuQmh6?=
 =?utf-8?B?N0dNVE9WbzF2dUpTSC9vaFZjT2t2V1VENmJSbWFaT3JudWFGbFZhOWRlMXR3?=
 =?utf-8?B?YmR4WWtBMEJEVm82aTlhanVKYkFWWHRFemlkMzV6WkRCTlVpVm9ZNS9JaXNk?=
 =?utf-8?B?L25zRHhpRzdhTTZBTVNMNjlYdE1nMTBWekhJbG8xbHdhQ2NMaDVOQjZCWklD?=
 =?utf-8?B?YjB2RTNtcmF5Q2xkRHd6bXk1MFhyYVJvbHh0TjlRa0VLb1MwZWVVZkVEbkN4?=
 =?utf-8?B?ak53cldHQXNZUFJ0NDJBaDFDQlMvbHdMTi9kTlRKR0JRY3Z4MXMxYi8zUk5x?=
 =?utf-8?B?TCtmbWJoY2FnWVdMZkhKM0VFTTJBS1JHaFB0N1luT2tsVUk4aUtqL2tiSHBh?=
 =?utf-8?B?aDBtV2RDSmdzeFlCa0tHU3NKVjhKRDJ0MS8rV0ZKeE1Yc0ZsdHZ6TTRKblJx?=
 =?utf-8?B?aHdJckdzc1VsZGNVT205cjBjTGRxdVVxeGxCZ0d1My9kaFNKREwvdmVncFNa?=
 =?utf-8?B?ZUc2MHpZY3pKMUFRUVo5WTBpbHkxQlFiSk9DRUdPRWJCTEFkVkZ6TzNpUGhs?=
 =?utf-8?B?d2EyWGxCa1N5ejVqbE9KenlkQW1NRit3eWZTZ1ZTV0Y3T28vNWFGZjJtTjBM?=
 =?utf-8?B?d09yNmhtWW9hT2JuazNLRWlEOEg1TElFbGJqWG1mV0oyd2FHaUkyTzY5RnZL?=
 =?utf-8?B?NkFMNlUxUHBHSTNXY2JoVGNiNURoOGNpeG5WNDVrRkNrOUdvajBXN3RPMzBZ?=
 =?utf-8?B?OVBlVWE1NDJaaklPaVFZTDd6QS91Z2M0WWZZcFVnL0RwOElHNkdwWXp3VlA4?=
 =?utf-8?B?ZGwxK0hMU2IvcTVRYndFOFpYci9nOFczdGw5MkphZlJHZm9DMStjOUQ0OE1S?=
 =?utf-8?B?aVUxNEhKSFhBK0xDT3BWN1ZuQzdEbVpSWmROcFJpWEhkd3NSQXNKVVE3aWwz?=
 =?utf-8?B?dG9jTFF2bU5XVjJyVmlPRUlNVUUwNGszRkp4VnczbkJibUFqNE5VaEdFcVFC?=
 =?utf-8?B?dlNQZHByRW50MDJwVXk3M3UyejlDMXQ3NURxcjdmUUgxV1lnN1hmRFk2VUlu?=
 =?utf-8?B?a0ZGa1E4Nm44ZWsvRlVZUEtIZ1d0Q1dwRFZIQXdUUjdTd1RXeDFaQXVrSmlO?=
 =?utf-8?B?Yyt6blNqNHpGMFNQSkYrM1lvdS9wOTZPUW5OQTNkUVRwRHpSdWxXKzg4TnJr?=
 =?utf-8?Q?EKJ9yhc1QEguLOCXWdEqBIhy5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qDfmZddMXfPT5FXY7r/gP1I/OuVnNspRYb8pWxKefaeznSKmA5wnuI0NOTvNbIr9dHwapZKCjpyChzZxXy5gmGzqc1e/vDqmX7EOPUCYn5N8+vBkazYtn1cdkB6hp6uaZfwtlaTBDWiIoXg20JeQZhDwyzVNSYd2XaHdDfoGEErAMYWZioo5pWh5VEDrbEyUVBiv9DJAP/UVA64vEA04XAOhj7DTf7ObK57MpCrbDlrufynqmj05i99GiCxn+rUTIwJKDP6ntVSm0p41ppQyR33d7VwNbE4oiccCQtLb004I6EZE2q691JaKfo7fEPVVqv6QxSDAYX+gP15CM4ShYAOgLO1dI30IJko/WoKkZ+fha+smhanKwRs8l75XZ8AUg6Vt33/TL8Nw2I3IqumbafyySx0UgVhUcYIxdruBh6AViw4PoE9k4DWFpWJuvbqvvN3l7AXm0WwuBROgym9XsznLJDGezYKUcYgXJXRXf4UaDTxCkiNIjIQGmNRZW1dLd2k0TGisGR65gwBqF2QHxH5CwDL5r7AeyGL7NaWkuwy3x+CJiagY9GkEDlMGnXhJdSxWPbMWhrDWN8dh8FFW3z0wcfr58BRb1P3vJBuOq2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f903fa3f-9528-4243-ff3b-08dc3ebf7f21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:58:57.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU/I232OhjpcZjYJ75nFBetlD8UWVPnLT/7Ff8yApbOT+8FeTEAxoWtT9bGSHH6QkdEl1RuiOknSuHT3edY+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: NPN_rEVwsYI4psPES8pG6WFzL0zVImI-
X-Proofpoint-GUID: NPN_rEVwsYI4psPES8pG6WFzL0zVImI-

On 9/26/23 01:48, Alexander Aring wrote:
> This patch adds fcntl corner cases that was being used to confirm issues
> on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> implementation and in those corner cases issues was being found and
> fixed.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
> - move fcntl tests into one fcntl c file
> - remove ofd and same owner tests, should be reflected by only one test
> - simplify commit message (remove testname out of it)
> - add error messages in fcntl.c to give more information if an error
>    occur
> 
>   src/Makefile          |   3 +-
>   src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/732     |  32 +++++
>   tests/generic/732.out |   2 +
>   4 files changed, 358 insertions(+), 1 deletion(-)
>   create mode 100644 src/fcntl.c
>   create mode 100755 tests/generic/732
>   create mode 100644 tests/generic/732.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 2815f919..67f936d3 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>   	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>   	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>   	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> +	fcntl
>   

Please add the binary file to the .gitignore.

src/fcntl_lock_corner_tests


Thanks, Anand

>   LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/fcntl.c b/src/fcntl.c
> new file mode 100644
> index 00000000..8e375357
> --- /dev/null
> +++ b/src/fcntl.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> + */
> +
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <wait.h>
> +
> +static char filename[PATH_MAX + 1];
> +static int fd;
> +
> +static void usage(char *name, const char *msg)
> +{
> +	printf("Fatal: %s\nUsage:\n"
> +	       "%s <file for fcntl>\n", msg, name);
> +	_exit(1);
> +}
> +
> +static void *do_equal_file_lock_thread(void *arg)
> +{
> +       struct flock fl = {
> +	       .l_type = F_WRLCK,
> +	       .l_whence = SEEK_SET,
> +	       .l_start = 0L,
> +	       .l_len = 1L,
> +       };
> +       int rv;
> +
> +       rv = fcntl(fd, F_SETLKW, &fl);
> +       if (rv == -1) {
> +	       perror("fcntl");
> +	       _exit(1);
> +       }
> +
> +       return NULL;
> +}
> +
> +static void do_test_equal_file_lock(void)
> +{
> +	struct flock fl;
> +	pthread_t t[2];
> +	int pid, rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0L;
> +	fl.l_len = 1L;
> +
> +	/* acquire range 0-0 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +	       perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		pthread_join(t[0], NULL);
> +		pthread_join(t[1], NULL);
> +
> +		_exit(0);
> +	}
> +
> +	/* wait until threads block on 0-0 */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	sleep(3);
> +
> +	/* check if the ->lock() implementation got the
> +	 * right locks granted because two waiter with the
> +	 * same file_lock fields are waiting
> +	 */
> +	fl.l_type = F_WRLCK;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1 && errno == EAGAIN) {
> +		fprintf(stderr, "deadlock, pthread not cleaned up correctly\n");
> +		_exit(1);
> +	}
> +
> +	wait(NULL);
> +}
> +
> +static void catch_alarm(int num) { }
> +
> +static void do_test_signal_interrupt_child(int *pfd)
> +{
> +	struct sigaction act;
> +	unsigned char m;
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	memset(&act, 0, sizeof(act));
> +	act.sa_handler = catch_alarm;
> +	sigemptyset(&act.sa_mask);
> +	sigaddset(&act.sa_mask, SIGALRM);
> +	sigaction(SIGALRM, &act, NULL);
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* interrupt SETLKW by signal in 3 secs */
> +	alarm(3);
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl interrupt successful but should fail with EINTR\n");
> +		_exit(1);
> +	}
> +
> +	/* synchronize to move parent to test region 1-1 */
> +	write(pfd[1], &m, sizeof(m));
> +
> +	/* keep child alive */
> +	read(pfd[1], &m, sizeof(m));
> +}
> +
> +static void do_test_signal_interrupt(void)
> +{
> +	struct flock fl;
> +	unsigned char m;
> +	int pid, rv;
> +	int pfd[2];
> +
> +	rv = pipe(pfd);
> +	if (rv == -1) {
> +		perror("pipe");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		do_test_signal_interrupt_child(pfd);
> +		_exit(0);
> +	}
> +
> +	/* wait until child writes */
> +	read(pfd[0], &m, sizeof(m));
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +	/* parent testing childs region, the child will think
> +	 * it has region 1-1 locked because it was interrupted
> +	 * by region 0-0. Due bugs the interruption also unlocked
> +	 * region 1-1.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl trylock successful but should fail because child still acquires region\n");
> +		_exit(1);
> +	}
> +
> +	write(pfd[0], &m, sizeof(m));
> +
> +	wait(NULL);
> +
> +	close(pfd[0]);
> +	close(pfd[1]);
> +
> +	/* cleanup everything */
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 2;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill_child(void)
> +{
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill(void)
> +{
> +	struct flock fl;
> +	int pid_to_kill;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid_to_kill = fork();
> +	if (pid_to_kill == 0) {
> +		do_test_kill_child();
> +		_exit(0);
> +	}
> +
> +	/* wait until child blocks */
> +	sleep(3);
> +
> +	kill(pid_to_kill, SIGKILL);
> +
> +	/* wait until Linux did plock cleanup */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* cleanup parent lock */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* check if the child still holds the lock
> +	 * and killing the child was not cleaning
> +	 * up locks.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if ((rv == -1 && errno == EAGAIN)) {
> +		fprintf(stderr, "fcntl trylock failed but should be successful because killing child should cleanup acquired lock\n");
> +		_exit(1);
> +	}
> +}
> +
> +int main(int argc, char * const argv[])
> +{
> +	if (optind != argc - 1)
> +		usage(argv[0], "<file for fcntl> is mandatory to tell the file where to run fcntl() on it");
> +
> +	strncpy(filename, argv[1], PATH_MAX);
> +
> +	fd = open(filename, O_RDWR | O_CREAT, 0700);
> +	if (fd == -1) {
> +		perror("open");
> +		_exit(1);
> +	}
> +
> +	/* test to have to equal struct file_lock requests in ->lock() */
> +	do_test_equal_file_lock();
> +	/* test to interrupt F_SETLKW by a signal and cleanup only canceled the pending interrupted request */
> +	do_test_signal_interrupt();
> +	/* test if cleanup is correct if a child gets killed while being blocked in F_SETLKW */
> +	do_test_kill();
> +
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/732 b/tests/generic/732
> new file mode 100755
> index 00000000..d77f9fc2
> --- /dev/null
> +++ b/tests/generic/732
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> +#
> +# FS QA Test 732
> +#
> +# This tests performs some fcntl() corner cases. See fcntl test
> +# program for more details.
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_test_program fcntl
> +
> +echo "Silence is golden"
> +
> +$here/src/fcntl $TEST_DIR/testfile
> +if [ $? -ne 0 ]
> +then
> +	exit
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/732.out b/tests/generic/732.out
> new file mode 100644
> index 00000000..451f82ce
> --- /dev/null
> +++ b/tests/generic/732.out
> @@ -0,0 +1,2 @@
> +QA output created by 732
> +Silence is golden

