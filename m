Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7715AC61D97
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Jan 2023 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjA2CnC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjA2Cm6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Jan 2023 21:42:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31E7688
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2023 18:42:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T0cCWG014333;
        Sun, 29 Jan 2023 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NrGVVajSFRzveypTLAcqXVh44UsWmaPXoZ3f4ZWw2mg=;
 b=oEFuTIkOxmPT3x8O2nRg/SdSK8VcqRqtXzK0ussrxwndelh7pLDVbkp8+4tDBFfQzoX5
 Fd+daccrPpwvaJzVMplWSVZGfINAcBLmdkHFGFbhdlQpVvLKC9IWX49yPb5byuuC03os
 WvO53WZNHf0HhkLSFuijpU1nRGhIwz6tOvHQb5liiOyeC+K6dahs6I+SaLVvezAGPfjg
 CEn412yXO0+44M9xcNnQkC4ann6YICCiIbhorWdMZ/haWQBH/g7cKw8rOgDUL+RYf0I2
 f5jJMddVAVHASVpxZ2Vbl+6TL3xrshW8pnPIrmAlO6rHLQnMb6mKe2VbCa0aQT65QA8x fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvq9gwwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30SLEt7Z037461;
        Sun, 29 Jan 2023 02:42:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59hp38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWXTvxqdqVBRWyOvYg4r3cauYoh64/nOSlf7o+DGTbW6yJm+O8gfV3mmOCu/hoF6vwhMhXiAOHAgbRb3NnpZkhXo9eCxKfsGG3/qanygl0fc+Xuw2hr/6ueuEfVJYNr6tZmG2vllEgKZcABatmovGDE0eKnPh1RhHoY8W8QGBstfG1G/kiDxdoJIySIKxG3QDV832wnt6xwR1APPWrXZyOyCfw+SJo/3JO5zhuRQfIzp1a66/CXzRv9GqTnloSMf1b9pvmuZcbHvX6+MiBQZ8nR0i1g4IqWbhlpOFEJD16j4VCcjjBoWP2iiJHpAM6LIJxHOtC5JbkDJfewS4dpTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrGVVajSFRzveypTLAcqXVh44UsWmaPXoZ3f4ZWw2mg=;
 b=CL3+NzulSVlVwSBHHf4mFhgzL+nqyg1IIQNfDUDUeDP4OZodxtwYEpsDuZ/Y+SmeNXh/LrYuq91LUAgpYZuCmHbngexvZ6w4uXjki7kP0E0TA5Hj53/CjPdv+tnMMoHmRN4C48zKaslOa4d8ioCu9GQY3fla2M0RA8IblZFlnk4vDD4g1l2ST/bXxLMaRxcTA8n5Nch0DqWCo0r66aRKni4Kc8+Thb+NAd2RjJtNXd3v7JuR84oJR5Djm3+A9Rfy2yD8BbFLuvfNRCS5PtfFRmLX7qIPIYd6JKMMLiv3bdyZnSSnMNoiJkMxbq9TRqshH8ezZSmSFFFlMyJz7eaCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrGVVajSFRzveypTLAcqXVh44UsWmaPXoZ3f4ZWw2mg=;
 b=X+SKn2TAGzLy+ATkC/vbZMnL5z6FcMgteKsdFQRWUxTzYK8W6+Vv6uBw0CgjkL1rkA5C9iPRlPYErT4w2I3qayNiB0XkW4TeP6V4MBwPpdW7R/99+6X09OCTudLlX6EhogWne++phd4mGet0AwmCkDjNXemxih6g7TleUGp0xl0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sun, 29 Jan
 2023 02:42:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.017; Sun, 29 Jan 2023
 02:42:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org
