Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D675C54EBD
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Jan 2023 16:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAMQi5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjAMQie (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 11:38:34 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767B42E04
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 08:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMtlHFDzUqOG5lbCUD+Rt4haWmlPOtZfjQ9nG9zD5OPNG43zq+T3ilKNqUvuaBnXXJuaQcS7sksMOgtzQELm6MyQzoHyUiuIuDrQ/SwNHpgGHu8szEecmJSIcMdSNg3CnCLmPp+iAfs7Cnc3NHyXVecQMv/HCQw+wmNxW8/jrEq5cvIifRi8P8OdWC0RqDV9osT4bebiNpQrhNjL5mxj9A/6rFt4M0XNL4KZaQc2hUYc+tWgwwQtLsPEi7kffnFzA3PeGGunRZHFZH0ZwZtyoWx54G8DlvznPURx7hu/PYKtm7SfnMCbXq7JK7kd0qPX+WtU07jr559J+8Xn48vAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw7NIeUHHdeUz1yEazQqufDcVEqzuCan+n1KTdXPBdY=;
 b=mB8TAFcakhrK+lWj0NST3vaqrlITx6rfUuzq3S4IQ7bz0vLqYHSW2VdIay7aR99A6TSzOwlxMolWs9fWVKS9LDITdUtei0AuVYePnyuapcZaJ7bCLIdmPET4x7wGRvwF9iMNezUNExUu0Yb8b+tZlNA4J7ABaiugX/er7CRd7vmc4Nx9v4rWpAivbSNJHpemU14Bw1GaWGyXb/wuEsu/UEgKONwySCiT0keWmb9Vb5/ZdhKK4KPICfrAOyDj8J+xgbCitFH8zvL6gSOZ2WWwtD2LgaFwbYQVtiCFxNX9QGxhuy4B/BAu2nR73GoDSQ1/KzuqbLzbD9SCYYauEZk7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw7NIeUHHdeUz1yEazQqufDcVEqzuCan+n1KTdXPBdY=;
 b=NByljI7O0mEJvYvbCxg1UZ4q1x72hH+6HOvZcmwdCPqRY/oWpQQeMuSPiylpM9bpwA9Qklh7pOULVozxQizAZVCcXn3Z9/m+g4k2iHgZalMd/2sxD1N8fHtFDZK4FSA6PeLCc94cap63dMIr5IkhIeTgKxpmUBpGLCb82wTC3nnUniUmUhLxaJRDxYVkFxCd8XvYN6820Z6U8XpRqe8ONAeZ8lzx1Qm24cXuaVpI4bj0e00B5FvozXlis7o5IfzzPPHFrounr1AJn2ZGpoipVTsHvaGPBp27TXna0VmwPmTh4LPFqWhgEASguVjh8tqAWgobJE/v21zk+e2Tj+WTUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by PAXPR04MB8374.eurprd04.prod.outlook.com
 (2603:10a6:102:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 16:35:57 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::376e:9292:2ffb:afb0%6]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 16:35:57 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v2] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Sat, 14 Jan 2023 00:35:47 +0800
