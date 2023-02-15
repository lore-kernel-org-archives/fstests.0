Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71CC636D4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Feb 2023 05:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjBOFNd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBOFNc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Feb 2023 00:13:32 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875496E83
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 21:13:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH5Mz1dxE5S0gTQSay51MD93Iljfv1qv8+4DXNTfll7Rjfty/NGPJHQ/wzdCnzPaJe3V/BlDIb3OwvySqxh7SDrWczjYf++UV6eGI2mMHnC6ufPZivHieg0LnzKIb6Irre6hKLpbhHiXochIcBrdlIpTf9K7lmbxQcl4Dnqw1ZS1rodaW+HUidZZbkgXTqBL2+uND0N4yNh5ogi0xUoM1xzl4KJwudTaF78pQNECRv7E6kisOfIa7TI7tAndXXN7cN1IB0wfQ05xV+m45rTO4SVpZbIwHTYuyWaUi8XuJ79kckUCwdwQTOMh/+Bip5EBK3l8bpCy+/cVmXyvFEnRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D4dS1tVHuD0hzmrZOHCAXhzLWag8xyZQRNTLHOfUkY=;
 b=B7PEZeFm2YoS0IWqMOnIsyLKK/5ZAVJPX5KQ95WsXfjqrHqoeNH8c+tjyRkD0e0Ss6TppG4UuWK2e4n/du1X9zYDzZU2KLt0+NyUcpl2yf+SUp1D1RsJxrgmED7qnK31aC6M3yNzWllLQPLrTl0LgAuIlE8oYNylbJ9jgZWSj3C5eZ+VOe3kgzm4rAY0VxnWcm+tVCd8/WkQxPoTtIflVDeHCMMeUI1WT1tSolkaSrFhG5sjQ73Wp8QqfH5ilYi40pPQZQEkE9U8dw5RSeCM9FxDHJX/TRDfidITxgzbMBl88AgiWSxkU9UWRLTM2LIu2eY2lLzb5LRY+e+3TRiQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D4dS1tVHuD0hzmrZOHCAXhzLWag8xyZQRNTLHOfUkY=;
 b=L7ZwvzxSdV7TEUjoNaHwcszuAbHPk3nLNQ/OonlkT6wJDcDezxa4NCcUlYkifHi4p6Mt4/QbnF1RTBQ6kh6s1Nq2N4p6v6tX0jhFyeR8KA+4E7l1lsP27GXhPcR5FTfhd2K3lj0pHtUMYEnqVwDAATicdnQKmsopXjkcRnIEhzRscxIVg4gxlnKoBBIKu/j7LErDNqdCwhG9HU6QXmpgFtPeCUMHhzRWAxajkw07ViHKNPf3AQ0NYZ4L+5j8+IK0EasIPwg/XIhQqW+jaG9troqtR35+c9odA/pPMBtnto3/GRYqRfarXtkMsDtczkUg14DcB4Ywc7Mcf+DQh297Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9)
 by PA4PR04MB7566.eurprd04.prod.outlook.com (2603:10a6:102:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 05:13:29 +0000
Received: from VI1PR04MB6863.eurprd04.prod.outlook.com
 ([fe80::247a:5c9a:d3e6:6b3b]) by VI1PR04MB6863.eurprd04.prod.outlook.com
 ([fe80::247a:5c9a:d3e6:6b3b%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 05:13:29 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v6] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Wed, 15 Feb 2023 13:13:19 +0800
Message-Id: <20230215051319.10327-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111131833.471ada43@echidna.fritz.box>
References: <20230111131833.471ada43@echidna.fritz.box>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To VI1PR04MB6863.eurprd04.prod.outlook.com
 (2603:10a6:803:12f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6863:EE_|PA4PR04MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 705472e7-065c-444e-a66b-08db0f136004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJjm5W+N2wk7TWMR0QEVqHGaex0W/UrTTrU4bc8vFMY7reI5JCCxrSMgtalC4RqJYb0iR3f/K0tFdF4NK/KVAdzNbtwxUZ9LICO3ZSCUj9KWcRfDVlbCK2hDDDgEgxKZqWjCbuJ8ulYogilvFsy+x7Dr87ZmlFCqXxX+NC2qqZrNz2ED0YLSdj3s56KlkH41fJpe4fYkNdJZAtti1VGJygLUxWSBlwVmt5R6E4UmzQoGKea+frUTFsBz2Tgy38K5MJlmwbRUUXpBhDYdaUEb6xPJUdVm1WNKCB52f2GZDjMFp4PTiiIGexllFg78iUJnKOI+GEx8FSWpVd95C55Fbk2QLhDk/TLACGi2TyucIO/iU29E7b2BvfM2OOGDLu7RFf0YJDNaM6hVY7BHUXpdolEO5t528qphGhluR9YStugIqcQZ/iP0tWHiHfrx7UQPbzZoWeuv9748UdSt2AVDNmEzL37CCTVqeHNh7X27bpJEuo+l1U+OyXe6AzSIdkFwj3dqN/o8vzImvGFJJfcgOsK82UdQvs6gTHivM2P+Mo2zj0CiXay99LrE+Xli/cKAE1qpOKpTRvRJ0aWe+l2i9FCgG46suqKs3dhOEVooboC3cPORps/heNjm3+iUaU1ZuLBe6Rw5mx1Jo66RYjUXdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6863.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(478600001)(83380400001)(36756003)(2906002)(6512007)(6666004)(186003)(1076003)(5660300002)(41300700001)(8936002)(6506007)(86362001)(6486002)(107886003)(38100700002)(2616005)(6916009)(66476007)(66556008)(316002)(66946007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfnehAYTmqEvYfMXp56U9MUrrDJE0o/2vzZK5CpE90Sb/fAL27yDGnXz9fBt?=
 =?us-ascii?Q?wreEVIV8GYgOC12VxjpitftwHGqycRHt0C+MI8fsPVqBxzijiSkDmlTa52zt?=
 =?us-ascii?Q?G/nXtPWhWABw2HE5fkXPeHvB5da8YUuVlBs0EydKVB7IUJAVNsln9mB5q4pw?=
 =?us-ascii?Q?bQ7PdAotRRSVgt+7CrKcZtOLOSJhrVkv0l4avurKuAKaxYOSOHT0jPlNRf4s?=
 =?us-ascii?Q?S+Vf+XvLgy6VRlVyi9riMzt/5KY2HV/MMBm8sjINXSmew83bDAqiaEMRYBSL?=
 =?us-ascii?Q?Flf2FNTfaJVRM+FbCWtrVnyxWoT6wDW4ZfqN3tZcXNmfRY2S7iV8PFlrdznv?=
 =?us-ascii?Q?eWQIxfBlMw3nvZ8cdk6DaDMSYSBlNmd3mz8BXKEWqn8m4vryKDkipVZVlB3Q?=
 =?us-ascii?Q?di3ObA8zqiNePx0yCI/3STtC8dIymWXDT4qzaO+ML1osN8nT3azfgQ1spSrE?=
 =?us-ascii?Q?vDPxnriIpUFx6uKJ+96Js6A3cR35/FpeN6/iAXxjcjI/DgW7lNS7+uMF+y3d?=
 =?us-ascii?Q?YlhsUJcYFd/pRNQoZGoqcDXWHdgIO2Gj4tjrF1HdUM3BJWoWqIcJQoXKH98q?=
 =?us-ascii?Q?U/NUHtqOKA1G76FYD/XClTpFBBFLU0TXcBV2f70NKaAQggdb0mq1WpRVCqxW?=
 =?us-ascii?Q?KoKcG0teT3NeDLUSvzXjiigA/1wgDgEw1zFC6wu2Z1tTVUprHn0gPaTHbth0?=
 =?us-ascii?Q?FG3vKio0bDVqllKEkp2yoqLJQB1QRzUKr+umvKcKD+NLMZJfx7vRGM5H4OsE?=
 =?us-ascii?Q?cDjdxEXZWZ5GLfllSyVChJ1lnfZYMsI3pLLH0ShnmLDurHGO/sHDVch76KLW?=
 =?us-ascii?Q?pTnYGJ2MYErLa5YLkHXkvrQ5W6ZqVx2YdX0FzxjuMR5YFYQfjz9bBHcFAJoP?=
 =?us-ascii?Q?Iev2cdVHi8avtkvcFxdtt/u2g7oZIawApxj3A+6eJNdRJXZXDMobkBnKxGEe?=
 =?us-ascii?Q?0ySlt//nDUUISJ25JL0NJ+BZF57VnH2HkIf0iXdqfKyIKZoraLRKAGrUnEtu?=
 =?us-ascii?Q?Ue52Wh0VEjutCmTY68jJyD+7uU+N5/RtoGH5OAyNrGDcb6UVMiU8akwnB4SY?=
 =?us-ascii?Q?ZlNZEXdrX001dIRDDGXVY/FK9geyEnW59zRVPrPpjLVphoigZIsgBS5FwdOk?=
 =?us-ascii?Q?fNrY6Nm6ehtbPe1uEcb7yvQezFNTC5iFIl07KCJQNPLPYljNfTi5UWLqIE/x?=
 =?us-ascii?Q?VDN9xJSSbj+kHtYhM6Ela55aE3DdeGU7wBHvCEtw5Z2Fn4rsUeY76PG8pcn2?=
 =?us-ascii?Q?GUN0B/EnSQfs825mzfaLbVKoKMwT4IHGbFfGo/TVy3dCocdi7yacHvb67TS5?=
 =?us-ascii?Q?Tqmxp4OwswGUCZJb1X8TGTNKvRHHdWfU9wo1PWcsFDOHK48O7/upwFQ5DQfo?=
 =?us-ascii?Q?IfH5MXx8xtMAW+5e+V4ZShf8LGjWQgccFlsuXJsvfP2B+gTUPlx88CFVmMhZ?=
 =?us-ascii?Q?Sa6PtZDP2iCvyKaw8mxhZi4k/XaAlAvdjt8/OME7Kp56LvGhXbMfC62DDnhT?=
 =?us-ascii?Q?u1BSJfJrL5Chn9WsDYFQGSN4Fjfow/z7h7N/RcX87GAqUBSBQ92uvKk3pj5Y?=
 =?us-ascii?Q?A91QJvLcrWaScNA7CJCtuSwfRxPOzhnwDTfBclHwvlFL3C2rS5Z1OSkvanoC?=
 =?us-ascii?Q?xogAcywvq/slCg2Y6DilGoBlioKJJo6qdd5dew4E6ESS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705472e7-065c-444e-a66b-08db0f136004
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6863.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:13:29.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/gll+TWphHIsHbUJfAXn4Q7q/IKlFVxQw7bFftLeItsviLi7+jSJ4dp3zCemx8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7566
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
profeils. For example, skip raid56 as it's not supported.

For dup profile, add dup to default profile configs.

Signed-off-by: An Long <lan@suse.com>
---
 common/btrfs    |  3 +++
 tests/btrfs/011 | 30 +++++++++++++++++-------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ee673a93..6557af86 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -213,6 +213,9 @@ _btrfs_get_profile_configs()
 			"raid5:raid5"
 			"raid6:raid6"
 		)
+		if [ "$1" == "dup" ]; then
+			configs+=("dup:dup")
+		fi
 	else
 		# User-provided configurations.
 		local configs=(${BTRFS_PROFILE_CONFIGS[@]})
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6c3d037f..852742ee 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -48,6 +48,7 @@ _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
 _require_scratch_size $((10 * 1024 * 1024)) #kB
 _require_command "$WIPEFS_PROG" wipefs
+_btrfs_get_profile_configs dup
 
 rm -f $tmp.*
 
@@ -237,19 +238,22 @@ btrfs_replace_test()
 	fi
 }
 
-workout "-m single -d single" 1 no 64
-# Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
-if ! _scratch_btrfs_is_zoned; then
-	workout "-m dup -d single" 1 no 64
-	workout "-m dup -d single" 1 cancel 1024
-	workout "-m raid0 -d raid0" 2 no 64
-	workout "-m raid1 -d raid1" 2 no 2048
-	workout "-m raid10 -d raid10" 4 no 64
-	workout "-m single -d single -M" 1 no 64
-	workout "-m dup -d dup -M" 1 no 64
-	workout "-m raid5 -d raid5" 2 no 64
-	workout "-m raid6 -d raid6" 3 no 64
-fi
+for t in "-m single -d single:1 no 64" \
+	"-m dup -d single:1 no 64" \
+	"-m dup -d single:1 cancel 1024" \
+	"-m raid0 -d raid0:2 no 64" \
+	"-m raid1 -d raid1:2 no 2048" \
+	"-m raid10 -d raid10:4 no 64" \
+	"-m single -d single -M:1 no 64" \
+	"-m dup -d dup -M:1 no 64" \
+	"-m raid5 -d raid5:2 no 64" \
+	"-m raid6 -d raid6:3 no 64"; do
+	mkfs_option=${t%:*}
+	workout_option=${t#*:}
+	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
+		workout "$mkfs_option" $workout_option
+	fi
+done
 
 echo "*** done"
 status=0
-- 
2.35.3

