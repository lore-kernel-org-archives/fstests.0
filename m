Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D171C61D97
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Jan 2023 02:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjA2CnF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjA2CnE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Jan 2023 21:43:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122083EC
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2023 18:43:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T0x4rg031584;
        Sun, 29 Jan 2023 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=V99m4V+Hc6DCYPl0ZwbrMuzrSlSPV/R6rM23BzAOcF0=;
 b=mr9bT4Noo5hYsxAl/wamK4c6bJhIstiPV1x6G2wu0ix4EnPeJA5yryd7UmwJ4+3NvgcX
 liibSMG4tCwwAxMkxi1j+DgvOVaze/tgvty4Tg9NqJ94GfS1aoxu8ou7clWM6D0XM7PT
 EwXuv9sVDM8nYMU0JoqvdwVGxJiZ+2JiqzRKH7S76r8fJAGmBO7QctHGQkW3iUJ8brWu
 XXR1xu903MWpCMfKruXgiUeOszReKZ9mNuCz/ovFcN1ZDevMHjsAY/rKkDJAULoxeY6T
 z7dXgLy6PE77JoVvSbZTZOsHP41cw/bHqbuUcR2smrgZJ7x77pC9d4eSQUI+pQRHW1DC og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp10x06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30SLea2E019130;
        Sun, 29 Jan 2023 02:42:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5315xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ele1kxz+/k7LPZ5rtQeMfCUAZZI3irRezgTgleo5ZqO63RGP9gZD3p/0OKBIU1rm9eUXMKlcF6EExid/KEAwaYMqqlf9bDN5cBAfhcsdDLkrLSlub5IoGG+OvU31BJKKyOBZXotW5jJchsa44gHKHzOw0xV1Pv1pklV9+k3CfFXBPD9Zzk1RlHPDUpt70Pa9a+LiD1qi2foO0PnkEVAeDr+cmehsVQVqT1SAUuLCLZ0uVzpTDO1rTlgsPdqFlXYOF5CGVylbVgbKI84jWdSeP/415eB8yTvmdtFmgn50BMLLj/mqXvymo75M2B8+xpNpcfz7GGQ+lfevecRij0tYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V99m4V+Hc6DCYPl0ZwbrMuzrSlSPV/R6rM23BzAOcF0=;
 b=mU29GVF1Oim5jJq/Qo4PDlB6pG++E0S/CM+9vgjIJhejubxOazKsB8WJnvRGBO0hVoambn7N/oKWo0UkIeCNsxN7w+2f2NZPxqpffyPcSiBqUqvHE5Oi0SJUD67E36pxEPl8DKHjR70HjmzTCsxAuzF1mafcUzVe7HEdeAAeGn0leEr+k4myXTsye7Qw0GDKgxlfevCB1VT0sYSFIyNc6iHQCsn9J2lJrju59pfzLBP5A7tkwuvd7T36ly0loy85n4Yjs98/J0sGkNqzBpy3HTHSWcd+IlK9oj5rW406a1NJu3sTUQqJRmthyjLXKX5AQSbW1qPIxy9aSjQxC6uC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V99m4V+Hc6DCYPl0ZwbrMuzrSlSPV/R6rM23BzAOcF0=;
 b=rThu5FxDK9sdTOd0jUDc8Ya+2085ZDCeLf1wwyD9ZGCbwUGbA9PQPZCadKNS7cb/EfeOU88JgqcMyK7rcsZU0B2zP0gTHCyl15cjgBoLfwPQGquEN6kMONw/oOxsIXg+ZJ0CyPjX53pGsqBicNLJs7nijCqzVS3mivg4AfkIK8I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sun, 29 Jan
 2023 02:42:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.017; Sun, 29 Jan 2023
 02:42:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org
