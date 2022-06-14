Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B4C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiFNFJB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiFNFJA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 01:09:00 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00079.outbound.protection.outlook.com [40.107.0.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF63A5EB
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 22:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aziL2xHuUFZy/M9ZdwT6XxOotD28+vVMhondywR1aqn5HuQGDvSDWbZLKWEOCFcgQ2e2A0BQv9xTg43WW1HW/L0sk4V/Yd5v/xrBD9qyp63fmduaJyh/u39T+6IHcVTQIQimHcvqjwCyLEbCyd8SfYRy0Wu0ib5HUaa4x/SQYnX2GsQ7f7zaLqOAVFkWrGZ5VWAcJgJdzzNLSDAuHC25APzBYvdLkvgvrK5aHcRqn5Abn48PFsDbxDXz2iDWmIMwSWS/70N0zA77R3fZMmhAp33homlZt0qhID9fXuyFNAnAcEPGUtnhVhDvZFlKa/Uo2IYvWxGnwyC3n2NjANjK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN3MytubStkzHUZ5PVFCfVRCNbVkip9GtbUmjuT95eo=;
 b=ZmWKZTRe/HjHXKiwp72o59EiFJHXB5xbxtYulTT3lQkt0WvTZOkuEbZxyf4Wav4TFseKNqvAzHwbkqW+jBI+Sdh60iOx74xrYFFEXU00wmOpTK91tUHU4+lzNwysmH8oop+QKyR44fcbYUq9Mbv9stOt0BllfxDsCnAGlWEj8CbiSfe5RhM/+gifVsPCWp87bRdYysGZyi1l1L7PegPkP0TAQtulMyclnYmiOl+Irpw0TE+DQ5DU5G61IjNwifDHNEinBF723AMgDFKtVpptIg/r/MwIMfGnYw8KU7G882QWPExJaGfKrv6ZDCejrzIKBqt9SC+5/mBwkVPgOdwEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN3MytubStkzHUZ5PVFCfVRCNbVkip9GtbUmjuT95eo=;
 b=u25Yzun8+xxHiejNuEj2o/Xk2HwrEIcn8pl1hg+2l3ysMc7PJ+YV4E5bNVFZGH1V+ENnaHS74tMb12Pf5/ukHDAL7yb5nwDAyniGKBYQCWMoGVj2exZW5Y/uXyrDx0tbbs6RAuUh/dIFcw4fpDg6XxADj+lsEQRORuk7Poz3dOi1sD2IVziW1RLd7ouRfIYPnOyvIUh6DkPAK0VNPkjTpj8eNLW0QUQDzqsxUhk6q4797B6Co7VVGjxIrdfeFFdcUhWyVQ7LM6FUkKYhaGDwRg5fbsyu98QRlQ3baFq2yxk8AzxDUk/JI+OsY56dQnqPR4zgqOruqd5fhNfzbxgQMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB6PR0401MB2663.eurprd04.prod.outlook.com (2603:10a6:4:3b::12)
 by AS4PR04MB9481.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 05:08:57 +0000
Received: from DB6PR0401MB2663.eurprd04.prod.outlook.com
 ([fe80::79f5:6373:c4c1:ab3c]) by DB6PR0401MB2663.eurprd04.prod.outlook.com
 ([fe80::79f5:6373:c4c1:ab3c%5]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 05:08:57 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH 2/2] common/rc: fix input value to _scratch_mkfs_sized
Date:   Tue, 14 Jun 2022 13:08:43 +0800
Message-Id: <20220614050843.11802-2-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614050843.11802-1-lan@suse.com>
References: <20220614050843.11802-1-lan@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To DB6PR0401MB2663.eurprd04.prod.outlook.com
 (2603:10a6:4:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf792a3-0bde-494e-3641-08da4dc3fc5c
X-MS-TrafficTypeDiagnostic: AS4PR04MB9481:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB9481B3D863C773296DC2F81AC6AA9@AS4PR04MB9481.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhQF9UKfYIm7GeNx0RGypvwdyc1+rt3xkbMmS95PRW7a/3pACklLb5iymW0KC+z1MemS8iFptYNFWRh6dlSJQaYQEmbo10rO1uydQYO5qZC6e/UtigebDlTcfGdCvGoxIYUAyh7SzugdWS0kz9b2jFe59+uPBUINGlSY4yVvBHoSNH1kqrzTMODuCWEIUcMIEPy0pblB4M1UYD9QD2DpNFbDvBTRGxTn1JxKTgJefu71LvD+Di1r3pwHrVwKiEjeNH+YXOBvcJWrJtJyNbQc4YKo8vZnnAmQP2XkZkR/lkBt8SVxLEyzN6ntqXuzi9Jg8sCnfbZLYispKIxoWV3Vzv7lHNOnl5+c0/ypxK/qRjQUoPAC9Nz0G0B7HYe/MPUL6F/nB/e2B7SXo4TzekfdX0cBIIYnu3eyL3RcceOoaryzTCD3er1wKMYLv7zBLr8raRNqwT23xPTCFpZeowWXrzwjO4/HkevB9J4P5Jp9W5Lf+KPtS/1IYryBvLdM+bSK7bQ26YbCSmp1P6xHioPMtlnkPPB5ZWlxWh5Dt/8Y3FT/+l52G4tBqjMRGvFVG3Fuv43XWltjfc68PTdNcEbzLg/xvgz3VJ5k3lql18jkiKPn1/8MmUCqLlHzZ6KVVxyYqlfpC9EtN2p2PHMUA+7fkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2663.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(6486002)(508600001)(6512007)(6916009)(8936002)(8676002)(5660300002)(36756003)(86362001)(4326008)(2616005)(66946007)(66556008)(66476007)(2906002)(83380400001)(186003)(1076003)(107886003)(38100700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhHlabvjO5xD0+gyeq3A0il9yaytToNh/RY9ODt9GZapl+hdN/U2zJToGOcA?=
 =?us-ascii?Q?bnhFQH1Zg8Q31nWE7pCFU0MK9cp0UWTvmziOtsAggRcB4qL0/4QNmrXE4Jci?=
 =?us-ascii?Q?3oxghFwT22jxSiTpzaKKBHomyoJ4X/sonU1F/36MzNb868m6x953OCmB4jM1?=
 =?us-ascii?Q?L8WAgJY6tx4dfqGVTNaaU99IBXZBXXxGxEh8InWd13PJ34kP6NIf+E+nW7C/?=
 =?us-ascii?Q?UMPtZO62eXfZJgGC7BaxTfsHHvqEQfiC2uNHnZ6HlvvbhvjWPw3pF93tVls8?=
 =?us-ascii?Q?iJI8tnCH9Wu7Dx565LPqp3c7KTlq2ql02e8KA16K9U5QSQSkuENG6DXT6wXk?=
 =?us-ascii?Q?27zzHajZIMUyclWiVEv9qojoyhNzuJ1cdd/UHSMDS7QZffEgs6RLWalmFfI+?=
 =?us-ascii?Q?hf05QD7EyWuMeM0Wa7v9w46zap9ei8OMIOWOb1IKjDaKlOh7d0c5PBANYmxI?=
 =?us-ascii?Q?ECCDOCkeJjk2VKWsZJM9EkNEChNoUEMfUV/XZ5H1NCWZ6A8d5ja8xPvah8+Z?=
 =?us-ascii?Q?4uZrcf5qPCjN+X6loJlJgcI4PRPP3Eu9CLQKZtUiEpVKHhXNzgyL9B8E+NEB?=
 =?us-ascii?Q?yUHqtBtOrx2F4E2huTSEICOKv3nlolNeilcDxHwfBkjs5YKeN+Gf38XrtoSn?=
 =?us-ascii?Q?x2yr96Lb5iU2ix9q0C6VRwaqtxDTIPt/KkiX3WB+0+0I2+LtJTn524BAi5pd?=
 =?us-ascii?Q?MkI2Ry84dSziJbJ6WiCUyVyGOS8TVcjs10H8z1tL3GWAtul219kp4sVB/D1q?=
 =?us-ascii?Q?LezzRN6srEHPW7Muzp4ot6gDJhugcR4ML66MnWF5fPZW5KrbZU3VozSLGGds?=
 =?us-ascii?Q?MYsL3K+EGkMcJv1UkCY66Cpd/mUAv3NncNkYsWzIahBTvAHWFeUAcRx84KmM?=
 =?us-ascii?Q?X20Qo6s3D8PpJQPH0glX09gLeI9sy4MlyAuCRJyulgnrWc7J/7GWWPSLlEVi?=
 =?us-ascii?Q?amzLBtx8JonxsumSDjJTLVAE5EhBS7SxHsmU6rjWL2P+Q70hoC33Bx2Yi4v7?=
 =?us-ascii?Q?z7hbqgQjLR8bdkerSzTZSsuh+/AucIGEEm15veO7YtqebHNyETrNILEZZK8X?=
 =?us-ascii?Q?yOQiy6ZzpM50siIeMFibnKxeKyD61oGUkwK4JGAU6BEewb88Ty7u+5QP8Q2p?=
 =?us-ascii?Q?IpxmsX6UHMu2kg700jw+ZMw4pHcV2Bhiw1+imVWlsIbYNq1f0JxjTrG3s2Ws?=
 =?us-ascii?Q?2hXN02wivC4zok5eU1AKo4OL/4fHCZ/GQqb5fzpGHyW3ZDUlujOZQvrTXp6H?=
 =?us-ascii?Q?y1X+2nai7N9knOBHQAuqEvv4NJrX79HieiDqM5z440Pd/KENGw8GUqxUrHG9?=
 =?us-ascii?Q?Ws47U++nySghphgaiXQa2KLnfYocSZXDpcE3PwkB2tEDguNZxphBbasaR35w?=
 =?us-ascii?Q?sLrT8isqa7/MY2BA+DhS2VvJGgUWV3Wv1dthfXZ4cfk21oAqWhd8HX8NNE0d?=
 =?us-ascii?Q?Xs6KocWn3U+NP8uBlpAMRSINHTzx/lj+NEND1LOfGyPyFmzJT8CZx0LZGnlL?=
 =?us-ascii?Q?atxJNb39wUYNhNrx1J8ID9Spzooqaq323o6KmGrgp09gqPHqLkp9wdn3W0rv?=
 =?us-ascii?Q?sUvDEIrvIKuM2De/c3jkuEeDg8SRrfvIwhOxRTraKM0b3qUF3w/5uNUS1G0D?=
 =?us-ascii?Q?21fMhzO5OlMIj9n+ZoW676fygccD+t9N02aG5d1t/eo17clAU6dXm8lolqu/?=
 =?us-ascii?Q?UR1j0gIaB+BOxtLyBitP/MJneAN3g2Nx4Rr+tI/O2lh8vz26Gh2XBHgEzTTw?=
 =?us-ascii?Q?RfNMOMSO3AGF5AA9eHdSn/3/AVQCibdfThuL8PeGBhvlGHGj3wij?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf792a3-0bde-494e-3641-08da4dc3fc5c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2663.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 05:08:57.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa0cxB3zSYq9KmliS+S41CWzLht3ahGiihLtw/fSsQuBWThUTnmAwwUUunqdOFpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9481
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

Signed-off-by: An Long <lan@suse.com>
---
 common/rc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index 22050bc2..026007d3 100644
--- a/common/rc
+++ b/common/rc
@@ -1077,7 +1077,7 @@ _parse_size_from_string()
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
+	blocksize=$(_parse_size_from_string $blocksize)
+	fssize=$(_parse_size_from_string $fssize)
 
 	local blocks=`expr $fssize / $blocksize`
 
-- 
2.35.3