Subject: [PATCH 0/4] fstest: fix compilation warnings
Date:   Sun, 29 Jan 2023 10:42:29 +0800
Message-Id: <cover.1674870429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d9898d-6ab0-4f58-d5ac-08db01a27d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lj63X40YNRHWUV4tUO3RhHUY88fE8cqEUrGE8xAelOYHjpDcZhSFLmO9jDpKPtvshXxItcLtm2DN4jdPZRvh4k3ZjI6e4nOdDuKyLTnTl8u1j82bFfO0rhvEKse/3OwKl5PwfF1b/KKPNs//tiBjYDaD2ZV0SAblzew+eEgYLcXklW0uKnm5S44kKnW2NrUsGGf3i2yuzs0wOaOVVEe9zONl4UFCXbYb0dM8u77SBEFOcJp87KYHxwU2/jYmnYm7y5FfaSmLuYsS0TihrHvBV5hbxJamEP3Kxm9dlqUiPUEa6jtMNfeykgglllMD9hsD1IYLlEYcoCJhAkTOKFUtVyUkXALwNnoERkDda2VbBQKAjp6vhZH3bw7TYsmpTlWjYwkymgaTj9mqKzRjcZxzD+v/LzprPd0xqegt14fSkmVbA8yPjHyoTJRM0uX9PuG2LKgLE4Jcnv7/sceELDM3yYXTRCh9ihta1ltm1q3thjNbzJ8mLf2dBvzEjhkXCWlXdEIyWKwXGY6CRFDnkKd6krVyS+QRBGRd3Puhb19Ou2feMzF1dQaUkVF1TVq35mZvbXcjO/gTYDxnlBxSCOQvlwYGMma18ocvoEHW85LVQfx9P0MmI9lpHsVhiTMOfE9QBPM8VtxBJvc5UwWaDobdig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6486002)(478600001)(26005)(83380400001)(86362001)(38100700002)(186003)(6512007)(36756003)(2616005)(6666004)(6506007)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(4744005)(5660300002)(316002)(8936002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNTWUAG+QdTMi29PzQlj2EavV/zi01wX5W8oZzLqXMhLxrcZr2dYxAZXdefF?=
 =?us-ascii?Q?ems+Szz7MvfYkmSUjRdedwJII1ZtPpZsHbl11SmsMeA0z+t+iza5jabyLE81?=
 =?us-ascii?Q?0nzH/DntKuQMsUD5eQEjKWyqTjrpUpCV5o6CNvoJsp+qYvYgdHlqk4r1bVnV?=
 =?us-ascii?Q?5G7Vszlrq9llGugg/QeRTZLJPe3G1hyWRXyaSfMHKWKWtFiPkekmuDbeQ201?=
 =?us-ascii?Q?6H0WPsL46zKIHSsosXu0ZiJoyQJInBK2kUUpqtCuGDmr/zz0LYmmYONas38S?=
 =?us-ascii?Q?RAlGQjkf/d91A9E3rQliSgQbLF0NJ9DJYCWUEfkjSHzc7AqxFpT2CnC3GUm0?=
 =?us-ascii?Q?4zN9FevqP+AcCeGSgJfCSbweINdlcMJjqp6p0za4dfENUPHYM2OsYXCFqKgX?=
 =?us-ascii?Q?J7jxRkpIwhjIFTXILclVeeWT6peR7KwTUzmBkazQgGeGxSWjaLTHEEOsQzFQ?=
 =?us-ascii?Q?VEgCY0SSdFQhtfozoS6tIHC/OdCmlNHKMG8rZCQDeKBvUDcDq1qEA0BG8LeG?=
 =?us-ascii?Q?pJT5g/quucxVcYpCs1+4KhN3zSUN1B6+LgUtcysESAElhCX8gytm2GDgwXuQ?=
 =?us-ascii?Q?v/JM8Zekz7H/2GK05AACTiTAqEpVKnI+nbpBiFiRuVTrci1BZV913GxHz0wU?=
 =?us-ascii?Q?BvQvA1c28fiJe/heeJ++P+/APU8k00i3oydzRK05IYJmrzjvUdpR6mqFEGmE?=
 =?us-ascii?Q?Cgf8960xXMtEJyOSkPbLJyrBBfhJ8UljFARDjfFWxTe6d2SCLTe8RhRS8fPz?=
 =?us-ascii?Q?gZ8SYU5BAQQ2HVvh6yggGzKEYxJtCg8HqNvFSpZHJtXhctKgqnuEA6A0dBP9?=
 =?us-ascii?Q?7qwCfnotlC6AHgCVu7YsfDGqWMCMXlHu5OZGpOFDvA/ldZZ2zCmJppXrU+N4?=
 =?us-ascii?Q?oFVmsp/J8Tm9xCXl1enWEoeI8/22KoStf00GfKJ6UbAOyW9JdZnUVlWM3K6m?=
 =?us-ascii?Q?yl2zBYgy6oNl29JoeQj3WSLH1I9ybRh1wZcUzfPZsth/ztop//cq1vjv9pnd?=
 =?us-ascii?Q?wRfsKRCqxeEbM3PUJqyM4SIWuytmj6ApXPwlLMeaxGLcnukyiUwj5IqmawU2?=
 =?us-ascii?Q?G9NmCbK8XYpkTIaj36BBOauyaht1SiDelPnAWFAGWbj43ac+QwC6N6e3MeC9?=
 =?us-ascii?Q?xB8fozhRo6A2Sh4lPUmszJ0FMD0h9QqD5bc8C40mNe6A5XLf4xObOcZgiUI5?=
 =?us-ascii?Q?rCoy8st34k0O7dFElfRrSsiuUcmJeqeVLWQZKxxUFmM7KAiXgtuUWTEMRAmk?=
 =?us-ascii?Q?UkQK2QCxQMr9wR5ueOmPP1h17nWQn4+jhipzXCjUZG317JFdzDZzaumjlNqW?=
 =?us-ascii?Q?3w0eZdCQiXhKF5IL9emCssUj856rNiMbXBmt5HStzJYb7jQJOgGntQrpuzIr?=
 =?us-ascii?Q?KR6VyOODwgqFv9jS4nkQ69ouNYcZZbVAkHckKK0FSYLez+rMDC+ukxBa39Kg?=
 =?us-ascii?Q?i0mxy30qIVp+FbGAxguJbwwr8oHHpwU2HEkRvivKZ2GTdvtCSzLdXPBmsYuV?=
 =?us-ascii?Q?7Sy4kKXnwiBot8o6TF940r65qvzdv904TK5XKSLOfmkQAak+EVcduBG7qUdR?=
 =?us-ascii?Q?O3PsC60zr8uC8WFTnsfwm2Fd2Ig3/k+xKJFdy+y0VzarP3/TlM9eftaxbmoi?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eENsqvaiEAVXThQqrfqC7wI8cVGc+QenwoELhaTrabO4JbGbpzo+9abLh8w+D6Osbczdk2Rb7bLeTImb2272FcFXNG0DWJ6AnEJQXbe6zBmaAY4PX1EJcfRpRWdMZx7PUrhhtMzIUhEujsAqKNU1hVSFx6KZyUmQBJ3kHP6FDfAdIHA4mZUo5T/HDXdd8OeKj92Tii+sMAMLuH2k6hyTGtiE43dA0eplq8HrL4IaalfsecWxrRZpFPvaTW611wgTfwNtm9qv3m1Y+rz2G+7GWAEOS90+rxUYWAYXGXWElSnbU6ZAcR7fv7vdxddYBjdj5ahab+S+nGIKzeu6fy6IS7cjQqg5GUD0GIrPXTQu+WbGhRaVxN5F/Hw+NXW0vyWGV7nhtQ/EhmXCdQQbfNWyosVIU2PY6wRWHFUF1rkSSBAG+Oq0SGwNI0ZRQyYm1MGmDzwiop3hKBG3VCsLBCm7iTr7tk6XMzhOaSI5/yN3ycZwMZE7+wcXS7L/wBRDZ8PlgBAUflmEKMubo1clOwp0VpR8U9s3EClWkT8xo1Vb0myp3gLdAIK+y/OerxXym/EeWlifnoLQr4GVxGczgdC5ymYbkeKHP2QlM+h6877N2Tj6CqU4jk5bNp/Hxy1Sldqiiv+82QAJzQtf/xmv0xSpirNLdsKdAiyEboSDEEU0sHbfbzHmkZHazK6dArgfvnfB6gUeF76Hlz1nMhDM9c8/K4Z2qG4QXyQB6hRBAb+y94a7en7YuYbAxbwQi9HqzapUz6fICgSqEuClcB/C8nfWgEXIEZ44ar8e9LckXZG3Lw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d9898d-6ab0-4f58-d5ac-08db01a27d55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 02:42:40.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V0N0lILvmHcPRXKcNlSn/ueArz8EC7P30uDzK3PcTpTn8AlT/c8pzKVelMpz5V6k2XWMMG1U+cGadW1ap7UAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=866
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290024
X-Proofpoint-ORIG-GUID: 50s7kHMmS7cI0iG-rwf7Tg7mFudMfplM
X-Proofpoint-GUID: 50s7kHMmS7cI0iG-rwf7Tg7mFudMfplM
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch set addresses several compilation warnings and is based on
the for-next.

Anand Jain (4):
  fstests: doio.c, fix missing initialization of -C arg
  fstests: fstest.c, fix compile warnings replace sprintf with snprintf
  fstests: t_getcwd.c, fix a warning related to buffer overflow
  fstests: aiodio_sparse2.c, fix compiler warning buffer overflow

 ltp/doio.c                           |  1 +
 src/aio-dio-regress/aiodio_sparse2.c |  1 +
 src/fstest.c                         | 17 +++++++++++++----
 src/t_getcwd.c                       |  4 ++--
 4 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.38.1

