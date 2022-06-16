Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237AAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jun 2022 04:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiFPEi6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiFPEi5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jun 2022 00:38:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9058E69
        for <fstests@vger.kernel.org>; Wed, 15 Jun 2022 21:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F12Ml1Q6AC9m316lgRPd+p3/WjLUVLlpKHXyqdfV96D4+6uc1nhJkYGBncjtGtcxKzJdcou7J3J4sFHnjGbranEoxDle04Fpg8I+YQWf6LQEf/PMvSYI/ZuzaD1XwTpifUFbe5Kydb+QnBqr85Nxwituyk8yt+4sc7wj1/PtAKnKxsMf7VSiK1cpjeAy8qjtP0ap0gpF3rYqGc775E7ooZiDJ1KnpiOulZxpGKWkQ4wGXNIC9jOZUjCH+Izqiv2Y9SmgN3Ekxftb+eSM8kcHdi2hq5podbZdK0L9uD2OiWYxmC3YYcL2681HezfOcXRnlpSsacrm2nvzzgNr+yfuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEhS61XMp8LsTCKN06cnG8IqcuigYfYjGdd6+KIFSgA=;
 b=Emn46E0dU+0GgW2L6TItJfayQzVzYeCVi/Ij7FU1UqyzhHc8/BUzyVikDhvgjfgBrzvJVshTN6kqUHCxU8PKb3dwbIhKCmVViZVGWNgwPPl4hgmRd2EkD0jdoRjoH/kRl0QogIfxEiM5FOAi/dHpjR91kCJlGANW8L654is+3yZat+mQ0fQE7QZY7hykkKbPu0E8SfnQuVFDQMG3aBoie5muzD3R5Tflt57aO27SrxHwVnt75AP/4J9X9Od1Y4GEzh6XAR87Us1LUKs1EN+jw8yfw9YDKG6xNiGgTFyeV9tfHycMaMCvUYcjs2SbJ/VxLhQ/TzKrnPn1gcq0r6bvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEhS61XMp8LsTCKN06cnG8IqcuigYfYjGdd6+KIFSgA=;
 b=MCiO1LRn79aL0OkdFNqK4jRXZIveZQkZ121/DkqlncJs6i1UcMw8icchQ9ItOI2NsRVKETlUrqu0Mmzq8hWGVb2mYzczPhiVOOvo+qnmeO2r/ZpiQaQXTH0nj90Lpc8Sq+/Ohjt5mwx2Tw/LzGJl85MFoxItoY20mu5ENeryk4GNJqIfX2QvhdXopoMBYfkF69U14scIdLcp5c1Qmf1kxNp3Qb17jdr2NNpJmVK+YS2SS8zK3USVaJ472xgZlm1tJtVtYq1sTlw1CSb9lpgOOBlF73jiEdNoimroggJJ4qgWw4muZm0ref+WnzpJ/mfD4duQk04RbXTThHm5bzQ6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by DB7PR04MB4828.eurprd04.prod.outlook.com
 (2603:10a6:10:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 04:38:53 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 04:38:53 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Date:   Thu, 16 Jun 2022 12:38:43 +0800
Message-Id: <20220616043845.14320-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e6a679-e740-48f2-994b-08da4f521dd3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4828:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4828C851CB434DE3DCBD4F8CC6AC9@DB7PR04MB4828.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 623eBgJytxfwate5nGG1LVGceAmXR6I37sBm66FiZ5RO/5XqAHw2ZMJ7EVRNtBU6y3QVbL7x8hL9vVYLKjj0Sm0tvYehc21aw/9HTJm9lj6LB4EZoDBtC/FBtP5xcNnh9WUTCzSyoQUWTw2nbt2g1OFPBy3Qv+yw/EfkV1W2xQcE1YDhZYktQ1sQPHr5u9qGbek0DrDEOA8iD1JaWK3j8hbDee3syHQ1bNDJZ5TVrYCr5u71qIgQ3zkGWY51gYiHMbid3ZbaWvYzba7kT5dxilzsEjbhul0Cb9WGfQ1HpLpnWkhqfTRuQyrmEVeSNjRF8YNORcqBSgnzEj2U/wuHeizyVe60CHNiq7Akt1CTXvLGCvNT2IzDaAh0p85JWfCGZcXdwlgkD3e1N6rATwckNqe9uEjEjbvt35GZX4dQ2z3tIBSjEwuYMOAyX+9Wixt/+wrcrZevUlX3Q3Gzs2CJAxPHOPL18r4ynNBu+UQNJrMFFXnh2R1nFCBbpkja3F6Wk9+hjDpLiWFGVnjXFMOnLWmFx4sp/ZDu0hl+xruguYRO2zAa4TL8OGoHIG+QiYFI6YcPDaDM+Uj5c3XVPp3A4gJjc1Rxu/6Ky+kPIxFedDM3LvHqZckD6d8bRd7/v30GONUuHXpAPi2xSU2Ibm6+NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(186003)(1076003)(38100700002)(83380400001)(86362001)(4326008)(36756003)(66556008)(66946007)(66476007)(316002)(8676002)(6916009)(2616005)(5660300002)(6486002)(4744005)(6512007)(6506007)(2906002)(8936002)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekZ1LKMU1JS+ce8wZ2+tB2til46thq2IEjCRQtT0OZfWBu9lfxEHC16Spdw4?=
 =?us-ascii?Q?FXJ18kVBu1nAbylwUYipUeIAwziD0TwxlPu9MXqpQ2iiUIZq8lQ2RHcVv9Zu?=
 =?us-ascii?Q?wUvDHpwP/RRBWJ6yiM4u19CLCtP7cJm9BPji7KRD+dmif9dfd5OJnHwBndhw?=
 =?us-ascii?Q?PqZA+Vf8CEMkaK8ZaeA/F6BtQ9td490TKNpWjqWNRRLlZKQ0hc8/tdxeH+r6?=
 =?us-ascii?Q?U1iGVNFS/CM9RO0adjqOszPUAeoKhcz//AmeNQuQ3NYzFcq969BtnYutmOc0?=
 =?us-ascii?Q?CamnQGQ/m44rv46M+4XXQ8IZPsfF7OhbxgGhNnWEiUzpDjJqkrTcBEFzcUT6?=
 =?us-ascii?Q?+5UnCzbzJaeSxHmox5dJLc2QbyaOdBL2qFHP6wIKjMYZFyjISt5qcpXgGsZ1?=
 =?us-ascii?Q?3udkw/ApM51AzmwqOlrShto2a3CfjvmpTg+v6gnFo13fDnPjUy/bR+AxmQlj?=
 =?us-ascii?Q?LiHqIpacDRKNijcF44YgkkTXv5uXilr/lSnvNnDXMFQunnT/4+vb68Bk3oaB?=
 =?us-ascii?Q?voPidCYHJHVs6gZH7J7pipWTdlbYI35ZAbJ0u6YQh6idf+How6DjCiPSydc4?=
 =?us-ascii?Q?ss+1/P0iOvnqyk7bYtoHGsRBajdWdkJjaOc/n6W9FdmmxTu7OrrZcgup4PCD?=
 =?us-ascii?Q?iXbqQok6j4x3MGtZDfletlFeLKjW+DOk/a/X2V0/4Ia+LzR5Vy/CvJ9nKeKP?=
 =?us-ascii?Q?59Bbnk3Y51YpQ2xHqp8m0ecH82W9CHOI50tn28FVL8IYW5k8Zbgn36wSP15L?=
 =?us-ascii?Q?s0jY/8BEHEPvUGQV/TUecx3y3LRbsdjYwvipKra4ebiLI9XVWIJEbltFLin0?=
 =?us-ascii?Q?obdFuqGg0IqtEZAZ9XzuBc8rBloa0s4fwx6ip6XrsOcd1NBuSgEgx9xO+mnW?=
 =?us-ascii?Q?GNuCCe2WjYcVDSaqghgzZYz6YREnngh0YH5hJ5axU+/DJUE1w1pr4xAyB50w?=
 =?us-ascii?Q?mD7PYlgbcy18ZegmtsLqy/3gi6SjjvbXrgQFOLyFt9AVjsySc9L4nHOo1A0w?=
 =?us-ascii?Q?xXDUilPtEzSTs/WHXOEvKBM/zYRZZteKR49ubh2kR0tmb19V8Pgm2QH77oFr?=
 =?us-ascii?Q?FEGZUCy9Burdp6pltlKlabE6v9RJ3fZKCC64jggYvTsun4wvu0BrOrsKj5tq?=
 =?us-ascii?Q?2pekZbhcyHFWAarwXqML16j837gDcRENt63peV+H/He7dpXaqy77x2yyiSqh?=
 =?us-ascii?Q?8dkGi85Ee1dtXgB36RQtp/5Yo7THrZgrgzB8AzFhOqM2M+S1gFdeH8wJFbAQ?=
 =?us-ascii?Q?YC6JzERY47VhAQUkVpoOgDIvcdgeQdx84IE/KZn0LzkVYWT5eJrATQWT2FCo?=
 =?us-ascii?Q?sDjdmohaxrHL01JvStaviDz57rp+i0cyxwTtlqbYssKv9+z7JFg61hPUmyPu?=
 =?us-ascii?Q?z1ewyqOHjFL9ewyVtLxIuCfg6PIkAE7J+h04n+8uibXzyup/1nF1S8IZSRGo?=
 =?us-ascii?Q?G4vGbuH7DJGQidYPkNQI/pPPUrk74Y0uewBDUnRIo47Vr4D9rab9tt+dnxkL?=
 =?us-ascii?Q?t8+3bN7niQPFgHPVYTymbWm6P9qxU9zK+lsOVOqIbNyVqS2JQOmxc8p8cx56?=
 =?us-ascii?Q?Y/LX8jLPzs3ZbPHnag/tkcIjZRTqFH2c2/MB481uv04Z36FxQcb5plHSFb99?=
 =?us-ascii?Q?jOb6N/tNhMQgE/Q4LGIsIwplD/GN6tHRUlyjD2Fe6yClKlM7zK+CG3fyeKwU?=
 =?us-ascii?Q?1wQP7C5+f31b7paftUIExh2LtuL7iFK/Vul/Ix/hxLYuKxlQ2pbr5hKMSnWr?=
 =?us-ascii?Q?h/Bq2rVQ8l/h7N4Av1FEBJKJ2bcsPaGZ7XkROAy7/UMkdINsnFTm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e6a679-e740-48f2-994b-08da4f521dd3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 04:38:53.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCx3ZwZssPHoODKZA5Rbm/hYw5Y4fxrFZl6XIsYBn7+73WvN0Jkck/56vYszvluB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4828
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Function _scratch_mkfs_sized cannot recognize the size descriptor.

For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
ext4, will fail with "mkfs.ext4: invalid block size - 4".

The [PATCH v2 2/2] based on [PATCH v2 1/2].

An Long (2):
  common/rc: add _parse_size_string
  common/rc: fix input value to _scratch_mkfs_sized

 common/rc | 66 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 12 deletions(-)


base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
-- 
2.35.3

