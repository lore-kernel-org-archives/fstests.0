Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C1BC83F33
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Sep 2023 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjIDGGY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Sep 2023 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGGX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2023 02:06:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3CDE
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 23:06:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383JpGBF008168;
        Mon, 4 Sep 2023 06:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iI2SSwJ597N/bA1HCI0FHNF8jfmu9z4WX71A2az+5V4=;
 b=pTYJrfAhL2qf5+8KLGwhKjE2euEU6Qx0MtSe1hliNzKteEC1V2gYAxEzSJwgILFVYDrC
 k1kFn+aveRXEhrRs9xVyhMKx4ltD7wjVbaolL4f7EqtXOdM4Fc2Ov3m2uMiwRYGY7rJT
 TkjtJy3zw0h2u2uKfOqxltNr+PKE8lnknN2rJamVLGGKSDPGuWNXOvHoE3oxMiW11kwc
 xvsbpihEc5NVjmmrfYcClSv4mQLdMWs38IzayiuLAv5TYGWm58sNFvVHQWYiITxJwOVn
 4eTj5o7fVxqR3JHcWVub4WyRnjyRihf0bD12Q/2XZ9s16N6zBR55D+m5K8+Qpf41N7If 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suw3ctf6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:06:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3843GuSH026896;
        Mon, 4 Sep 2023 06:06:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug39mvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQeRzEPq5CS5VMtW5SfGbwaVkqydHniJtH8HubGUxgx4+RSTKJxntoTe+UXbGPu+WQVkGom4fqAjmi4RYbNMPtXzpkdiC/m1YxS3VWj6jcf6DmW/7hxg0oMfUpU2oyAnAv5I9nSGzgSHszh2MjolRbsD84kddoQtfJJGsjzwZTf/IRJ4Y93ZJFrA1E2vGvBqqimfoo/tGdY19stjR4iR0rMcALWAsNCZt4QQ/YcYu3x9g8D8wMDwIRpJbQRH93MqJUmJideGep4T1UKTCHu4a47X9vOoOj+zXcxl4ZzYkPH9AQXn/cWroqZ78to3vJPg+4WyEk7n4f+cR0ojBox7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI2SSwJ597N/bA1HCI0FHNF8jfmu9z4WX71A2az+5V4=;
 b=O28jgDinPjCZ/RoNM+uX+YeVhfMn4K6PhUQ+wZPtetkyC6xK9AdtNHBBDbJgXg9FSu+chZd+jMzts9XbRVf16OqxeslfQltJDqzs9lyOmItRuf152l9KlSbHy3i+E6SHKlshPovWfnsLCdR/GgO5vcWvrPbCr6dmJVid0iPiXJNdJqQcd4D2kt3tD2xEozUx7F/TZPhv2zzlfrLVAREofVNdo9sxI00HWuiSTPA2j7tv7M6rxQfLp+5VxkXEhEg5I2U1uRkjW1xqJ/jJMi098SrivG/mMEaETqtnEgzAVvycQg/6MHlUUT9O77hhaTAbXAt+qkOrqmj3n44PZpdJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI2SSwJ597N/bA1HCI0FHNF8jfmu9z4WX71A2az+5V4=;
 b=p4Gh8YKDFxvLLgaqUpFglcZ8WKA6611Ncm+mhXPMs+71GL4YHNK3GetIVgtUpnooeGULvLaWF+aBgwITDQ9KAOQYzNpdSt+Fm9xBgOUKGEcK3OAcDwLvmdICD+1gzZalXWAbSL8ZeR1x77MCRGzsndkEwEGNv5icx6l/y9mrCFY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 06:05:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 06:05:58 +0000
Message-ID: <85745478-dcb2-2815-709a-aa9e52184d1b@oracle.com>
Date:   Mon, 4 Sep 2023 14:05:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] btrfs: Add test for the single-dev feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, kernel@gpiccoli.net,
        kernel-dev@igalia.com
