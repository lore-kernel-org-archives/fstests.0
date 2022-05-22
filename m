Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FCDC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 22 May 2022 14:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbiEVOKj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 May 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbiEVOKi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 May 2022 10:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2DFD14D2F
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653228634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAGQOuGQmyAW43l6fuW4f3tIjP+oEgnXaZB3G1shCKQ=;
        b=BQS3tg2iRSo7uf/aMAz61UOKoP3gKQD6Xv9c/F+lIGHFisS38ESXei+XfYhoOvg1/q43ib
        Ao2BZ1r+6/eVJgWY/LMQYZxOLHWD+TjcWjkWZoy6sUVJOe0Ar697Yn36n6381vFHaiY0hp
        Y8dj62mnyl3eWrtDfSIW7f75xApxqns=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-7tT0GpBjMEOjVmovIRoN2Q-1; Sun, 22 May 2022 10:10:31 -0400
X-MC-Unique: 7tT0GpBjMEOjVmovIRoN2Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-e630d5d6easo6033831fac.10
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAGQOuGQmyAW43l6fuW4f3tIjP+oEgnXaZB3G1shCKQ=;
        b=ofk9oEtC8vq7AqI2jpW86JNfNLU0jdWmWj/O7HPTCoIpeDO79H2IyW1yXlhIAs8RKS
         LXZVvUmgYHQohwZfAswfyt33wlAtxHezm4L2kfiCdrLCy5o8mtSHVvH0ONiUvIcxpx46
         eHEtfsSH14M+6hXJ2UzLTXME7ZfMK6s//HfNT+IF5786k3IqN3WoWJ54aErkvDo5OO35
         NIwbeZChy8oyw0uKvn6ypoRMRgKYF9LY+Gta3ZbEdWSzwoIgldxtiSqOPqhBl1yCrJut
         ozqIqiGVxDcQCBuWNaRGQG3TuNo3g3P4RJ+xQjHeVjNLJX7sd7iCdD1EpqhuUfijJu2J
         EwRw==
X-Gm-Message-State: AOAM531Qt3S3hgOJRNL4yI4WV/x3PMe8RsNNo1KQopTTmnnVkPeR3MP+
        GztHD7PMuhEzW3Hda00JNKYzUNI99IaES1BRofC+SJWuMl7Ii3zWEY1gKbpJPIhPEjVBjRqNyIY
        5pTV0/tv6qEkYA7H/+w==
X-Received: by 2002:a05:6808:f86:b0:328:c95e:ba17 with SMTP id o6-20020a0568080f8600b00328c95eba17mr9697297oiw.161.1653228630191;
        Sun, 22 May 2022 07:10:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvZm9qSyexBKN6jJ8p/DXvBOwCJq3PxyJtlxHo28nuDq0JT04zVpJYKjddEQSEzR7yRo4Jrg==
X-Received: by 2002:a05:6808:f86:b0:328:c95e:ba17 with SMTP id o6-20020a0568080f8600b00328c95eba17mr9697288oiw.161.1653228629907;
        Sun, 22 May 2022 07:10:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v132-20020aca618a000000b00325cda1ffabsm3110141oib.42.2022.05.22.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 07:10:29 -0700 (PDT)
Date:   Sun, 22 May 2022 22:10:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: annotate fix commits for upcoming 5.10.y backports
Message-ID: <20220522141023.diwajhcswq53wgt5@zlang-mailbox>
References: <20220520143249.2103631-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520143249.2103631-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 05:32:49PM +0300, Amir Goldstein wrote:
> In preparation for backporting xfs fixes to stable kernel 5.10.y,
> annotate some of the tests that pass after applying the backports.
> 
> Most of the annotated tests have the fix commit documented either
> in comment or in commit message already.
> 
> All tests have been verified to pass with fix commits apply, but
> for a few tests, a failure was observed when running on kernel without
> the documented fix commit. That is probably because failure happens
> only on a specific setup.
> 
> Generic tests have also been annotated with xfs fix commits.
> That may produce wrong hints if the test fails on another fs, but
> that is what hints are for - to give tester a hint, so if tester is
> not testing xfs, it's easy to figure out that the hint is irrelevant.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi Zorro,
> 
> Here are a bunch of fixed_by annotations for xfs bug fixes,
> which I am in the process of testing for stable kernel v5.10.y [1].

I just confirmed that these commit IDs are right, and these cases are
specific reproducer for them. So I'd like to ack this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> There are a lot more tests with fix commits documented in comments
> and/or commit message, but I did not annotate any test that I did not
> verify myself to pass with the fix commit.

Thanks for you did that such carefully. You remind me that I just release
a new fstests version v2022.05.22, which has several known failures too.
https://lore.kernel.org/fstests/20220522094622.25751C385AA@smtp.kernel.org/T/#u

I'm thinking about another question, if a case covers more and more known
issue, the known list will be very long, even might take 1/3 of the code
lines. That will look not graceful ...

