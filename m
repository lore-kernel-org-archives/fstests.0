Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517E0CCA473
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiF0OJF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiF0OI5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 10:08:57 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20086.outbound.protection.outlook.com [40.107.2.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FE639D
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 07:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFifzth+j4AssZ1HnhcjScsQyIS266ucEsO2ITdBdZ9c4uVB2JplHpzTtoMy40z8PGNQhIAR5LWPQS3c8SFTnv87Ds9hZ0xuQ3H9Ar52bq9fxbNi9Fq/cjyzOlT0o85USCvzksNPpQ0tq3JFqXZaLiFBQoZeSNcWNpzSDmt4L3OyO2RX8ZXXw0yTRyGDOnF4QLtDEl8iomQ7xIM9PagoH4Ow6cLE6DNilpAvDKN8J591F2tUZp9xGIt45DZBcnVr6lWKnCDoQgdSpcgtBbrlJKGabrV8MBn3Sm7clCVDAQqE1cYXBYem/FFI1s55b5DMberzV5/+35RDfI/y6npgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTLbxrioMsJBflhHZv4ZvUsuE/jxBotk5SYT6q2M2yY=;
 b=bVO5KTqWmBQDmDmUMC/0FL+azDtoCY3Y1o1Ee96zdFO0IoYFFFLJnWHLC3XjyPd2Tedhs0peu7YSodYPoEVgYYFEgGE4N0OKz9aChtaG2DTsd3DWo4x0UmJ2HV0+rGFd4CFSD8zhjApXm9Zl2lgc4u8BZUM0M/HaxJwzoGb26q4Wcn8B6GFS1cjHtsSgIbg5D/W17bPfvW5C6yTvGbyJX7f5tdeN8XMd/BEnL93pHJrKJcUUs0gCUQ9LEJ4Kuy5Aqaqv5tLOQyb7ZJ8z9K4nsQlc3Y3jFKHSJml57lt+nz31AmjQGnTHShtzk/J4Ml6/vH5EV9FCOBhwz/XOHdbUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLbxrioMsJBflhHZv4ZvUsuE/jxBotk5SYT6q2M2yY=;
 b=H1HJ8Md9BN/W7JUzCMobyzID+r9iPTSTxbAWPjRsaf6wwFhtN8oAW3oh4ONDuNFq9xsbaWJB/bHVnNZt1rg9Qy2iEE4xV14+FPklK50TL/nQqFCG5RxCS682YhjHFBXFHoJYD+9mmbfFcaJfl6BsJsn3RZ4akipvYH6GjcwFa6WuE2BKOGkRRtGzadq9HvwU5iLapKSckyFmWBqut8D5v/zd7rTpkqSlilYhipy7aTGI4MVMbkZrDo0kfspQSPY1VJkUzRfaOfRnDtNods4cg7t71Ei7G2AHYVD/ufLWmVEe1YgwxVJIn/FA8kvGZL4It+oI8GZ8MV04Q/e2RpYLkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by VI1PR04MB6095.eurprd04.prod.outlook.com
 (2603:10a6:803:f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:08:40 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5%10]) with mapi id 15.20.5373.018; Mon, 27 Jun
 2022 14:08:40 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH 1/2] common/config: add _check_mkfs_block_options
