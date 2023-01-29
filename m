Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A063EC61D97
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Jan 2023 02:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjA2CnL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA2CnI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Jan 2023 21:43:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B5CDD7
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2023 18:43:07 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T05H5k007755;
        Sun, 29 Jan 2023 02:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YB/0awCy5x35aDeq45R9VA2fg4z8fOZwJ8n37S0fBDw=;
 b=ZcX3o0CRdZEFq8eFG3YUDirGyvsKVmFdrUAjiG+ueH1um/vz7X9HactKWqXd/YeddaxX
 8GDFhrXEQT9EFqB8FDYTejCnevhSJf0lDDLl/a2uYrIJjv0ZKJ7pWLlLaF/TdgNvh9Jy
 Zvh5U5jMi4X6v++0nfssEi24msmmjbCKwMj3wKKmSrbTt1TJ/ploANA9VSvZe5pOIjIQ
 y9eGxju8Vsn0nvf/vIdI0kE11Fc/bCvBYmeQZsWoaRo/Wu9WZaT03qr3DrVIpSpvGC3X
 SW1DHuso2Z3FZZ+jfw9tdt7crO8XDsLpBaC3eyMVbicatQFgra+jA8Jr+IfQmWEGBhlf wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp10x09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:43:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30SLTgkW000779;
        Sun, 29 Jan 2023 02:43:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct52sj53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEbQfAjOfIkIOrJlW+MdzLTu6RAjc9KyJn+lMZ+qy12aFRdCRacEsJK0oN3QJ35nwdIe1P58JEL8pRXHX5bLBUovSYemgOsJolLYrgZVcM8lDjb7kJp/OMKtnnxwX4zu3QHHtbTd5c1I1cqir+V0r9vH2yRaAprUBnpvZiK0b8dbNOx7ZzWo3Uwb8/9WZDF57sNMtIY6bE9m0Fgck9ah7qIKrfPzeF/XieGiD7M25Ow8Vz4uxgXoTRKdF5OqhVAsWYVB/hfLO4Sa2aE0Sv3NrWk9EQ1gENySkbnQDukfV1k9V8uvWZZyxam6/YnkCPEXQLn3r2bDoNbz4Yl9LDZbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB/0awCy5x35aDeq45R9VA2fg4z8fOZwJ8n37S0fBDw=;
 b=EDH6VXKaRNehh728Ny8qH+9O9XaRWuolVXEvtvz9lprpRXT1QWYTB/t0W9HWcNyA3GTQOHghdJV+wk+ODbpn3mso/l0cfaAaNQLr79/tmkFOjamBtCN3cs7vSV4TTf+doanUEmWIS9D/Zb60rspx3Hsi4yf2bz4sr5Q1dCUlWPlOyF+1mYMrRwQ5/WDwklsnXZKn+GVLaUNELKCcSittwszENESJ8KkUwDgidQj0C+5QHPZbOCeBqDAL0vgskBH9nXPqjufT/atDLlXQd5QOdYX4WDqMODfyLm/zKzDitafu9IFeUJnxn4AX2KX6ush/kJ62Y7xbeenCh7/6UgauXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB/0awCy5x35aDeq45R9VA2fg4z8fOZwJ8n37S0fBDw=;
 b=NTctbP8MxPtyG+xO384ipkiN6ULTjvOyi+AbuwGHAv2SRMkn4HNuYb6kgP/lT4DcLU8UWomV/rmJopRaQn3KmPyJkmaRYCfE0tRX+Bjhtv5IGwpwnlBdAbPzqoLUer2rBR5en9GFrcRBweyI+N4tePIfuOqp7jNVmK9/QqdK+tw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sun, 29 Jan
 2023 02:43:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.017; Sun, 29 Jan 2023
 02:43:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org