References: <20230830221943.3375955-1-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230830221943.3375955-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: d0367df8-12d2-4015-7390-08dbad0d01c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuRzj/o/LoxXNaG09UYVCSMc8brlDctnXEK1UxjwVxtluwKRLyrAnQ48eLuJr6K35SqGfpHFbXYCapS0ob3QqvWPYdfLwYe2+Qqa0EP+Gf/sgW/CL+YMRMbg6uOmLkSg5czAc3ZFG+FG2JM8EYs0E9ioGg/gmYzl/y5fKmsQmjhon6bcHmT0U51Dpl9f3LrkO5bw6BbQqrfwKwPqFaN2e622zbijm46huEv8UDuiIe85jMZSMUA0Ut+67Xt8qD3rWtVMX4GYAeflhciaBc2c7gzdj4PFugZElWb/T8MNw7CDzlPS6ioKezDD/BUZSf88QxPix/BrpUVd7B6vTWwdvGhbViJYyWFWJ4VCWxysdJR+ew4tOXxdWRT5jPduMvey/tFBGG+0yYDEw+28TJNtcF+DeJJAHe9Fv+lWyzYTEhfbp0neRGlGTs8Ao4zejDDVCSZ7Dy4bOoikJ9A5eDDxrqjOIwNlddXTv9F+YMWIaM3wTUluX0yJOGswD6SNDKqCSxDbpuN3eZBN1524l1BG9189rzsnZjtPno+7j41kBXYN2w8f5SHIp+LT498Mkatd9c4nOZHekqdwgKB3Vp9wuSHo9KAIOITBhiTZt4xIz/K37ObjNxlA+G7wH30H8UWZ0CbvcRw5GE8lQdv2NNc4Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(966005)(8936002)(41300700001)(83380400001)(44832011)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(31686004)(66476007)(66556008)(316002)(4326008)(6512007)(2616005)(6506007)(26005)(6486002)(36756003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdIZGFlQS9TNHA2aFNWT04rSzlvelVpL2RhL0JrRXFneXZ1VVMzMlM0YWNl?=
 =?utf-8?B?dHg5eGZmZnc1czIzMkxyNFZrT29rWHpzMk5yM0kwS2JNMklpdjRvMVVIMDgx?=
 =?utf-8?B?cUU3L3lmczR0VHY1Rkx6ZmpRRzhYbGtPRnc3RFhDenJPRFBhK2luak5LOFVu?=
 =?utf-8?B?Z0swUVVCRGtkeWp4dVN3cXZWUkd2eW52aTlIdzVUUTZnRmZGMUZZOFdjbVZJ?=
 =?utf-8?B?Mk5FMnhOeGt2aGRodGdFMDMxRndNYVpIL2JVS1V6b255MFFGSDRiUldoU1Rh?=
 =?utf-8?B?andrWks1enY5N1RSeGlpYzllQXZQWmdsT1VFRkdYb1hZb053ZHFYdjFOU1F0?=
 =?utf-8?B?U3pvSzRJbkpCdjFjQmRzMDloK2piT2RPY3Z3THBtZFM4YkNOMkxySktjMTFy?=
 =?utf-8?B?c2k4em5VdVVXamxBU21VbWZXUWpHenV2eldudmlJclFpWHlEcVY2TGw4TnpC?=
 =?utf-8?B?dnB4YjIwcXZiQ2hCUGtrMlVaKzNsM0x1Z2NiNWxlZzRMcWlmQ2U0bGtTUkZ3?=
 =?utf-8?B?TDZpbFgwb1lkckZLYi9sOWcwYVlxdk9WQ0VoK2lQMHZ1a1pyYmNuOWNPZ3Nv?=
 =?utf-8?B?cndnSHhvT3lzUVJUSTlCc2xPYUltNndraXBSNi9UZ2lrUVRwckxlSXp4b0tR?=
 =?utf-8?B?NGhLY2JwbGxCZ0hhSjU3alV5aDdPdklGOGJtY0ZMd0NDWHBzODhGWGlKMldi?=
 =?utf-8?B?cTlaMlBWSFo5THJPQlJ6WnZNdUNFeExEdEswRzhLc21zRk1FM2hUMU92K2lY?=
 =?utf-8?B?ODhVRlM0b0Q2S0VDL3dpcjY5dk81SDgzeEtnUmVlZGhGT3NXOUVTNlJlR0ti?=
 =?utf-8?B?YmtKcU9kWGRpUWRiMTFyQ3NoOUIxcUx1d3E1eFM0QVYzN2NITVpNaitVZ1Bw?=
 =?utf-8?B?MkpMaDRlMlcra2dzUFZjYnBtK1lOL2ZwTXY0Rmw3bzRpUVVzdm0vdHQxRjhZ?=
 =?utf-8?B?TWtZeUlkTkNhY29EVVlhMEtBVEVUN2lvaUJkZlFxUEZFRVpLUVpOMU9lNlZR?=
 =?utf-8?B?QThsMEZwQ01Yd1F5Zm16WDFvWlovVGVvUE9tQ01TWEpXeUxicW14UVVzeVc4?=
 =?utf-8?B?NEdFcDZCNmFPYzgwVWtUQVVkUER6MzFYb1pYbTFxVEJYQUNlVmE1SU8vQk9F?=
 =?utf-8?B?d2lKV1pjNUhxNDV6RU9iNWFud3RxeDZVTktzYUZrbnRVbS8rNGErdzlYM0pT?=
 =?utf-8?B?dXgweHMwa01KaDNCWkdubXhmTUJBYTNjdy9DUnNiVHFTc3Y0RG5zNm9lUW9h?=
 =?utf-8?B?VmJ1cnZ4U1Jya2xpVVBPQnc4TWw0MCt2eW4vR0VwNVZpd0VzWUNZaXFVUzdi?=
 =?utf-8?B?ZTJmaXRFcWM0TytGTHRzTGhYaUU0M1VkMGo0cHhhZkxnZ3Z6OXBvREpwZGNs?=
 =?utf-8?B?ZE1NZHRuV201bGR0QkpWV0RCUjN3SDUrVStOSW1IYjNvWTkrc2o1dmNvNUhs?=
 =?utf-8?B?aTk1OC9hajFubUlQNVFSZGFPM0lWcXZudDZSNDFjRTFpR3VXM3ZOcDk2WDNo?=
 =?utf-8?B?Q3I3SFEvbHhsMVA3Q0JRRng2VXdYamRzZ3dwS3RWYWtNNW90dlVIb0JwcEgx?=
 =?utf-8?B?Z1BPTjM3cmxwcUozVVBiQjlHQ20vODJSWjdvTWViaHVjSTV4SzBsOUo5YXhP?=
 =?utf-8?B?dWlrY09xdkxNejRnU0NyMG5HNmIvaDV2cHhwbkl4YlppN2VKQTk4UmJjR1dY?=
 =?utf-8?B?eVhGTy9iZHJ1eHNmWnBraTROVC9RcWFEeTdFaVk1Y2tLWDhBek5tK1UzRFI3?=
 =?utf-8?B?SnVTYkVnSGlOOUVSWWxkNVFTaDhqTVNGK3hLc01talA5VTlnd2J6eHp1UXdI?=
 =?utf-8?B?bkNnYkxqczR3MHB4TWQwN3hCK2hVMnlmd0FpSkVHUTZVY3lEVi9EYVUvNGk3?=
 =?utf-8?B?RDlrb2JhMkJEMTFyVFZFMXdWWkY5MGtTb0FCcXVVOVYyczU5dDVXU2d6bWYx?=
 =?utf-8?B?bU92SXBHdkdjWUhXdUxVdnJnaXgyVy9tRDZMcStHYzlLWUNHYmM3VHY0dmM5?=
 =?utf-8?B?d2FsK2YzbnRxMnVFamVPSEdUSjFVT3pUS1hSZmY0V3pRQ3AwaHgxZ0c4dmdj?=
 =?utf-8?B?MDJPbUxpd1dFcjFkdmswOEhRWWJGem4ycHV6cVE3cVVKdjFnVEQwSkNzbXAz?=
 =?utf-8?Q?nJksojsUI8Wg6qHcKfYuOafh/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TrapbwzR/F02k12xNAWyLKCABtbeHELfeVEQ3veuLaxV4q3XRDaPPNWk3E9UCVhaT21LkMrLWBpHpHeS0NZkk9MhssXQI8pFHfv1LcszT4h2EKwtTe3WA7dwCmsG0sRsc4tmFgwXX2t39ORtKbtjxReNury/bV83iYZX+BpixcH4u6WP1pSVaY9xMHn8P5VPgsUWsx8Wy7Pxyi9QS9/6Y4nAUX5YmWJ/goDNVqoZg4SezovvMRUPmYnuI9S7rI58slEfZ0tVpqnV70y6b0NkzFAf/sGcj80m11rbOLRmHOMoXGAA98yeJLelu1WCgyIwBAxxboTWeYthXdC0KzyqRRHsc5SgTeIBMySxc72F2mHiTcuVqKV4e4o43Nvs5L+aqhsJQbRyD23I/vuVAK0kvf4BPgozLUcSY7ywz6CfCfHwM1Ae31WmKMm/GA8uiUHnIAjDpllBCqoNlDcZBzzqY+eUHazmXi4vu3QBxyDqKVBfH1y1FuyJQRobmn5/7OLGhFx1FA/PIVn+eqBJmL98MQTzTJiyHyF47K9mz+ji/3E4MBU/h4Yl6hZHVrxKquA1uGdfdBwA33NbCaSR9hFVOgWYXkK21QEqo3LNelK2p3FXERPfEVyLXYuK5e5QHfaQpgielLLX3fPJda4IbhnoeMAGlFLRnDr5xdZU2+hrLZPEz102ArS6SNLrTr9T3YFw7YwTRSESvymn2BGu0jWBqF5yThOFmUB+ZtqCGR5l29GzWOMaUfNPbT1gWeE7Py/LYtfcvAiFynqLNDA0qUsLAvW2ARtlUcZ6St58HhKZhyrIVgpYpioBtBiuw0RYFR32pg9WqlSc8x9f4cEXODCWMpJCdHUSD4dz6rHvvEB/aaEW7xvPKnL5s+9jCa3yE6ER
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0367df8-12d2-4015-7390-08dbad0d01c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 06:05:58.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQoMVqgLYepI17DIo9Uj29rZASO3CMVNrFRyMWRvMkKCEnvDaLdTbFmZ8c5ZDIJC3kIbeewqXtJJS9G15SRYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040053
X-Proofpoint-GUID: jz_0ucpqmugx2S9ZAyfzOsfdnblIbSJW
X-Proofpoint-ORIG-GUID: jz_0ucpqmugx2S9ZAyfzOsfdnblIbSJW
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



Thanks for the test cases. These test cases might need to be updated as
per the final changes in the kernel patches.

> 
> [0] https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/
> 
> 
>   tests/btrfs/300     | 107 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/300.out |   5 +++
>   2 files changed, 112 insertions(+)
>   create mode 100755 tests/btrfs/300
>   create mode 100644 tests/btrfs/300.out
> 
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 000000000000..120e790906ea
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,107 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Test for the btrfs single-dev feature - both mkfs and btrfstune are
> +# validated, as well as explicitly unsupported commands, like device
> +# removal / replacement.
> +#
> +. ./common/preamble
> +_begin_fstest auto mkfs quick
> +. ./common/filter
> +_supported_fs btrfs
> +
> +_require_btrfs_mkfs_feature single-dev
> +_require_btrfs_fs_feature single_dev
> +
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2

We can use

_scratch_dev_pool_get 1
_spare_dev_get

So scratch devices are set to SCRATCH_DEV and SPARE_DEV.


> +
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_command "$WIPEFS_PROG" wipefs
> +
> +# Used random hash to avoid name collision.
> +DIR_a="563b01de1f_a"
> +DIR_b="563b01de1f_b"
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	rm -rf $SCRATCH_MNT/$DIR_a
> +	rm -rf $SCRATCH_MNT/$DIR_b
> +}
> +
> +# Helper to mount a btrfs fs
> +# Arg 1: device
> +# Arg 2: mount point
> +mount_btrfs()
> +{
> +	$MOUNT_PROG -t btrfs $1 $2
> +	[ $? -ne 0 ] && _fail "mounting $1 on $2 failed"
> +}
> +
> +mkdir $SCRATCH_MNT/$DIR_a
> +mkdir $SCRATCH_MNT/$DIR_b