Date:   Mon, 27 Jun 2022 22:08:26 +0800
Message-Id: <20220627140827.23775-2-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627140827.23775-1-lan@suse.com>
References: <20220627140827.23775-1-lan@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934467d8-9a31-4f79-ba52-08da584689b8
X-MS-TrafficTypeDiagnostic: VI1PR04MB6095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDXw6BaQYj7BYfY33cgKJNerdO8Jk+Tr1O53gghzQaMEX/HbD/OOaIhoSVZMMa7qRP4xi+B6P9YaP0FGEYcmYrN0/TiDpyERlfBceiq8l0pXNdvsouvMUhH6fzCSbHVJc5ow1idlBDg70jdZY1Lx03qgN9A3BVeLdXR/E1aYhvApc9swpV4wTswepyGQuh/A6RGBqybOt+sQ2y75tdPbX/V5H550BEK0RtshEnuakyUQ1AU7nnGsh1In8pha2M5Heq+G3mC8zOh2nlj92nrPpfW+92rTH5OWQ+nsOcTl/xcTbqJUEnNiFXAWeZ40T5+/6MV7MEfJILXJsYS9OwJrXqpOKWpafA4SN9e1WJoQ+6lwq4RRLSbgB00TQ84dSLDwFQEsAGQhyetggu7V+R/kH7g0LpLZuMtmjOmc+O3R7UoDgYLiFcZhYCbcuGcFoHla1exIkmlvaEQGkRDe44YVGG2bMboLWTLNx9v9aTCeTtWtuCbZOpvwmR7xOI5ZDf2fqGI1zuoG7R75R6oEXtgkfjmSFSDxjb83HmeTo2NA0aPwrFelW7Pm3OYC2wjiqMZdZ5OAdopc8yyAYKVNuN1orJ7kN7Sr312hQz9wlB/B5rTxXsxJjV3YQuemKPsp5bJ768MzF9Fp5xqJB4MxUo0jsZkBuv35AfnoB+m8OGvN4yjLa6b6DsswLUxrKD1e4Sf5MyiLj/m/T4g/vmdviaOBVQaFK2XW4FavC8RqyUNcDiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(366004)(136003)(86362001)(8676002)(6506007)(4326008)(83380400001)(1076003)(6666004)(6512007)(66556008)(8936002)(478600001)(66476007)(6486002)(66946007)(5660300002)(41300700001)(2616005)(38100700002)(107886003)(36756003)(316002)(2906002)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VO+3Goi7CCxHkzK0Mw3Gyii+PGgyra8xf7aZmSuB9xJ469lnxPqXMfwqgs8H?=
 =?us-ascii?Q?nPv3/ORKRoS+YkCp407Qq2yquRfcEEJBdtyRLyAQ9vn/SNKg7mS7X46B6Swa?=
 =?us-ascii?Q?lPyFGvedPMljRKRLsPL79b+1qa+ZbGOG5kHHciwgOED/ZsGa/Pe0xe4xZOew?=
 =?us-ascii?Q?PoZi7Zxzrlbs5gD1Kn2DWF/DTYuX7gjcnoei3dwjXWwSjcR1NWiITLpFEBmQ?=
 =?us-ascii?Q?VYQujNr2aW/Yzv3knf1oqEhAcas/pTsJb/p0hEvIkExHU05m7vECTL2KLUh/?=
 =?us-ascii?Q?1Q24tQOYz72GUH+FuqyWlxrhCqHbwklzSHb/cQVoAehyU0F23midmsZb5w75?=
 =?us-ascii?Q?1CwT1BWJJpEdZ89ST5+HQbs94sSkdo+0eFQ7+23h76JDQDIJ7PQQPAkCuNQf?=
 =?us-ascii?Q?QhcWK/F5qyFjbnBnxP+gaxpk0Lx7XQ8VC1xtAjMpIUwgPPYZEJ6KAwKPVSll?=
 =?us-ascii?Q?T4m/tPyV0ig475pAng1TT3gZKW6pFf4i9PYB3deq7jHpD3Ye4SCCPsp2UDJT?=
 =?us-ascii?Q?YB5/FkL3uRX/Q846VasNM2adOPreGGRzDdzLmqs49QkWyU248xNAX6O5sQZP?=
 =?us-ascii?Q?5gWI7TKhDC59t1QDWtlOP8QS48IVTJ6ftmAHuoS9JEuz4TIuLHVe9t64Jlbe?=
 =?us-ascii?Q?eA/W5y1JV6/ATIpRr20qSRBmJN46bJ6bdtFbKxmoRhdUoZFHB6A1zHFFYQO6?=
 =?us-ascii?Q?+ZS6y5EAP90p74KyiPGhWEZ2CVaGv5LbPsvr5RcuPqbmDxi89RWpLTfvL7QP?=
 =?us-ascii?Q?DfjEExTGTaH+a0j6jveUHQjmiBBtfgZxtbpn6UZmfnoURQFD6IQ7JThhkF0z?=
 =?us-ascii?Q?E9wHkzM0hAbUn3uIZWF9hrDKOUKla7riaiXujcywdUHbGLW1bYJ1wHO6SrGl?=
 =?us-ascii?Q?2F3nQWMnqBJyrGvg8wknz5x+gMdIyvhbj9AmJrZVFen3hcTNKh73pAU4hCh5?=
 =?us-ascii?Q?KAAgITcztbfHytSTTPwu6rr2hoo6cVMo5+FA1UQb4U8thT+WzHLRNZGaRaON?=
 =?us-ascii?Q?dE+bCWofYL+sOFj/IPUc7QymaFOsZmjnvgrhz2Yj/1VKoWWpjwvrAx+nEsoX?=
 =?us-ascii?Q?gw+HpHCle9g6O1rRUrt6cmI2SBqWGUqY3bbCWUiasXy6GL2simeNEbKIRG/w?=
 =?us-ascii?Q?veGw7qnetQZh4ITnZ7zQyps+5VNpzf4H1QXUxS/pd5L7ugzFn3qhuOwDNhQn?=
 =?us-ascii?Q?PeBFHzmnVj+SeYehctjoAk+dayL/ibY2ludsI7G5Poq1ZOc7aX6Pd5g8gOmV?=
 =?us-ascii?Q?peebJllXMqMFKOHeGphLI0sA0IV53yg8HiAc9BcofByaCX71PDp/Kx6Eb0GW?=
 =?us-ascii?Q?lv6JwomXP6uVj+OGwPZm4RKbOSQm16L++hPjfEDyPtX9yahQWpiaaUmzqX5F?=
 =?us-ascii?Q?YT/mQnqtagu55Gvs4ZB2gZKIb0yumSjuS6JQ1bDEm2iTWzJbD2jNfNCH+uK7?=
 =?us-ascii?Q?XmSCCXOqhXpNxeGu5yGD+IHYuPu0VLl7w0MWX0MWIR0/iBrjnKRISJIyQFOm?=
 =?us-ascii?Q?7sUxbncT5KbwUKuclUZWXiP7+XuasPrk7A8jBcL+BiQyhUv7HU6Ucq7AhpzE?=
 =?us-ascii?Q?cNWZ68oUJRNCS8eUOlI1Kzta6Cj36r0G87+ABQRb/OVr4wUFONABWdbITRU3?=
 =?us-ascii?Q?T3s17JbF1i7ynE7jO3snZLs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934467d8-9a31-4f79-ba52-08da584689b8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:08:40.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdm7LcXXqY1VHcwS0ui+grxYYV8OBR4hsFaMlwIlIHYlNTKJ8odd0EbE16OMk+yF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6095
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a helper to check MKFS_OPTIONS to use pure integer in bytes, and
create variable FS_BLOCK_SIZE=blocksize.
For example, set MKFS_OPTIONS="-b 4096" but not "-b 4k", then
FS_BLOCK_SIZE=4096.

