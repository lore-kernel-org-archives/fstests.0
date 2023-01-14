Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1C8C46467
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Jan 2023 03:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjANDT1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 22:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjANDTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 22:19:25 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8388DEA
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 19:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up3u+GcVqhpQw8qfviit6sWFUTxuhiQiD6NdXhse3zhZlF3ZnYj12V6YUv880NmKK6q2CW82jaorYzqgIeBL4iNzflho4rHkJmLFlm2QkqRaSWcbUSLJl0QwKoGbyvVLD8qSPlQQFUwAx9mKR8f83ZmEy+chs4qYKav3OlW27NSce60TBJuhDj7Gsk5dFFayYAcMtQ1eZvcMlup/VJvbf/7XvhdSh3WNFQzdNF0qMSiEDnWstxqBw7FBbXaDExtH2y0XRpfX5UMBUTjv93yJ8Yo+dKAVo3PccKJe4JVaN22a9MDberK9Fz+tIB87lEGmzCfyeK1ds8mwxAje4cpTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0vEq2im92753IgNs23jHNTjOnmRF2Y+dXkR/4eXDSU=;
 b=WV94O2cik/Zd5D3ovYOSOUKJ2OmcDea5IUgzOrebvGCWZYxLXtzgi/WmPvbDiW4oiP5jfAmFblpK9h8W5lZx8OmXu1WVQ5CdVVCW+5oaFhaW0lgM0JNo/dAO8cc4TN/APwEpY2rTAS0g94R4rX0nQ832Mm9TU36KG0fATPk0zvn2DwwqZIzZWVQIwFcISjc3oG+/WgBk49/NM6s8EkEXowP/gJALsfMXDvKmSzKNIqkQ6v9jN5LNsTDHJ167ZfQAG6b+9T46QDjzSXBmNfu4/aHi5cyZyg3xwZB/M1zG6qX5PMeFLd5ggg8CJ9y9WaRqGAQK3PW43+g0fVBMGGc4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0vEq2im92753IgNs23jHNTjOnmRF2Y+dXkR/4eXDSU=;
 b=aLzx0ul5JTAbpeD6W4lP4puFyS5Z7MVBlZTG2tR1xnnncXRTEjlXLf1baLhj+q8vqTfifX6KbZe8LVG2h0t3cCmU6ObdhGHYjwlSDK9KaDrwKAsQEBIAqXQDmOs/GyH7fop15MiMu1DDKuL30J7MDF2VsQ5ht2spdxLbUYhlgOdJh7f6vM0/ID01ySqM3kW4o0Wpoapm9fUFanwUE9/UUvglBUmcAJBNWkuE2lK7ku7apuI32ZDx/qZovN4rebK7ZHXePpIt2fG6Zh7JgixU061OiJqaHW7QZnQrJt9votukjF1UBH4ZGWjCHwqJ0kfbW856CynE4jcoP9tgLYi/cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by AM9PR04MB8453.eurprd04.prod.outlook.com
 (2603:10a6:20b:410::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 14 Jan
 2023 03:19:19 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0%6]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 03:19:19 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v4] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Sat, 14 Jan 2023 11:19:09 +0800
