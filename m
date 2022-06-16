Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F4C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jun 2022 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349333AbiFPEjE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiFPEjC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jun 2022 00:39:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBA58E69
        for <fstests@vger.kernel.org>; Wed, 15 Jun 2022 21:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8zs83g4ArkNUREs9M7+XTfmSiPSuGrzjWWX+zZDHbw14IikZz8y0vzZRzEWRuU7ghZM7qFV1xtw50Sj+MG4hJT3ANjHtaJfJpQkOWGajQdIN2NTKZRIh0bVVDPTpuTrkRgd0uSEQgP21y87ltxWwrncBLc08rECyTPNRzvNkJiEmONJQv/I46S8rQ0vw/vZ9zqoPeuxMxP/Zzu8KOJUmKInbTheplSdi60u9+w0w2pLdiPdAxBIDs3kewS3QQPYJrrqL6YGp/tuM1MDCfhJpPRMczChJTzW6ShtoGUlApSH+Wu0Us542yz1P2a3RthLYnaT1L6qKgbyoYOgWWVqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In7Yp4GOM9VfpAx1wqkI/ZKzxObQXhTIc8r9xFuCRm8=;
 b=fPdb4v9JwoCcqeBF5+kniD4r6knBuk+5DybHDYyIa491eRaB0NI1LUk2hReB1HXKD8ppxoF8qUmPvZZWEXas8GzqCVEUpMUxJymrJvdSgxOYlSvGfaYWRodK+bCQmOpesJgMQ295d2TYnYlDp5NdlwL0mClvKSJecU3GnqZOta9/2CHg1MhQNtU3+AhYu1rpRLWkFV9QR+IeqLQdxz8nKdxwpWQBZH2YP2hOktr92I7DJpeueszrt+k95WBVcWh2tZr0VCyomRwVDQO2PwO6nYhyfH8Zt/nEJddLalFp22pDLaQHkkLDr/dwyxhxzuVglT7zTwIUDYRP8RP4xnvlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In7Yp4GOM9VfpAx1wqkI/ZKzxObQXhTIc8r9xFuCRm8=;
 b=MN/neN0P2Bjue43HlVlRR/WwpSamHIWY/S4Xp0yvRMlhgrf476Mi0zf0ThFY0x07RhOyfS6CzBPprSxreLqibCaKVBCmGzv0VkxknC1lItR+GsbB4aK0xLcr1BxQ3+BfnM7vw9B8gXmB0TlfTgYDYH7M58c22AR2JGOMOPWZ3mUwHO/AHFHDNzdSOoGAvNsVd8ETiI/WEbXkrcQewSjhcmoDN4HeN7X1J40w3nYtxunxz6j8LMEAoQ/4s9kjHr3dk3MbRjTx3kpP4d3rQnybJO92LKPmPUrvvdS0pZPtVsxAmRgZQzYgTFDYN6GR3t9XPdWd0gc8zxyGZaQOe7wP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by DB7PR04MB4828.eurprd04.prod.outlook.com
 (2603:10a6:10:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 04:39:00 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 04:39:00 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v2 1/2] common/rc: add _parse_size_string
