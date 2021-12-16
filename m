Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7CC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhLPSsK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:48:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231334AbhLPSsJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 13:48:09 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BGHJf46024284;
        Thu, 16 Dec 2021 10:48:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OXoDhgKoQt3uc2mhavhZ2KtPkHVt7OEcW2YpCXU4S10=;
 b=Ws+qWYEpiAErtc0bONoaFkiAL7vR6m1MqUmEolaHdwGSaIsQEtFfG6Dc7yGzDDhYiuIi
 ofZxAPcQCuDAIRezrhE4+KuDEObm/BLleRPZ/O5W/c9EEF7yseyDWS/E57cSWuR/Q4ja
 xEDOkSaqR4WQIanyWCfUXAvQTkep2sFHkLI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3d00nn4sf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 10:48:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:48:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnA7kn6TGb/YPZEZbf0/0OnjLp2Xc+WPtHySKFiCVzf9dKlUMNlPKHv5CBYC2uLyLhNm+YE5XJgSAqPg7rlxiwGGhk0gQQc11uqTRAIl+YbMokFNZ7VgGXOvJIbEnd9NwTeVeBDF55gfSjfIY0siwlPIUsrJu+pfTZ7TfDwkW7vVW/quWUsBZ3pOLax15u2/GXwYL0rFQefcQ/lGZYm8mOcXDz0cRtt6VrVLk6x0Ruvg5N2VbnZlEpPI/YhbaJtfKxjnvOVOsKOa9QVXLjiW9d5WCIRA+MKJL8EUSv6ir+eaWApjE9Hiyz3YeATXTuYUihAC0LYBjt34MrLkYyVFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXoDhgKoQt3uc2mhavhZ2KtPkHVt7OEcW2YpCXU4S10=;
 b=LhvA/f23Aloqg77l4VD0UZTO5IGwEskA10RDOmoY8WmqdT+r5HnvhTd0+SfEp2/yfohux7Y/mPhf3AgnqEvwgdGQ5QqRr6WmH3+HbId4qq5gp9d5UIe8Anyfi/seL+4UUVUkllA7Hcxs+2CZwo/8o6PJOS64REj7R4+titb13aHVoBCPi4ZY6G6aYdEKf8z3d4HNYaUQdtkDNlppXWM5oZK6TtkGAIUFI/WWWGBaCk/1ukZX5UcVLv6bxWyI8p7WrMeHJmU042rzfvar67/oXp1DJ1ZvHLGHe4Yi+9hicsAlAKUAxLDxBf0heLRFr19oGksfyQYjaYUbVW/mqaraEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (20.183.238.170) by
 MWHPR15MB1853.namprd15.prod.outlook.com (10.174.255.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 18:48:06 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 18:48:06 +0000
Message-ID: <20ec140b-8617-6ce9-aadb-52207256007f@fb.com>
Date:   Thu, 16 Dec 2021 10:48:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/2] Add support for using liburing xattr
Content-Language: en-US
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
References: <20211201055202.3142034-1-shr@fb.com> <YbYScqspQfzeqPEn@desktop>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <YbYScqspQfzeqPEn@desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46df0b60-8fea-46bf-49b1-08d9c0c49902
X-MS-TrafficTypeDiagnostic: MWHPR15MB1853:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1853E67F92B28D5E50A5D3C7D8779@MWHPR15MB1853.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilVXI/8oH0NHy43dzgQylgwRjdCDgjWSUwr2M8DdP+YFYVJnuogahll3cgCqIt1pb15rkwpGaxYm37qTiAioB7EF76ta2xOJ4/LMxS2MVl23UWB0Q64y6w4yyY6jr7ZHw1nRJAD2CaQzTaQAdVYl7BDHNixr4LQ9gQDOAGq4NAx2q/5/jEAnCzP7pg+G3A8jbsaQpvSbf0ICfm0U9l0iwFF/tKzHkJ82XWC5yAJVdVz8hpXNrUMJ71kV2nHpzGbVtxkIDXiHX84ZPfGTJW57AALoqeacJ2sPniOKN/Rx0UEQb1ethzan70+96FpVjKnZYLIiNhT/tJelcZsNOPYEWr2d8Da56zPXgNL6J9MAf1GwTJk9L2dO3MVgcGppSswNa8fhwXdD+h52FdQJr/jdy8wCkyij2Z9FpxtYKJbr+WQe+kNVo2a6IM8pkB+wB+RVGaQ/c2l5AWeilncwThTa9JwCXmBtqQ1lR1tcXmUSXVJzdQVHL3AJQEgjkqgx40ZStVY2hY7g9pwC206STcGMRlIcj4autQK8F+oKUynnRM2vDmaiLUmHgf3jvk5gyOvcTcmxQVMQF0qw58y+yhTXKoGnIBp2cgQu8tliYwEnK8RkrQn9CQp5OQ2Qb+sEoZKkZVE86413kZNNSg9/vGwV7a8Lz4Abv2xoVoCQJlig0rdsoUBDQPfE8Ke0JKY1p1JabHUoFpgKyRSulBn16STtTNLJVTUXarz3k3L2TCb1LB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(31686004)(83380400001)(66946007)(2616005)(38100700002)(508600001)(53546011)(6506007)(86362001)(36756003)(6512007)(8676002)(186003)(5660300002)(66556008)(66476007)(45080400002)(31696002)(6486002)(8936002)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZVcWJlblpxRUtYTVc5NHlBV21oOHdSdmdCNUptMjc3YTN6QXkwbUR6bXNm?=
 =?utf-8?B?Q00vUkZIK2ZSRHdYQW5WTTNqR2FGU1hDWG0zOHFGblFjay9jQjdkZjJzb1Iz?=
 =?utf-8?B?VEdLYmtGSlRlNlpiaHBkNlZ5d0c2R1lPSzRQakdZWnYrR0liVi9SSnN5Z283?=
 =?utf-8?B?Qk5sdDRJeWZhRzNKVzhWb2t4Rks5dTlkUFJnWlRNdnRrdFBQbUtIWTJ6OFJU?=
 =?utf-8?B?V3pLdmRTMnVnT3V1cUg2eVFvdU1qelR6WmRjdGVLbm5SbUhUcURJZ0RXb3Zo?=
 =?utf-8?B?THZvaTk5KzVxQkFaMmNGZWNZaHdhS2V2NjhXM0ZnUG8xR0p4bDlqRW9SMFYy?=
 =?utf-8?B?a3YraVBXUEg2eVJzcG5VeDhhWHdZZDhRRjhoMzJtc1ZnNUN2cWNmSERESnFn?=
 =?utf-8?B?SFE5NEd6ZW5XczZnaEY4NlZPNGtkeEVFSFNkR1J6aGRsdWhGVklWZzFDNXVB?=
 =?utf-8?B?bE1rYWEyWjJCZFlFQkdKNWoxc1dOQnBZdEJoNWhaSDZNcitNbjVvRkl0OUIx?=
 =?utf-8?B?c3ZDeVRKVWwrZWdRYys0TGFzZEZQSHU1RHNTL2dEL09mZXBkNUd5OFVyM0Nz?=
 =?utf-8?B?S3VtUnJmTk5pZTdKNGJxckE4Y3U4SnJpTkxyNHBzMGFXWW1wSkFCZTBpc1cz?=
 =?utf-8?B?ajFjTGRQajhvcXRMcm5acXNsVHR4OStMcGVhNjlFNVdKanlrckRRMm5EOHFt?=
 =?utf-8?B?c2NHVWdsS1VtMm0zVE9sblIyMTFWVTlrWTI5Tkc0UXRUWjAyT0xWYlI3UDF0?=
 =?utf-8?B?YlhTNVpyVGgwdTVMcGNLVFZ0TUdXN1BXQUVrTHc5YlRmSUY0L1prdXRtTGZj?=
 =?utf-8?B?N2gxQ1ZrVFovNHAveWRzc2JFRkYwQ3gwWDZsSCtVVkVLcUNJQkFtRDFVMk8r?=
 =?utf-8?B?OC9hUjl2UE5SQlR6RDQ5T3NpS3lhUGZWMjdIbUFMZFZMRDRaYUJPTk0wN1Z0?=
 =?utf-8?B?a2RITUpGQ1R6N0xzNVFHYzhKbGpkcThoaDV0ZVRoMEc1cStGUTJ4T3RZaTFC?=
 =?utf-8?B?UUwvVzB6R3RrWVV6N05lRC8vV0pNcDE3N1FMdFBadWF6OWE0T1RocGxvdlpY?=
 =?utf-8?B?amh5OHhMQmJrdUFSTzUwZlhHVHJzV01DckJnMDVMM1NkMkFpc2tqazcydUw2?=
 =?utf-8?B?VEZkZXRDY2d0c0pBZjV6Nk5wOEp0ZXlFN2ZMM2E4MmF3WkRVZDRMYWNLQ0Z1?=
 =?utf-8?B?Z1ZUNis4UE5qdVd5aGQ1emZXOVJGdm9WM1NoajNuMG85ZkV0b0lKMkFWaXlI?=
 =?utf-8?B?cWVlK08yUitrQ2JuQXIxMC9KQ0lWWmszSjFqdi9XWTFKZHVPOTBROVhGTjBM?=
 =?utf-8?B?djRubC9PTE5lRGhqTVFBSlJSdmtiQzdOLzhXRk5DNzVxTTRNVGJrais0eTRx?=
 =?utf-8?B?WFJDRFRsLzM4WVV2Wjg2RExpR094WXFvYWxUUDg5Tnh1dEhwWUlwRW52TEcy?=
 =?utf-8?B?WDlkdnBGcUJUdTBPZlpybGt3RnI3cGlOM1BudzdIV2VBNnBwWC9Pcys1dDFr?=
 =?utf-8?B?eFllQnRmL1hJN0FrVjRETllncCt1LzJJc0JZR256a0pPZEczL0kvSG9CMkxU?=
 =?utf-8?B?NE1VRERHd0VsR1NQY2F5d204bjRJak93bkxiUnl0UGNKVG05Tk5BQ2wyZDlw?=
 =?utf-8?B?T1BmMGZUUHVWTHQrME9lK2JKUjB4RVJ2ZTRDT1N6cDJocUwyUXNNRkZndWlC?=
 =?utf-8?B?TnU5Q3hDRXo5MUpWa1pGWGs0K3g4MXFQLzJoNlFVci9id2lCMG5WUHN4MlYw?=
 =?utf-8?B?WG5zcEt3OW5zdnJsNmhTZkN3UWFGUmtJeEcwL1hNL2RtRDdlRzNHSGQrNUZ3?=
 =?utf-8?B?V1hMSE1KRytTOXk3MkdTMjhic1pNNHBCL0dnTVh2amJXTmxtYnRvYkExdVdH?=
 =?utf-8?B?NXA5d0R5M0Rsd2tsbHZlRUlDNC94WnlDNVdwWHRjdUh5aXBnZ1VWVFF3dVRr?=
 =?utf-8?B?WEJvZWRlK0Jadi9jZ1UvdDVPaGNmb0lUWFJLYWxsb1VKdVRNQnk0U1pLaVVo?=
 =?utf-8?B?dy9LcDBvTVpUdkxOZXZBNERIdUxlK05XbDdwSUJyZjl2b01ZRG9iU0VLSld6?=
 =?utf-8?B?Ujh6alRDdC9ua1QyMFc0bnJiT1pzTS9rV0FieTdMOEdhcEIvZEtDTi9TVm9L?=
 =?utf-8?Q?zT3dmbuFsaUmOWxcCOonglT6+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df0b60-8fea-46bf-49b1-08d9c0c49902
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:48:06.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZLPLIPSlpNmFCGo+CEaA3qD3GVntHdecW+Nm4eApLmRU2Bd8xQeMLlMo9H2tvS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1853
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: RjFttM5mtPiCpUUVZicc7F7VS3mQ2mKZ
X-Proofpoint-ORIG-GUID: RjFttM5mtPiCpUUVZicc7F7VS3mQ2mKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=910 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 12/12/21 7:17 AM, Eryu Guan wrote:
> On Tue, Nov 30, 2021 at 09:52:00PM -0800, Stefan Roesch wrote:
>> This adds support for using the xattr implementation in liburing.
>>
>> Patch 1: fstress: add suport for using liburing setxattr
>>   Uses the liburing setxattr implementation in fsstress.
>>
>> Patch 2: fstress: add suport for using liburing getxattr
>>   Uses the liburing getxattr implementation in fsstress.
>>
>> There are two additional patch series related to this:
>> - io_uring: add xattr support
>> - liburing: add xattr support
> 
> Patches look fine to me overall, just one minor issue in patch 2.
> 
> But I'd like to firstly make sure the above patches for kernel and
> liburing will be accepted, so we don't merge tests for features that are
> never upstreamed. They don't have to be actually upstreamed, as long as
> the maintainers don't reject the new features.
> 
> And fsstress.c has been updated, would you please rebase & resend by
> then?
> 

I fixed the tab issue and rebased to version 4.

> Thanks,
> Eryu
> 
>>
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> base-commit: 2050356437e3576673ec5ead79ad72eb619f0d72
>> ---
>> V2: - Introduce dedicated functions for uring getxattr and
>>       uring setxattr, so they are not automatically linked
>>       in if liburing is available.
>>
>>
>> Stefan Roesch (2):
>>   fstress: add suport for using liburing setxattr
>>   fstress: add suport for using liburing getxattr
>>
>>  ltp/fsstress.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 116 insertions(+), 6 deletions(-)
>>
>> -- 
>> 2.30.2
