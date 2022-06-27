Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4465AC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 14:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiF0OIz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiF0OIv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 10:08:51 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20086.outbound.protection.outlook.com [40.107.2.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE312AEC
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 07:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+42SlKVOGKqwSf7kRQb6OZ6Ey1tVihHA3DKEo8oKi/V9DWE3vqR/4wpq71We3as2HOi60QZFzkvdSgCYR0XGpKZWRlE5T0wTb42VS8iHek7KQhKLY2yeN/9DU2hOKg7LIH1cuhvFd5fIKQcuTbOx9wjNBM+7algSlI2CoTqRVI98Br0/AUIjAg9Oy4s34lUajA5ra26Odlte7VyR+Y3PWtLw1T6PPnpa4E1QIkhyeTgylpLhlN0R2kFt2b37cF/cNYuBOr4h0wkrEmRGZ3dJq6Dr+aQW2YXg+QA5mi6/3xSo3uVJdWsYleb5t0IDLMVxF+pL5vhSzWf5dxCIqCIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlygDkQGwPU2jbeOoDpV3CgZWH9UK6NeuTsqstwDgdw=;
 b=i64o1CULgK6N1N0WrvDdlq6ovWiXjf1luCIdNHyJ3Gyu/cv+rmkJKW8OWE6BIMybeeCa+yuGZeDvDoGGuFpwGk67qO0jEqqUq47/NIloDS0SrYxDToYBRAexan08Zj8DX3SmuQzAaAsgA516kSDNNcDIAJh7VtQqfqjgoPp6WEhqI/Fbo7Vdl9KwG/Vln3Qt0Bu1ZfEwACCU0m3stJfVQzSSGSZuy3502FCARfBJhxSH0ssKdgop6LZJnsRvivfWrB3O9bBa6tZtD6yvPTfhq0VZZi6WA49zv9OWxCaGJL/H6HwUZHL7tV70QLuxcPr9oUdC9S8d2Phyx7Cv19IPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlygDkQGwPU2jbeOoDpV3CgZWH9UK6NeuTsqstwDgdw=;
 b=CzMpEwB3TFYkjQLjsEGwXHc4VvlT9juvD+qXnU9HHagNr/JbgvyeREfuqePLSZKRFYaPnYweNjfFvYIOwpwtY87hvzuvvCK7Xte9P96yaUBb0+JlilliPRiTgE0NqGuiuQM3AO2TrITtYkhAaejntGc/u8ctHdUEQsCpQwkJrMc/EWfvOuImKFOrePME3B6jE9SfWukex26hEAMCrv/d9DkXGPF/Xta30DOj9R3QkJWyz330N8p2a8Jea/XhK6954tHvE8SzsSjG+nPvAT8tzrvHL7I1arCwjgTN5NAQ3D2b34ulVePS7HB64MXr6YAbbdnuclYfg0yNxqiXRYbVew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by VI1PR04MB6095.eurprd04.prod.outlook.com
 (2603:10a6:803:f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:08:35 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::35ba:f1ca:dbc9:b5b5%10]) with mapi id 15.20.5373.018; Mon, 27 Jun
 2022 14:08:35 +0000
