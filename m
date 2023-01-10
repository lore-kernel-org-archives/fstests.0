Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56AC54EBC
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjAJRXM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjAJRWg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 12:22:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9530542
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 09:22:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj0DMuQmlhxJMngjX/Tr/7GCA8hAjDLDILFRpSOgWO5+WAYy4ezvvQfoVl0hVZnzdWVcuF7GmcX9C+wnsNoiLIbYMwhpKQ5SNRJVoezaT05YjXC76+TeXUVTzPCd8ckp88op1h7p75q2+RXejXZi80ReWYzisZdOkrcOIAYh8GKvjR+cA+kW8mFC/uiRzOOz4ZtN6e90pgP+U83b9uEg6d+MJk8fQ4AMeEmnYLgHmu8z31DiykoDcedtisnHRaF80rjenOjFwr2Mu3IwepkBDltITI/Ke5z7XuzNBbMoRvIlF+jUxtis+yh9Brzc+27bKYaFJHyDEGloeSC1hfGH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/pd3gqNPz5SqGzug1KEMCGVPKmKOMqs2Z3Xb+0AFcE=;
 b=bZdYmzfyb3ZY59ENOJBphcZeyAhsuFaUm4qnXlN35JnkdDHnGVnV+o+vDJ+DmktufLYrS0HhKA/+IC3OY0SbuNfsJgDVROaA1Vr64aYWTg+EAB/5v8isFIndYgh4giucu+HnqCgT99ahdcRR7hpIP7znwxKzQfo6ujpIV5nrJNNSbL3Ec7ndwRCCz3Bgxl7RrMKG3b0eo6ZacZr61zj8hf0XYhLKDKq3oS0vr+LsKne72cBjzkQ08clmLH/laMcIazQ5v08npwskd6Jiio/UbXfc6U6+op2xNM0p416UQbw0Okanlt962/ouAgAzs7fNE29EE1m74cKfAiLF8rpgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/pd3gqNPz5SqGzug1KEMCGVPKmKOMqs2Z3Xb+0AFcE=;
 b=ZT0L2hoTV+uQDDtOmX94pSZeUtmw7vByarP1IS/WLXODTZQxejHYSarAgT6St/Amh6pWfuABdwgmjSkB9MXTg0FGHrbxdNRn6ByGh5XOgyl4ONORt5xaJ9Y1a7QGjZGAMR9N8P0F8c6A3Mduokz9PHFmQAF4u3FZNorsWIJKBWDygV3ZDr7V5HwNrNeC7EPyqiTRbuYK7yFjBJRnjKOtI3LL9TqyUkQ80BtCeANuW/1uM2Z0pTRHfVapT3NOvRe+HGi8PV1vxhkZhvK/z10cY7Cx3iYlqRPFmXPzVk7DgOliVFs43OlNyAeTnBWOcgLretW+IcvEWiU0C9vHfsfN3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by PAXPR04MB8671.eurprd04.prod.outlook.com
 (2603:10a6:102:21e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 17:22:32 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 17:22:31 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Wed, 11 Jan 2023 01:22:21 +0800
Message-Id: <20230110172221.24710-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2671:EE_|PAXPR04MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bbe371-5059-4863-1d04-08daf32f41bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh9Lnpnxq4dlaJEqX/umx+3vD7ANzqw2+PtMqyTchtkq0SBVAG2cUYmptoVtOCcJMiTwXMg2cnxOP2hkpXpKLwpTqIw5myf/U47ct/EKqNwLnSCzuXQIhqmvXtqvPm6flP1UZ2w7ujpONvmgbXfzf7+CrWhoSYXS2qoCIwx0wXrQt+HXvGzdt7/5GS/4zo9JfYBo8cahdQhd2h/heA4ff26AjlU2OnKwndXtebVAku9QY534M/8+aYS7fEW0B3fix2Z2lDUMIoGrP8Wqpj5pRqtfKWLcy7Fl+iSuuWBZaoguh6LX9XZmnRzmlqStnmINu7wAIWT0pRwM+KbCjvbDSS6Ol1cun3L6Q/P9xr0OyhyJCgSENgl3laTmd4Lr1jtP84V+GWwsvgHNoEDJc3x8NRCseQKo5HveC72HHTekAZ6FW2y3Mf5ygpNZDGfmdMw3/q0GTu7H/ApEL/YP6F7rwh+QFL2gOgLOm7lx5JbHERYkmdBSMpiZ70Fn72Og7Rri3Sfl64abCMdLC4waK1g4fK2Io2ygZipfYCcVr5lRl7z0vKqZKOl+4/DG/NmxeOs7rbh40KJgb5Vp9ROKL07UZhJv0KDhyrghl62FzzutNf71HjaqTCK113GOu6xzPL5lCagOwGeEsqFdPzNbNB3mSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(6506007)(478600001)(6486002)(1076003)(107886003)(186003)(6916009)(6512007)(66476007)(8676002)(66946007)(6666004)(41300700001)(2616005)(4326008)(316002)(83380400001)(86362001)(38100700002)(66556008)(2906002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoxMPit+mZIdVziolWK5FsIs7GMCZlUcFY9hV6TIjC/W4TEPs2jG04IpY81T?=
 =?us-ascii?Q?C6DfXp63bS85hNYDI0Wd4F3TajrEPmwdQQuGf2+uNGLKyoGMLfa/Rcrz9grn?=
 =?us-ascii?Q?chPdsuNg24L6DlorYcSFKu9gaO5k2lTE4t1HQs2TEYpSHExvnl7KxXYOk2kN?=
 =?us-ascii?Q?EPSdZ8H4fGxjmVpLOrH9fn10ezDc/5wce2qL/VfagXTPSN5hDYWTFQuXO/fg?=
 =?us-ascii?Q?Gen+WbYLGcEFf+TTOdswbtJt6w5SO09EmKgOVAu+T4hLNzbSVIMgmtkJHoT2?=
 =?us-ascii?Q?XOZOLLBoNf37l/m3bJC3SMYbXd88MIZKUehWSujNKFjJvpJ1+pXuTcgrdHAB?=
 =?us-ascii?Q?E/0EuR6xKKOD3diwKXJf9LDgdSPIY8dASaNzjhdh6oT2rQ97UjYJU3kegpJq?=
 =?us-ascii?Q?N9lfxeAD168bneq+BpihseSNr76sUB3Lypb83H73QEN4fThjL2g5P8sGJEFe?=
 =?us-ascii?Q?ugO8zfeG0fRiyj3spXTJ7WNNwGWIsa7LHhw5ulGdVJn3YEseQPjArt5YJ3qv?=
 =?us-ascii?Q?mvN5Fkzw126g8nvTtXJgczCAEsOwHwh0TLgnMfcfT4jgpBiFyLYHS+4Oq1GJ?=
 =?us-ascii?Q?UOLUyp0o9BB/hKppDy6fom1PZBmPdsmn2iJJnyKyZSgtBUeLm6f3/fdDYv9g?=
 =?us-ascii?Q?7Fi+f9Lj+VfnbXa8NNZOPcpcv5zW60nyAN4xnsLSCwuYeu0toIKRQNxofhTo?=
 =?us-ascii?Q?eQUCZ4oMtvTaXxdP1GQCG8CIqgcVWuu9h7BjIQIgboaHGzaceqX7fWfRyj67?=
 =?us-ascii?Q?5dWKvRY1zXQlkxK3cmjKy/GIg50/W5bmuuu0Ypk2LVyVycqIiqj8fI/Gq0Qy?=
 =?us-ascii?Q?Bx+br7ot1W+6o4pMUtcrvr+4uTjHWVcMWVsVMvuKSepfSSkmAu1CtN+TnCQu?=
 =?us-ascii?Q?VgbnIeZ7vh9pqrFGSOGXqfc0SP6ab1LZuE7qlxGm5gzirqnpZGFgevrl4R8s?=
 =?us-ascii?Q?inhOV2phv5f3m434p5fvC6xbtYsOfAsb2AvQ0dqIF1zVbCNPnxf56aIKSuJv?=
 =?us-ascii?Q?8jdxwJOKwLUkJalU0nrwgwFfMUmMnckJURWWuumYrfhCamq49XEnRZCrmdFI?=
 =?us-ascii?Q?Q9RuLabUpuXfClM0o6F+cTokqZDn+BvbGQdYK9kjtiMvr41K3g6qCRo5kZRo?=
 =?us-ascii?Q?ANd0tD3rL88LwupGdl67PBdFUsymIu8stEyc1BOmfA7mQhNvikgRJbRr+V5j?=
 =?us-ascii?Q?25M52WLv6c9t0HcC6YX6gNJtCD3aVRKOaDWOW7iZTysA7sWQcisVo2BnCauD?=
 =?us-ascii?Q?uZkBKQmKIV+qbN7CSzUUNCj4RPzQdhIX9TncBmeCQDtP96OPJ9GeXNty7vUk?=
 =?us-ascii?Q?88XWQd7hi3UFQrWM9ruR/IY5Ycra2LlWKp3cOSVsCaUuM3YK1AODCARou8T6?=
 =?us-ascii?Q?Otiz0wkH3JMdhEGGO8cWKeEW5s+jq3vLSsomBJaB/UTjVEgEah8uoh4mjEIN?=
 =?us-ascii?Q?zrtBe0uFm5sKXx9ZSWr6Lt9XKthueasbivsiEkPuRaHN3wl4US3xCyGIkVLq?=
 =?us-ascii?Q?l6hsYMVX2M1+RKiyORD+y0NtuTCzcOegNLD5pociwz0d5hTGiFnIxeSxoGdy?=
 =?us-ascii?Q?VXTGVLxsWSiDCTT2BGivLLPRE7zJnccpe9v55HxC1FEkt7WN9x6KO+uaEUJl?=
 =?us-ascii?Q?8/8M3LMcBPogWAA1Q2Wuuwg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bbe371-5059-4863-1d04-08daf32f41bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:22:31.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOnK/ImuEY4H+dgeyo/nxEgeMTcEMwf995SpchRnHD+Nxv1LxSY9V8iDcMJISG1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8671
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
profiles. For example, skip raid56 as it's not supported.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/011 | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6c3d037f..b9d175d1 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -22,6 +22,8 @@
 . ./common/preamble
 _begin_fstest auto replace volume
 
+_btrfs_get_profile_configs
+
 noise_pid=0
 
 # Override the default cleanup function.
@@ -237,18 +239,44 @@ btrfs_replace_test()
 	fi
 }
 
-workout "-m single -d single" 1 no 64
+if [[ "${_btrfs_profile_configs[@]}" =~ "-m single -d single" ]]; then
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
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m dup -d single" ]]; then
+		workout "-m dup -d single" 1 no 64
+		workout "-m dup -d single" 1 cancel 1024
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid0 -d raid0" ]]; then
+		workout "-m raid0 -d raid0" 2 no 64
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid1 -d raid1" ]]; then
+		workout "-m raid1 -d raid1" 2 no 2048
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid10 -d raid10" ]]; then
+		workout "-m raid10 -d raid10" 4 no 64
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m single -d single" ]]; then
+		workout "-m single -d single -M" 1 no 64
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m dup -d dup" ]]; then
+		workout "-m dup -d dup -M" 1 no 64
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid5 -d raid5" ]]; then
+		workout "-m raid5 -d raid5" 2 no 64
+	fi
+
+	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid6 -d raid6" ]]; then
+		workout "-m raid6 -d raid6" 3 no 64
+	fi
 fi
 
 echo "*** done"
-- 
2.35.3

