Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5379C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 17:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358092AbiDLRTz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358080AbiDLRTw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 13:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02EED51E60
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649783852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMKYxn0CO5u8O7kh/hfqyhlcuQeH0sO+Eo2BmHtqcCY=;
        b=ZGWfr2grBBOgafciC5rJyWzeq3auIcQxDr9ABPGujXnTx5B1cydbsfivJ726I71yYS47xN
        RR+zfChe8YJBVTAFGXFKMKnh5z2pEHy9whp9APhXAXr1J4lZX6paleQTpPnAlai6bclp5r
        5fgQPQkb0QCWFt4ZArBBcYr7aeBRFCU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-1IgePv4iNWSSpKtBFsYEqA-1; Tue, 12 Apr 2022 13:17:30 -0400
X-MC-Unique: 1IgePv4iNWSSpKtBFsYEqA-1
Received: by mail-qk1-f200.google.com with SMTP id u6-20020a05620a430600b0069c0f5ad4e2so5056249qko.2
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 10:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rMKYxn0CO5u8O7kh/hfqyhlcuQeH0sO+Eo2BmHtqcCY=;
        b=07YoImZErnOJRhhvhyuk04HElBXOZK/qvsT0kVF2uh7svXZc+4Iun12qlTek6a45WL
         SZVlDkViWSC66wbBvzXOfqOvveNguDL0FOuf5KHvxOByK84RHX8fn0oqi7Ndg14Zsoyu
         S5d5rnYbj62GS+1a+Ud5OzcLiIN+G7xXXPzwuWGS0kUOP2eR2P7AuBcXJzp7O1MQHWju
         KGKJKkus7GWY3K0KdYFpPs8FhviAkTZVRIrc47GzXIb2MjcaoSA4O+gZZ0hSFu9bQXyM
         D8Uro24DHTCZqfhDz+MwK0ahcE1fr1lY6RlIj165WgodU3fN8n9nu74qBQm5p0vVWrfb
         bMHw==
X-Gm-Message-State: AOAM5314ogYWnOWg51Wl8DK+wK7bGRNULyPsGvzL5yAQkYMIOPtIFzFc
        14So0HDv/tm/sjOava/s3SwCunamb5nuqUXwCC7NCS0V4hqKzYB4eQMIvFWEmK4XqzcKEslZTzk
        ncKTpmurlG3FZkLy+1Q==
X-Received: by 2002:a05:620a:248a:b0:69c:437e:4ea9 with SMTP id i10-20020a05620a248a00b0069c437e4ea9mr2025604qkn.10.1649783849685;
        Tue, 12 Apr 2022 10:17:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzepXyAWM9FzabWnsyRbaG6czO9LEgDUi//UedTfrasHEdzeNTE/aO0X5G75YF0HwAZYm4yhw==
X-Received: by 2002:a05:620a:248a:b0:69c:437e:4ea9 with SMTP id i10-20020a05620a248a00b0069c437e4ea9mr2025588qkn.10.1649783849384;
        Tue, 12 Apr 2022 10:17:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm4872152qti.20.2022.04.12.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:17:28 -0700 (PDT)
Date:   Wed, 13 Apr 2022 01:17:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] generic: test that linking into a directory fails
 with EDQUOT
Message-ID: <20220412171723.owphga4kmx3im7zv@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971767143.169983.12905331894414458027.stgit@magnolia>
 <164971768834.169983.11537125892654404197.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971768834.169983.11537125892654404197.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 03:54:48PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a regression test to make sure that unprivileged userspace linking
> into a directory fails with EDQUOT when the directory quota limits have
> been exceeded.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/832     |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/832.out |    3 ++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/generic/832
>  create mode 100644 tests/generic/832.out
> 
> 
> diff --git a/tests/generic/832 b/tests/generic/832
> new file mode 100755
> index 00000000..1190b795
> --- /dev/null
> +++ b/tests/generic/832
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 832
> +#
> +# Ensure that unprivileged userspace hits EDQUOT while linking files into a
> +# directory when the directory's quota limits have been exceeded.
> +#
> +# Regression test for commit:
> +#
> +# 871b9316e7a7 ("xfs: reserve quota for dir expansion when linking/unlinking files")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick quota
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/quota
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_quota
> +_require_user
> +_require_scratch
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_qmount_option usrquota
> +_qmount
> +
> +blocksize=$(_get_block_size $SCRATCH_MNT)
> +scratchdir=$SCRATCH_MNT/dir
> +scratchfile=$SCRATCH_MNT/file
> +mkdir $scratchdir
> +touch $scratchfile
> +
> +# Create a 2-block directory for our 1-block quota limit
> +total_size=$((blocksize * 2))
> +dirents=$((total_size / 255))
> +
> +for ((i = 0; i < dirents; i++)); do
> +	name=$(printf "x%0254d" $i)
> +	ln $scratchfile $scratchdir/$name
> +done
> +
> +# Set a low quota hardlimit for an unprivileged uid and chown the files to it
> +echo "set up quota" >> $seqres.full
> +setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
> +chown $qa_user $scratchdir $scratchfile
> +repquota -upn $SCRATCH_MNT >> $seqres.full
> +
> +# Fail at appending the directory as qa_user to ensure quota enforcement works
> +echo "fail quota" >> $seqres.full
> +for ((i = 0; i < dirents; i++)); do
> +	name=$(printf "y%0254d" $i)
> +	su - "$qa_user" -c "ln $scratchfile $scratchdir/$name" 2>&1 | \

All looks good to me. Only one question about this "su -". Is the "-" necessary?
I checked all cases in fstests, no one use "--login" when try to su to $qa_user.
I'm not sure if "login $qa_user" will affect the testing, I just know it affect
environment variables.

Thanks,
Zorro

> +		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
> +	test "${PIPESTATUS[0]}" -ne 0 && break
> +done
> +repquota -upn $SCRATCH_MNT >> $seqres.full
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/832.out b/tests/generic/832.out
> new file mode 100644
> index 00000000..593afe8b
> --- /dev/null
> +++ b/tests/generic/832.out
> @@ -0,0 +1,3 @@
> +QA output created by 832
> +ln: failed to create hard link 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
> +Silence is golden
> 

