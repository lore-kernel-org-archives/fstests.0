Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC2AC4338F
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Aug 2021 01:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962DA60FBF
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Aug 2021 01:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHMByr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:54:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63968 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMByr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Aug 2021 21:54:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1q3TX002486;
        Fri, 13 Aug 2021 01:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VetHrNyU9AeZgH5YOnigdokqfkHBc9i67QC/utYXBs4=;
 b=o0Xoj5zmaV4O8BgsSrGNSe5gdKJ1TGq8y9uMUjmC88MmLDoM2EmuGn00pqrkZa70rpFU
 5MoHhoNIlfgeeeA3whjZuy3v49UqRpjHSM/f10nvfAPEIwH8yRXVRNy5KNliRZRZb2Bd
 Ynjc6qo4qjo7jNytmGHpgGzs08WQU5kispCDNuWroAfDURN6zG/1vc9wuPNtyRXZj+uh
 tyE5CYp9J0tvSHvhhlpjThTSl/UY+hbqJc6YS5cBuoDO1NAua/Olk3P3j4fBFnIpxVBl
 gSwK8PmdX2+4a9J4FCWiEDeQc2a2Rc02qubdedhnl4uvXqQVK1fFMchX+WF+ApbIk0xb Yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VetHrNyU9AeZgH5YOnigdokqfkHBc9i67QC/utYXBs4=;
 b=CnVof0xDl8vYH+siOESwf9Haj6UHUtMaqAPKD+FQV4UCrdRMx3KzhUgDG9LYy/zph3Tx
 6AjZ8SLzBkxhMHKe3s6Yn/7KgzV8wsg6B3VeJ80St6+eJt0BIHyVCEZcyZo1VE6krxZn
 ip09fiEpvqBGMVVcJwhGKczqIAWaWBf9s8B7dHwypD1Vz7GoAm8vCOx8PuUIg9GLkche
 fsF+fyT4qMja8kPYTVK6/9nLIYeOQsYaj8UV2x/ahpBK5ALz7CR0AEnMhvUR1slxxTwS
 ftt0fkUnmgQUM59WYB2P7mNIec+il63JjhLXLH6pY51G1ayNhBVg8+uKF1iMt+k48dFf sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajhqcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:54:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1oPOl092188;
        Fri, 13 Aug 2021 01:54:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 3aa3xyemnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMpzxziaZ7lCuI0MvfAh7tGGZNrhsxfAMe46IuaXvNU7lkpS5S9sH4i5YLiH+xWIqvNQsk3CRfUlBTTeAxOGqjud5+l/u4R1Ifu2Tr0uNblFOwJqSUvKcUhZCtqebv4nq2cz3OL2Yu5jlwCq9pQxGCBk/a62AA55THkn1hxugxNUFQiCw0xaNcpSsz+C+rQHdRtzVg9Wzw3nIlDvbPESyY/8DHqQP+jT5hShvsmDlh5yrJI477IGp/eS78XGJGBpJ0NCfq06y8DtOMyDfbFiolgZ0nTwa+8COJBRFydQjlOuFNJxoddkT+VCy6Tx72CgSUWqcmB4PfQH1TwY0o6HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VetHrNyU9AeZgH5YOnigdokqfkHBc9i67QC/utYXBs4=;
 b=kSNcCHC6Y7VDWWZr1zRXdYAQRoGopvVFQTiWfNzONI6ZkdQI18jAoFmUiua3iGzIvXqd6OIODXYRYzkh5GjZ5Oxy2SHdVnLHw4bcf9I0ITuO7AYUFPxKBFE03ODar06TWxAP2Q6sbv7acl6t7d5ERluroxv3JX+NDzZIPBY7CVG45niPPtle55VpO+0h9VBp1rxZJ1ZLcyaEFiEBR9N9UlfuSYh6TOnA4IBSO1MB78H2FvmsWYocRzIs8/jfgfBsssp+phOzlwCkvEy79FUDseQ19ZoirDcPYj6/0a5vCAp5TEc/BOBXqolunB8Y/m5b8jIpS2B2kNsqWPiU9yRlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VetHrNyU9AeZgH5YOnigdokqfkHBc9i67QC/utYXBs4=;
 b=ccV6f9Q0P7ew+alFRCxnBDC5lDQ/iam1WlgKyuku1oVOdsoOBFDpRwN+v6wl3hA7o60GSFVQI5Myr/DdnQxVDiyvFL9qbeQyZZxwrmi1cdLvHJzxmtFINMrGtjza3GbbeJNVeQsp7FxRGQf5iFM3vD+LSF62f+3zXC1CgBOaVgc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 01:54:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:54:06 +0000
