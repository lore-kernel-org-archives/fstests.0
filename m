Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD74C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jun 2022 04:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiFPEjL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiFPEjJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jun 2022 00:39:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76458E69
        for <fstests@vger.kernel.org>; Wed, 15 Jun 2022 21:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfHLcNozF4e7PFtJ+0AHi0CM0OqykpZHmMJcGYhCuMucMAl8aNXBu56xmCbo/JWeYYIAQcpIafYhZhpOfphuSiwJPTEZ7HDRKaGQ4DgUGo19v9KTl9qrHg8GqIsntlWnJ1ywRTA5vs+JjWLgwb9faUvWclRRegJKFybxEMfK1RHh+y87Ku+s4qg4D2CngJctHHTJY/RYWZVQDunCTWQi8vzwZOi0SdeE9xMXz02HWNNPdvnr7oaJrb+VncOKujC8AI4uFAdhFwtAYmWAkEpXA7Pfr9tnZSqhkLP4G1VK+YLzCG0ZdB/VyKGaGwZI8l5BQgwBpLtis0YoW35HDR8JcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl3yHF4xaSboBCaWj+DZLN21CXU1z2FGR7fON9cOYIk=;
 b=JWDFL47GmfkwELHXXVAjoevJepB7oPJ17qHPJfc/sK6nWRpWkngO/o4zVFIifbKAMaIL8hRxk2hCZrp9eqKQrtc6rpoF0ceqxxxixxk+ea4ABPS8pLT1nt2NIDdw2JWXzZe785V80zRLWBanpRf+MrKnOAMUjzhV0iqzNJGMzDY0M7Iwh3LqPAxW0zKT9oe7gs87DxDpYAf4f8kmuSMLp1KkjcTsLH6Q34RoOnMAXRKIY7PyJXRlt/0b22Uxw2y5HigELLNcjTY8D7m6io0/eCEE23oh73cLfcjSg6mp467WthrWC9KEN50iE5MJTc6OE+X0H2+O/uSEZPOYBOQFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl3yHF4xaSboBCaWj+DZLN21CXU1z2FGR7fON9cOYIk=;
 b=EApsjdD1aZBt2qnnZ3fhuXc5YeBT3srkB5uZZ7NCW53rx728OywQmS+5PZYVzRpKWXUwsPPydXKdXNjlMhtNb1FHANvRq13wiATNrwTIds+RQCHE028zbK8szyXpb98eHPGaW1uggx+wzKi2RCaOfShL3pFloSi8N/c5n6gESTR1Py6Rs1Z6HWbmisp79EVQ0ZJCG15g8rBYWXnkkaTI4ycN4zc16zYeaWw963U2V6DbH9cenROOn/oLkMu82COtXB0Am7XrbFEA0AJr1y51f29LJ9xaB2FRudfPaj8dPYxHjgVifwHBIYNHzJd+WX/tVVmho2aFGbu/33ZPcrTckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by DB7PR04MB4828.eurprd04.prod.outlook.com
 (2603:10a6:10:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 04:39:07 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 04:39:07 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v2 2/2] common/rc: fix input value to _scratch_mkfs_sized
