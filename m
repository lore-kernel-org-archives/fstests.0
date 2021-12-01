Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA4C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Dec 2021 14:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350019AbhLAOuk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Dec 2021 09:50:40 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:33790 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351271AbhLAOuA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Dec 2021 09:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638369995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WPx4Rf0Ktqr8Z4HYPWj+koMbJp4/H9Ha2ws4HP8EfJM=;
        b=cskWA0vnTg2t5J7nFDaDuXyR4ZueIE8hTs14vSkc8QzqK5Bpov3abEEBR1hnYyhk5kQuP6
        PmGDuZV4OUCQVWkgrkj4GfyXflQhvaMqcvY60BAGPA6jiHmvhi8UcaYjS2+b0j1jsecOfl
        S7e/afOSGjYQRjkwpa4KVvjt2G2v17s=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-Q2GfGKXQNySkrVK2p2FSfQ-1; Wed, 01 Dec 2021 15:46:34 +0100
X-MC-Unique: Q2GfGKXQNySkrVK2p2FSfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPo5j+uZvXq2LlcEJ+w2p4NuAOQkaq/e6lQBjBLW0CpACwMJCfrSlwDyJi5R6nDdRA7cILQ4e3PZS5LmhBESYzAaB7losgXQ78ue52t/l7R3dd5FrZN9tH9RX2X54nrmLaZHJKEJY9XtkHxkWcug63CcQNrMc66yKkqNr52gq/m9aoDpZPGeXNFEZFEWz8bDJqrEJ0fMqc4xcTZg6SLxM3Yp37GyWLHexukvxqKv11uGLfGuMEoBNqIJXEMiOSKCTVyifQiMHRC8UjlSakIIcmhwxfS0qFfbFAEIzrWpSBj1BYavurzUq1+wtoMFTPTh0+27W+9Jv4goXCpbnJPJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkzd9Yx9rJwRIXvVwTNcoCxAQ9QQ189vdTyCQ4RbG4U=;
 b=edsQTwODn5rd1S13i10IMQYC5CEDmjGT21pMVb/XNWqZqEuSjV3kX8kxh39r2s62sFQ6IOEAJ0zwbJlibtnQLuuxBFSSCLsLi2bsMho/yESBQiHLvhFA2J690XIzVTq7b/e6NoMHaEEL0owDBiFKLV6nayKw5mew+Q5RFZ9DD8w7WO5bpNM+BOmAn8cBSTMCCZQXeP9+P1nz9IqB/tMTGJvirph0cEpXQkbw6d4D4Z1P2cgQnLcJNiv68xpQ11RZd11vyDToaKn/q0u6Hsf4cB8WkajVfMdMBjPCsq76t5sehpVV3uY5xNdAI56kvg4WItMSeiK1mpJPgfHUcitjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4120.eurprd04.prod.outlook.com (2603:10a6:209:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:46:32 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 14:46:32 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
CC:     An Long <lan@suse.com>
Subject: [PATCH] btrfs/099: Fix qgroupid issue
Date:   Wed,  1 Dec 2021 22:46:10 +0800
Message-ID: <20211201144610.26002-1-lan@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
Received: from localhost (240e:304:4b83:59a0:6023:9568:82af:2c64) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 14:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b0265b-d626-49c1-93c8-08d9b4d95d73
X-MS-TrafficTypeDiagnostic: AM6PR04MB4120:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4120F42CF6BF83EDDC707590C6689@AM6PR04MB4120.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLu+6ck0FFPIQNRpr4jAHSmeZt9R37LIPYFKB1tOVXTD+ypfT7CRIDHOLmH0hAW6ch3xdWE14KmHN11luC1/6j1bF5/ijsiN7ai6hlvZ72HeO4jMReEi3Neh9+ZG5Vlz5GGVhNi/pzYEnsJTsVQfE5uYZffQiFzIzymJUMzstnjuae7ouUR/Cq3jYv8PN20EdZJSYSuzVbrKa8Y6V3AJFNp1S/DVqnfl3RkB0dQ9vZK5mAlLUd5Xl9aw2LsngH7EGd5dTvjltemPKMWx/C59qNujsaZkdpu5cQO/L20xrw3vTsdII8ZZ3wVMC0r78nZMLgo5PbvNVl9gcidl9d3HL7cOIFXewgd60BdFuRG3PY9OlIeJsb67E/5a8MMzIoUHjQJY8FL8P/PU7tF9EfD4kC9o9auEhWE72Of4iiqZha982Ie6TRxnGfDE+V4xjuGecPk+54bCze+lmqgtmfY3FNsqK785CLGfoDy3JOYX1F/TPw/WitLNOypQTMvdUvNven3xlScs3Wj1y28Yaom1TkY1OxMPCucvd+FGt3jLhOjnbLzezKbcjCR/iH06dpdxfvdF+ofA+DqeCvXwz2hO6zCtlg6dkMXWmvfZmW4aHIEYhEJC3qS7IY0dLa0ZRHFbddzXAKmvamvdl7X2Dp0+Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(36756003)(8936002)(4744005)(66946007)(5660300002)(1076003)(83380400001)(66556008)(4326008)(8676002)(2906002)(66476007)(6916009)(6666004)(186003)(86362001)(38100700002)(6496006)(6486002)(2616005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NG3h0B1/c2yc5BJBwb3zc7+3oh6HB0mx/zpzuuayjUsIo4OQAmctnBfx3Ufy?=
 =?us-ascii?Q?y/HPjRqUbrzTe6LD5+p4ywLoyF+IW5qyCqYJZKMm+X9DXxU15mfK/Rpjpbxj?=
 =?us-ascii?Q?XtEsU8zujZWOStgcjjE0rJsh5vGCrR0X3MVgJ0aetquphtaM01w/O5PhanVj?=
 =?us-ascii?Q?DQSJJpUZJnYiExONG1PlTzc8xUZcAIgAqI59LG/xGz7BYymMotNKGje0dumU?=
 =?us-ascii?Q?gqCaoEr1Sdsiek5LL2RryQ4pwkMaDmi0PT7U3ifetK70eu17e7lBnlgVVSQF?=
 =?us-ascii?Q?HS4F34pIpMr0B1sU/elo9yf7Itu9Pjq5xnqIfkwTwSMTwBtLn2KlAQ4dMfR0?=
 =?us-ascii?Q?alkubCJaDuvL5Qj9ZnzKBnr7uUTa3l2H9uUj/SBHJ6j3KeHXOvMpunkJr8oP?=
 =?us-ascii?Q?RfFzSEo8Nolx4GYW1I7vdpko1hOURf8T5mf7YxGC6aou7PXTb/u74IWdbJbV?=
 =?us-ascii?Q?akoJo9/MB0hcg3x1tLr8N+15LQA7EFvgtb9V56Z/MP80tuHKEu8F6vakKZgr?=
 =?us-ascii?Q?1GlMhjpBwMuJgiDQRlh/ejCOkVGrKE2AKZw8FhqQ/C5Vi6hybqunMSq7N7Pz?=
 =?us-ascii?Q?7mrXKcXPm82l7Jg1kclmiyBscgOzFC8ubGwrIFBc3rpDUFXHkfZD/I8wKn6O?=
 =?us-ascii?Q?Zs0hM09Xckzn8EbIwt9FV3mzPXPavek0kZ9/7kxjpO7tFLrg2J73Y3jjIAj2?=
 =?us-ascii?Q?GNtbRc+Tg6MKjU9WSgiQGYOqXUspTcHWmTAM7lzjLThjE9TQYNpr+J1iiRBx?=
 =?us-ascii?Q?6+lMY8lLDpEQE59oBFOXHnu622NZ2t6qMb2Tcvp19nHwPIZP8mc0+HKQkU8o?=
 =?us-ascii?Q?8Oh9QAzZV7rIMG5WcCw1f2pUjl/70jpQGsS6r5YFXg/t5TZqlXtndHw8Rn0g?=
 =?us-ascii?Q?lGW+68hF7hPwUrxkKVYMTEastXLEfL6Hmh/kB7NqE4EDd/i+Dt5RBUJsPLJX?=
 =?us-ascii?Q?wDrEdQSFvN86FTvuzF/VoNy1oCNRIe6yRTXdwA8Yee8IHH6WDV2j8LOqFMT4?=
 =?us-ascii?Q?oDUt3xiBu278zPJVi56dSpTsQVmemKNsuA69IW2L0mEbuwyLyqKcEpkylhV2?=
 =?us-ascii?Q?0hAqtkMGJELGCXcdEHlpDPfCF6Hz7xvVO2aPYkqK2v4Mh1ttcOQuhVnbc8Z+?=
 =?us-ascii?Q?4tKkvAeJYTSLCAfxHT24TKjo+GYvtCii6bFmHG+jdZb7dYTXoE47qXMSvtSD?=
 =?us-ascii?Q?rIvKOkdaSs2fuAnNGmCZcCN5f4FkV4cl4Cy9hwOgrDv9eyQIu6uRYRWrxoF6?=
 =?us-ascii?Q?EpP8baecJU88kBTMxViB1e52AgDlZIiR42ksp79L1nWe68B+KzDhEU0ITnLQ?=
 =?us-ascii?Q?hp8l4e7PnUl51VjN16/rz0ihtLVTyBmiEnu4eIDahxedYY65SJ6qQGDQiRmt?=
 =?us-ascii?Q?TTDWNW1O0J+K0K3OclC7DR8/jc4xjoqeqb8Zjdw56qqebVaLxetBpZ7d7d4R?=
 =?us-ascii?Q?pvMNWHAwi9S0jlVLd6BHIa+AxWshaJp2BGiWEGfw0pRCy3VLLnPBJr+6/5sI?=
 =?us-ascii?Q?rQRTfckpYZrmUC83vevd+In2CjqyrWHgGET+39QJWZEP6jebzXHZh6/wBZdU?=
 =?us-ascii?Q?j3+nCxMY8GSFjB2o4sCQGMAYa1XHh37dAHb+tDCymLO/cDfQBrLVe86dxuS+?=
 =?us-ascii?Q?pr66ucstjtSeHq/ehKrX3mU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b0265b-d626-49c1-93c8-08d9b4d95d73
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 14:46:32.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxZq4HLQmHorqUSELoPUyHgXYyCBR5dIPevtN1FW+nRYd61Dyhar9Cog4ASvs7Rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4120
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The qgroup commands now accepts the level/id format. Use 0/subvolid to
avoid invalid qgroupid error.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/099 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/099 b/tests/btrfs/099
index 375cc2b9..f3a2002a 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -29,7 +29,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT $(($FILESIZE * 2 / 1024))
=20
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit $FILESIZE 5 $SCRATCH_MNT
+_run_btrfs_util_prog qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
=20
 # loop 5 times without sync to ensure reserved space leak will happen
 for i in `seq 1 5`; do
--=20
2.31.1