Subject: [PATCH 2/4] fstests: fstest.c, fix compile warnings replace sprintf with snprintf
Date:   Sun, 29 Jan 2023 10:42:31 +0800
Message-Id: <db18b852d84ded8c360b0ef8c94a16f038e4b795.1674870429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1674870429.git.anand.jain@oracle.com>
References: <cover.1674870429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e60a44-da3c-4d03-22c8-08db01a28634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bx83ZNfupw4VI3p4lHCnqikH+ngQlsd2oHDk/ybDhQW/4WBOBvyvRSSWN67IMwqR6cZJHHqdXwklh7e1TM2qMSS8t5EVskCmkzGgWFnbgcrK/+Py9IxONIveHHvhcNK2h3PaQadvIrq6RAvIb9Msb8C+ty0qD1KFHTSQqGDfUO8yJRaGJZzKF2hdPOfSheloRgCz6i5UV4sO3wMCmj7jQDWzaW/s5Pp5qKOVFm4Wr9POeFWpIb87pGBPheOGawQCW2kxtkwG7ICo8fJk03RAw5BnzaVn2F1lcSkFcFZ2zLD3lv3V48z/L4zq3quq+eKfQvHKpoJNxhA4yzA/jlV6bSjhySJRSLK9pf5NFNDYc2jLsfuRvBmvdEapIpJrhzC3oaAgxCj2sb9jV4FGDhFkW1k4o43eBUo3zSzltnq9F8fYBFHZq0+30kOWc7Tj/s7C2vmdR5pyrfIYVBOsroVF/gun30/a4kF8prWhhD1B4QSuyWUIJcZyaiexXFxNFP7n3/UgQJTjQNyMYMAmZpYnqI9A75BMAleTJ84W3EusOb+0PHcCvjsHguSBxW4To5F9JeaY0G/PntfwJAwDzwKdJScBcxfyM+TtAa7UPrSVrsh3R8BaRSVPjUnBg/1dr7xtYeOCKyEDgwDDeHOWBlzKRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6486002)(478600001)(26005)(83380400001)(86362001)(38100700002)(186003)(6512007)(36756003)(2616005)(6666004)(6506007)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(5660300002)(316002)(8936002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B79rcNWm88tLo4PZUFxbX1lUUPrpi6tFW9vic0PSUfSoki2faJV5eKsHpqr8?=
 =?us-ascii?Q?HHZ4pT7ndUGytrwQ76YsKlrSlZSqEZ6EBde6dC+s3PSTdh14fCzFIXVc8N8K?=
 =?us-ascii?Q?j/r3vi7//9dd9bnGOyIR3oWWfPdIiG7O/YoPlnoDVHnVkM72JbICs3FrSyk5?=
 =?us-ascii?Q?fk8dkMTe2P+p6Dwe/4wYbzMSBn+kuAVzjW714aUHFhAoLyXmGS1W16LSTqeX?=
 =?us-ascii?Q?200wTtNTqK7IM++XHo9xlpvyikT3VrkhEFnGm1ejWq/uppJiH8oIHGkJ9gwG?=
 =?us-ascii?Q?YklsEtXkCRvfwa9TIC69uFt0bY9Ij6DyMFVkzk04YwcZVQJl2M5IPwMdpcDE?=
 =?us-ascii?Q?CZvINKNsfyXE+cjHUxeQTaS05nAShrvPDhZ8g0JoCbPsvp1eyz+0OVA5+yaU?=
 =?us-ascii?Q?gCfZpZf+RKYkfNdx56QKzithe/XzXDi7diMctGTjTAjCBsZrqp+h5akdwHj0?=
 =?us-ascii?Q?xorpP4Dpro3953qBSx+oBDHP8kUFqsWGI1K9JpDBE47lVbnCpKKiZMXP0m+k?=
 =?us-ascii?Q?LL5idPg7TY+bwcTlpJFvaXl5InWjMWZ/8n84pyd0FfVxUCK/fLox8sPMEG6d?=
 =?us-ascii?Q?eW3vz7McJC3zvohSwvT8kIkHg2baWgeba6Glf0tnGq8KFM/22sCsvAY86NPc?=
 =?us-ascii?Q?cRCLEiNVWulnD2NKjBH54HAq0a7aMdYaIA2XA6mVBDCcUh4YqQp4aBlE6aNR?=
 =?us-ascii?Q?6sSmjn13tsQDzaLfU0wy3uFa1WmpQLh0n20nlOk3Otgf+SkUA90N8ixZjjz8?=
 =?us-ascii?Q?B767vBeoMpxqq/7kxOc1k66NyGRzfOBuK5OkpQKgc8R/o/n3aqJUqH6GK0wB?=
 =?us-ascii?Q?QlAQcem4+A3owWkNC1M26cs9kMVjUvy0Wrl0hLiyhZ3LEsvjAvQl3r1N05QA?=
 =?us-ascii?Q?8iodNFttTWeQMJnWf5XnsOXpfjAnUUfswdg/KG0gmafWYRWBgk8p3yDRy7g8?=
 =?us-ascii?Q?t43s6eh/AVTnlNth/X5SE2ygKxBRu4Aqcmv6r9BuoRPQ9BTFQamjp9wm14R+?=
 =?us-ascii?Q?Il3oj/+fUAEYLFgu3ZiEKfmv97wWnE0L4VIOxHwuPBnACnEfjzUs64DyOEPN?=
 =?us-ascii?Q?LTvOqAiTX4J5ti+a8noIwmgFn1otTR3J/4dyaLNViInW5+RNDAyk3QU6MrZ/?=
 =?us-ascii?Q?G/iTfufYCS/8v093Ru17kDhwDj1W61XG5uWPbTtiTD3fozgVRsWY1wEm39me?=
 =?us-ascii?Q?4F1jZDs/FszoYPMSfAw0e0QY/AUlmAD3VuE214p4Nsi3IANyOagFn6wh+xrq?=
 =?us-ascii?Q?uH8lEmJCs343VypIuipf985oQ/FTYNrOa691l94AE/MvFlOR0jgMS1ZXalWs?=
 =?us-ascii?Q?/Xezik2xsWNpmilG+kHIwrvT01SbAzQr5P/xql+7F8h2/QEYpQGJO/FRP2cW?=
 =?us-ascii?Q?KMlWLxCOVfYek+IUqOIGCooldDM3KWF9hEMXkIYKB6AKaGwr0LVbB2ztlkhN?=
 =?us-ascii?Q?Rv3eszommZYFr+QTyZm9A4ilNI1DjzHA9bxnYZv6w7uznTaez8CsML6AptMY?=
 =?us-ascii?Q?7nvzSdZxi0zWFQMVGfizzTimezQE0+6qdnEl5iFNRIrow5+8CAnOnEw9D+uK?=
 =?us-ascii?Q?5U/s3A/kmplHkTXg+F/mnnGhd1UK/5f98f+tWKn0q9aK540G0za5KOBsA4Ms?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: khBGLnMWttJY7WibCE39n2Q+GzSOt5XGpbeYlhk1pRuKJqqNVkQm/A4Clgi2kn0y02UKBRA8QPkGMA0EPTF8Tq0YBYSEgt12XBwgf96l4gwYNJTsQ/FKPt5Yx/wXaVDHSMSa7AsMs6fV+zEdKr2SKnesIFsZ5Tx2d/n77bLT55zACGOBx6anQTptWWX41yibn3V6LfgA5CgppbiX41lgyP5hWD0C37qLs5qrrWlozy+WmiGWsNWT/hznafbnNVLLKHc71vZ6D0IUvEB3zygI31Io76USpISsaUBOf6yENnMCnYdfsAZwgbC1R4lju8k7Q2oKme0sdf3h4dbf3ipunAAqyYkKircpw9qJyuKU4tt3wt9qNItxusX0gSVluKOw8Gd8nwMxppa3jutT2BipNcvTele0nhMcgC6/CruXAbTBymEfgyQn0tCj7CzsD5WSx6XTuh5U5UjbxjcWxkcuaRSBWVbU9wgy9iw5+sQrXGQkBJhJvcDCwPhC41rxuLpCgD4YLRL5wMZyKG3s2JZeA0NH0r/85JESd2CICsOEjNYjhbbls/dkqJfuEhKm0eTygTTUc6COJ3x8h3xKAW32T1Dy0L67FRNzjw0mte+n2waALlNjRSV2tKoy5HZPNXKm8fVX3XfmPQ97MKy1RAYkeDXBzH1nDiaigJ/OPFiSG0L6CxLn+PTl1P7mxzzi+H5AL/Sn9bTYyragNgDvJO5m3ckVcg1YKbM4mkgEX9cY2wFWQ4Vg6tsXAscrbfmqvAQa9MrUkoyLdf7LUo8mYNIcwWTS77V3x1G9ZeBpUdxcIic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e60a44-da3c-4d03-22c8-08db01a28634
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 02:42:55.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI47rQg7WrlE0rgKUra1X/zUe45/D/wXhp9sFHXd5dXIrBwMfhBCHq1LM3beW/P+S1lr+ZZD7JMeAb3h9Ux+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290025
X-Proofpoint-GUID: 4p618NACJlcXbq4i1ZmoAq02JGew-uu1
X-Proofpoint-ORIG-GUID: 4p618NACJlcXbq4i1ZmoAq02JGew-uu1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fixes the buffer overflow warnings, by using snprintf instead of
sprintf.

fstest.c:95:20: warning: '/file' directive writing 5 bytes into a region of size between 1 and 1024 [-Wformat-overflow=]
  sprintf(fname, "%s/file%d", dir, fnum);
                    ^~~~~
fstest.c:166:20: warning: '/file' directive writing 5 bytes into a region of size between 1 and 1024 [-Wformat-overflow=]
  sprintf(fname, "%s/file%d", dir, fnum);

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/fstest.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/fstest.c b/src/fstest.c
index e4b9e081144a..4f6dc643dd12 100644
--- a/src/fstest.c
+++ b/src/fstest.c
@@ -88,11 +88,16 @@ static void check_buffer(uchar *buf, int loop, int child, int fnum, int ofs)
 static void create_file(const char *dir, int loop, int child, int fnum)
 {
 	char *buf;
-	int size, fd;
+	int size, fd, ret;
 	char fname[1024];
 
 	buf = x_malloc(block_size);
-	sprintf(fname, "%s/file%d", dir, fnum);
+	ret = snprintf(fname, sizeof(fname), "%s/file%d", dir, fnum);
+	if (ret < 0 || ret >= sizeof(fname)) {
+		fprintf(stderr,"file path '%s' too long %d\n", dir, ret);
+		exit(1);
+	}
+
 	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC | (use_sync?O_SYNC:0), 0644);
 	if (fd == -1) {
 		perror(fname);
@@ -158,12 +163,16 @@ bozo!
 static void check_file(const char *dir, int loop, int child, int fnum)
 {
 	uchar *buf;
-	int size, fd;
+	int size, fd, ret;
 	char fname[1024];
 
 	buf = x_malloc(block_size);
 
-	sprintf(fname, "%s/file%d", dir, fnum);
+	ret = snprintf(fname, sizeof(fname), "%s/file%d", dir, fnum);
+	if (ret < 0 || ret >= sizeof(fname)) {
+		fprintf(stderr,"file path is '%s' too long %d\n", dir, ret);
+		exit(1);
+	}
 	fd = open(fname, O_RDONLY);
 	if (fd == -1) {
 		perror(fname);
-- 
2.38.1

