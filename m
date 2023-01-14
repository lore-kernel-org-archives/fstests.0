Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA2FC46467
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Jan 2023 03:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjANDMj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 22:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjANDMi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 22:12:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B2C892ED
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 19:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3xa1bQkcsQSHDPtHXmzEdWJKQv3vLGIchHQSK1Qml72KRKc7KDR4KDqKm8TmC5/PKzsCtKrzrE/WSfTDpSEHrOEgw9VX+rIXtIyz8eaOXuSpevwt33zd/Ud8Mfmm7j9H5Yz3MMGbovFGxhWBcPMxEzbK1npfeT5Q0jbk1Ajli7QDXXb32rkNgOsYpE3spUbzv5IhJYun/pj4kalV4qetF3+phqMCDpbCTHGqU7/onOWHCCEQvuAiU8g/0X2l7KI14Y1V/8xloNAJwgzYK05p8zVSClgLlbDG42FDeXRqUNabcnOKwLfDYxY7Ec9xN9n/Q604LkshvZNM4ZyU1Sjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhJftntoly2xW3lwLu0HPu725go7NBydOY+hiaV/gvE=;
 b=n3kr6UY9ATlhmK8GProLU7RN6pqJ6Xh4g85G6REUPD2AMduJDbix2cEYyhuzrIttdWXKM7UWqMO/qk0whlwvsYoJpajrm11baXX0pdeG2oD23Rs2XkqKGQkmLxJ74gScStFuyyhDGREYOfnT9msHQKF2Q4kgVt5+gYrjNpxDV7C06K5bY/6Mgq9KaheoiO0FQSB7lZ7XciDWiD1zsqJlgFlZOFYNRTfAcWZt4Qi2PS+Oknl1V9yXVqCYd7xlcqNDHron/0UU+lb1uPK0DinTAZASBEvXL+oR00AMk6lSOzxTVRm/fow5vjvXHnurI/PXWYPudKEYgqx7S1rkNONS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhJftntoly2xW3lwLu0HPu725go7NBydOY+hiaV/gvE=;
 b=jfa+vvKcoGtLJ3QfDf68Gsc0azJ0nz0tcKgezMMD4GZQEiZFQMBD8MtMdvtFRHawSzCi2h5JB8ZlTfDvbQGu5Sj8EUAbyPWy4VCdaEdUpxkEx1pDxn45v0d4pWc73dktpKbbeTr8Qdh4Zp0gr2OO/+eNFi8XgK8QLciFSNuPQgrSkl+R7KYpnz040NtuIIC33FjYASmlAX8obrL8kT8ikwfxUFoJvcy/1DJ2RpZrYAY05PQCnJ+qozGbq0BVxsitG7TqhLOECv6s//vCPzeRHBrqv6TG/pjG/O7LFXrPh3BAQty7bISpMXb//znD6vr/UqjoQiWD+6d4ynMixfRwdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by AM9PR04MB8453.eurprd04.prod.outlook.com
 (2603:10a6:20b:410::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 14 Jan
 2023 03:12:34 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0%6]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 03:12:34 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v3] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Sat, 14 Jan 2023 11:12:23 +0800
