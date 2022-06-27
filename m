Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70910C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 14:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiF0OJE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiF0OI5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 10:08:57 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10071.outbound.protection.outlook.com [40.107.1.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E2624E
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn5huUvgUAcMDKCLWw4JIdupST0B0YgBO+oqH9qOIQW5v0iqmt2Jzc3YEbvRH/4Sllq5uw8ilMUjQSy4abZk9zdPKEeM8taM9v2QezN4U7TEiG3ovnCsi/cmQYLAR/f6MOGXOVFcsoECaj6FSt41v+LnElflCpmeUm4Jk3ixZqwK4d7w0VY0U9tyYMS4fDKr726H1poEab8eh49LvY3w/09QxC8ZXADd2KF+PgdI7InrU59hG8qNsdjZprmloPqgZam5UNUhbnPxe1sYR/7J2iOGNz7uGE3DMU+++kzGMFxsnmne1TEffcF78wPSSml7+g4v1KNEVU4iqqdm5BzvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QrSzN5fzVDUtBkooggSYkc7zX9bAHBi8USWLrRjhBI=;
 b=XrynQk0eZjLIX6cqbQHeWFX319LifJDD3Hu3/clyNUrR94SZ0sQFc90ePFPfath3DFMVok83Md0bYn7tgx9f7N6sfezdahGhblxBpy9GPRDs68+TCnZVSgCuCJWsbENuiJjsXaEpzjxaLwYKVj7XGDZfxkkCGbPsBaTUV60mjcU2Mtsh00C4xms+br9QIQcB43He4dTK5Jla0ayYi1dP8LJz3HM2siPBqOVehCQZN5Ptad47cXJSUI/xCAcCDRfvji3AsJ2esiRGt65q14J9SzgdB7UR/MKw2J5M1HdBCv7YlKbflM1UIxgtcaR2tdi33vbR3T+Yv1T2/cOR5hjdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QrSzN5fzVDUtBkooggSYkc7zX9bAHBi8USWLrRjhBI=;
 b=eknZAVeJlCNT0BSb+tNKPXyeKf6NA4BMy9pfxm/1KjV2w+ZZCNoAtDwNnJR70bAa5acsX1HzCECTvFt5S23k/RMuFg+Xn7sSXYqMNEW5U6PfpBwJdVhMwU5Vjr63AP7LJiEKxA1GthrenY2bbxEtQYyH1SIDQhZ9E58Inp4n2+O1qrNAt68I7kwpHEbXwLhGYrozgI3zK9L5+7IdFgKWbtBoN0wV2owGpW5zC0QqzWjhPt1WGxOzExZ/WlDWyA/rqqqsAY8FKGihMmaTcPO5odR27jbs6B2fxqWPZ9jVTJRVcccBSfBPmDLg9R7g/9KoB1cPHYPPBp5ASAB/i+bXlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by AM6PR04MB5141.eurprd04.prod.outlook.com
 (2603:10a6:20b:c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:08:48 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5%10]) with mapi id 15.20.5373.018; Mon, 27 Jun
 2022 14:08:47 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH 2/2] common/rc: fix input value to _scratch_mkfs_sized