Subject: Re: [PATCH] btrfs/220: fix clear_cache and inode_cache option tests
To:     Boris Burkov <boris@bur.io>
References: <409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io>
Cc:     kernel-team@fb.com, fstests@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <eabe03ab-14d8-0fe4-61e9-1557dfe3f6af@oracle.com>
Date:   Fri, 13 Aug 2021 09:53:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 01:54:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bdd927-34e8-4753-e664-08d95dfd3bdb
X-MS-TrafficTypeDiagnostic: BLAPR10MB5137:
X-Microsoft-Antispam-PRVS: <BLAPR10MB51372610136E94ED74CECC85E5FA9@BLAPR10MB5137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: con8+Awrdvap0ZCk9kaxPKhy4LcqK3mVAaiLFJnG8sVJDgwSlDvOV/p28U904UVhRJyHttAiRR5nWyBVLlHe1DVxPzs/X3ysXOzTGLoyEpHmSKqA+Bg99M41MNjyd5eNM2DU+uvwPo3biMN1ZKoBcWDQ5jqFXQag1bMMpz0GQwMUksR6lxlgwh6RKuy3a1vwhXXh1EG96CrGf5psldhSdfEN8SE86FLGk2DQ2SV3vparePwx+aY5SRB8+ZxrnzUXZOEoYgw78CD5bOFza1ud5Mlq1S0AcwO+rqH6kCO4O73Pz6aoMnWyktEgsVeONPsByS8XSY8URNCtEAbHdZWv+XSs2Ur9uJ8/hpGlfFem7/9JoYiufGdVFd3RJMAniwrxYQnukLWsozjPZNkP3pQu00r0+ivaiwSvYG84gVaJ6sCabidKEe5l9U7YBQrv2jUufNqFN2S03tUIVBulX9ZA26WEGurM/i24WCAM/G2YNGku/I7z9KGIMnTA3NAegilHiFc5MT5iPOYy5f+vKMbA6iwjmQzKAuGRsmHjLlZfJCFqB9phBNx+ME2DwDUEcdtYgqgjHWFbYANh2N38K7fd1gNugL+vzGb1MLBZOGeVUTknqMqohbiaJKb7gKkzrjkaGIWKEz2KeXMd0JzKZvG04LapuQZzkR7T9VW9t/rRCN+1goAdFek1PiSnlMrQqTq0L1po/7jzFw2WIq0V3QiXuxrmXANamPl4BHX2yMCq0Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(66556008)(31686004)(38100700002)(6486002)(6666004)(53546011)(4326008)(2906002)(2616005)(8936002)(6916009)(26005)(186003)(66476007)(16576012)(83380400001)(8676002)(478600001)(956004)(36756003)(31696002)(86362001)(4744005)(66946007)(5660300002)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q24xb3RJSFJKQ1V0NSt5ZjRGTUZIZnJlSVF6aHhWOXIyeUg3d0xkYTVhcDJx?=
 =?utf-8?B?dzkwMzQ4VWFwNHZscURKR2Q2a1ZuUjJnL3FOUHltTWNackwzeDFUVUJjQTl4?=
 =?utf-8?B?T1ZvQ1U0VWNWRkxnUURiREpnaFpHNTBxN0MwOFExa3IxRXQ1RW81MEMxeU84?=
 =?utf-8?B?RlJIQjM5eTdPNmpMZGtabkxlREdKdjJkSWovNUhEc3BrM0NsQm9rd3pUbHI0?=
 =?utf-8?B?L2Rzc3VLZWY4cCs1WEVYWlVrUk5kN3lCcFFOZ3F5T2tqYnphQmhraE5Bc1ZK?=
 =?utf-8?B?RXY5Y3RXci9lcFRoejNtSkpPSDZ2L0kya25laXNzM0cwa0NmbEx5Rk9XNkto?=
 =?utf-8?B?Y2FIZnUwQndVcUVRSXkyQXZZZHpWTE82VFJpVkhCRmdFdmlPaVZWRzBKM3lP?=
 =?utf-8?B?MlVsa1RSaGNLVktud2FZMHV4OGpyTkVUTXNlZFMramFvVGFxYkY5aHczYTM5?=
 =?utf-8?B?M2tKN3ovM3hBVHpuWmhHc2VYbnZPUythdUZrQktQWXAxMzZqS3dBS3YyMlpj?=
 =?utf-8?B?VmYvUDNXU2JPMVZWaG5XV0thaUpOTzI0MTJFMTVoRWZNUG9JS0x6NmFRayti?=
 =?utf-8?B?WHdwWW9XK2hhcXN6a21nV1FuY1FzU293aVEvQm91eXRKV0JJaVZlN1M5cGI0?=
 =?utf-8?B?aDNzN3lzcTdoN0lsM1dzRk5iQUVPVFRnNXBnWkYxTUVCcHVZdFdtdUp6dnIw?=
 =?utf-8?B?VkpkM0xqMGxldDk0ZTVqWVovSFBsTkxvSk1hMitoOWZpdFY5WkoyL3ZwSXcw?=
 =?utf-8?B?Mll2M1N5OWJoS1l5dUpGRXJyRVk5bTY2UVVJMmZVZDZoMTlTQ0t6b3BnQjJ3?=
 =?utf-8?B?eWVGbkFnd1VWUHBucGExUFB1RUlab01FMUtabGVDZlp3QVFoT1cxbHRQS1hM?=
 =?utf-8?B?UXlkQjdqS1J3OTUwQkxQVDBFazQwR0xVY01TSXgzakVwbkljRmNaeXNXQ05v?=
 =?utf-8?B?Q0pxN1VrL0xTZThBazY0QmZqck0valhlWU1kU3pjeW9DR1dsWmxCb1loSnlN?=
 =?utf-8?B?N3laZUhlMUl4czdLa1BDUFppd0FFU3VNSU1CMk9BaE9JZkxwUGZFWjVoZEZJ?=
 =?utf-8?B?RmNUNWtGQ1h4a1AraWsyeitqYTEvRTllS1JSU0N4UnJwcFlXQWdzLzZvU3o5?=
 =?utf-8?B?WHZWd2tXamF0V1g0eG9zcWllNnN0QThibGd6Njg4Lzh6YTRjL0M1cDhQZkd6?=
 =?utf-8?B?ZzB3Ymh1L3ZQVk90OEcvS3E5MEpZNW1lTzQyNExJaEtuS0l1MGxDRG9sbmM2?=
 =?utf-8?B?ME9vaWIzMWFHNk9nV3RPeWp4U3VnamJoUXFsK0xuRStFWWxuYzN3M0dBelhY?=
 =?utf-8?B?NFRaTmZqeXBuRlMySGw0NUMvamtuOVVJYXZGem5GWXpRU015cE5xSDFROVlQ?=
 =?utf-8?B?ZkdDZmFJYXJVNWNVL3NWdENSU3d6KzNnUUsvaUl6Zlc2MXA3WDZSem92OE1m?=
 =?utf-8?B?M2tXL05wWi8wS2NkYnExMHRQYW5vck83REgwWUdEZU45ZldSb0x0a1A2VUdq?=
 =?utf-8?B?c2hSaTJ0cVowSHpwcEc2N2xhVERPVnlhUDY0M3ROblpvbXRFY1BVMlRpV1Fz?=
 =?utf-8?B?eU9zaHBpcU5VKzU1YTgwZ3c1ckhDam5URHRFSUQ3Rk5CQ1ZVZGVheVN0aDVt?=
 =?utf-8?B?akVPYXNNdkdIUTIvYUthZFJyYjRCVXBVRXlpdEdCWEdLYkJNNGNON2FNaFJ6?=
 =?utf-8?B?QTlPd05yM1FuNXNMcENiYkRERkEwMldKVGY2NVZNbTNIb0RIVUJ0bDNLaDhq?=
 =?utf-8?Q?7zRoCdwg1ojc8v/hYGoa5AgaLi9YEJ/gqzzx4Jf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bdd927-34e8-4753-e664-08d95dfd3bdb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:54:06.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0k1daODRGVRUdzqb7xX3kzOB8wSVPOHTCdrIAlfvkbKu4avG9D5AbERSpja0GPrHduJISkB/ApuatNI+/hQ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130009
X-Proofpoint-ORIG-GUID: 3f5I_u04xAWhBcI_w5_kHe8OLwLJyVPz
X-Proofpoint-GUID: 3f5I_u04xAWhBcI_w5_kHe8OLwLJyVPz
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 13/01/2021 05:17, Boris Burkov wrote:
> I recently changed clear_cache to not appear in mount options, as it has
> one shot semantics, which was breaking this test. Test explicitly that
> it _doesn't_ appear, which properly fails on old filesystems and passes
> on misc-next.
> 
> The patch that changed this behavior was:
> 8b228324a8ce btrfs: clear free space tree on ro->rw remount
> 
> Separately, inode_cache is deprecated and will never appear in mount
> options; remove it entirely.
> 
> Signed-off-by: Boris Burkov


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.