Message-Id: <20230114031909.8294-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111131833.471ada43@echidna.fritz.box>
References: <20230111131833.471ada43@echidna.fritz.box>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2671:EE_|AM9PR04MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5155a2-094b-4c57-9f2e-08daf5de200f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bd43gBwVgQe+aI+UT6KFMqsTxJqZv6yNaXjKAYEcbp8k1uTSf2kZ6n4a/DwnLlDHrjToNSM/bUMIpSoI8IJ4m+mq1eKAeh9vyF1PjOjjoehrcvAZWtbZSmd2jooJ6tBWPKbaciObbgQy2XuHGkrhlYifRfKlU5PWrtFW6lhJUh4uIO+eCbTijB7EetnBa/2HxhrXMEo/xSfitdPWonHyWvNHQg33jIF9rkzFNMjHUDnKSG5GOjbnosp3P/o3X5SzoWjoUUUQkEwIs6sxn/kiaUpJXVARruhaxlF4B8PsgC0lhNEIJcE0/ZFILxy1DzEqTvO9ecl7tRqgo+PONCdjzTZ20jA3Mcn/Jgp9f+ZW6qieyy4MF5069PEJm0MC439N3BCC3AzLcaysrBG5z0xCFcsbJBShgw6vgt//ps+BqhzGeTv/y7K0d0BPYQG2ePwKLg6CN7YZdSaq3tu+owZblpyO+Ku4iWL0BNuQycCJh0lHZ9OdWm0yKbzvDORYTCa4b2ZRGAzeueA1KVzUttYICiLQR8MIO0HeumwzEWsyhHgwuLKqiV4L2olLfqOuayKPd3GUaq4iF3Io2yWvE1VyTQH66nXsk9Thmp0NiCOiK5rqXywmwYt8T63z45fQDdo/R4XQJaiVMntn1sGPfAQXkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(36756003)(6506007)(6666004)(107886003)(6512007)(186003)(6486002)(478600001)(38100700002)(86362001)(83380400001)(2616005)(1076003)(8936002)(5660300002)(2906002)(66556008)(66946007)(6916009)(66476007)(316002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZGzw8pN4XGXMVZJR9X54zVmYYYjJVD2bvk9mz/g3Fk+BJZPkcg9WovLS/c+?=
 =?us-ascii?Q?7FtJVgCsUEtrgo+410ETk4ISfUqpBMqVHS6EgrhXrcXlGIFaJwWilcqSBZQr?=
 =?us-ascii?Q?88AADxj0WGzfE/SietWo+5+2+fBniweqCaFrye1tQmKL2knxy+pX7DlCn99m?=
 =?us-ascii?Q?5T1+I1nCSFH3hkneii5fnBBh0RhZIruCGxFjxtt03ce3r5Bxc+p5vRVJ711J?=
 =?us-ascii?Q?OwjkMhe4Eemsj6WTjL2LL2/8rQeKqdhz9bzUjYMtZCwdJZX6XH4NQRiISIEE?=
 =?us-ascii?Q?U6yscFB2nLlt+XCabj9TtSAB1yo+WYrVlvVgG8cyjwXEVZ0kTyBk/OXRj1+a?=
 =?us-ascii?Q?MPC4PCpkBZc9esZDYpKoECF+Mu2DKgjnFCvVVolYfvgMTaRBNFq7uzpeS3ey?=
 =?us-ascii?Q?5KwkafYtZ3VFRA90FuMN76wpHFdVRBG6ZiC4jKi3ZTetkUZcAr+uBjd4v/LR?=
 =?us-ascii?Q?BY+00qpEeSIXpUvPJdZV/6DDJ7Q2d1ta+YqgSHa6KXqkhS3JfOXj7dLqUBh5?=
 =?us-ascii?Q?1yzXppXqU6jS6xZqVGDSYcw7hnnPR8NVemmVYQNPlTqvY/1TqM6ZBUAsVyTb?=
 =?us-ascii?Q?1lv+yavIRe7ltfEY9VhjSTiKzce4VbeEoJDE8EFaFlOIE0tN+pCBRoC29k/I?=
 =?us-ascii?Q?cSjMkXRC1me3OOB+tnll2r38JFP+JbKdaKIIsUFwWWik47BxKfFlmzcAGzKE?=
 =?us-ascii?Q?n4soJYgumnwH4j8PRjZAepp4vz/oADKGPv/K5jlsZlQ0m6PqDDQKkxIRxJkD?=
 =?us-ascii?Q?BOZzdE0kJwGILFwWebz1a6XBosIbozBeT2bJ7XgkHahxWSm5gmBLaMk6UxD0?=
 =?us-ascii?Q?K3DcsnbcyhdUprOhMqx8rLG/gfRjK4mSp3LYbTtsN0LXrHT/9Ti6j8iITow7?=
 =?us-ascii?Q?70XiyAApC3Up2u46f12J4yAzc/FtV+rZqW8U3p7t3bU5YezcFdv73l1SoCA3?=
 =?us-ascii?Q?D9V8E5Q1NtrQa94f1jDW5R4bXJaEyGSD4vM9XEx+ZVaOPtFx8YR1gnfm5uHJ?=
 =?us-ascii?Q?gi3geJH/SdYoYT8413O46v5owKAoRrtfoSNupnUoJ9XbC+rKZbH0SjCSxAfr?=
 =?us-ascii?Q?F5Z1QZPyBqwb0N2ARYZmIqndZTGEjz8Qad8sPpiSS2c75IlE8VUnw6cXwMgS?=
 =?us-ascii?Q?HHbRukW1Y5qudeHG/1u90L00kYoluP2AFSZCbZOAXfjfjcMPiOizaHT5CnZ0?=
 =?us-ascii?Q?AO9WU4Tlo/I29bAcqM1I33INYKCbt6lZ9J60itxbfroYWONMyH2el/kMrjxD?=
 =?us-ascii?Q?h2bugeS7+kIL4gr5bZ2SnUzKPlQc/qikWmhRmhJO5hxbX3q7yEU3AaWKLawh?=
 =?us-ascii?Q?6xL3/sZhkRSAfVjCUjmJLKBlRhPbAE7mbdMR8c7PgPcMr7IMTXah1sK+rA+G?=
 =?us-ascii?Q?nW8SpAvyeBMgngm85DZA2X4tETcpa+hoY+kskAKP2/LC+P7aFXGzW74zOK0i?=
 =?us-ascii?Q?DNj5DkiV6oq1vXsZNRunaZqPs+GyQhelyxUBrCA0uPY5QofM7R0qiParDAaW?=
 =?us-ascii?Q?1H587rKsPX9/cZhzVEKJp6cavZ6g6dIan+Zo/F3qWPjAjJ3Ses/BayIceDYd?=
 =?us-ascii?Q?3yAFcaXSivP5LJ2o66jAbrXuPYw+ZiMeouV7s2t3aC2eOayr5TTjZ5Kc0Sdh?=
 =?us-ascii?Q?UZ0Lp2e1hNivno21ObSH0bA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5155a2-094b-4c57-9f2e-08daf5de200f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 03:19:19.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts4Bttp9TLeCDacjhsBvGLB8evl+2CkX/LmE2sVrJ7G9uD7ioTpqI3PzOk6paA9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8453
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
profiles. For example, skip raid56 as it's not supported.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/011 | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6c3d037f..ac45e735 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -48,6 +48,7 @@ _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
 _require_scratch_size $((10 * 1024 * 1024)) #kB
 _require_command "$WIPEFS_PROG" wipefs
