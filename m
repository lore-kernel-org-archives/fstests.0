Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A65C6379F
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Feb 2023 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBNPba (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjBNPb1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 10:31:27 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9622BEDD
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 07:31:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT3JCjY9sDWXCrcGQByzTcuJqMYc4DFsTjBmKzK0od74frQOEZxL6XR9CHhLClEQr6wV0zsyo/HzkIPulq5rDtjrGRp2H2d5qg8IjfSxgoSP2QYy92Hs0QM4m6irDLpHJiWmvjBs10LDZSOb5gNxFWqVaQnIMClb2ELQGPwwZ3RWPFdEB0Rd3EasrT+kNb6aEot9faxgeQQzQF/gMONUNvLu13AJR/7Ssq0z/54Q3sSZ7hqPszTT/+3CuPnDgYuyt9qbdtDfWEFgnGcs+bAeQ85bUNUJO94qC4UUyIBcaDBJHx6/ztGSaicsFhZJqkNKlOxcoqZ0Y64rwK1pZChw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VED0Gwx/PbGTwgwU7Et0qW3tSgKpm1MDdkD1CvnxKqI=;
 b=F/FfBFxz0DWmYMFJQe97ZfHW64OyapN9LvGJapQrRHsy5HT83Vlqx6aHUebpxlrdnyl8lpxTbH7SHw4/lIrPs3gavXCVcLThhKKTd90nw3VexJ5YAr1ZxX4nQPFdchXwlk1+btn4OUUaDFaNoHZ13e31tEDdZGPgWmOXIpZdZv9IfaDvN3vYO5+KuUboi1Vy2x6waon4OwMuSFGut0a9Q/NV5vai9IfUTOn1lZfzQcSj4QDPtawjsi0ZuD6ExrNSU0R0efXlnRry6z9RUrfPPbOnK70ZKBYts/ArHxClBSIexDBTzD+45QGY5FRQpGjhuqtrHInccm8IivgkVsvFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VED0Gwx/PbGTwgwU7Et0qW3tSgKpm1MDdkD1CvnxKqI=;
 b=0/FdEEVma7C34/H4Wt8MTtkvIQd74edGCsA3k88QkrKq+cpu/r87YifoN7/k+Zf8RD9715D5pJV+iXweTxZabLIgy3DEaUoQW4wkAK2cOtXhwyK3FuqE7c/v34t+mscFtRimggHdL59G82sDFDlMO/uqVR9QxIcEkTXI7268D+Zty5Clxu7Z6M3TxaWn+9MSfjuGrHvyxTQ5ru8x9ZTkjJGoUxNpo+CT0tt+BOoKRXzTJgCVZYxv+B6VlpNp/8e6FGQN0sBPWWlThz9Zy4nX45RW6JGQQ3fEClH52aYYBA+5JTazga4HgGhdf38A2ZHPeoB1ZL3RCaX55zAN9wBnBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by AM9PR04MB8098.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 15:31:19 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::4ea5:4596:106:ac90]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::4ea5:4596:106:ac90%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 15:31:19 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v5] btrfs/011: use $_btrfs_profile_configs to limit the tests
