Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABDC433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFDE6196B
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1Siq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:38:46 -0400
Received: from out20-15.mail.aliyun.com ([115.124.20.15]:58621 "EHLO
        out20-15.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhC1Sij (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 14:38:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07613073|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.199471-0.00793264-0.792596;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Jrd-vHR_1616956716;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Jrd-vHR_1616956716)
          by smtp.aliyun-inc.com(10.147.42.241);
          Mon, 29 Mar 2021 02:38:37 +0800
Date:   Mon, 29 Mar 2021 02:38:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v11 5/6] xfs/529: quotas and idmapped mounts
Message-ID: <YGDNLJaZ/1X3O4lb@desktop>
References: <20210327111856.1211544-1-brauner@kernel.org>
 <20210327111856.1211544-6-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327111856.1211544-6-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 27, 2021 at 12:18:55PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Test that xfs quota behave correctly on idmapped mounts.
> Mount a scratch device with user and group quota support enabled. Create
> directories "unmapped" and "idmapped". Create files in the unampped
> mount and verify quota behavior. Create files through the idmapped mount
> and verify identical behavior.
> 
> Cc: Eryu Guan <guan@eryu.me>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: fstests@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 - v8 */
> patch not present
> 
> /* v9 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Rebased on current master.
> 
> /* v10 */
> - Eryu Guan <guan@eryu.me>:
>   - Remove leading "_" from local helpers.
>   - Remove redundant "-q" option from umount -l calls.
>   - Use wipe_mount() in a few more places.
> 
> /* v11 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Add a dedicated "idmapped" tag for idmapped mounts tests.
> ---
>  tests/xfs/529     | 378 ++++++++++++++++++++++++++
>  tests/xfs/529.out | 657 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/group   |   1 +
>  3 files changed, 1036 insertions(+)
>  create mode 100644 tests/xfs/529
>  create mode 100644 tests/xfs/529.out
> 
> diff --git a/tests/xfs/529 b/tests/xfs/529
> new file mode 100644
> index 00000000..a5607306
> --- /dev/null
> +++ b/tests/xfs/529
> @@ -0,0 +1,378 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
> +# All Rights Reserved.
> +#
> +# FS QA Test No. 529
> +#
> +# Exercise basic xfs_quota functionality (user/group/project quota)
> +# Use of "sync" mount option here is an attempt to get deterministic
> +# allocator behaviour.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +wipe_mounts()
> +{
> +	umount -l "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1

If lazy umount is not necessary, please just use bare umount, I found it
hard to debug if someone is holding the mount.

$UMOUNT_PROG "${SCRATCH_MNT}/idmapped"

Thanks,
Eryu