we can use something like:

test_dir="${TEST_DIR}/${seq}"
scratch_mnt_copy=$test_dir/mnt_copy

> +
> +DEV1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +DEV2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')


A general rule of thumb is to have one test case per file.


> +# Part 1
> +# First test involves a mkfs with single-dev feature enabled.
> +# If it succeeds and mounting that FS *twice* also succeeds,
> +# we're good and continue.
> +$WIPEFS_PROG -a $DEV1 >> $seqres.full 2>&1
> +$WIPEFS_PROG -a $DEV2 >> $seqres.full 2>&1
> +
> +$MKFS_BTRFS_PROG -O single-dev $DEV1 >>$seqres.full 2>&1

_scratch_mkfs "-b 300m -O single-dev"

The '-b 300m' option prevents the below 'dd' operation from taking
too long to complete on larger devices.

> +dd if=$DEV1 of=$DEV2 bs=64M conv=fsync >> $seqres.full 2>&1
> +

dd if=$SCRATCH_DEV of=SPARE_DEV bs=300m count=1 conv=fsync >> 
$seqres.full 2>&1


> +mount_btrfs $DEV1 $SCRATCH_MNT/$DIR_a
> +mount_btrfs $DEV2 $SCRATCH_MNT/$DIR_b


_scratch_mount
_mount $SPARE_DEV $scratch_mnt_copy

