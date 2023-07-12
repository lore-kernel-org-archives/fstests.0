Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801EEB64D9
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGLHPt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGLHPs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 03:15:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC0BE
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 00:15:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6bEoE018444;
        Wed, 12 Jul 2023 07:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tuj7dawJAhOt9BRV2bL7++IjIo7b4jbomITDTzWc/WQ=;
 b=Lvama1oinsbynptQQxUvsK5C7tTGfiHXT02FZLpiKlRZlX3/gEjSDcmZuwoDEV0K/Kb1
 cSA/DUmZ1sOA9U1QlGiYHJEyGR6akBtQROyN/9Fnkt39oDEEjcXNxqWnXxBeCWFKSZMZ
 as1wBfIV7ZFi00/DQ7p84lqAlMbLQlQoCE8fZMfWrRF9TvhyQJp04aCOvWHS7jYF7DzJ
 m4LNiw4u1lsV8eGpJXhoBxAaQ4jYGnJVAfZCI9+5LCZUeRos5YFI3kisSp4E/pS1H2+D
 ayr9rKBK4fc6y8MNd78olevC3vn7RrzcJiaiuCGMyDqOXRk08JZGe3ycNbbCbUVYor5Z 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtxjeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 07:15:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C5Tfrg004415;
        Wed, 12 Jul 2023 07:15:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8ccv8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 07:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goSGwoc2Rh2k7Pv9uPwBllAd8LDpP4NUI8cj8FLiEfcYFQfga9kJ8XrLrHGuuAzr2jH0zrmimxiC/w8/6NSZOB0vs8ALSqT2Xdoc91cIqqxBCR0ykU4g5cTyXDv+07420Gs/75CTUFkIaNjowzAdTecSSZxwaJMevTYMzr4D0db6HcNA/iN8LtI37r+YZ2SyQs+dCAhFUVRQussT0x8c50dOkiFZXH9u+GPU+7Zn1larcWrNNQr+drIIy+yrUB72z5pok3iOZq7oLNcTw44c6J973HkfYy+5wQgHVVvlLCqm0QGTnUkTUMJqW7sY2CMHr8b6mTvX/7LJtmMysHmTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuj7dawJAhOt9BRV2bL7++IjIo7b4jbomITDTzWc/WQ=;
 b=RXUBC3sSpWbHcrrQlt2B9jkkrH/KT4CMLELMSXom902XdVElF7qAGrY9Ko3902QwPBG4XSDqIty1b4+mHTlpXOQwkbs1CgjuRhPw1YGwUamSI4eDqeotfuX32Sf/p+A0f8qIKD1juZp3pjihnNQ5R1oYORHjT1u3VhniRl3JslnFIm61JSndNC83NDkzEdRlU1nB3oilX9c+WV/qra5vPkvVirPG+80ThNoc9eRkJwaxIxInClEoRhAsSgXdaF8MnrbEIiL1R1LDWTwuvgWY8h2TRRBQBwIb2nsY9iu/j0YwwHzgBBjV0ydofzycKe438Ib3ojL4ZB3DRQrxoBek1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuj7dawJAhOt9BRV2bL7++IjIo7b4jbomITDTzWc/WQ=;
 b=hiQMFv+hlVy8ADukwNixmnBuzgy6UQxO5kuHG5h/N3F1rTSOoasiVxiH++axLJy5qj0oFOXoRovPTjBZigt9efLvKQIIqjDE4IXQYFYVW0nvUg/Iw6l+ZKo/fiDoxH40LGSuZsaVyPn2nMYek0uzEhJCxSJx/je1P8uT46dFU+8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 07:15:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 07:15:38 +0000
