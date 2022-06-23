Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00915C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiFWQJF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiFWQIo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 12:08:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7225EB9
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 09:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6vyL8TLXgjCbBr/MYYlXWZpsjXZQJUTsobX3T37qerRSh932kEDUHmC+oDKID26576pNTHPXF9bCfgS49hJhmMOMjrDRvHtg+WiOnmN86wzcoM3N4bnM/SuzH6Almy9OYlZxxAabX2PDP+A+/yM4btXPteSAdIVZmP4oZ8y1FlZieQaR5uOvECHzsEGBdfxTPCnowMwkjujCMmQZdSU9vLK4o1+zWDkQw3EFPrlypRrcYGoG9pdaz61MJngXi5N/rtWrF5kP0LS5E/vqVsGU4IF7GUwR+IRh2A8mvW422hS0hChnIVhhYl4ZDjHzSrSnfKuIGuW+DFT2LsDVtWnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NglPQPsrIVpFeoQWtrTBHFKLaCdsSD8KU38YNgOVqJk=;
 b=ZORK+FRbHkSkEkgWFRJcMzWRQbpqLJ8SSt0nTBGbbyFYUo49iJ5cOW2TKdAfK5SLUi7LLJCy3hXgvn6IMxof3AzqM10il794F3aakWacyPZJn3OpUoDsIx+7NS8rO6gbcswh7OwD7/X7K7K+EfQLD7NiZpGwozeOB8T9hkerOKmu94I7TiU3EBH/EmTcv347+vhzR2HTlQZVEtSmePwqCqHMZPO09+ydl/YHh77RUfC3hBiGaeWkYM77yPwX1HtPcHfbVMzN6zk4sRyZnbHx0WyB5V1YBo/O0sd9xRgiKkiLZB4Vlz0bkDsCGUaZW9/iB7NkCUWja1djEqJw9xfKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NglPQPsrIVpFeoQWtrTBHFKLaCdsSD8KU38YNgOVqJk=;
 b=1gdzoyZ9BWigvX+DwnscMfV8Vbfth5bPPArQdQdOf+Fl82ECVIxpjWVRNJflIzzB6kbhaBnBPry88bPz1tUMvrrQDI/Me4bhxcCKzNmnSbuNOoMfR5PfH5/qk62LxWGPV3RkpQ7I4g1HkW1hSmmbd/DX7TOqyk6HTqgkMzTn1fjxCZVsR8Z9x+H7n1C842A3xOVHojdkXlgqbgP4FiqP8W6TlIV4E16jRlxfnfr7rrgIEXBMmeovqh+ju/Z2xI6G1w/hLBEz9m1y21wzJs+MHq6V21sJkItqBK4TkoLFMTXxwzkIm/Qwe41lbTx3hwfkqDmZsMrXTZIbz0S6M49RfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by PAXPR04MB8320.eurprd04.prod.outlook.com
 (2603:10a6:102:1cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 16:08:32 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5%9]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 16:08:32 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH] common/config: Fix use of MKFS_OPTIONS
