Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D89C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 05:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiFNFIz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiFNFIy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 01:08:54 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00062.outbound.protection.outlook.com [40.107.0.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8B3A70A
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 22:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYKOn1owV+hVUygybJob6d2uLb6aLez+Gqek66PswCX+EMmsg8+/b7HjQcUut++DdR8+f5L3eHDjppY9jiuSs45gnRZ10pu3Hf9Po7FUGyr2tV0bk9XCOg61kXCx5um4t8JKI9vPVXWX0lxNlzio8r9XCMtmmNPthYXfWCpKSueQPP5Wgazpq2I3arbdH8NAlwD2ohtVUIdRIA9ifn8Yo+J90N4BJW1LgTLupjSnsvmapJYAH7I6AGRoQcEB0jDDUoIOmLvS1A66ghOrex0IbDdwQadTuXiML0x7Wk7s6tzh7W3fYDhKt8o74Ms86Tq12yVtL5+J+cYfO4+oM5TaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe9B+yCKJMqEWCQ1/acr3m41RfkPeFSQIIEQ3PNT7KA=;
 b=KbZ9EaMQYc0fcB45v8DhxlvXRXiqDpkKRqFf7oCZW0QekVomNQm9ocnnTtg1c+5JgX3W1VID/uleywhD77uU4ModRiofrBumxSYUogXTK1bi0HVrpbYW/W0K0Q6T/XYvpD0ZdscPvgkangJN2vUSCTW3hLQLfhkF2bs8GGmOWiJAQtDnSaC0+7e3KSdcDLhTRPQyxHF5cNYJm6TqykX8DvljrMFju+ic+1BPqPm0s9zBcJR7L+A/Npias8xVHbGYB4mZri/o4PhKZqawPqDi8ihdf+QhSz3jgK8cq98gOPZHzLs7mPWvqyAXyGAfMOn9GYEKMaL16h361QX61k7TfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe9B+yCKJMqEWCQ1/acr3m41RfkPeFSQIIEQ3PNT7KA=;
 b=CxwFtSKTyugVxnw+IFNfZh1Yb0ZgJiJfe749Vsbd5d956OvQmlIO7r8XYx859tTTSHkdeHg5Pm7gKN9V2Xf2E+Cp8wgtevF1J3ihxtvtGpmxZ40PZuPCbs79/msLVZ8xMSbg/YYqGkdu690RQ4Mp2cvOMGNTrosAhDWt244hpHWeHET2XRaI+9CJ1lH+KyAw8uB3g7S1RbD6bTZXYfY2gHJV4cd8rPsRvIBJkSFFD2820GfKnT5UOzgObtj2hfyF61WRZaP6oz/YYHZQd8N7DGiS7SQNUHaTwsfY51hoEcZ6uxKlEAfkQ+QOXZ5JAjYYOSNXuArRjM9J218oDIZfDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB6PR0401MB2663.eurprd04.prod.outlook.com (2603:10a6:4:3b::12)
 by AS4PR04MB9481.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 05:08:51 +0000
Received: from DB6PR0401MB2663.eurprd04.prod.outlook.com
 ([fe80::79f5:6373:c4c1:ab3c]) by DB6PR0401MB2663.eurprd04.prod.outlook.com
 ([fe80::79f5:6373:c4c1:ab3c%5]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 05:08:51 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH 1/2] common/rc: add _parse_size_from_string
Date:   Tue, 14 Jun 2022 13:08:42 +0800
Message-Id: <20220614050843.11802-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DB6PR0401MB2663.eurprd04.prod.outlook.com
 (2603:10a6:4:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb2214f-9a60-44b8-ed7b-08da4dc3f872
X-MS-TrafficTypeDiagnostic: AS4PR04MB9481:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB948188B273641B493F4BA478C6AA9@AS4PR04MB9481.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OzZUeqUfgL7XJvP/QJrdh2DHsfgETD3E6cEdhBhj+6D/k+UXGesbSrAw5j8MFRVUtusp+g2g3Qb6FEnYzL/JFEYU6L10ERpUt0ODiUKb5xn79QDB8mx5NPZichNKMijJkE0+qNhPpZw7+DHMMhHlc7z9T6IcVrE9tQo1eHoTJAVj98aI02VWaj1iZBcbRwbl/4Ih1U3u/5leW6O+uD+W2Y7uGxu1frjjB+k2bS4YtpMDU1a/H6lHtoOp+hvwXDQDQAEzv2izSxufX69zFzON1rABybPGOR64k31jkxcSETjzHOjyd+UHdNbpy3gLaBZUnIwc2GdWjbf2UkMXOdk20d9TA7tZQsQp2GCliy5lot3gZq0JrxvyoGNWToTV+83W7HttPH+BijiWi7SYS5LuJG6YAgGesLVkpSj4hqN7bNuyiPoXDmxeZ2/RwVkVTk5bFYSY1TG3KRXBRmuWMaq6huym1spSMsJ1Tvu8wU13oYrpmgOqzv8NcJ40A/+DS3vDn9vum/HDbuxZe88UMeXmuW5KI07tHknVYj4cER+ILRsbY3+KJqO7QzWjWXFRmWt9Vpop50EzYNg40PRFX0+J6K2fw3aCsvJ6CH07WZTmP/qhjor6UiidevRJ61IRkIPBJ1im2YXa/546yH0WhOruA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2663.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(6486002)(508600001)(6512007)(6916009)(8936002)(8676002)(5660300002)(36756003)(86362001)(4326008)(2616005)(66946007)(66556008)(66476007)(2906002)(83380400001)(186003)(1076003)(107886003)(38100700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36VBn9RDYV4dQYPDWt1pGyz6MoupxxRFJmv3b/wxtkTCU+YIq9eHCLlnTTKr?=
 =?us-ascii?Q?uce6C+0DdWhRBMdYUQzZ1upjWM9liQk4u6gqKKg7NyQHetO7akk74NNQHg/V?=
 =?us-ascii?Q?8W/Q3lMhtFvkudRLnfPsBfAx0btRfKoKpaP549oFR9sRpswMUhNycyOx+ALX?=
 =?us-ascii?Q?D5EyroF6dzuBDwrqJg5a5gGDMZvj0Hu9/SMb2o4mSwmuT3JHhSZ1825SnUL+?=
 =?us-ascii?Q?9IOjwtZm4LWm38bfjoJY8DN8S5meOrK53HPS0fGq+jn3VLusUOrmL1sKuTJ+?=
 =?us-ascii?Q?Lj0407/JaCZR/U+NGzM9IUWDfZXMszZpG6Qny/oMYtsR8HUtLk/zyJa5buUQ?=
 =?us-ascii?Q?ebcisM08eZKvNp+pD5bBiWv3PhE8Q+x7NFj6WaNCmG0QlrOWAePJitZGbo4R?=
 =?us-ascii?Q?AebYmxN8p3VGQFHu4OtG+9kJqOXmuz92rhNYvDUq+mZNC901yVKfoiGGN1yM?=
 =?us-ascii?Q?bESbQwkYat5gtVwWg+8Jf1vAoLmzWR9udJfXf4mSHpIC12j81ga2Knv+S98i?=
 =?us-ascii?Q?P9fcdMIX3NRo8Rc4ovAtdx1IUFJCAxFVaxdHhn32KEevSn+Yg041jynozoBT?=
 =?us-ascii?Q?6tkyajLAPg1k6hLe5iMbmkQ82uRBIxgGi/7Q1YpXGjGCQFqM/+9CHNUNPEI+?=
 =?us-ascii?Q?PtyHM+jLKA3kOpabHhAR1edQ+j1Xc10i8HZgRL08AwVIBLFinEfLEh/AdgS4?=
 =?us-ascii?Q?6rOQwljka5rbWu0zB38gXpRvg4INSeceLDKVNsd/rBuJhl87NgGoS/foKQ5S?=
 =?us-ascii?Q?zbkdGZSd+pKACUdn1mIJieJPB78NO4UFXWOGSMUFL1rKozVoUpm+sGam+33n?=
 =?us-ascii?Q?Dk8hWh9GJ1s6Se859mv1NJuVfaS+nm4rMTNOXNjeZD4hDkC7A6CkaD8Mpine?=
 =?us-ascii?Q?Bo5lepztyJmOOZhfSvHOX47tdzJ7YQzOcGj82L3ZruuT8sf2NpBPk/01EjvJ?=
 =?us-ascii?Q?FDZOx/d/uGaVaExI/fGVEn5kS9tWYSnVV2K/TMV4be99mCAw2KSTXzHZQkAh?=
 =?us-ascii?Q?84JJ2UzLmzyOddVrJtyRheZ3qCPf47YaMmewBOFzS5v7WjNiPuqlxat+cKLt?=
 =?us-ascii?Q?hGOGP5ALJTWbv84aRvZMS9oYXXhWOnbfB1amcBjQEpus/ZJVI+kwiiqWcgZX?=
 =?us-ascii?Q?lDPMY+r8HlIQREPlsD2VQNF+85c5ejhMYgQBkQjvuS+pxP6HUX8AK7Necin9?=
 =?us-ascii?Q?IBl0fDgn5KU1Xkghw4uaqJDq5FjWnOKf+Eu5otob04+mgAfnLrlRJekrqF5v?=
 =?us-ascii?Q?yPPMsdlUbDQ1gI12EDfMR9rMzGgZLKkdtgjBTM7LQgXc/a2BGvC+Thvx5ki1?=
 =?us-ascii?Q?qs3wp1c4tYO7KLt2qIrlmp4eTk0Mdgsb/Yq+3AlIwCjfyVBdvGgc9PIdW5Yl?=
 =?us-ascii?Q?U7vIq7KYVyha6BUZmb0numf0+7vlBvjC+amVqr5v+DRrS8bWSMPOq6D1k/VH?=
 =?us-ascii?Q?8CF4Y50YyoX/HfR9u/eQFb+ekY5lT5pIF2SSJtuWBavNygW3egdFq6qq3WOV?=
 =?us-ascii?Q?sl/W+ow73o+EDh8eWy9wVwb3L+YMIQqoCzL7q9mebs1/15CKDBpBigFLcWcH?=
 =?us-ascii?Q?c6q0rQfoZlxWm0O6jlGZF6rEwrqClJhSEa/8isAJxnDXEakQ6rjP71OpRcpL?=
 =?us-ascii?Q?HFPQbs/YBFgSkOlrH6dCsPFCmF9FyECClkfsMifB+nD+8r86+vHHQ62uFfG9?=
 =?us-ascii?Q?DC9Z8Mhp9dzEv8jfaUGSV7DI75v1p5HZ4er4LXLbpTFrJRlfitY9aAjlbXkd?=
 =?us-ascii?Q?/Wa5WtMRMWe1Zx4H9vQ8f5w5mu1BzWeWDQRKacfe7CQzxNfVB2fd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb2214f-9a60-44b8-ed7b-08da4dc3f872
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2663.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 05:08:50.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urJtELYH6dKs9iLEUUFXRVgJucLm7mCTw5Omm3n31JHpcmbzaWmrTdBAeWWJymkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9481
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a helper to convert size value to bytes. This is used to handle
value as bytes, such as 4k to 4096.

Signed-off-by: An Long <lan@suse.com>
---
 common/rc | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/common/rc b/common/rc
index 3c072c16..22050bc2 100644
--- a/common/rc
+++ b/common/rc
@@ -1028,6 +1028,54 @@ _check_minimal_fs_size()
 	fi
 }
 
+# Convert size value to bytes
+# _parse_size_from_string <size>
+_parse_size_from_string()
+{
+        local str=$1
+        local mult=1
+        local size
+        local endchar
+
+        if [[ $str =~ ^[0-9]+[a-zA-Z]$ ]] ; then
+                size=${str:: -1}
+                endchar=${str: -1}
+                case $endchar in
+                e|E)
+                                mult=$(($mult * 1024))
+                                ;&
+                p|P)
+                                mult=$(($mult * 1024))
+                                ;&
+                t|T)
+                                mult=$(($mult * 1024))
+                                ;&
+                g|G)
+                                mult=$(($mult * 1024))
+                                ;&
+                m|M)
+                                mult=$(($mult * 1024))
+                                ;&
+                k|K)
+                                mult=$(($mult * 1024))
+                                ;&
+                b|B)
+                                ;;
+                *)
+                                echo "unknown size descriptor $endchar"
+                                exit 1
+                esac
+        elif [[ $str =~ ^[0-9]+$ ]] ; then
+                size=$str
+        else
+                echo "size value $str is invalid"
+                exit 1
+        fi
+
+        size=$(($size * $mult))
+        echo $size
+}
+
 # Create fs of certain size on scratch device
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
-- 
2.35.3