Date:   Thu, 16 Jun 2022 12:38:45 +0800
Message-Id: <20220616043845.14320-3-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616043845.14320-1-lan@suse.com>
References: <20220616043845.14320-1-lan@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3c8c5c-f1c1-4943-8839-08da4f5225e6
X-MS-TrafficTypeDiagnostic: DB7PR04MB4828:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4828A42FFA89D7A968A39B1CC6AC9@DB7PR04MB4828.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9XhRnoRxdSxrtA33+eL1tqKNKhfqXq98mcepRF0Q5VSm3/KfZ2RP3t1s8xSFpUK9Z3JJl3oetI89f8p4PmLcxiG4n3nnMnwICXZAk2+b7qJjrxfewXMIBXlhXSHd01wW0nv3dLJcqGXAHnAWNDFJ+oazez4Ui8ecf7PUBEj34DQPokrF8gA739SSO3/7CwyMtf+B1xtan+AdoIoq+aKJoiGvapopzfYDN77Jf3EL9qWyfO/+A/RWuNJiuplUo453UhrJNSIBHWFqKdoD9Gi+M6nSLjsnKF1J5wt8IHYPz0tx4wMbGfj5d6NU93lAiR7xQKe4P+bMBwT1CZ6Wbp3c6AiaIQB9yU22Quq0ASuc49bnI0PbCy+NPZ0e5oF0Eu+rkWb/hS7Lq1w18++zkREW90Xf4raFRLbm2I6h8EHGVsQuMEXmplztXXwNHVOR5T+RfRzSxfMWUbSvOujvn4GR1HvxAewixpodma+WD50FkcwSQ+RzhWBxSkJwEzcLpYuMierO5Z3bJncTAmKaEkaGreDz1lSqhZepgr/zmQ8nSI9zt4wAUsMeILQRAOfotd30HV4i7EL/h2hFNxooK+Any3GjSJ6tDzAogdHGBXw1FQAeh+PZuweHbq6J12lHNlGGBgx68+4MSLP1UOY0YsjDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(186003)(1076003)(38100700002)(83380400001)(86362001)(4326008)(36756003)(66556008)(66946007)(66476007)(316002)(8676002)(6916009)(2616005)(5660300002)(6486002)(6512007)(6506007)(2906002)(8936002)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qR1zGsk1bwpe61oadmc2T35/CaPWvAcvthdIN9KrCAj8XAGuVvxPGADL3WQJ?=
 =?us-ascii?Q?nFxy82m7ftSxDbN7bpS7GfiFZGz8iyEAOsL3bNqwEI3IKYfJMX0mOM38/bLt?=
 =?us-ascii?Q?MekwDI+Z4BONhpaNM+WftQC3DBCu4vr7pYgeBekSVIK9x9lBoKLx3EXFMirD?=
 =?us-ascii?Q?7tEQ2uGfRsp5HKxgneA5LXJDInZCVumA/+4rvTEqb1dQKoHcZy0NNPTFjDp3?=
 =?us-ascii?Q?koiokk84PvSS1YGp2x12j2BHoMMfX8tM3S5zUhFuRLh0V+49WaVAHcXv0baC?=
 =?us-ascii?Q?ZkpRDgowpLFtGVG/+3AzZX0A72LFGHxQsDQ3Wzu6+LeqeooBgUKzmF5V47IC?=
 =?us-ascii?Q?Hj6cffWj45HcyBchaoG4s4+PBaad/1Y1RUNzPUz8JxvxgN95JDSuaKK8DUCg?=
 =?us-ascii?Q?WShVLpTPlotol8XbWmlozLPHTFk9t0fWP35htdfOLy7fnsZed7d3lb8PKwUO?=
 =?us-ascii?Q?ja3j5hlOg1IEWPsrUmZgjbwT0RZgOE5+pkWz3pf7OhdSD9yziqvAGHN/IQ5q?=
 =?us-ascii?Q?TrddOl74mZmdwXwUtgOZLyEaWzbrTr9/ZlFx62pZZmg8HCaZXkJq4eSWCbJo?=
 =?us-ascii?Q?XkMk6/6ZpzX3B+8tYX6xryWzZ/igldvqXKkJLvnOddkfSK59xILUle97Qc0l?=
 =?us-ascii?Q?O8ZYnt9ANDB1p1sbmkAPf2F0xhi4h5h4yfXN6SsUcHKLQeuHnH/v988ObknT?=
 =?us-ascii?Q?5/ekJxcpwhwcWcL4fi6PNGHCZDLoVsj+SUrn+qBUrY5rVIxamt0O//0yeEo3?=
 =?us-ascii?Q?U9M9gk037oHR+N9pOns15s/S832sOoIMX/TZILSvwWBIOkFVUuGzleI4BlUZ?=
 =?us-ascii?Q?30Xf4yPdYiyVK7nd0Qk4VjZJ3WV8bf8KXV/qjLk+EUF4b/3b84TwqWjE0ED4?=
 =?us-ascii?Q?SUpESOLCNfwv9aj4e4JayNKyGWwwuKzY1sPDGOVwqa4nSG0MO7tvZBxVK+p+?=
 =?us-ascii?Q?Sj9vwdKku5k7iqClcEt+XYgXiDYpkFsyJ+w8OK6F3PKmik+WthxhOWKfAZXT?=
 =?us-ascii?Q?9fXlM93KL80lykTAxpzCtYL2OSJOqWj/D6GnOTJAVQFSvxbcCU3Cx+pkeJNu?=
 =?us-ascii?Q?CnwpJoG38V/oqZnnWoYbrDo1swY3ciYIBcuMDH9Lp6bzxmb+Pfw61BTU/UwY?=
 =?us-ascii?Q?4n8Y4qUYISomDR7yCj5877JEFUHPmTlgTkIgb5NsIlc2Re0jTxwVAwrTiVs8?=
 =?us-ascii?Q?J7YsgoTg5mVlF5Gsp+YC08UeV5WF5Qf6MEYRZeiqHE5NtEW6Q8cZ4gej4TYu?=
 =?us-ascii?Q?wn/1ti1gu/WFvwQ0P8ExrWYDnvEoNtJdUPDqBtlLJFL7GmUOe2ddb514mx2k?=
 =?us-ascii?Q?aOEptziaKlTUuEAVb3BrTIhMYDrgDRx+M/iotf+5qQBk5GEMW+DxnnM72GIP?=
 =?us-ascii?Q?MC6hBz7MWVRLOmYWqooSRZrYMeJJBmOgu/q++YNqHfuUfm/pjUCnZPC0tJyi?=
 =?us-ascii?Q?QP2CwwKOpF8hLjXR6xDvv2oHVOmDkBMBUZv/7+V/aBF3GRhINznyAawXd1SV?=
 =?us-ascii?Q?8HE2PByKrUTfeoVT3ci7NLHG57eI6eS5se4EYSEFmcZ8pHuQE5cGHdI0vaJK?=
 =?us-ascii?Q?SbhCAridWNKTE5awLm+LlTCsA8yznECUu77n1iRW2Y9L/bNpp0Xfy8sLnwI1?=
 =?us-ascii?Q?XfoBhJ3dDpnMhZ52mvQ5kZLMdeW1MreCSIIcOqoBQcFXHH/CakVoYi+MlGBy?=
 =?us-ascii?Q?A4fsesIwBMvIERBaA5vC48269/5hoYE3+I0ctQUWhEWL8U5lNInnvSbnmF7o?=
 =?us-ascii?Q?2fbA3QxC4nlvpEpvp2dsuIUuBc5hwEHO6Ge/48pozvkl7wBWsN+n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3c8c5c-f1c1-4943-8839-08da4f5225e6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 04:39:06.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUK4Sx4UTQcWt/shFqEYuHbOYMsvHeJDhjOp0uz1j2fFxm07p5q0eLwVyM0uvHRi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4828
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_scratch_mkfs_sized only receive integer number of bytes as a valid
input. But if the MKFS_OPTIONS variable exists, it will use the value of
block size in MKFS_OPTIONS to override input. In case of
MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This
will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
btrfs.