Message-Id: <20230113163547.18036-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111131833.471ada43@echidna.fritz.box>
References: <20230111131833.471ada43@echidna.fritz.box>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2671:EE_|PAXPR04MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a3c657-87a0-4a2c-7604-08daf5843ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMGLS/e6pPhZ7ghEohMhxYApsaLqUkJWHaoX8lH9rIDVhy1AdqgY0+n0AtIKeUxmD3MYfhiVoBBTtQ9ofXnFRCjZGcJ5zTKtjInU7Uvk8wFyXHn5bDBzo4d9knqeHyIBwbk7smCjjSukDVhP8w60LVkkKGJHlirOCe2TkptOVl/lIZp9bLN8NUBZblxQoyaxaW5DLBBL0NUkU1dm0c/TgDA1hKDJAyijkjdaL6UPAxVs9a4YTPMT8XY/qp1iqJkfAY/4kHuov6OUOHGXlU8vjhCVzkqwIAYfMcrZB+UzbfFw8mruoJMhzIW/w1t88J+l8Cmw3VLA85yPrYpi8oJG/F0dFQal7m8mxxrNYl6cyQacxAaMrWvk0soIfigILQvNlyyQ6ajR7bkCXzW3nLa5pxo/Dl+Dwr37Bx9TPtn/TRgSeTMJMJLDneMBaI9oDHPyc9dS26h4rGvI5ko5z96oHpx/oEN1UhqvKhiRPfpMIa79t9yJuQeaufhXMxu5jeegWb8XXDDWC/LZBMbRFPk8W1uFKqRMU3Wq3smLIZXtFZJCxf40z1dUILnsTUuOyjYKyNWNGexX+nxkr+aAXMFnsSjMsDrJox0zXeuanIRJfJKEl23FXR08BYz8Lj8zQF78bwoGCY9xmggzG2Uiu9VzhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(6486002)(478600001)(107886003)(6666004)(6506007)(8936002)(41300700001)(316002)(6916009)(66946007)(66476007)(66556008)(8676002)(5660300002)(1076003)(38100700002)(2616005)(86362001)(186003)(83380400001)(6512007)(4326008)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAXkVFiQ3cFwtRrjCuwKZi2MW0NKBnElBn0T7qGvKnTO04Iok1lYrDG9BpDg?=
 =?us-ascii?Q?R42VstYaqqWF/cAbJ2ByKdphSOz9JmAmYoDDy3RzLUMNtTp8dVZEsXzAK1Zy?=
 =?us-ascii?Q?2Mf7YI7CJzkr9M1zu/klBBkBCDbC5QoVc2A9XXuVv7jKOqYPiq2IYzmivU37?=
 =?us-ascii?Q?3SCpkfFh4OY9W5dQQZp5xRDmCekdxh+FJQNTTclzDIqXOhcJDrAaF2UkJ6b+?=
 =?us-ascii?Q?Ql5FGefLW6SeC/VnFP3qCOxHDQXfB8GBNr3vXWKtrgYKtsTe/1Ss0AIOA6ey?=
 =?us-ascii?Q?vMFuuBTlH/+Kg2R+rEWqVG4Amcsp/A7Pz/nFmD9C5iF3M8Rj9aXlUQsPqok2?=
 =?us-ascii?Q?iVs8/bhNPyYq41kGxg/USs6C57BLldLe3LWKFu8szTvDhoUXWLalnNkCQPzH?=
 =?us-ascii?Q?IZC7xUiyrP/xXyAudnoSpyHUUmik6cFLzjS+P+Svk9TyipA5ITNthFcgRGsP?=
 =?us-ascii?Q?xe4EvaXEWQ8HCWDsfqb4kcMp8CY1/Pv1rnqNknnLIxW+0y7yEuqXB0wzX+I6?=
 =?us-ascii?Q?kXvjXGFZDPoTGGk8PrNtq444MLQA+fReqV8sG+lEmM7LL9IVnbxMElj5wKJt?=
 =?us-ascii?Q?nWw9tfo6VaRJlAMjsmXum0pvk0G7xQEURbv+i/MZQ8TM1Zna14x5Qewe9I5D?=
 =?us-ascii?Q?1X7f4yteuxHaxuKeMA+C2yzwko5AGuYGBTc3ydLhdKWiLU2sCUvMBVS1QgyE?=
 =?us-ascii?Q?nK57fnKiAW8YfZPWLpxNn5nv06Bnbw4Y6oq7OIXqxwqcCSnC7CMwS8U3AJQq?=
 =?us-ascii?Q?h3AU9H+gU0dm3p4+y5E3qdWkFau3RiTZqm5t55FfuqHnZyYKHd/1W4/Bj9K/?=
 =?us-ascii?Q?XmmNBmBvKubNAp4QhYlwni06V/YCEfCyO03HkVMhSnU5Kyg7sfe5QOsC0pCt?=
 =?us-ascii?Q?ulX8TzakKivX8lR2oSujRivjlDnMnUgb7lvFmwVXjMDgfZSkQzXgsIG4Sczf?=
 =?us-ascii?Q?hsIcqapL0iOHPFQxzJvBAnmj1yjsALgE8LsQKDjAzP3fwlageHwf9a0T5+Og?=
 =?us-ascii?Q?sLQc4QXYEcdU4HtjpXKbKagYozJQNaRhbXKCsODnnsbu+AMT53oQaZWq9QoK?=
 =?us-ascii?Q?n9jKPL7z0jjE7sh+5uCe7iTjoMvlNEEvuVWewhT+In4fiLrae9De8U0nVNBs?=
 =?us-ascii?Q?a/RU+kRAiRDg9ItISPXswLiH9mT75MWehxpyiZaM8THLQ37QCBNsuYwCDjtl?=
 =?us-ascii?Q?EUQRBZw8BkCKy3ZucyuMPMXwIdK3TJ/ei19zTb1wyr/M3Bn8OVAgRk50KhUl?=
 =?us-ascii?Q?kyndZf3odfSLQNo3gRNN5Le79PKG8RebdFRSToVTKaySmzg0aVpA4nymAPwq?=
 =?us-ascii?Q?sHSdbxOnJeRyH3TiheslgoNWFHyo/Lq8OG2RK/+0RQk2clRtoMETiiIODMTm?=
 =?us-ascii?Q?V0D0/o8tFOj2etUBRcmKfPZguHKvdY/EJ8kWYfwPuJUF8vXWJAqYc1t1FHHe?=
 =?us-ascii?Q?HFYsk7cmd8BmQ1rIGSgbN6vr8PLeoFJTVyi5pD2X65HMk1Yr7K3wng08zFAz?=
 =?us-ascii?Q?weHzZBd7GwPhZdJrFPK5rR1ZADI3WU5MHCrqjSuVBo9gtD/McYP6TkJezRJ/?=
 =?us-ascii?Q?l6kpKBEuxYQ/7PC2fFavn/DK82X25F8ByKblqZ22ep5YfdLykacRJdyJWBKG?=
 =?us-ascii?Q?ZXQg2M8ZlFYW0pKd48lQzMk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3c657-87a0-4a2c-7604-08daf5843ee4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 16:35:56.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmKS8Bpzxo2OqIPN4zmz/zU6m4cSTdyeZW1CvulRVM9UOyOmaLVaUp8qLblidGY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8374
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
profiles. For example, skip raid56 as it's not supported.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/011 | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6c3d037f..6dfa1fd6 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -22,6 +22,8 @@
 . ./common/preamble
 _begin_fstest auto replace volume
 
+_btrfs_get_profile_configs
+
 noise_pid=0
 
 # Override the default cleanup function.
@@ -237,18 +239,27 @@ btrfs_replace_test()
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