Date:   Thu, 16 Jun 2022 12:38:44 +0800
Message-Id: <20220616043845.14320-2-lan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616043845.14320-1-lan@suse.com>
References: <20220616043845.14320-1-lan@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03503b15-c314-4881-cd26-08da4f5221c8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4828:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB48284F5D52FF373DFB3DC444C6AC9@DB7PR04MB4828.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NjJrZo5R9VCyxZpK3kCdy3AyrRjU/8gg4xazJRtry/GSIYi3Yv6ZHcqJqxXCUJqe07ZBQeasIvBCiwAOwTpaXJL9LpFyIRhlVzKqhpVqAYxbBIac3qgMZ6MR/oOLPuWE0akVoO7quItwXROsPMFuSVWafbCcibSSn9Yj2gF1mU8EwG0IFy6ArbdbSsdaQDZvPo0WDz/XnfyhVPaBEkfBu9uihJLajcQqefGbr6ob0EvPCPxBtedzq9YV8bo7VhSV6oW5H3yLdjcBV4+BGoM5DaOkjSeKNro6aIAXMxMPEMkl3ifux+4II/nL8LSA6iTmiEuVjPOovJAQ+rQZ1kSvTE0Wk31R1F4XtGFvNAvx7u8vdStd2os3z3p4U8/mJ/3o8svcNLHoHy6vgDCUx8sOROwLkPtlGMvRO+VFErO8LNizcwJ/DGB/8ykn/oNUKveGuuSl7wYyAhVj2ujZNPWMrbDlwAvfTrqyQjWAlKf7zg0h4Wi0RSrBktqzLjZ9NSBtBdqxVgwn2TZwGLxxx86vzKIpn7zURPtB9OTJ6hqbr+oprf4kXDWpA0u6DneeTXOBpmp+j26Jsqp5LOqHhfwGNfwCFTRQ6VcLobDWpNj/Akc7XzH/EMPJm5XJZQSFiUBDlEULfh15fiLyPX3WR3AJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(186003)(1076003)(38100700002)(83380400001)(86362001)(4326008)(36756003)(66556008)(66946007)(66476007)(316002)(8676002)(6916009)(2616005)(5660300002)(6486002)(6512007)(6506007)(2906002)(8936002)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ne2Jexp22z3h2ElfpJs020nkc/aGqO2dIho4Q7n6tq3ZimqIxvYCtxL5kpp?=
 =?us-ascii?Q?AbzCQlWMUOUhSdRbWpTSsU0vxN/tTdfRDSBXKY2aeNkDnbIO9GQN2dYlmn+g?=
 =?us-ascii?Q?/gBGrwVaOCANNdk++k8Bi3kV8MyTZgQocQdIQE3Q96PDrZF+w15kHDo0snoK?=
 =?us-ascii?Q?5dLrxSVbzU5bgEHKBiGixzxWa+doStMdN1YxikN5XhVbz61H8xMltUDOTHr/?=
 =?us-ascii?Q?ZEmLEgjB5eL5KPfiqMBgNQQDST6cNewyRt0zKUgAMKPRy0DLlMUamSJ5Grqo?=
 =?us-ascii?Q?ha3z+4OJl0vc4hlIr/Ta8Zlrt1rKz1bqjLkSfSiJk+TFzkhMJ79EfNRX19nk?=
 =?us-ascii?Q?fm8Kw4sAomQ56j9r/YQry3i3lVK84i+1LIdsSnF4Q9iWJ4acf9c3zhn6nim7?=
 =?us-ascii?Q?IpU6HVJG8hXpogWGIgFaW44csK/nZczFnV/wrwqCgT+A5SRdAoC0GN/6cHPi?=
 =?us-ascii?Q?5B0rGDqau12r+EV4HkHnPvcjOER5sYkBh8Wh+JmbfH6jnJ4EXD9VpJfFAqI9?=
 =?us-ascii?Q?TIP0gWpVn14iABHIOLxXj33N9YxiKkkHFHruEz5hXa8Iz1YWEyeNPhKZsvfZ?=
 =?us-ascii?Q?USAsz2zG9fShh4ZH77fXvRc8QvVXpO/8OPRjWeTSn9AcEoYPoGscz55ZuG1h?=
 =?us-ascii?Q?5JOpp+W9xN5cey9D6bo8LhjaVgaGIAHOS0T5iK6BdUHPgKlQYqgmLwM+sq5t?=
 =?us-ascii?Q?sbG2//hReeCZmlTX/q92LKKm5tMOiiqLKL8R+7E0X1wnYfCHY0UzjNxphJpN?=
 =?us-ascii?Q?aEHa6SJZDpy/4NZWD0QjmCcQqbw+Ife3LyFviWvmfue5YDMXlwjh4YFXG+yN?=
 =?us-ascii?Q?a2V+C8ESFZIDBo3NHYITo2xKZYYGEE1wkTavBklN5Y6n96Lzy0agXeIqy1kX?=
 =?us-ascii?Q?emzQbWv6AFsTDQaOwGPS3JvWggctCt209xx11yWls8uL4+QLK28/ppZrwX7l?=
 =?us-ascii?Q?FGtNczmv3BwH9bIEUCIHB8RJFrAceJxQhzQ2Hh5XxghUZH7d1/+FU4+qnooS?=
 =?us-ascii?Q?RSHXtKyVIgS+bavFtEClatIsqG9Vmj1GndKalEd7z/RLNFuCOwT5A7TJrHfJ?=
 =?us-ascii?Q?V02XofmOsj/iU1BBkz3xuZoZ3L0rXrB4Q8dzZraehwJS62LlUSE2ojSHa+og?=
 =?us-ascii?Q?nGBmhuKkTMrVnFAFFagfzTk10l2c/oX4MxzFOn25IgmySngyyEMb42GNg6kN?=
 =?us-ascii?Q?6HF0GTwk2EL5DV/Js1DUEPTYDECLykgAc0uORxbzDQMafoXVhZRPTr5/yMML?=
 =?us-ascii?Q?WmQldtxvPgs1ZONdqV9f2sf6mW5vQHLBn7WxUm5WgijUDKgUlWsCgI6tQXJS?=
 =?us-ascii?Q?pJ1gIX/ivYenURjClr+Iakn+Eq21Lyd/qHypTv9+aNsArUUykpv99ecvsr7b?=
 =?us-ascii?Q?+gyBocG4K9F/x/rkznYAZiRxTFcK7PW/ASYZx7uT3A+cd7DRAXg7b7ruoNV1?=
 =?us-ascii?Q?zMTxfAZwRjH/hlhGzQDmZ5vieKcajqO0tp88CzYeJ+912W2XM35nPfU+n4hy?=
 =?us-ascii?Q?IlmC9USf2tLlNcPfnq+BgOAphgxlSCpa1BzZ92Zthbe2817vxaW9Q4stMTjZ?=
 =?us-ascii?Q?6k/6wgh9S0T2/+aMGahVUqXyNVg5ajr8GYBKHTqgZwg/Ct0IuC8CTxAwy6Ha?=
 =?us-ascii?Q?BRJadNZExAJShfLvHbbm2L07r3rxutX6497skddCnbLsGtWLDQbGD+POV0H4?=
 =?us-ascii?Q?iPRDIO+LWIqoGiF6aLQ/e/3g7W5ATzLFBHncphJ4ztVIYfaNn3dCMs7hl39h?=
 =?us-ascii?Q?+V6gMgIA+gjgpFVBdvO/U63lDFpQ+BBEExknIhdv1MvIfdw1TQYD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03503b15-c314-4881-cd26-08da4f5221c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 04:39:00.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4Wtx5oPZwhuwRrvl6iZAp/XDY/O7R0/kH8eQXE93H2janCBdTD2JHcJTXNqBDD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4828
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a helper to convert size value to bytes. This is used to handle
value as bytes, such as 4k to 4096.

Signed-off-by: An Long <lan@suse.com>
---
V1 -> V2:
 - Rename _parse_size_from_string to _parse_size_string
 - Remove unnecessary '$' sign
---
 common/rc | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/common/rc b/common/rc
index 3c072c16..09ffafa4 100644
--- a/common/rc
+++ b/common/rc
@@ -1028,6 +1028,54 @@ _check_minimal_fs_size()
 	fi
 }
 
+# Convert size value to bytes
+# _parse_size_string <size>
+_parse_size_string()
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
+                                mult=$((mult * 1024))
+                                ;&
+                p|P)
+                                mult=$((mult * 1024))
+                                ;&
+                t|T)
+                                mult=$((mult * 1024))
+                                ;&
+                g|G)
+                                mult=$((mult * 1024))
+                                ;&
+                m|M)
+                                mult=$((mult * 1024))
+                                ;&
+                k|K)
+                                mult=$((mult * 1024))
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
+        size=$((size * mult))
+        echo $size
+}
+
 # Create fs of certain size on scratch device
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
-- 
2.35.3