Message-Id: <20230114031223.7633-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111131833.471ada43@echidna.fritz.box>
References: <20230111131833.471ada43@echidna.fritz.box>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To VI1PR0401MB2671.eurprd04.prod.outlook.com (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2671:EE_|AM9PR04MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: adbc459d-1cf4-4867-3791-08daf5dd2df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMQ5hm+W4G67pfgourv6qJCSZRZoH3E5lFRJ72Lz9fcK8qJqr/AEAxZvBnOt2ZfcW5Uc9pa7ts5MFb8rH0e93tBY7Gfy65LjtUWWoFPF4cLihIi/oQIakyZ/nepi7nuZoLbZiRU52vgPfw3+NoSFipLx6YeRfYHRKR9KA7KHxgmeCj5x8gZwIJ/+2SFN/vV0CHs4udept+qeIXyg2SVeMySe7SAAv8uehVVAKK+pLNxwcLCbTVWDpc5Qg1SYIfUDlDSCGdwuceKH5KKIEbhp1vKx/R0Nikqe3zwQBQRvLia5hR47YaLLxyvv/EUln43h4sDxCYqs7ycVS3mDpDeAocKDVnsdrz3vZBKGUB8uaNYnDSTSFvDwwTuXOmfgfljkJlWaCOL6fRxcuqTteIdeOpw17RGRWBkL7/EQvlVGfblMlkypFjp1kmounBusgzkscvS7XaK1u8PaH554GnwlQ4IqJ6oezV7ACzCooTqj3gdopLSnDzVZxm4jJvt6++45lrGl7ujOk2V3mxsbW5Avr4StNLznweqc68ro6kXIWHfo6IgsdxaLkC4BL6UaK4YA8524EO9L5Mv6lpSGXR2cHzl0fdRWYhMi/V1fsjktqfhQAQMd/XQ3vGnikNTgH5sU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(36756003)(6506007)(6666004)(107886003)(6512007)(186003)(6486002)(478600001)(38100700002)(86362001)(83380400001)(2616005)(1076003)(8936002)(5660300002)(2906002)(66556008)(66946007)(6916009)(66476007)(316002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCcrSur26191XCHEXt6U0DcMjgzWTsDbFLd4MJrHamXvSsJevET6uZVTJ5mW?=
 =?us-ascii?Q?8Pr1SVdI/ZBILq9EJbadqbylpIPnBBP2/6mDC+MKsMJBJUdl+8RnXQ9qGhRC?=
 =?us-ascii?Q?M9DbO0sVTce386Kb5nUyygf004tX1MLks5xx3w0twirSIPCSIaxH4XvVxF6b?=
 =?us-ascii?Q?DKXj61csBpU1x6v/JxUHNkFqZx7WVl6m9lhcGFJl5AMaUzOCmMnysjx4GmFa?=
 =?us-ascii?Q?u7Fu0TciVdcI8KKHz4vS9TXPl6/WBecTBd2WWU6m+kV4SP2+PC2A2G9TpW5B?=
 =?us-ascii?Q?G2f/yj4pnhtT7+GSDh5EvKlcRJKd3cisKXHr+dGf6ATrO72x2EdXP7fjiQye?=
 =?us-ascii?Q?Kci36T7BjGz5Kf2/EvOHWTYB8kBZNhJRKCIWGHYWlrqyxQNep26dNSl84i8/?=
 =?us-ascii?Q?7U2LiIaB2fGBULZHJ1zmquauA6Rlbeis/Yzpt/T04rsLv0cWh/BrN5yH6ySM?=
 =?us-ascii?Q?k53V4hYsHb9cb6HXTmP8l9QstoJndax5myvOVb1F3vFHimIPvnV0by07B9MX?=
 =?us-ascii?Q?p6W+RsuL6zSzeMvAIeHV7IZ4jgVBspExirp7pJDrh6/7Cj/ThTHlDexdrag/?=
 =?us-ascii?Q?M2C36Uy1b5MwgQAXHrn6SjfJqdkdm7CZe02GCcGKQcIrovpgLFJRyCGRNJAP?=
 =?us-ascii?Q?/cFoZyUZ9wsy8a4CoEFxwFVNkUOfNCX0uHrV7mkUycSEM7gDGYq1/b6c1CYI?=
 =?us-ascii?Q?7NCNA1YHx78VRk42ojA/ooHZuplGWmx7kGJcFcik4d3ZpldlzMKWBQ9hgYHY?=
 =?us-ascii?Q?WtGTCAHVjgrGx9vC+S4Ug8lpzGpc6+QLwuuJGdhTw8ED+iA/YB5eDT75Usy/?=
 =?us-ascii?Q?/7d+99de5MsOtwpqnctABTa7RNMfC5cVTNeQx/iuBjyJoivQSY35bZ6kOYkr?=
 =?us-ascii?Q?g7VpmQhvnJGQn+piT4f4FwNXkYqhhC+/YV8Dppn3LMLGmnRzL/MiVWk6zOad?=
 =?us-ascii?Q?FBoWbUSrKGzZhJ09MjMsez3kvnGtWdEaLuEtcVp6xcfQdweke7uVhBpasKoB?=
 =?us-ascii?Q?mJU/1Ctq6LM1nAwcBn0K7wt1Vx5kFn90jz/F9aDN2USdA6iXPIcOkhOdf6FW?=
 =?us-ascii?Q?RU48e+gMpDkxHOE1Wd8Qc/p2I3lCnmINUVsWjUBnrhJiGgtYBVnuj+duTuSb?=
 =?us-ascii?Q?QM3SEhJKEEQFc30A6N0WmqqATc8dFJZyqdg76V0z7GJTmUfzsM91Jp5s6pbw?=
 =?us-ascii?Q?geTO7smxfJnRYOacjC71uLW6e9vd3D/ST3+TosoE2ejh+vd6bvsUsqphWcOa?=
 =?us-ascii?Q?rQZhuojV90nXFhx4jJ4lykOq7fL1Y/3NkF4bVNuGy2HLfCCuYTffyxA2d1V/?=
 =?us-ascii?Q?6uUDQMGYK3gmD2/b4AfT+0UqqR1oKP0bvIJGiCTTdEvcW8CV8LT9d71D15zc?=
 =?us-ascii?Q?d7z2iH3ue+Hm9bov9cqoFmSDLeqqU/JAus48QC/Lv4CVf92n2v9CPrlY1wxt?=
 =?us-ascii?Q?6Qwf7a9WtSyM2JETc8iW6I3jvJ4XIZVAyDMNCg+HAQPCNPi8CFfwk8QhAXfx?=
 =?us-ascii?Q?Ec8CkDQDB+fXXToOHVgRJ2dovutOt1OZtp7BpSYWliiXyuWLoQAvU6PBlMbw?=
 =?us-ascii?Q?tUv8Ww8p4uR+b4t5B9hdfbhUsm3wtSw9U/RvOn3uEVsarTz7x7rvyNEiyYDs?=
 =?us-ascii?Q?1qywffPqvu+8gucuD2GwsXQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbc459d-1cf4-4867-3791-08daf5dd2df4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 03:12:33.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8G3bV5QwjKxwKO7BKm0NVdMAGZNxNaHKMi5SbdwYeDbOPtDSoKthxqQuPfvHTMp
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
index 6c3d037f..b351ca2c 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -47,6 +47,7 @@ _require_scratch_nocheck
 _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
 _require_scratch_size $((10 * 1024 * 1024)) #kB
+_btrfs_get_profile_configs
 _require_command "$WIPEFS_PROG" wipefs
 
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