In addition, since we can receive various strings, so remove integer
number check.

This patch depends on patch ("common/rc: add _parse_size_from_string").

Signed-off-by: An Long <lan@suse.com>
---
V1 -> V2:
 - Rename _parse_size_from_string to _parse_size_string
 - Add dependency patch info to commit message
---
 common/rc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index 09ffafa4..9b5d2f72 100644
--- a/common/rc
+++ b/common/rc
@@ -1077,7 +1077,7 @@ _parse_size_string()
 }
 
 # Create fs of certain size on scratch device
-# _scratch_mkfs_sized <size in bytes> [optional blocksize]
+# _scratch_mkfs_sized <size> [optional blocksize]
 _scratch_mkfs_sized()
 {
 	local fssize=$1
@@ -1086,13 +1086,13 @@ _scratch_mkfs_sized()
 
 	case $FSTYP in
 	xfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+[a-zA-Z]?).*/\1/p'`
 		;;
 	btrfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+[a-zA-Z]?).*/\1/p'`
 		;;
 	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
-		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+[a-zA-Z]?).*/\1/p'`
 		;;
 	jfs)
 		def_blksz=4096
@@ -1101,14 +1101,8 @@ _scratch_mkfs_sized()
 
 	[ -n "$def_blksz" ] && blocksize=$def_blksz
 	[ -z "$blocksize" ] && blocksize=4096
-
-	local re='^[0-9]+$'
-	if ! [[ $fssize =~ $re ]] ; then
-		_notrun "error: _scratch_mkfs_sized: fs size \"$fssize\" not an integer."
-	fi
-	if ! [[ $blocksize =~ $re ]] ; then
-		_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
-	fi
+	blocksize=$(_parse_size_string $blocksize)
+	fssize=$(_parse_size_string $fssize)
 
 	local blocks=`expr $fssize / $blocksize`
 
-- 
2.35.3