Date:   Fri, 24 Jun 2022 00:08:25 +0800
Message-Id: <20220623160825.31788-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1788f531-f15c-49b3-9b71-08da55329eae
X-MS-TrafficTypeDiagnostic: PAXPR04MB8320:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0tD8rHLeNioGUbnHVsnn9XG/1ZS0JbryGE6dhj1oESBq+622YrcwMD2EzVcOs/vpGIHooM/rGTLjxSqBSKVib0ILbW2SnmbcHH7zpdHQrn7fUNfEXcpavgJYpX3l7mVulTGi4PrjRWZhpntj3SjuVxpWLO8ayYOahxn81WnK39w+ttQRWx8qahxVP8CDOtNjDJdkhOIco8dSzd1uVNm7/fsikl7e8cYdLSZtLr5Bv4CjP2pIPealWLgiawiGl9k7edIbKj5gdxbrlRWs+LZP29qTJ1Nj9OORt00Ocy11JKKeVkVbxqiKFLV2L/ZnKbddDJ1YKIoLHszhb2sp/g+wHKgWKUHy3nnAAXKKcfnTUizm2CT3CZ4dyWMgLScYQBqut7fo15OtceF/vQpy9Q7vpLIEq5h9sjAtY8rjc74U4mdaIL7DdMtpRVmWOK1pmHMQRqffyljJ7xjmkxuKAjZ1agSS2LjgDz2G2z9egZlIOo92iKdFyXZgzpSFcpqlHPHEt/2UQrj+qvIIh8F6q4lj7VsMFNVpPDed0S8JOQfgPE3rtWxnhGdPmvrEi6RLRx7qiRrtVQlZAw9RVAd+hP5amwpv0Lm7VV0UkVjC2rPnXalYl7SCtWQccuVr1qGUC5qa8LVWLBvjg14y3GjRNz1sc3EWc1FwtoAeVORCkmU2hDlNkZpmiCmbXvAHUl9hNeweH9Io52mxnQL8u0ymgh93Mu/lTMkqttgscVtE2xhI+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(107886003)(5660300002)(6512007)(1076003)(86362001)(38100700002)(4326008)(6916009)(6506007)(41300700001)(6666004)(2616005)(83380400001)(2906002)(316002)(8936002)(66476007)(8676002)(36756003)(6486002)(478600001)(66556008)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGQtp+5cvw1pVTJWro0Sej22aXy1xkUuoLlpVVWaTZwibTXgiRiTFmQn9lPr?=
 =?us-ascii?Q?3Kx4rwEC4pOIRnF8fIWjslE0rhw+k2bqdnJpub6Lz8NHZVWti0jrPxuE4Xzs?=
 =?us-ascii?Q?eD/BY5fapFoW+tD4T0uSN8y38xPHlHFpeDFkWyjDrFh+JWvn/LALhWTCiKuh?=
 =?us-ascii?Q?XErZTbbOb1OIa9uVKkK/0Ce/dcB6emxCkC7tynnzhodUP5pCpZl74cGciekH?=
 =?us-ascii?Q?C1FjPOyIpk7JYj8q2rPDNFtdCPUCso+mUlSNZDpczk1vFIRb4+fy3CjBFypt?=
 =?us-ascii?Q?0l5L5JrUNYSAFNRO0FHQ7X4H9gpZsw+JAsEBBXCjD/OBa9rQY8kf5wrM1nDR?=
 =?us-ascii?Q?erFqKbNbkmRx6GHoj7mUehNn9Kk9K2PSv8Q+4x5+WaYSOC7DnOIc2uwMGxif?=
 =?us-ascii?Q?FrF7luMKZpOWnEsz4v0IZ3XghxubJrEKChUIGtnme6GCoOU+r1scdftOsIqr?=
 =?us-ascii?Q?31y4zOEBLKgZyqqlP9lggVOed34VBDOEum2kxNiV6VL0VyG54I4SQTihdoPE?=
 =?us-ascii?Q?J9ITkW9uYXf2TF1IZtZv92yGYBR38oFVcXS2FarAwjCLo8sikK6ehcM3VFx+?=
 =?us-ascii?Q?FpYB9uUSHm/nmTMT1NEfWw6yV4RkYQsb3qRUGj0/CbYO0JURVrlICZxQlWOz?=
 =?us-ascii?Q?rrvsGm40cEp4qIUpyItuTX03R2LAHhISFtNiRvF1iizoWg65xby4VhIcDtLB?=
 =?us-ascii?Q?WDjAAHfXUERQoqr9h51bnV4n2ksOhN9pHqW9z7+CUmRVwK4g9BeeWtpdPWIx?=
 =?us-ascii?Q?CDTKqcXD4e1BGkYZRGetowP3PM84q9W8RwNv5P78Dcmr5LsqrGriEVm0SLtR?=
 =?us-ascii?Q?FaQrVtdS27ZVK1bVWr8iQYAn7liB7EUYnDY1XNqUUtACqdhDHZiPluLOV8yi?=
 =?us-ascii?Q?EBQWqgolKsMQNgrgMQiZn29QVw5A/T7+1zsHvxzFNXbGaPflNapEgd7wWRqs?=
 =?us-ascii?Q?n2SDBRFlAdbNpqCmSMzdMts94KSCqNb+AE7KI41pWfloTEeXmD2tzdTeJf9r?=
 =?us-ascii?Q?dfd4L7a/ssDs2Flf3PrZyoL9VwHxbU3X/mSriVRlWEUrPJwEASCiWbuP3y5L?=
 =?us-ascii?Q?6P75ENFFxCUib728tYyIINhgjHwO5kNCwhQDJW6WnckBzA6lfMOmLqBGytjm?=
 =?us-ascii?Q?G0tB3Dh+o8kUil92ptGREcqJbxaNDox/z1mgkoZ7tgDdx2HjuR9HFU3LkecD?=
 =?us-ascii?Q?qhhZUXq8TDbp5xzkkO+MpeFJo2U+f7XhTeY1h9KKR/POwzF8qLFxeGCsxpfD?=
 =?us-ascii?Q?iRR8JbOKcS6I6EM6qHvRlXVlagSj+19uSwTsMswEpSdX93xE30sdupuUVgg0?=
 =?us-ascii?Q?JavJhbDuE/4xcRvKnukgAS6ce+RkgeEIpNmT2Fokqm/Wqgps86B+cYNkuyyi?=
 =?us-ascii?Q?8pJOtTqO2q0zB7DXZt73JHtDOXD5W6zSMPg9lMcYqJlThMZ3pIzWfEgGGSQf?=
 =?us-ascii?Q?F2hNeGXInC9GJHBZPz+85k+xF1SMBva5U5wNOQ/s7aEp85paYdgJ2DTbPDd/?=
 =?us-ascii?Q?tNvvCtTg4AS7SGKrc+GMxqwqWv5zvjYgOw0jPu6TaLqqjdZfyiGciAuhauIn?=
 =?us-ascii?Q?dYyb6iA3nOqZOG81s3yGSrYXEsMyA4qg/l4XV2CVT4HXknSTxg46NgPPodiH?=
 =?us-ascii?Q?+tzobfz2A3+2H8om/o3pAcI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1788f531-f15c-49b3-9b71-08da55329eae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 16:08:32.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BM5qPwiuIHQIEbGxvRKDE1HcDHSa9/sgHx8xYVc7vi1+EfsQ2+npn6w/EmUpS2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_scratch_mkfs_sized() only receive integer number of bytes as a valid
input. But if the MKFS_OPTIONS variable exists, it will use the value of
block size in MKFS_OPTIONS to override input. In case of
MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This
will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
btrfs.

Therefore, add validation check to force MKFS_OPTIONS to use pure
integer in bytes for any size value.

Signed-off-by: An Long <lan@suse.com>
---
 README        | 3 ++-
 common/config | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 80d148be..7c2d3334 100644
--- a/README
+++ b/README
@@ -241,7 +241,8 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
-
+ - If MKFS_OPTIONS is used, the size value must be an integer number of bytes
+   without units. For example, set MKFS_OPTIONS="-b 4096" but not "-b 4k".
 ______________________
 USING THE FSQA SUITE
 ______________________
diff --git a/common/config b/common/config
index de3aba15..ec723ac4 100644
--- a/common/config
+++ b/common/config
@@ -896,5 +896,10 @@ else
 	fi
 fi
 
+# check the size value in $MKFS_OPTIONS is an integer
+if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
+        _fatal "error: \$MKFS_OPTIONS: Only number in bytes is allowed, no units."
+fi
+
 # make sure this script returns success
 /bin/true
-- 
2.35.3