Signed-off-by: An Long <lan@suse.com>
---
 README        |  4 ++++
 common/config | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/README b/README
index 80d148be..e80b8457 100644
--- a/README
+++ b/README
@@ -241,6 +241,10 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
+ - If MKFS_OPTIONS contains block size, the value must be an integer number of
+   bytes without units. And the variable FS_BLOCK_SIZE will be created.
+   For example, set MKFS_OPTIONS="-b 4096" but not "-b 4k", then
+   FS_BLOCK_SIZE=4096.
 
 ______________________
 USING THE FSQA SUITE
diff --git a/common/config b/common/config
index de3aba15..d34b1bf3 100644
--- a/common/config
+++ b/common/config
@@ -623,6 +623,34 @@ _check_device()
 	esac
 }
 
+# Check block size in $MKFS_OPTIONS is a valid integer
+# And then set the value in $FS_BLOCK_SIZE
+_check_mkfs_block_options()
+{
+        # Avoid that FS_BLOCK_SIZE is different from MKFS_OPTIONS
+        # Otherwise it will cause confusion
+        unset FS_BLOCK_SIZE
+
+        case $FSTYP in
+        xfs)
+                FS_BLOCK_SIZE=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+[a-zA-Z]?).*/\1/p'`
+                ;;
+        btrfs)
+                FS_BLOCK_SIZE=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+[a-zA-Z]?).*/\1/p'`
+                ;;
+        ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
+                FS_BLOCK_SIZE=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+[a-zA-Z]?).*/\1/p'`
+                ;;
+        jfs)
+                FS_BLOCK_SIZE=4096
+                ;;
+        esac
+
+        if [ -n "$FS_BLOCK_SIZE" ] && ! [[ $FS_BLOCK_SIZE =~ ^[0-9]+$ ]] ; then
+		_fatal "\$MKFS_OPTIONS: block size \"$FS_BLOCK_SIZE\" not an integer."
+        fi
+}
+
 # check and return a canonical mount point path
 _canonicalize_mountpoint()
 {
@@ -896,5 +924,7 @@ else
 	fi
 fi
 
+_check_mkfs_block_options
+
 # make sure this script returns success
 /bin/true
-- 
2.35.3