Subject: [PATCH 3/4] fstests: t_getcwd.c, fix a warning related to buffer overflow
Date:   Sun, 29 Jan 2023 10:42:32 +0800
Message-Id: <7c1a98e17fdd0248c7d68302c28bd910883274ab.1674870429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1674870429.git.anand.jain@oracle.com>
References: <cover.1674870429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 5642b4ff-4876-404f-6035-08db01a28a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08fSdlLflQ4nA3q3xoZH1Lg2J82gOgCNSV+PQ9Yc1C9RJnH80gNpAEEMmLwstB5VkMg9uqNX8rPm2shMAIB9L9oktZ/C+5P8JH1NaxlbqQXVZZff947Hr313Vs4Bcylg0Hg6SjW022I/+GjlzqmZ/kU38f2K3zIpul4BF4lQUa7SIGpk1fX1JZzfZhYPx8YLuIvaIz8Ve/J6Uc1XUiQKQo2e3fXmroKU8Gh6A5zf4xiMiDReLppVvXsHGzkXERDKEx8lYPPLKuNqooClvjW66ZFFIid5y51HPvsYoly5kXPZpvNTHbXtHbcExnXZhcshVQ3OP/dsRkv77xN9tTD3JoLetJbfgP4RMF6Okzvwm5ha2BUfAh+5zNb11Bf5/RmfchVZIDOs7FWn30od9iR0HyT3Kol4KSDXfz72jRF5ExL/cnncnzOVI+gdDosrSYxh1bxj2+i6iYxJ8AImXqsx+aNOc3GwClLo6XiNsELHLEPxpgmFNei9/Vp9+nKBk4HWK6Cee1u+OdK6mQ6eY11VBIeqMo4eYpEBZZKjixFUtsHbe9NAL/ES+yzOciIr0H76x5Rq9qlnoamj0YYjkxAa8p9o0f57uOfTrrmvbrp6z2yoRdDuioHyks39SG4taPBkdy5WPN7r0SZA08b3EGFuhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6486002)(478600001)(26005)(83380400001)(86362001)(38100700002)(186003)(6512007)(36756003)(2616005)(6666004)(6506007)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(5660300002)(316002)(8936002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?btH6MMzW2tizFdc7GWcDZK3II3Tf05DBZlTl+sdYSX5jFWXCapKjgU/0YFBy?=
 =?us-ascii?Q?nMygLCCruDDUZP4Ff26AoJu3OO96JtXWmj+62quYioaVl2NNpTE90lyxRvzi?=
 =?us-ascii?Q?rDHF374C47oWugU8Ie2+VpEZwBc+7mKfG7dMO1UI3wAYDjrh7e7R4Wrfaig1?=
 =?us-ascii?Q?I9rF+Y5sEeb50fkb/3oJpCpjkjGBPBGzo6v2HjzGNJU+qzC3iDF1hnGuoe9O?=
 =?us-ascii?Q?vvPwV0HD091YNKdWfXBCcBGffRufizgRSqEtR4xUv8OjYM/VTpbAqh4WWm4y?=
 =?us-ascii?Q?c+HXVXC11f/10H2LC2rpWNjcHADUcJvpL3Fo1Q40pLcPW761EBLJGVOdeOg+?=
 =?us-ascii?Q?1qk3w1pcwS+xmcN8q7b8hLNZ7JkdqTNhfzAGUblmOdAjPzzLZVL9pUxtTJqx?=
 =?us-ascii?Q?Bb7zIGLWOLu2KKBcZjULUlAmVgy6cELQRAqYGOH1S7uSGrIz1V/5+kAkzffm?=
 =?us-ascii?Q?NZbzNtIEgw++k6LFx1Pf5CrFlyxcYl1M5uJgUG4yCJSDw6zAfVUZWBMWblib?=
 =?us-ascii?Q?7Lc2lLpUauqh9YzfFeUoPACeeDOYPLXoGC4dlIblGQIY6bTqC9skipT/EbW0?=
 =?us-ascii?Q?fok+I37EA6vk7uucTH6HnHkKSuIVd+3Jbldixquck5xKYaFpvcgW3/Ze25n5?=
 =?us-ascii?Q?TC477mFjjvuIud3eqKOEG2gFqy3+C59gBwzUFp39XVpvu6AP6/uXEiZ49YNn?=
 =?us-ascii?Q?CWojasR6keVsnoM5v5l3QeQoBnPKM44KzH24QkNaUYYyRrmLaJi1kjlu3twW?=
 =?us-ascii?Q?ePpDNKv3QtnyqVmAPUaioUnDNDWzCW3zrWX7dsQOlmRCH6YnIIIi0tBegcAR?=
 =?us-ascii?Q?eYbBVggfSKMupqqLwDHi2un7NKaqK4dDmN9hjJ11H1asCsTLcAqZ37HAVpgw?=
 =?us-ascii?Q?P8oEBg9Jh18wHpVCyfsnuRn1NGWyvah+XbavqH/q7PgQ+Ge4fKKdMasJ1n3Z?=
 =?us-ascii?Q?jSzLB8XfUz64ecr1EivC9a6OSFAf0R/DrLXcezJBTi/tbVIAT9q6AZW+PX25?=
 =?us-ascii?Q?p4HuNR1oEP9Y/E1uDzhCDUpBDJJ9c5UJUgCiTdUmeZcNdJaHvuMTlIJ+ogEw?=
 =?us-ascii?Q?YYyo8R0VdwZhJ/t7RUv6ETMPReSxSrC6/odPhmR4oZTM458MXHE51E7UKFii?=
 =?us-ascii?Q?4ZgE5d0y2Y+F5W21xsf93oH8PiPdDVKQEFnFpn10VXvaR9AogYPBXPlJ343m?=
 =?us-ascii?Q?wiv1TjcMpCB6ZoemJyNXmfC5OaBL7+P+A9qkWRIIL1gr4BBNEDSJ5/HvopJD?=
 =?us-ascii?Q?6ryrZnunU1T3GvoqNxM/ZBTKLhRkBV8ZBV5G22TE6pHszLc4VfbU5W7SV65K?=
 =?us-ascii?Q?JX1/vKs1CnpK/Iw8/tqA7Sju+PaApfN3guug18HyEM18vWZorGJbamnX62yZ?=
 =?us-ascii?Q?25ZP7tIUzO9PyHOO7zP1cMf/1QoubT3ut2Frsq1G3e8FXyuxshCorcg5IWsr?=
 =?us-ascii?Q?ZwzFTZu++30t+tLE8pM4RWbtHu7OTIdRT6ZcTtiUyWeiW8seAYfo0oF5K6Hf?=
 =?us-ascii?Q?ORzkchboZmKF2Ev2VRp+T3EeoU16TsINDiKyolphJA7sunJSFNRe2ThhZVo6?=
 =?us-ascii?Q?SjehZMn7Fpe0lRVSuwI9s5MFDyLzNJB1jcJ1tv1w/Bt9QIW9hGvDMOL2LZA2?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4u5Mzhnx14lihHjVOIM+XbzRgQ5lUyIAAfrrR2wxwX7hxh4E4+JCGhGyQfEoI+lLlBg0WMaolZJqw3Q2cjWOm+yD8uVYc8cw0GpiHY8B/i6vibfJd4KG0zhaPwwULTBhxjUAnVyaOxAt6CsnfFNc9ADcMiMBUFrv5mJIjSscLiWcdVHj3NO7tMYuwvo2UVbnF8mwjuM8Zvip+udZ0CqA+PwoRDrIpg0mXeqEl5fM5EH/I0Ryhu4o2tDZhMq9CQ31sn0RkRmOvXjw0PH3GyPJ65iJw68XmsV7WyV3ZQ0FfNKrh5Kn2HdgKkkB8LTgFFZoX3Xdf1BQSkSccLVfw/DmB7PxHs2lQ0Wd8fDiJLXe4FBGVXfvAv5aUGXR+DBvANdlWUWeC13580Agsu6BAD+SMVU767vD6DzlhL8GC1fER3X+y2qlw9JZo5JUXFysTvkv1rd49BuHYrhdwhRUQyY1tIJRlgI21h9jw5MkOmmlqoRzIEGID7jRXtC7XMVW/OblMkkZWVXXOG42PLMXRPygg8VgFqsKAslGZ+fMWETDh+5m/stbgKjALG1VUdBaVxETCcmqabVnm/DZMa9iEL7UB2u8a0irqeknTCL61oZ9npquUKk1whQYz6+2mwbWx5KVSDQmjLYx3HLnUHXqjZxqr+V0I/iVS5hApwgryGHmDNnLLvPZybQch8CE0Lbs99JmwxJtxubAEHOkOcoJe60Ui3MMbfj1kS0Jf/QFNFCcHnHKqUbMnVSSMe990Htc+IhInjqBEfgR+VB6T8i+4d/umzTKSkgvgbC4cIhYSVCmzgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5642b4ff-4876-404f-6035-08db01a28a35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 02:43:01.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miG+jFarAsJiAy7Oaq156onRboFg1Sylg3bAFYJWWiYBAOPgVKAO+pNZr+8vPc/EjhrxAcLlqhWi32YzlkRzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290025
X-Proofpoint-GUID: tu0WGbm7Wyv6iSTyl38bZg0gUtV4_k-0
X-Proofpoint-ORIG-GUID: tu0WGbm7Wyv6iSTyl38bZg0gUtV4_k-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

GCC reports warning related to 'strncpy' and its specified bound being
equal to the destination buffer size.

t_getcwd.c: In function 'do_rename':
t_getcwd.c:40:2: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
  strncpy(c_name, prefix, BUF_SIZE);

A buffer overflow is unlikely here because the only caller for
do_rename() sends a 16 char long %prefix and BUF_SIZE is defined as 256.

The change is made to reduce the buffer length in order to silence
compilation warning.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/t_getcwd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/t_getcwd.c b/src/t_getcwd.c
index 27255bd024e1..e9b5d7feb31f 100644
--- a/src/t_getcwd.c
+++ b/src/t_getcwd.c
@@ -30,14 +30,14 @@ int test_getcwd(char *init_cwd)
 	return 0;
 }
 
-void do_rename(char *prefix)
+static void do_rename(char *prefix)
 {
 	int i = 0;
 	int fd;
 	char c_name[BUF_SIZE];
 	char n_name[BUF_SIZE];
 
-	strncpy(c_name, prefix, BUF_SIZE);
+	strncpy(c_name, prefix, BUF_SIZE - 1);
 
 	fd = open(c_name, O_CREAT | O_RDWR, 0644);
 	if (fd < 0) {
-- 
2.38.1