Date:   Mon, 27 Jun 2022 22:08:27 +0800
Message-Id: <20220627140827.23775-3-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627140827.23775-1-lan@suse.com>
References: <20220627140827.23775-1-lan@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afaa07da-0671-4554-50eb-08da58468db0
X-MS-TrafficTypeDiagnostic: AM6PR04MB5141:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di5zofTDIOKF8TNg+qen7k4fYx+RLsTZNsd94xqbHXY2vNehdb1T5qCKeUAYKlekntppvIhCSlPN0bElak2XpOw46g6yQabkBl3/kM7i8ays9TgpOOCzqW7qGgWp35HKeM532ExIBtvQpaZ3w+mMGiEaRfGWaI4KZXlyZjimWiwsp3f8R6uXb7HbwmGd/Lwq8PFaQsAY+E3RsA6lvVej8D+ylUfRNfcWEw9YEX8MlkX8lSF//DAHaz8b2hPK/rUAbp6CeBvNNSd3dMP0N5xyTd8b2ym+hNRbGw9wR7GsGFqpuR8zVRMI3tcnvW7wVj5YfTVu6rA5D/MNeBuYuKEALyorixgjRsSk07uUwRQrkJCDz2jqdzTvz6CoSegM6NiXN7s1Xxujv4Fr5MWv+TsqFhEUUS+AWpLDb3WdlFgF0hDkwIpAsVmqp6XABXot3XUCV4tJmo4aQbxOitbJ8/e5JVVGwsUiYD0YeS1DV7WU7WeXB/QiV1I+KjEFX+ZhLJB+RUTrpNTYnqvq6+E5MFIsGu22R/F/LGOZNotrcdVCtPGp39eKVWYeGIGP4A0/4+oFzppJ0zSVFijUsam62zm1jdI4wKUadCM5F1051SNbrcJiNG518/ywocEaGf6RFwWPblu6b0LaLpEC5IFtDJo+jWEiGfMaTugFUNgdSPs/RPNuBeO6RA2EVsOk8at6Z4QWQJI+xJQd29EKkQRKRRGZcE2+KNeOBevaDempaML/fAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(346002)(396003)(2616005)(107886003)(6916009)(41300700001)(83380400001)(316002)(1076003)(8936002)(5660300002)(86362001)(6666004)(6486002)(478600001)(186003)(4326008)(66556008)(6512007)(8676002)(2906002)(38100700002)(66946007)(6506007)(36756003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgsLjA5txiG0WuF48LeMRNbX79DOSQRr9Q4ZtYpYbtCnRwxyWmNrWLcOZsAN?=
 =?us-ascii?Q?r9DNqFxJm4lZtk7ndsJqQfhH1oJjq9N9lLfH1bRwkDw3FAxngcWMJSCh/lFO?=
 =?us-ascii?Q?X7f2PpUDWI5u75HtXBzKmSRv8ZnM9BYZ1dn5E6QI3m3/hbuuaBmBmKYLsifk?=
 =?us-ascii?Q?i3nZ2l0L1gu3G6ZH4YbPc3ZkHIz8bk1ILGnxnK1X+fRobdAs6NorYsniQB8f?=
 =?us-ascii?Q?ql8QasGWHrfbBISeDvgWkuDo0ZtywfgfaF3c3xqiZlcXCAjjOIpL+JiOhe3L?=
 =?us-ascii?Q?MG//D1wQeInEvd16oxQB88r7TwC6YawB62MPdyQPJg+H1JDqW4mHDTACvrKW?=
 =?us-ascii?Q?Vgn3e67qJIW08OnOzSBYHc0uOpZyBdMUfEvN0yvGtq0vPSp6949Xmi+L4pwa?=
 =?us-ascii?Q?nlReF7BeRwYNu9feWA9kvKck5qoSaS5lGr6lzudODcg+qIY2djb921LiNcdH?=
 =?us-ascii?Q?WoG55Sl4qurW/IEfyvEEYEwmSN9bLQfWIMnkQbE/g2QOj9+l+6FOJ11PxpsT?=
 =?us-ascii?Q?Jpt2bxsU+8c+4DxS/aPSOIiIDDZPBbvq5CmgMrZJqPwx1+548o3iCLhMZmVm?=
 =?us-ascii?Q?jHT8TgyiUOQqYced7KcdheY2uwYBd76py+ARqb+oB4mugG1d2pRqwDi6RIZJ?=
 =?us-ascii?Q?DIMONF/hTW+HELbKWl+qyyNMFtRCbgOjOay8lwHBivOoOshi+bgNNAAMMsiE?=
 =?us-ascii?Q?/E0R2HQgyjUvjWenAQcBUtrz5Bg/pNBXzFQ5TiWGEqK9PRI214VaduevANE0?=
 =?us-ascii?Q?Mr4D41CsYwGMsjo8ICaiT2RvXXJEolnpmOzz8x6c0RDsO81wuVtxER3kpck2?=
 =?us-ascii?Q?bxK8jWPterm8l4huBvCekUlgJQ7IyUg3ckZZ+xJNprIGKcVk+USvUFsMZTSe?=
 =?us-ascii?Q?Abta005CO3kViADC8Y0AcFV+hzFiIp5OYt3mCUiIMaf+wT05tw8wZMdyEQXB?=
 =?us-ascii?Q?8YwRb2CKX6d3lscq5bPrRVw5it3aMiI9PBXxgfs/BItD5P438SXxK7gJuQBd?=
 =?us-ascii?Q?RUMRDG8B8ucTdypoIiYNe6m8sgWLBFaUvbpiyxx0/ru0hDGxABaktq6GTL7q?=
 =?us-ascii?Q?pnkhvYPbkEABivhvckKX2FPlGSV7gj/1KL+cN0H2zkbsyD7nwFSw2yUSpvte?=
 =?us-ascii?Q?D2ScvtPcO11CE1yyc4yo9N50Y90NTqq0AZ376ZiDYogjnIoWn7CV4dEruG2f?=
 =?us-ascii?Q?Ri/wpDrjGJvV3pD/m/hfTNmocMQSvwWJd4d0w9ekMULkwTHyxwGGqMvZT0wC?=
 =?us-ascii?Q?bywDSl3OBZTPSVZ/RkFV7M+YwOQU9zzOqPZS126bq2ZjZZqco3tG5QSyeGdg?=
 =?us-ascii?Q?r7lngT1YvrMktcOcr1nS5GeeNh9o2KPGjWTzpimDNONOs//GuV9hLmJzdPFZ?=
 =?us-ascii?Q?nwE5b9T+hP87N637+FYYle4Cs4MA8egPTmci1d8emd5y/oH+ZqAfr4EVtSpX?=
 =?us-ascii?Q?p+XI9uW2ljfU89AluF6dhnwcW98P8+ebWlbAk8scC13WQ2d/Z+gJC9DRnIUy?=
 =?us-ascii?Q?vtKsVAtQqwgAkNaQMAwSa3LSRI2tHi1MUgJ8N//riroxZRLM2gQCpUJvtnGl?=
 =?us-ascii?Q?MYsBVfBe8K1I+Qmh0K7pqY4knGD8Auh1nfb4MLBSZCUEIBCVQKVsjeAAe3p1?=
 =?us-ascii?Q?cxMWOvkOIBVz7lt9O6l7pcw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa07da-0671-4554-50eb-08da58468db0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:08:47.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw/Kk5wByXttuNQK3UsQ8lUZ11SUYBffV4NdlhvGyOkQ6ceAKUZXlfmkN4MTYHXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5141
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_scratch_mkfs_sized only receive integer number of bytes as a valid
input. But if the MKFS_OPTIONS variable exists, it will use the value of
block size in MKFS_OPTIONS to override input. In case of
MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This
will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
btrfs.

This patch depends on patch ("common/config: add _check_mkfs_block_options").

Signed-off-by: An Long <lan@suse.com>
---
 common/rc | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/common/rc b/common/rc
index 3c072c16..8b8c3b51 100644
--- a/common/rc
+++ b/common/rc
@@ -1036,21 +1036,7 @@ _scratch_mkfs_sized()
 	local blocksize=$2
 	local def_blksz
 
-	case $FSTYP in
-	xfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
-		;;
-	btrfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
-		;;
-	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
-		;;
-	jfs)
-		def_blksz=4096
-		;;
-	esac
-
+	[ -n "$FS_BLOCK_SIZE" ] && def_blksz=$FS_BLOCK_SIZE
 	[ -n "$def_blksz" ] && blocksize=$def_blksz
 	[ -z "$blocksize" ] && blocksize=4096
 
-- 
2.35.3

