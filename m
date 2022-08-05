Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79579C25B07
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Aug 2022 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiHERSm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiHERSl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Aug 2022 13:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FD904507D
        for <fstests@vger.kernel.org>; Fri,  5 Aug 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659719918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g88lQaqy4wejbQ8juNcEgdcW3ntpZ265KFVAS+Qb7mY=;
        b=LKel5vp2Fb4Rb6P6+ApA9IESqNW+X3a62xxjALlSZO7SAYcPBfVUnb/Q9ksi3wooGBW0DY
        vBHUkcX1IYFBJRNlbU7M29JQtl0u71IpDmn+3zDrG/h988qn3CijLAl0kaBoKKoyUCD6IX
        XYFa7FxUro+z7WKg9NjjR/pn+eLbHFs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-DoH2FLqiPJ-54L11Ih_1sA-1; Fri, 05 Aug 2022 13:18:37 -0400
X-MC-Unique: DoH2FLqiPJ-54L11Ih_1sA-1
Received: by mail-qt1-f197.google.com with SMTP id bl15-20020a05622a244f00b0034218498b06so2332192qtb.14
        for <fstests@vger.kernel.org>; Fri, 05 Aug 2022 10:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g88lQaqy4wejbQ8juNcEgdcW3ntpZ265KFVAS+Qb7mY=;
        b=uaMFYgiroTVU9hsWuHuRYhzXjUJFAnopB3PfuN5UFgHDoCTOHCkGo13bk/TzD6tjeO
         9B4ZePG1gUPEEeTiQp1ti3XN7yjn5nXZ9BIQX33W096nQrpeaBTDNtXfsRyIJYrQsB37
         bjaldvt8zDe5fNHNiGDorLJhI3kO5/wNR0/AByrlZTJpGu+4unJ3eeiPjCzoAIPSugng
         yfVmWJoIsOHQ3PmsFB09D+fIOdzlJxrOjeUiejaDld7Rm3k1HYTKprOYlZkCwd43eOSo
         3tDDUEgjAU9mwI2KhYhqfa9QyV6ne5hNcMl8FEI1XqtbJ/JHGLeWZmufvQWctx64CiuH
         Itgg==
X-Gm-Message-State: ACgBeo1a02EKjB+xOl+A6nPytmRkL2Wma7EVcGV7vRRVkxPOEMfo+HTa
        T+kVKu1TXxDUjDndkKJCErkbHzBIgWSO0M0DhmbRguorKNf4DtmWIqGdBhhbplLQFLjQ4pK/m9X
        RnUrNTiMOwVZFBIZ3cQ==
X-Received: by 2002:a05:620a:440b:b0:6b6:2e97:e4c with SMTP id v11-20020a05620a440b00b006b62e970e4cmr5790558qkp.649.1659719916930;
        Fri, 05 Aug 2022 10:18:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kqjtHICcj4eDxklFmB/oks0HJmu522PPq/3wsMgKT+PkbCxF+svnfDGgT8WpnBoMluRfLog==
X-Received: by 2002:a05:620a:440b:b0:6b6:2e97:e4c with SMTP id v11-20020a05620a440b00b006b62e970e4cmr5790546qkp.649.1659719916688;
        Fri, 05 Aug 2022 10:18:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q55-20020a05620a2a7700b006b909ad6646sm3369843qkp.16.2022.08.05.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:18:36 -0700 (PDT)
Date:   Sat, 6 Aug 2022 01:18:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] generic: new test to verify selinux label of whiteout
 inode
Message-ID: <20220805171830.bufxpsw36plxxbux@zlang-mailbox>
References: <20220714145632.998355-1-zlang@kernel.org>
 <20220725061327.266746-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725061327.266746-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 25, 2022 at 02:13:27PM +0800, Zorro Lang wrote:
> A but on XFS cause renameat2() with flags=RENAME_WHITEOUT doesn't
> apply an selinux label. That's quite different with other fs (e.g.
> ext4, tmpfs).
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Ping, any review poings for this patch? The bug fix has been merged into
mainline kernel:
  70b589a37e1a ("xfs: add selinux labels to whiteout inodes")

Thanks,
Zorro

> 
> Thanks the review points from Amir, this v2 did below changes:
> 1) Add "whiteout" group
> 2) Add commit ID from xfs-linux xfs-5.20-merge-2 (will change if need)
> 3) Rebase to latest fstests for-next branch
> 
> Thanks,
> Zorro
> 
>  tests/generic/693     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/693.out |  2 ++
>  2 files changed, 66 insertions(+)
>  create mode 100755 tests/generic/693
>  create mode 100644 tests/generic/693.out
> 
> diff --git a/tests/generic/693 b/tests/generic/693
> new file mode 100755
> index 00000000..adf191c4
> --- /dev/null
> +++ b/tests/generic/693
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Red Hat, Copyright.  All Rights Reserved.
> +#
> +# FS QA Test No. 693
> +#
> +# Verify selinux label can be kept after RENAME_WHITEOUT. This is
> +# a regression test for:
> +#   70b589a37e1a ("xfs: add selinux labels to whiteout inodes")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rename attr whiteout
> +
> +# Import common functions.
> +. ./common/attr
> +. ./common/renameat2
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_attrs
> +_require_renameat2 whiteout
> +
> +_fixed_by_kernel_commit 70b589a37e1a \
> +	xfs: add selinux labels to whiteout inodes
> +
> +get_selinux_label()
> +{
> +	local label
> +
> +	label=`_getfattr --absolute-names -n security.selinux $@ | sed -n 's/security.selinux=\"\(.*\)\"/\1/p'`
> +	if [ ${PIPESTATUS[0]} -ne 0 -o -z "$label" ];then
> +		_fail "Fail to get selinux label: $label"
> +	fi
> +	echo $label
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +# SELINUX_MOUNT_OPTIONS will be set in common/config if selinux is enabled
> +if [ -z "$SELINUX_MOUNT_OPTIONS" ]; then
> +	_notrun "Require selinux to be enabled"
> +fi
> +# This test need to verify selinux labels in objects, so unset this selinux
> +# mount option
> +export SELINUX_MOUNT_OPTIONS=""
> +_scratch_mount
> +
> +touch $SCRATCH_MNT/f1
> +echo "Before RENAME_WHITEOUT" >> $seqres.full
> +ls -lZ $SCRATCH_MNT >> $seqres.full 2>&1
> +# Expect f1 and f2 have same label after RENAME_WHITEOUT
> +$here/src/renameat2 -w $SCRATCH_MNT/f1 $SCRATCH_MNT/f2
> +echo "After RENAME_WHITEOUT" >> $seqres.full
> +ls -lZ $SCRATCH_MNT >> $seqres.full 2>&1
> +label1=`get_selinux_label $SCRATCH_MNT/f1`
> +label2=`get_selinux_label $SCRATCH_MNT/f2`
> +if [ "$label1" != "$label2" ];then
> +	echo "$label1 != $label2"
> +fi
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/693.out b/tests/generic/693.out
> new file mode 100644
> index 00000000..01884ea5
> --- /dev/null
> +++ b/tests/generic/693.out
> @@ -0,0 +1,2 @@
> +QA output created by 693
> +Silence is golden
> -- 
> 2.31.1
> 