We'd better to not make an existed case grow biger and biger. And don't
record known issues in a case which just can reproduce it with small chance
randomly. Likes you record e4826691cc7e ("xfs: restore shutdown check in mapped
write fault path") into g/623, actually we found it by g/019 at first, then
write g/623 to cover that. So g/019 isn't the recommended case to record this
issue.

Thanks,
Zorro

> 
> If tests were not documented in kernel commit message nor mentioned
> in the mailing list correspondance and if kernel commit or subject were
> not mentioned in fstests commit message or comments, then I may have
> missed those secret tests.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/xfs-5.10.y
> 
>  tests/generic/623 | 3 +++
>  tests/generic/631 | 2 ++
>  tests/generic/646 | 3 +++
>  tests/generic/649 | 3 +++
>  tests/xfs/145     | 3 +++
>  tests/xfs/177     | 2 ++
>  tests/xfs/513     | 3 +++
>  tests/xfs/539     | 7 +++++--
>  tests/xfs/542     | 3 +++
>  9 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/623 b/tests/generic/623
> index 324251b7..ea016d91 100755
> --- a/tests/generic/623
> +++ b/tests/generic/623
> @@ -12,6 +12,9 @@ _begin_fstest auto quick shutdown
>  . ./common/filter
>  
>  _supported_fs generic
> +_fixed_by_kernel_commit e4826691cc7e \
> +	"xfs: restore shutdown check in mapped write fault path"
> +
>  _require_scratch_nocheck
>  _require_scratch_shutdown
>  
> diff --git a/tests/generic/631 b/tests/generic/631
> index 219f7a05..ff1bb113 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -40,6 +40,8 @@ _require_scratch
>  _require_attrs trusted
>  _supported_fs ^overlay
>  _require_extra_fs overlay
> +_fixed_by_kernel_commit 6da1b4b1ab36 \
> +	"xfs: fix an ABBA deadlock in xfs_rename"
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> diff --git a/tests/generic/646 b/tests/generic/646
> index 79d3f17c..027df557 100755
> --- a/tests/generic/646
> +++ b/tests/generic/646
> @@ -15,6 +15,9 @@
>  _begin_fstest auto quick recoveryloop shutdown
>  
>  # real QA test starts here
> +_supported_fs generic
> +_fixed_by_kernel_commit 50d25484bebe \
> +	"xfs: sync lazy sb accounting on quiesce of read-only mounts"
>  
>  _require_scratch
>  _require_scratch_shutdown
> diff --git a/tests/generic/649 b/tests/generic/649
> index a6aabfaf..d6727765 100755
> --- a/tests/generic/649
> +++ b/tests/generic/649
> @@ -33,6 +33,9 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _supported_fs generic
> +_fixed_by_kernel_commit 72a048c1056a \
> +	"xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
> +
>  _require_cp_reflink
>  _require_test_reflink
>  _require_test_program "punch-alternating"
> diff --git a/tests/xfs/145 b/tests/xfs/145
> index d32e726e..5fd8dcad 100755
> --- a/tests/xfs/145
> +++ b/tests/xfs/145
> @@ -18,6 +18,9 @@ _begin_fstest auto quick quota
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_fixed_by_kernel_commit 1aecf3734a95 \
> +	"xfs: fix chown leaking delalloc quota blocks when fssetxattr fails"
> +
>  _require_command "$FILEFRAG_PROG" filefrag
>  _require_test_program "chprojid_fail"
>  _require_quota
> diff --git a/tests/xfs/177 b/tests/xfs/177
> index 10891550..1e59bd6c 100755
> --- a/tests/xfs/177
> +++ b/tests/xfs/177
> @@ -39,6 +39,8 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _supported_fs xfs
> +_fixed_by_kernel_commit f38a032b165d "xfs: fix I_DONTCACHE"
> +
>  _require_xfs_io_command "bulkstat"
>  _require_scratch
>  
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index bfdfd4f6..85500af0 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -31,6 +31,9 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_fixed_by_kernel_commit 237d7887ae72 \
> +	"xfs: show the proper user quota options"
> +
>  _require_test
>  _require_loop
>  _require_xfs_io_command "falloc"
> diff --git a/tests/xfs/539 b/tests/xfs/539
> index 4bc52c1a..77b44c89 100755
> --- a/tests/xfs/539
> +++ b/tests/xfs/539
> @@ -9,15 +9,18 @@
>  # the same value as during the mount
>  #
>  # Regression test for commit:
> -# xfs: Skip repetitive warnings about mount options
> +# 92cf7d36384b xfs: Skip repetitive warnings about mount options
>  
>  . ./common/preamble
>  _begin_fstest auto quick mount
>  
>  # Import common functions.
>  
> -_require_check_dmesg
>  _supported_fs xfs
> +_fixed_by_kernel_commit 92cf7d36384b \
> +	"xfs: Skip repetitive warnings about mount options"
> +
> +_require_check_dmesg
>  _require_scratch
>  
>  log_tag()
> diff --git a/tests/xfs/542 b/tests/xfs/542
> index 5c45eed7..1540541e 100755
> --- a/tests/xfs/542
> +++ b/tests/xfs/542
> @@ -26,6 +26,9 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_fixed_by_kernel_commit 5ca5916b6bc9 \
> +	"xfs: punch out data fork delalloc blocks on COW writeback failure"
> +
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "cowextsize"
> -- 
> 2.25.1
> 

