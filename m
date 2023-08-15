Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550FC41513
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjHOMem (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjHOMeX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 08:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630341BCB
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692102788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7HzAnhcqEU1blWzt01EDDAXZE94Upm8A8YKMc1Q4AU=;
        b=b0HWwLgt3G1T3OKi14fsnRlNsiHEkJx1o+PDZo6JNDrHKgPHwC0uJ/Aj0vxXTtvcVdXdRL
        fcRLwny7hH7QaFedG5kQShBUw18Yac5K4Eela3fxmUJe69XOYJ29m/Ow5rUYNpeoUWUnyu
        cEE1Mz3vCAX5KxaMHbyrF3KAtHEbRK8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-WEWKCxfeNG2higkS2FUDXw-1; Tue, 15 Aug 2023 08:33:06 -0400
X-MC-Unique: WEWKCxfeNG2higkS2FUDXw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bde50b4dc5so22706385ad.3
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 05:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692102785; x=1692707585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7HzAnhcqEU1blWzt01EDDAXZE94Upm8A8YKMc1Q4AU=;
        b=UnCaaUZHlO69jFBMJccNjoOX+ivAzz8t4BME+kQvIWPL9JY7//e1gegS8asGeY6Zno
         FsPeGXplEbkDHZfLC7n5Qrx5cjGCZ/xEez/7OxoYGWdLwXAfOdsJ+xy4/XNENBfVVeuH
         Je8U2DtGZ9hN5/bB69FPgWMKDiE4HlnPVjJkBLKnZxrkeDerPujMZI/3dM0tOFY6yEur
         z/giWreFjYHR5itAevfGKbFh7ga56fIsapIXUNdD4NHO5gCCo1XE0RI9ACQaFs1uK/3Q
         pUKhtBIK4voTBAEIKhnH1krXDvOwQmZrsb2H2VCfQfbE8W599TcIS95vzcRAaSz1GGCk
         xbbg==
X-Gm-Message-State: AOJu0YwBTUUQrPQ8OCq3XvX2BoamJOEkQQaTGrsnnxjm1EVQsp5fMWOK
        HbSihtca6DCZY+yTKGqDfZiFE6Ry7Oba77yzWvacyclhOStoamlzwA06aBh2mLylxoUXZKZculU
        xhP9IMxy0s/fGU0cPA6USWYouVsk/OWQ=
X-Received: by 2002:a17:902:b58f:b0:1bb:891b:8bd with SMTP id a15-20020a170902b58f00b001bb891b08bdmr10210423pls.34.1692102785425;
        Tue, 15 Aug 2023 05:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzG3bSGJYUoeny8VydVZNy7TJk7rq4lCS3b4X8x8ejoorUAPh1BmcYqPBHFvCOPKS4u59fTQ==
X-Received: by 2002:a17:902:b58f:b0:1bb:891b:8bd with SMTP id a15-20020a170902b58f00b001bb891b08bdmr10210413pls.34.1692102785085;
        Tue, 15 Aug 2023 05:33:05 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001bdc2d10753sm7727149plb.215.2023.08.15.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 05:33:04 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:33:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] fstests: Vertify dir permissions when creating a stub
 subvolume
Message-ID: <20230815123301.ev6sh42utd3gmdzl@zlang-mailbox>
References: <20230814203759.3555213-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814203759.3555213-1-lee@trager.us>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 01:37:59PM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
> v3
> - Fixed whitepsace in 300.out due to find command not using './' before %P
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
> common/rc           |  6 ++++++
>  tests/btrfs/300     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++++
>  tests/overlay/020   |  7 +------
>  4 files changed, 71 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..ca7c5c14 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,12 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +

(One more blank line)

> +_require_unshare() {
> +	unshare -f -r -m -p -U  true &>/dev/null || \

Should we check if `unshare` command supports "-f -r -m -p -U" options? Or
let specific testcase decides which option they need?

> +		_notrun "unshare $@: not found, should be in util-linux"
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..fb9cd49f
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol snapshot
> +
> +_supported_fs btrfs
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +_register_cleanup "cleanup"

Better to register cleanup ealier, you can move it below the _begin_fstest.

> +
> +test_dir="${TEST_DIR}/$(basename $0)"

If you need "$(basename $0)", you can use "$seq" directly.

> +cleanup() {
> +    [ -d "$test_dir" ] && rm -rf $test_dir

I think the "[ -d "$test_dir" ]" isn't needed, due to the "-f" of rm command
"ignore nonexistent files and arguments".

Besides that, you also need below two lines in cleanup:
        cd /
        rm -r -f $tmp.*

> +}
> +
> +mkdir $test_dir

$TEST_DIR doesn't like $SCRATCH_MNT, We don't always remove all dirs/files
of $TEST_DIR after a subcase test done. So we can't be sure your "$test_dir"
isn't existed. So you'd better to do "rm -rf $test_dir" before using it.

> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshare
> +# sets the namespace for the running shell. The test must run in one user
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};

Is relative path necessary?

If the relative path is just for golden image output, you can use
"| _filter_test_dir" after `BTRFS_UTIL_PROG` and `find` command lines.

Anyway, as you do these in _user_do, so relative path is fine for me too.

Thanks,
Zorro

> +unshare --user --keep-caps --map-auto --map-root-user;
> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"
> +
> +find $test_dir/. -printf "%M %u %g ./%P\n"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 00000000..6e94447e
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,18 @@
> +QA output created by 300
> +Create subvolume './subvol'
> +Create subvolume 'subvol/subsubvol'
> +Create a snapshot of 'subvol' in './snapshot'
> +drwxr-xr-x fsgqa fsgqa ./
> +drwxr-xr-x fsgqa fsgqa ./subvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/1
> +-rw-r--r-- fsgqa fsgqa ./subvol/2
> +-rw-r--r-- fsgqa fsgqa ./subvol/3
> +drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
> +drwxr-xr-x fsgqa fsgqa ./snapshot
> +-rw-r--r-- fsgqa fsgqa ./snapshot/1
> +-rw-r--r-- fsgqa fsgqa ./snapshot/2
> +-rw-r--r-- fsgqa fsgqa ./snapshot/3
> +drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
> diff --git a/tests/overlay/020 b/tests/overlay/020
> index 98a33aec..9f82da34 100755
> --- a/tests/overlay/020
> +++ b/tests/overlay/020
> @@ -16,18 +16,13 @@ _begin_fstest auto quick copyup perms
>  
>  # real QA test starts here
>  
> -require_unshare() {
> -	unshare -f -r "$@" true &>/dev/null || \
> -		_notrun "unshare $@: not supported"
> -}
> -
>  # Modify as appropriate.
>  _supported_fs overlay
>  _fixed_by_kernel_commit 3fe6e52f0626 \
>  	"ovl: override creds with the ones from the superblock mounter"
>  
>  _require_scratch
> -require_unshare -m -p -U
> +_require_unshare
>  
>  # Remove all files from previous tests
>  _scratch_mkfs
> -- 
> 2.34.1
> 