Message-ID: <f6365013-ab73-5b2b-6dba-3b628dbe1b56@oracle.com>
Date:   Wed, 12 Jul 2023 15:06:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>, gost.dev@samsung.com
References: <CGME20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0@eucas1p1.samsung.com>
 <20221216105750.28493-1-p.raghav@samsung.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221216105750.28493-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bfaf81-b474-47ad-bcee-08db82a7caa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GZp0dxrJvM26lOLE9t2lnTmdMik/YWCDV8XWPL+cPPYkn2JhRFmIvB6bjFfm8QyyfkBto/SZHfAkJV7NKTyKj1WckY47/tZSjecTWqn9h4cgWtXy+2q4zXB67bH5dW48YGUyx+fVPxZmAR2DaYlazx7u+TkjWNoIqdZbkY73wiQLeIOcEisfpFtxnLmD8c1WFVbXt5ciOCieWItXWnQeHEeXiHev/qeJfNW1PNPgAgT+BBlb4VIvVWipB1Tkw6U0N2cM2k53B8PIzn6sMCb9+DPDE1/459OrFB1ca/Ng8dS/vBCRhBXqHFZS/QOXbtPtiiCWxczqepqKVO7VgHKMSiRH9Gvtx6vspMnEcZZUJRylblrN3AO7zNdj/Djhjz0x8wMdOUGoPXApV9r1vcfH0+4XNIzytqRkEBpk3SEMlldYD6VUl8J3WG28OLT+SFL6LdmY3DbBqF1Os0K3oIpYbodCVEvBauO65/Mv+kpbF1lV6obbfkjeEEo9Gg9rOCL/fJEUYPJSq7N2Ug6SHG2zeuWir+wfZIJbyeXtY5YxVtqKFOBs7VbEG0OIzUDblgyIA38/UdwsD/YLN8E1+I8jQrk7Cu8x1s+WkLsMC0Ijcl0CwKn6ZRGn0pdbijlMKGRU5qN6091lTikwU8ihCBbEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(26005)(53546011)(36756003)(6512007)(6486002)(316002)(2906002)(41300700001)(4744005)(38100700002)(66946007)(66476007)(66556008)(4326008)(86362001)(44832011)(31696002)(8676002)(8936002)(31686004)(5660300002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05pUUN1bU44WW1md2lpYVgzQm5oN29tYWpISVA0SG1xcUdMeHl3cGNGUlJB?=
 =?utf-8?B?QnI2WGdOOFZRbFQ4Q0VnL0wva3E3NG12RGpIcDF0dlprM1h3eUhFcFNNT2Rk?=
 =?utf-8?B?T2g5KzRhM0dyNHdvKzZJSnBqblYycnZoZEtjU2hHbjNiVzNVSDdHMmNYd2ta?=
 =?utf-8?B?VjhOVnViWWhOSHVwVWRXZU41UkpTVkwvTERxR0F4NjVwNjRWcVk4Z1NKSjV3?=
 =?utf-8?B?Y0ovQ2xFS1VxRzg5NE9Ec3FvSW1FUThVYjdkUWFMMUdEOGloOTZRL3VCK0hp?=
 =?utf-8?B?N1B3Mnd5Vlk2L1NHUnExMjNvNGRTNytaNmtGY1FrYm1uVzJCTVdOUGQrS1pQ?=
 =?utf-8?B?VEZ6dlBVYzJaQXlwaXplR0RxQTNzZEEwbU9PNGR1amtTMGcrc3RHdkZtMGhX?=
 =?utf-8?B?TGRnTHlXclJHbHMxV1Z6TC9PbjZRYmRZaHhuT2NpN0RmdDhRWStBclFlZUZ1?=
 =?utf-8?B?ckxlS3VHTXR1SXNBMDJLVGRrU1F2OHY0c3FoTEpFUmlXVkdYM2dKdzJzUUxZ?=
 =?utf-8?B?d2hFOTVoYS9TSHFFM2FrWG9nVWNZOHhYRjd3UFU3RlhlckRJeFFKejgwVldZ?=
 =?utf-8?B?dGJSTDJhSlprL2hlaEtiaWVmYmpUclNZME9Yd1J0MDRNTHRwL3FyK2xMTFBS?=
 =?utf-8?B?emdON1ZoOTdoc2xaWDlHWWRFWnp3bVlpcDljc2xCREtsT1Nxb0FhelN1MHEw?=
 =?utf-8?B?bnZ1VmJ4T2M2dERKcVdLbmZNaUNaZjJBUWFGVWx1czVyeUk4Q3FTOW5lSExo?=
 =?utf-8?B?cEFWRkZHYzB2N2hMMEFJY1hzZ2hQcmtkV05vdGdKeC9VdHI4c3FKQmVsNmhX?=
 =?utf-8?B?QzlORHlDbnZzTmVNYVY5c2xNWjNhblRGeW8xV3lzdDNQbmVlQUJYcWtTcHYy?=
 =?utf-8?B?eFNCT1U0VDlNQldaSU5manlhWldZS2RGem0wMWV1bkl0a1VnQWdleXVGREh6?=
 =?utf-8?B?SkVkKzFWNWhYUG1kS1B3Vkd0VHFTWWd0ZHRiV0ppQUMxb0w4Sm96WXpNclZv?=
 =?utf-8?B?MFRqZkVxcUR2MWNYdi9zMmh3NzI0MkNldkRRRi9kbkNYMTNkYzhSVjhTTkg2?=
 =?utf-8?B?aEpmRVFiRHZwOXZKdWl0Umx5M2tEb0lxS2VvMGpWZUFGWHNtSDdwOFgra0pG?=
 =?utf-8?B?VXF1b1FkdDV6UzVYQ3BIeXpuUFNRNEZQekl1YTJwS0tLRkdwL01TbkJnQnlB?=
 =?utf-8?B?dGJ4Nml3NFZNeVhPSStLV0hQcTRjV01Wc3NYVW5RUnRGRjEva2l6aE83WTEr?=
 =?utf-8?B?UDdUaFluOEhvbjZZN1NodXk1S3ZvV0xRcXdkSXprZzZaak1xZERKTy9scmx3?=
 =?utf-8?B?ZnIwREtVQXJDSWwwbjR6ekFvNThob3NRdEczZnhVbmJaeTBZL01lWXVMaXdB?=
 =?utf-8?B?bzF2Y2JRMzRiVE5aM1dBV2pFK2p3NTdhWjJXa3o2bVNZb3RiTFJXUllrVmVO?=
 =?utf-8?B?UE5taDhaLzMyYW1wUWFONmNvdDgxTllRUklhSktHVStUYkl4dG50QzB2Y2F5?=
 =?utf-8?B?RkZhQXQ2cytIYndIWkJHaTdZczNIMlEwenNIaFdCNlI5TlJCOW9TR0ZicjNu?=
 =?utf-8?B?SkJ5ZENkblY0eXUzMDBrNHlxWTNnRlRYN2dJditaeGorK0VIRjRTRVFtRDVM?=
 =?utf-8?B?TzlmcXc2eStXQzRqbldTdXlna29FbytqRXkxWnlmSEVFcHl4cXUrWXJFYnZ5?=
 =?utf-8?B?VWVvbzRtcUFYK1ZLWi84emp3c1liRzZvbXlySUNWcWFGVnVIbzhHdGtzb00r?=
 =?utf-8?B?dmxld1g5Ly94TzJncmNJdTNMaEFUZlFaeWlkQmhzQng1RWtSa08vV1l6c0M3?=
 =?utf-8?B?dFpHQWRtaGh5ejN5RlpnQWc3VFFldmR6WDNIZXp3UVVtRTdwK2N3ZmgrYTE4?=
 =?utf-8?B?RDNydHpQQ1BnQlV2QXBDN3VzZG43cktPK2M5aGpUWm95Y2Z0SGI4TGlnS3g0?=
 =?utf-8?B?bHBUZm5pSmtMb3o3M0k2TWVSRERyVlVJWko1V0NNa2psWGNWL2lVOS9pWCtk?=
 =?utf-8?B?Y09LWmJwMEdHS1dia0RiOFd5ZE9tdjE0L2RwajBJYnAxMS8wSjZiVmphRC9N?=
 =?utf-8?B?ZnVUbzlDVHJ4Sk5rb3lsNmI4bE13YjdyT0F6ZXIxa1k1dTl5dFRNdkYzS0ZR?=
 =?utf-8?Q?ubHyd3r2NHXe3M0js5M0VQX0a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +PZG0obeKEl6rDU3A/gu0tNRJrkHVeyPp8CmbJgeghXSXGuP9HNrPAJ5vEoWArlBoan+TVYFv0yCKOsUWSGFX8QLwUjetU/fOl428pFM/MnIHvCLHVXs0EWPx63RbC1tx8NSuvNXfK+RangbJ4tzZL++8AWu98FTm/2XIKBxnGnP6UTxVI7AwpNuEbFdp6nz2jf32oot2aGJOejLEMWxLWnP0TV1QOJuXCDc7R6+Fm3WBZ8lTMsGbcuLhnfaNWn97vKPNOuEjjt46MQo3a2k91ve3nFlbVmeT5o4/TVdlcAYNtuIy5pai6FZTkoRA9NLFlWIaa94jqRdnQmwEORqIfMVwEA0OeZbU+ftTRMqOFOUITJsk+pInK5xG5KSrv5v9W3Jt0AvH5EjiZRO2bA3eTDxL/RKNzMelPY40bH+9R4TJiK0FStF/jXZLljHsbuPWp55fM3FScUXTSSeNqFc8Y+ObPBibyn2goEVvjf/0G1W93d3g+8P4q3wjyV+/xD/clx1uaUFj2LnOT7NmVBQrOl2DD/xKbG6YQ6/c2bNELZpvg1RfrJu5UPUnQUkytsiGhqkDZAnnxw1T7eRaDZx0MMS69MxvYyNBc27UHqhseBJiu44kPdii+0E58J7iI0b8ffXNzNt1dfk1AUztT9j5XHD54+8BiZQgZKDHf3rkPhI78qn/hpJvqp7hnTs0yr7FpJ9Y3VbnBnEeftrioKrQj5T5PLIypQ9BM0ONrm32i/Ar7jrHZmiNrDduhGj89G6806xuHk0/4Nh/dlvz3zLU2YQAGf/yYJGhk9e9TCIoJfj7KK9t4Gv2B9EwlhXYV0ArwM5IuKYN5AlbTKVXpd7PTsSZ2kZv9lsmE7CdCCmRwxhoW2ph45urPMDf2xKfrFc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bfaf81-b474-47ad-bcee-08db82a7caa6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:15:38.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVBuQu6HqsPZxtsV+UscG3LeLb3UQ9k36EBJVBxEDQmTWd9wZKBlQSFUA5dHfp2rRxTsNQ1C/6KFLV3aIUzXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120062
X-Proofpoint-GUID: blxaffowfib1mF12X6BQS-lGP7yith9C
X-Proofpoint-ORIG-GUID: blxaffowfib1mF12X6BQS-lGP7yith9C
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 16/12/22 18:57, Pankaj Raghav wrote:
> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
> commit and cc4804bfd639 ("btrfs: skip reclaim if block_group is empty"),
> reclaim algorithm has been changed to be less aggressive, which breaks this
> test.
> 
> The test has been adapted so that the new auto-reclaim algorithm can be
> tested with the following flow:
> - Write a small file
> - Write a big file that crosses the reclaim limit
> - Delete the big file
> - Check that only the block group that contained the small file is reclaimed,
>    and the small file is relocated to a new block group.
> ---

SOB is missing.

Pankaj, this patch has not been integrated yet.
Could you please resend it?

Thanks, Anand

