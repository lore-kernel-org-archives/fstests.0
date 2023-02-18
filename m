Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95114C61DA4
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBRGNt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjBRGNt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7B53EFF
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676700784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlhZHif87k19Wtyw3lzpfAlaCH1LATq/sslPtMpHTBM=;
        b=BL8l29vw/HbYte/7OSuSC3e7Zucmh+RR5OV5f3F/IQALzrsIq0fGJHUYK0uLqpNTzXYMjJ
        C/jpNVeHjF2OB5sFTWRZ3X2bhGwZI7WTYOObe8BFRuR9aV4nO6yUVeoteBOlb8PC5b1Uqk
        REQUWKBGhUI8ExVKfbTFOTVZ2fdlmi4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-JJcKjXjzNCiP0uLf6P57Jg-1; Sat, 18 Feb 2023 01:13:02 -0500
X-MC-Unique: JJcKjXjzNCiP0uLf6P57Jg-1
Received: by mail-pf1-f199.google.com with SMTP id g200-20020a6252d1000000b0059395f5a701so1398513pfb.13
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlhZHif87k19Wtyw3lzpfAlaCH1LATq/sslPtMpHTBM=;
        b=C5x8Nz5n+qm4/fF/+1eN4eRe+0LA/ORpSjceczAw6zoXBCpkLakoDRudxHD8O3eHjj
         DE8V6A0zQ7+mIaNztwvkWGsn/Zy1zbueAj/KvrT6QUtNvQbap0yXvxFiw8NE5fKHxIVf
         M2lGJfaZo7eMMX/C6NVs7aw3X4/2dzsI4UQavDr8uJkq+YhONoX2GjiNqq2/AdKFDe62
         f89D7u7zUM7epNA+1lTI3fIn5tv5ZhsJ0rEthBxTOMBZDIPZAYGNoHf+bRYuN3C5SiU5
         D8Pyu7io/E9TXD3106FJX48Y6Um+DhjSN5Mq4Fz3leyA/kvlag8LKrNNe5dSjTS8gNBG
         75uQ==
X-Gm-Message-State: AO0yUKWx5OydJ4Fbin9oESYCZ/ftFzaJaEBmVyL2iWJ7c+8o+pGET6ek
        M2QsrZD5FbWBwFcl6D1MV87dFpc2Nefw7Y+5GDY895x4dK8TClGAqIrygyXJJyfYn0HacnpU+Ka
        t4xmY86tG/H524cHH1g==
X-Received: by 2002:a62:190a:0:b0:5a8:abd2:2beb with SMTP id 10-20020a62190a000000b005a8abd22bebmr3741132pfz.30.1676700781542;
        Fri, 17 Feb 2023 22:13:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/ZfShrd7Qw1U/ei83DMpg4KvM8qa/HqNPzPMTMln8YlYHP0gBKfP0qCUb0VZCEaYnDwuEiLQ==
X-Received: by 2002:a62:190a:0:b0:5a8:abd2:2beb with SMTP id 10-20020a62190a000000b005a8abd22bebmr3741117pfz.30.1676700781154;
        Fri, 17 Feb 2023 22:13:01 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b005931a44a239sm3942166pfo.112.2023.02.17.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:13:00 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:12:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: race fsstress with online scrub and repair for
 quotacheck
Message-ID: <20230218061256.dqolmvai4b2ugegr@zlang-mailbox>
References: <167243876462.727185.1053988846654244651.stgit@magnolia>
 <167243876474.727185.6330332863953257231.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243876474.727185.6330332863953257231.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:24PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create tests to race fsstress with quota count check and repair while
> running fsstress in the background.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/715     |   40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/715.out |    2 ++
>  tests/xfs/812     |   40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/812.out |    2 ++
>  4 files changed, 84 insertions(+)
>  create mode 100755 tests/xfs/715
>  create mode 100644 tests/xfs/715.out
>  create mode 100755 tests/xfs/812
>  create mode 100644 tests/xfs/812.out
> 
> 
> diff --git a/tests/xfs/715 b/tests/xfs/715
> new file mode 100755
> index 0000000000..eca979b297
> --- /dev/null
> +++ b/tests/xfs/715
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 715
> +#
> +# Race fsstress and quotacheck repair for a while to see if we crash or
> +# livelock.
> +#
> +. ./common/preamble
> +_begin_fstest online_repair dangerous_fsstress_repair
> +
> +_cleanup() {
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_require_xfs_quota_acct_enabled "$SCRATCH_DEV" any
> +_scratch_xfs_stress_online_repair -s "repair quotacheck"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/715.out b/tests/xfs/715.out
> new file mode 100644
> index 0000000000..b5947d898b
> --- /dev/null
> +++ b/tests/xfs/715.out
> @@ -0,0 +1,2 @@
> +QA output created by 715
> +Silence is golden
> diff --git a/tests/xfs/812 b/tests/xfs/812
> new file mode 100755
> index 0000000000..f84494e392
> --- /dev/null
> +++ b/tests/xfs/812
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 812
> +#
> +# Race fsstress and quotacheck scrub for a while to see if we crash or
> +# livelock.
> +#
> +. ./common/preamble
> +_begin_fstest scrub dangerous_fsstress_scrub
> +
> +_cleanup() {
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_scrub
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_require_xfs_quota_acct_enabled "$SCRATCH_DEV" any
> +_scratch_xfs_stress_scrub -s "scrub quotacheck"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/812.out b/tests/xfs/812.out
> new file mode 100644
> index 0000000000..d8dbb15dc7
> --- /dev/null
> +++ b/tests/xfs/812.out
> @@ -0,0 +1,2 @@
> +QA output created by 812
> +Silence is golden
> 

