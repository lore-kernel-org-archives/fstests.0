Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD618C432BE
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Aug 2021 06:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1642610CB
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Aug 2021 06:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhHZGlj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239721AbhHZGlj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Aug 2021 02:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629960052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvO62wlaX1Dc+Ptvkh91QGb90MEgcGEGXnHPcdm8pCk=;
        b=O7y8hbDQODS1qy+wylWI1+9SbS0kNv0zI9pJEwB/vHq00w7RTeQxL2pY5/OtcHycUAT9qw
        jd1xzKIkbhNV+y2j6tlirr7OLsnEKu51HoS45VkbKJ//zXLAAcw6hX+75chuxzRCGIA+vy
        2JqcWTgSoXjm19lo6A+W4r8BASQEhQc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-MQe53ff3NXi30umx21frvw-1; Thu, 26 Aug 2021 02:40:50 -0400
X-MC-Unique: MQe53ff3NXi30umx21frvw-1
Received: by mail-pj1-f71.google.com with SMTP id 41-20020a17090a0fac00b00195a5a61ab8so427900pjz.3
        for <fstests@vger.kernel.org>; Wed, 25 Aug 2021 23:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cvO62wlaX1Dc+Ptvkh91QGb90MEgcGEGXnHPcdm8pCk=;
        b=bleGF6M5uqsi0dCfoSwAMcrRPBySueOJBf4Ndmct/c5ouaTHg1Zni2EQU/zevu4Mai
         zZmWEQWAoprujD/i8o8ZRJhV7MGstQrSBYR4E0LLP7hvjGNmCCCRxwG3AEqjTPoKOJdK
         FTc+pcFMfmhvCezolhdpnuVRd+Cx0fJokmwwcKL9WgAbsYPHZ2JiUGPXOMoWsYvjHp5S
         ZJQXAoIYRnX2jCzdkRnGaBYAPelK0OFMYhkF2gYS5xq6tkzMoe/vhP9bde+JT/jJq3XH
         L9ioxRvNMi9YURUNl0SikMBfQH5A5kiXCDeHl2kvVC0pGwkS8+93YrQao2cB17sEQTYR
         WXXg==
X-Gm-Message-State: AOAM530g1f00nPVXLicAKGkPM5yg7xnAjgJzLOj+4fs8Cp9fhdtmZeO4
        cXVbX2IPwcd1KYThx2n+ug6cyrivrSts8Gm45cz3K5hzhyu4s90tN3Xu9vu58OxBi3pNOnaWCpx
        N3FxUcN22W4ad/Cv1+g==
X-Received: by 2002:a63:f050:: with SMTP id s16mr2068815pgj.258.1629960049162;
        Wed, 25 Aug 2021 23:40:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLR4ARpxfsrDcHoz3zpEIs6sIlC4HLbtPEpofptZti+EJpdK5x4xzIQjcsHL/+VvOPSGA2VQ==
X-Received: by 2002:a63:f050:: with SMTP id s16mr2068797pgj.258.1629960048948;
        Wed, 25 Aug 2021 23:40:48 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 23sm2138053pgk.89.2021.08.25.23.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 23:40:48 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:01:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5] tests/generic: check log recovery with readonly mount
Message-ID: <20210826070139.3aspejx62xrl3mwg@fedora>
Mail-Followup-To: Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
 <3628adee-a6f1-6621-2988-786334fb6284@redhat.com>
 <a5d58dab-5f4b-884f-d29e-e531e536fc24@redhat.com>
 <20210825032630.gezd2jvkd4oczzsx@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825032630.gezd2jvkd4oczzsx@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 25, 2021 at 11:26:30AM +0800, Murphy Zhou wrote:
> And followed by a rw mount. After log recovery by these 2 mounts, the
> filesystem should be in a consistent state.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> 
> Thanks for reviewing! It seems my last several replies from gmail got
> rejected by the list.
> 
> v2:
>    Add explanation of the issue
>    add xfs_force_bdev data $SCRATCH_MNT
>    use DF_PROG
>    Re numbered this test
> v3:
>    Add _require_scratch_shutdown
>    Use _get_available_space
>    Explain why does not use _scratch_mount
> v4:
>    Add to recoveryloop group
>    Move to generic as there is no xfs specific operations
>    Remove all operations after 2 cycle mounts, let the fsck in fstests to check the filesystem consistency
>    Use _scratch_shutdown, MOUNT_PROG
>    Remove unnecessary comments
> v5:
>    Make _xfs_force_bdev xfs only
>    Use _scratch_mount, it's still reproducible

Good to me now,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> 
>  tests/generic/999     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..60e0ce59
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 RedHat All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Testcase for kernel commit:
> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> +#
> +# After shutdown and readonly mount, a following read-write mount would
> +# get wrong number of available blocks. This is caused by unmounting the log
> +# on a readonly filesystem doesn't log the sb counters.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick recoveryloop shutdown
> +
> +# real QA test starts here
> +
> +_require_scratch
> +_require_scratch_shutdown
> +_scratch_mkfs > $seqres.full 2>&1
> +
> +_scratch_mount
> +[ "$FSTYP" == "xfs" ] && _xfs_force_bdev data $SCRATCH_MNT
> +
> +echo Testing > $SCRATCH_MNT/testfile
> +
> +# -f is required to reproduce the original issue
> +_scratch_shutdown -f
> +
> +_scratch_cycle_mount ro
> +_scratch_cycle_mount
> +
> +# These two mounts should have the log fully recovered. Exit here and let the
> +# fsck operation of xfstests to check the consistence of the tested filesystem.
> +# On the buggy kernel, this testcase reports filesystem is inconsistent.
> +# On the fixed kernel, testcase pass.
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..3b276ca8
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> -- 
> 2.20.1
> 