Date:   Tue, 14 Feb 2023 23:30:57 +0800
Message-Id: <20230214153057.23971-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111131833.471ada43@echidna.fritz.box>
References: <20230111131833.471ada43@echidna.fritz.box>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To VI1PR0401MB2671.eurprd04.prod.outlook.com (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2671:EE_|AM9PR04MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: d52d284a-cb02-40b4-ba03-08db0ea084a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyGyjpeX7HOktdzcET1bowzbAnndZ3ai0KAkaLUSPppsSQ7I7MsXaL/+sbphqrQD6qsqG90LpMAnPO02oeNd6HOtg4LyRRLrCGxDIJB/4gKAzuox0TDEuRlSbLSq+a7HnNScTAIDysKIx8k0UiAVrnkHnAcBghXNpTFcK1ndFpEnISKPV8YwvKrM4cLwbqD6/pbHarMO9p3qB2YJRVbIiiSnEB3cFF+QVGmWc8w24l4mn2Z87Op+G2E1q8VfohnC0xVk0QpcUbon3tE5QDNH54XLSfGvunnAXO4EeQlJ1U9P3xxVTn07s5DwGjln8uNa5xmLSvppTzsrWmXlVmVAzimOWcaYqCwYwKo6MS7jetVLUpCUEC8KfO1ZdLkXUx297dPLBaiVIg05iKYUfEI07z/JmumcepbwZzKoQ4EbYHZ9Clji2TVoAfxIdU3GwsnXkWVOoVPDw/ZLW3/aG6XJyWMEE+CwJkoiwfZAlEkErZkWZmhU91LJ0er37/NFiwJjyIdVT0LhkBYywUUNKQ6T/YBv4WAfA4cycu2IrNWAi0Bmv2grIasJGmkh9oeU0MgOnoQCphDZmY8ffBvszfaF+7cYLMUo2iCgIjMo15/MvWartkcgOn/7tyHaxq1Hx/93EAbmJlopOrdOMkceOjVZSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(6666004)(107886003)(8936002)(6486002)(186003)(478600001)(38100700002)(6506007)(1076003)(6512007)(2616005)(316002)(6916009)(4326008)(66556008)(8676002)(66476007)(66946007)(41300700001)(36756003)(83380400001)(2906002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLT7HdRNCVlVNgqW0HZ5g4a7o194Cjlpu2iS1wn7XpU6kqLZVeDgVuOnp77Q?=
 =?us-ascii?Q?mhn2uiqjY9Lk2FC4KUp4wr5NA8Azb3pDbUnQoOo8A0uluzrc3Zw7jVVmjjsM?=
 =?us-ascii?Q?pgNLTKR0IIQpC6FWSrHq7a+Gj7ed+Mkzm1l92a7sBSWtT7OivSdGGgWvuD8H?=
 =?us-ascii?Q?Rt9V7xpf2rFXt0FFNfhrjLf+Vv6ObCa+k9/FsTxvB+u9njy+V/BNrTUMqvLx?=
 =?us-ascii?Q?VNbG05SIM+qtj5uIq1wTUStKEvQx1eDy2YvToU5WCEdpJvPOOkoaUzwf+qTb?=
 =?us-ascii?Q?znHCHMFP06OCmXMXooBw3cTRiuhfoFNBQqAEKJl175L1n9lnN5DHECI23MV/?=
 =?us-ascii?Q?DS8vMvKLVYrBwtH3Y0LMo04a2iIp2cTRdVzMevKLxyMWDG9MKQVpQ44/riaB?=
 =?us-ascii?Q?VFXQQAQeH2BksZ63+GsDJm3WuDW0wZoyqVNm71vtC1Nvtm+jJnvVgxdpnNfn?=
 =?us-ascii?Q?kd057tYZhYoPK16zDRp5dM3Q8O20LuoIE05rZ38cDy/AkUtJK6f1LOU/HaSw?=
 =?us-ascii?Q?iRVoufGaWd6grXDWLsQghmhsTwORrxZDSmU1CTZtcP+vndq4G9oVxyimwKEo?=
 =?us-ascii?Q?a4M68/7SqvC1jD6ZnPgYU9fyUsgAH1FW2Xt7DQr/uXfpR4ENB4+BSqSPQd4s?=
 =?us-ascii?Q?VAVFeUWAdyrDKFOQTEXiLN437+lK4UXRN2l6mN1mNcqwoyYOFXI0dkI60lZl?=
 =?us-ascii?Q?kX+EbvsRNJz9Ea/JyeGuyJOlxiZ+PL/a7LvkzNckv4VklRPZnlCE/18jhv3C?=
 =?us-ascii?Q?R8Zv8en/EQRIRjRzniJxHRFi8mkyTB3KE52vZ2DrpTPLTpbyVnCjqleMoCGW?=
 =?us-ascii?Q?Bp+aEFFQ2eTlFoiVqqkG3yweCewYo0mcA1LucLRtXTRNSxEJU6a/KatTE9uF?=
 =?us-ascii?Q?AfQXuLDATPBt8QcZ1+NysIfwhWHKryWMXSiJ1zwCvaCajlbsB6X9m5kSiKcP?=
 =?us-ascii?Q?6vU9bCRgclX5OowWHKWQcYOB9Xoc30H1xDrktSbhReS2xaTTdedMBlL2erO2?=
 =?us-ascii?Q?8pYdhNKpdfMi8UVlc+MFKDdOY4Fr0UN8belehsRXKd5RMvFX7IAep74lfzpi?=
 =?us-ascii?Q?HtVBiAUFM0HjF15WCKPWACGc8AdDSLLn2W3qGSI5K4c7nDQcYHMEWug+8+kJ?=
 =?us-ascii?Q?Uvwmp1SYsX2HqaBWP7r9VL2AbuU6/MNuELtAlnlDh8cWyU29FgEIrT5Xljoq?=
 =?us-ascii?Q?G+GXTWT4nMoxIUDOju0/WGpewHdvG+RQIwQPedb0GT9G0g6KH25RfOkqvGZP?=
 =?us-ascii?Q?i7iMnBOI4QgT9CEiSUtwzpEVMN8IdPOEh4JebFVvdtZorJfaGcfTKpO2EKtM?=
 =?us-ascii?Q?jihCPseTDjRVrk7EP9yks8zs2h5MbFTjb6McZwyn4oLDGMUib5vVz5TwoLtu?=
 =?us-ascii?Q?GMJE9XRSB04c18OfGLkWHwIqJfV3Q2nR3CiFP3Sj1wGfVkPJ3o67ZxA6L3Hw?=
 =?us-ascii?Q?vJ4Tc5ntEkvYQN+ViNA9ynn9Z56df9wY5jhqBJYyOJJHaWZ6D/UrCgJ0Pu4+?=
 =?us-ascii?Q?tQFw3ry4p0dZ5djuF+DSWPzAhvTt87QlZQK1ZJaIRN1/bf4XHMizrKtm1gps?=
 =?us-ascii?Q?XkoyA3KxnJk0JKMGryqx/DfcTO/Y0jP0mLiA+jGRxR8wEX9Slcv0QUovUgPl?=
 =?us-ascii?Q?P8TWT/CkOK+475Bbf2OHmAJuDqPoU0vyadrB0dSa/X1M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d284a-cb02-40b4-ba03-08db0ea084a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:31:18.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPYE7/47H+Pxn8TFalB5nOIZ5qqppU87i3tCRHFaczq/7EXmNdJYBiq9pQJY6DU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8098
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
profiles. For example, skip raid56 as it's not supported.

For dup profile, add dup to default profile configs

Signed-off-by: An Long <lan@suse.com>
---
 common/btrfs    |  6 ++++++
 tests/btrfs/011 | 30 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ee673a93..e857a40e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -213,6 +213,12 @@ _btrfs_get_profile_configs()
 			"raid5:raid5"
 			"raid6:raid6"
 		)
+		if [ "$1" == "dup" ]; then
+			configs=(
+				${configs[*]}
+				"dup:dup"
+			)
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