_spare_dev_put
_scratch_dev_pool_put


status=0
exit

> +
> +$UMOUNT_PROG $SCRATCH_MNT/$DIR_b
> +$UMOUNT_PROG $SCRATCH_MNT/$DIR_a


> +
> +
> +# Part 2
> +# Second test is similar to the first with the difference we
> +# run mkfs with no single-dev mention, and make use of btrfstune
> +# to set such feature.
> +$WIPEFS_PROG -a $DEV1 >> $seqres.full 2>&1
> +$WIPEFS_PROG -a $DEV2 >> $seqres.full 2>&1
> +


> +$MKFS_BTRFS_PROG $DEV1 >>$seqres.full 2>&1
> +$BTRFS_TUNE_PROG --convert-to-single-device $DEV1
> +dd if=$DEV1 of=$DEV2 bs=64M conv=fsync >> $seqres.full 2>&1
> +
> +mount_btrfs $DEV1 $SCRATCH_MNT/$DIR_a
> +mount_btrfs $DEV2 $SCRATCH_MNT/$DIR_b
> +
> +$UMOUNT_PROG $SCRATCH_MNT/$DIR_b
> +$UMOUNT_PROG $SCRATCH_MNT/$DIR_a
> +
> +
> +# Part 3
> +# Final part attempts to run some single-dev unsupported commands,
> +# like device replace/remove - it they fail, test succeeds!
> +mount_btrfs $DEV1 $SCRATCH_MNT
> +
> +$BTRFS_UTIL_PROG device replace start $DEV1 $DEV1 $SCRATCH_MNT 2>&1 \
> +	| _filter_scratch
> +
> +$BTRFS_UTIL_PROG device remove $DEV1 $SCRATCH_MNT 2>&1 \
> +	| sed -e "s,\B$DEV1,DEV1,g"
> +
> +$UMOUNT_PROG $SCRATCH_MNT
> +_scratch_dev_pool_put 2
> +
> +# success, all done
> +status=0
> +echo "Finished"
> +
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 000000000000..5f13cfb228fb
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,5 @@
> +QA output created by 300
> +ERROR: ioctl(DEV_REPLACE_STATUS) failed on "SCRATCH_MNT": Invalid argument
> +
> +ERROR: error removing device 'DEV1': Invalid argument
> +Finished