From:   An Long <lan@suse.com>
To:     fstests@vger.kernel.org
Cc:     An Long <lan@suse.com>
Subject: [PATCH 0/2] Fix input value to _scratch_mkfs_sized
Date:   Mon, 27 Jun 2022 22:08:25 +0800
Message-Id: <20220627140827.23775-1-lan@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd793ae-de7d-466c-926d-08da58468633
X-MS-TrafficTypeDiagnostic: VI1PR04MB6095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RoEJV2ZuOI4J0k8Ji43oZ8cZpofBuLFL3dwSkdWcLpN+FgzRTxby3BSLC0Sofy/ZvGNqXhUFMQFzsDylnh3jnFYr9g/9oZzpU0WoO04axBxTZZeDGR+g6n+29dc6vmkz4+++TkZK+Vo2PeVwjdFto2qEBhvI6QXgpF3SDop9bbjBnXjctvm4bWKmNfo6vIMOKKSwubHFNOMs2QErGyt/TaQznGqjg8cOTMjC9h3vLVoV2pyqiajoSEdU0g1SPFa17jd2C9adFxfTddjtOBAbi5GRWe/xGM0pzwlJOojHMuq9K8vnc3RbUGJsREfM+kY27e1+zsOALTLYs5TrkNdADfTjllOcHeFufgkRBTHFFwZbnHkW4GCTlkiMKbL8OS0F54U+5hA2cseR8Jm/bd8yD+T9R3B9Y4zr2GJIgUJ+6L/SbipDGq2RNHaTuNcCCnJFjDHPX033g7thJyPO0UbdRaNaBhs2y18HZMLbXlh+UmSVWAM6gv84hSqw2GH92d5mAuHiXnlL32ilh1t/OeYwMzjQEpfsMt7E2KOPhVXMABiFLDzcycy43A4pkE6rAG8p0xrUK0y9++iXgx1yRo3DHmO5CUjAqX0TI55uAjvMas7UAz9KJXDFi8TOeCO5PpBfNsZMcJx7IL2DJs8mshw+HuFcEmmwiu2hyjw2/iH7pibNINF6Me7VG8zn8H0joQHDDWdVONE9zUNmFuZz+3Eni8DvJN5WVFka6Ar13kvpIgLVkcKMeZQpib/wI46fO4y1hsNjb6XDoyJecl0yq3I10Vb/7e480o4qS0zVhGtYoVq7aTSvYOjAewitceR/j3g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(366004)(136003)(86362001)(8676002)(6506007)(4326008)(83380400001)(1076003)(6666004)(6512007)(66556008)(8936002)(478600001)(66476007)(6486002)(66946007)(4744005)(5660300002)(41300700001)(966005)(2616005)(38100700002)(107886003)(36756003)(316002)(2906002)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epENz3JetnRNbzcNsw9ssLbD33rkyzD0jcZcfKpvvXC47MfU3DcvveR2qfCP?=
 =?us-ascii?Q?DPbIqS3Q3mPd40KBfj5yI4neYOhmZLZqf5Ou2XeDV5Z6F1RwQ5r8d1xwxXRx?=
 =?us-ascii?Q?lLjuiI2qID0mcd/0CZ9geIs1ep6O8wuDTh0EotRJcrp1qv8m/npLY86QmynY?=
 =?us-ascii?Q?CPsL3INkeiq9IlL+JB5Q4GxS0xVhOXVs6zhNRYPf8aU2R5CgvKtYW4d3UOpI?=
 =?us-ascii?Q?W8A0ZzRRBzDcOBZeZlAqxOXA0N8OSkq4eYuxzWalKHaD2rE7sl8bJqEEhUMa?=
 =?us-ascii?Q?OZYMRRQWA3XQtZRZ9b0z3qrSooZMARVBj14GJuRFPssoobR94a6WknWuww2K?=
 =?us-ascii?Q?FijqJQECaW2RTTPAeoDVlY1NPBHvg/GkaNakc30rAAnVQVaubAVzQASZ/l9s?=
 =?us-ascii?Q?Px0YaQj/SRQqrhEZQdDP0fpZpLD5EkoYiMD48gsdbPMVPHIKthK6xHDCrMOJ?=
 =?us-ascii?Q?FDc7d8ppfre0SuJskl/I6HnLXkgvG/7UJfNUbPiKnPmivmzpIct0P38Rb4vl?=
 =?us-ascii?Q?GRI+G+Bj1d2ez5uLSkVIWmctt8SoJguiZnoSYK2jroOzMLvNynZCHGY+fNt9?=
 =?us-ascii?Q?wNsAxA2FGDsbnqyuugyvBfYBKiPGpR1jn791BF9JxfKNAjG2fllH9Hj+C2Tv?=
 =?us-ascii?Q?rMlX1zLeSBMj927PRFjhM4qPytXdhoYne6P6O7owiY5jeBgPNz9+KiORcnqs?=
 =?us-ascii?Q?hLr7rgpSZbzD8C+rRGIlNZrZED/lQWOIuhTPm2kPcHuTBsCvSANVYZ+xtWvJ?=
 =?us-ascii?Q?yJn1kVyJDNaDSm8rBXzLcI93Riu0jVo8llJeLWzY6OI/hrqjFzYkR9wQv2oE?=
 =?us-ascii?Q?9PWas9aXYClp4Et49q7EdcP2p7i6Mfe+kGPLuaNklWXnPO+WknocKzTpKGmn?=
 =?us-ascii?Q?dj6L9mzVXaGP8VQbQqxLEXYAh9DMOK1T8BuKBFgQ5SffmHfqRT4hcobkBDkP?=
 =?us-ascii?Q?LpZrScAaKMtvlOnAljjq1VXkllU6SEthBYWbTP8SGyR6HncGNfW+KXd8ph/p?=
 =?us-ascii?Q?nVGyhoQy6kvRLd7S6zRbZARtdBXESujRD64A3nosPcPmMDhOKqPHn9kjipz3?=
 =?us-ascii?Q?KHwuFC2exfCjMBgE85WT9eG3NI5ta087L0ULWa62L179+80F+UOa7n6CsWUl?=
 =?us-ascii?Q?e9/BYVuaqdzLJRJpRUZ9s9YWwXI4i2hGo/TzaOwIi6ZAJmNc9sKj87pOAGrI?=
 =?us-ascii?Q?rEDbqOEvKneAcAgqaJmtKOS/pAal4R8DKmUxyAosYZlVMpuEt4XP1UzFSQWw?=
 =?us-ascii?Q?aCKDu9eQb/CMT1wRpB0OOzi2zvoMBYbMxDF4sb9QJbMXA5a/3gTp3dWQApvW?=
 =?us-ascii?Q?eoTHUETOexOFmXMkCX+snciAb/YRKt5U/VCETm7aLkLU9INlUTmnuJUocSDr?=
 =?us-ascii?Q?PasILCZ+8WEOoQQ+chacf483pgm2iGpEYaSY19ghxLeP4YlsnT8McPcw5b0K?=
 =?us-ascii?Q?wP25HHFbhYEPAsIPJBFDXn4q9/A5nmaVDCoQSVwffyYM1sJl60Rdnyxj7/wM?=
 =?us-ascii?Q?fqySy7BJurf2Er7ZLJHUWNGeyUgOyhfkN0xCkwS8smzEEaDHcPfy4LK7l/12?=
 =?us-ascii?Q?SIe8zCSgM68JjonhmZn0AVD78gtNggLzLfzXqQ9GE9zsBThg4caxUVGDF8BC?=
 =?us-ascii?Q?SLYqi1aJEdrYXU9Hak6PNho=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd793ae-de7d-466c-926d-08da58468633
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:08:34.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkO4H9GJoxjdi3w4u6WC12Fg1eABOs/sQ8qGaN5D5zZ640BHE7B4Zd6uYqZCLaKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6095
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Function _scratch_mkfs_sized cannot recognize the size descriptor.

For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
ext4, will fail with "mkfs.ext4: invalid block size - 4".

The [PATCH 2/2] based on [PATCH 1/2].

Full story is here:
https://lore.kernel.org/fstests/Yre%2F9qV62dtVyCvn@mit.edu/T/#t
https://lore.kernel.org/fstests/20220621044038.ppvdexgob3kzs46m@zlang-mailbox/T/#t

An Long (2):
  common/config: add _check_mkfs_block_options
  common/rc: fix input value to _scratch_mkfs_sized

 README        |  4 ++++
 common/config | 30 ++++++++++++++++++++++++++++++
 common/rc     | 16 +---------------
 3 files changed, 35 insertions(+), 15 deletions(-)


base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
-- 
2.35.3

