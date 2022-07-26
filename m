Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8915CC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Jul 2022 05:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiGZFEi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Jul 2022 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiGZFEi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Jul 2022 01:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414ADCE2A
        for <fstests@vger.kernel.org>; Mon, 25 Jul 2022 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658811876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jbFsJ3u7b3EDDKcMh5oNzFJd3D1ohx97XZnBcYktxo=;
        b=PuRdGXj545o9G9NtFvKR7pgUbJUYV40izlsXQbSurxSZQXt2ymrWKHoY3dojaFpGVJFJ1T
        3ZD5w3LbmVxLdAxbri+HY2ASFpfu9Sicawc+olevg/pnzF0D2GCBz9oTHsiw2xcuR19CgN
        ykAL48c2W38Y21/MRR12ToDS38aPrjw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-fqRwKIXgOLuH8vSbvtSNGw-1; Tue, 26 Jul 2022 01:04:34 -0400
X-MC-Unique: fqRwKIXgOLuH8vSbvtSNGw-1
Received: by mail-qv1-f72.google.com with SMTP id lp8-20020a056214590800b004744f4ad562so2556266qvb.2
        for <fstests@vger.kernel.org>; Mon, 25 Jul 2022 22:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jbFsJ3u7b3EDDKcMh5oNzFJd3D1ohx97XZnBcYktxo=;
        b=y3cAAI07rt1Ic/iMaEEbpc+hGQd3JSmNqpDIMWx9ommz2gt6Oskb7fLyjojSu1Wb8p
         ws4exwz2NDIPS9rV3kDCsmNC/AEXiyNt0/GyIOvYRg8P6Vi1MfVv4O7SmAy1zuu67oSA
         oetpliiJ6VBdhVjA6yDlZ5rucEGGCuI6mYOz72ec5eCTv8rygmaNzJhTCvnofZVOfHCK
         6vyCz2K9UHVjOlnn3qbYy5zCciewvHNyaCEKio4SU+b/nKynaYSRIiqylIS2r6YwLG6W
         lV2aBLy+K4ijUnGHJlSPqH/A8gD74cRACn49PZlE4vf1nu8roRr/qzWwwgPyFjTjwpI2
         zEcg==
X-Gm-Message-State: AJIora8DABe6W82fJgTxnF+RNg2nvhlVEwBkqNzkpH+oXyKFZzHkbpDV
        1trxLciu0D0aVSieSwd9amc3n6+62HqwC1h2rnRQvDgO4/guGOTW8T4BUqJOy59odNBkZhg+5yZ
        Kz8NNUn4LuyWPC2H9nQ==
X-Received: by 2002:a05:6214:2308:b0:435:3440:7d3c with SMTP id gc8-20020a056214230800b0043534407d3cmr13494258qvb.65.1658811874014;
        Mon, 25 Jul 2022 22:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXQYbiB7HSbDLNks65TuqQ8Fsz7p+v34ASBzL9falTwWhi3pLz+Lznym+CVZ/U2DP/OXs9Mg==
X-Received: by 2002:a05:6214:2308:b0:435:3440:7d3c with SMTP id gc8-20020a056214230800b0043534407d3cmr13494245qvb.65.1658811873716;
        Mon, 25 Jul 2022 22:04:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v33-20020a05622a18a100b0031f0b43629dsm9273741qtc.23.2022.07.25.22.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 22:04:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:04:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4] ext4: resize fs after set reserved GDT blocks equals
 100
Message-ID: <20220726050428.buqfbitoqspaafvg@zlang-mailbox>
References: <20220726032240.3709879-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726032240.3709879-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 26, 2022 at 11:22:40AM +0800, Sun Ke wrote:
> Set reserved GDT blocks equals 100, then resize fs, will trigger null
> pointer.
> 
> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
> check.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/057     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..f4bbcd32
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# Set reserved GDT blocks equals 100, then resize fs, will trigger null pointer.

The number "100" isn't important, it just hope to get reserved GDT blocks
even if you disable resize_inode feature. So you'd better to reflect these
two conditions, rather than the number "100". E.g:

# A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks check").
# Make sure there's not kernel crash, if resize an ext4 which resize_inode
# feature is disabled but has reserved GDT blocks.

> +#
> +# Regression test for commit
> +# b55c3cd102a6 ext4: add reserved GDT blocks check
> +#
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
     ^^^^
Remove this useless comment

> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_command "$TUNE2FS_PROG" tune2fs

If you don't need this command anymore, remove this line.

> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$DEBUGFS_PROG" debugfs
> +_require_scratch_size $((1024 * 1024)) #kB
> +_require_scratch_nocheck

Generally we don't use _require_scratch_size and _require_scratch together,
You can use a simple one line:

  _require_scratch_size_nocheck $((1024 * 1024))

> +
> +# set fs size 512M

If you'd like to have some comments:

# Initalize a 512M ext4 fs with resize_inode feature disabled

> +dev_size=$((512 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> +

# Force some reserved GDT blocks to trigger the bug

> +$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> +	>>$seqres.full 2>&1
> +
> +$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> +	grep "Reserved GDT blocks"
> +
> +_scratch_mount
> +
> +# resize fs will trigger NULL pointer in ext4_flex_group_add

# Expect no crash from this resize operation

> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..99423e16
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Reserved GDT blocks:      100
> -- 
> 2.13.6
> 