+_btrfs_get_profile_configs
 
 rm -f $tmp.*
 
@@ -237,18 +238,27 @@ btrfs_replace_test()
 	fi
 }
 
-workout "-m single -d single" 1 no 64
+if [[ "${_btrfs_profile_configs[@]}" =~ "-m single -d single"( |$) ]]; then
+	workout "-m single -d single" 1 no 64
+fi
+
 # Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
 if ! _scratch_btrfs_is_zoned; then
-	workout "-m dup -d single" 1 no 64
-	workout "-m dup -d single" 1 cancel 1024
-	workout "-m raid0 -d raid0" 2 no 64
-	workout "-m raid1 -d raid1" 2 no 2048
-	workout "-m raid10 -d raid10" 4 no 64
-	workout "-m single -d single -M" 1 no 64
-	workout "-m dup -d dup -M" 1 no 64
-	workout "-m raid5 -d raid5" 2 no 64
-	workout "-m raid6 -d raid6" 3 no 64
+	for t in "-m dup -d single:1 no 64" \
+		"-m dup -d single:1 cancel 1024" \
+		"-m raid0 -d raid0:2 no 64" \
+		"-m raid1 -d raid1:2 no 2048" \
+		"-m raid10 -d raid10:4 no 64" \
+		"-m single -d single -M:1 no 64" \
+		"-m dup -d dup -M:1 no 64" \
+		"-m raid5 -d raid5:2 no 64" \
+		"-m raid6 -d raid6:3 no 64"; do
+		mkfs_option=${t%:*}
+		workout_option=${t#*:}
+		if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
+			workout "$mkfs_option" $workout_option
+		fi
+	done
 fi
 
 echo "*** done"
-- 
2.35.3

