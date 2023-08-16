Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A99BC001B0
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Aug 2023 10:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbjHPKSj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbjHPKSO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Aug 2023 06:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33784138
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692181050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/4TlQaUgpN5C2FjPup3rLJkJfUEhe/1WNXH5y5dSaU=;
        b=a4phiJtju0WmIz3A95bdi1QMFrj/DdBRyaLMPznvIYiSZG/253RjpK3+iZOc8igSpZS2XJ
        yFAtYilOIj5Wn3tLY3Eyq8BN9/nYK3H2mvALTR9DhWJODEi0lJppnnUjgx2Zg5tokt9wig
        RtoD9UGtLbAeAQ/kRtnZzllJ88mtgdE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-NlbUeNr0PKOmwpH8Poj4xA-1; Wed, 16 Aug 2023 06:17:28 -0400
X-MC-Unique: NlbUeNr0PKOmwpH8Poj4xA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bbb34b0abaso124642735ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 03:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181047; x=1692785847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/4TlQaUgpN5C2FjPup3rLJkJfUEhe/1WNXH5y5dSaU=;
        b=EprHotN7FnnUETv8sxMKiZydTuIPlp6l2WXh4t1RQoj7PN3yDDnSUYlbKFC4rSoVGW
         g8Oewg6s9Cn7pybY63KVdmz+sc7ODb23tsvXDz+2dCU3lXRoQiG4LcxvfD/eQNdolZ3E
         rIw4wU6A4e9+l7kDfDM9x/yEAeDnXQn6Z32UWL94e+qD8F1J1KV370rqujCphtiynp9T
         cOaD3hJI2diZTflChKwjz3OPUv9U6CWTeqrMkJvj1a/6ROZH1yv/KCjRjZLvBzMJrU1U
         /B8C8DgZzrsIY5CKMW6joyuLhdOqIBdEzTZ7xByLNYypvhMs0c2V4Y525OxSWqVeXho/
         9Ndw==
X-Gm-Message-State: AOJu0YwY+jq06//tNbMIZla63adXf6gEFCk4y8U+AiZcj2cGdr8TMayK
        S5IzQES0KiYBhu6U4SEXuEUEKhUSnA3NnR2LwQXx3zJbGi6FtcK2LXkv+oeVBdbXJmHUjxd7UG8
        /M8hxoV7pKlLBEnnsvmdVMR7lSyK6NBQ=
X-Received: by 2002:a17:902:d4ce:b0:1bb:b34b:73a with SMTP id o14-20020a170902d4ce00b001bbb34b073amr1660974plg.25.1692181047549;
        Wed, 16 Aug 2023 03:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSGZKYpVVdVMri+bQScXYJQzozpxhf1OPb09r/vJLOPdxs8moc7FcKfs8uXQnBbxr2JHWlFg==
X-Received: by 2002:a17:902:d4ce:b0:1bb:b34b:73a with SMTP id o14-20020a170902d4ce00b001bbb34b073amr1660956plg.25.1692181047153;
        Wed, 16 Aug 2023 03:17:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b001bde440e693sm5556629plc.44.2023.08.16.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:17:26 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:17:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4] fstests: Vertify dir permissions when creating a stub
 subvolume
Message-ID: <20230816101723.x2twz764yk3bfr2o@zlang-mailbox>
References: <20230816005157.3703141-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816005157.3703141-1-lee@trager.us>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 15, 2023 at 05:51:57PM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
> v4:
> - Removed extra blank line in common/rc
> - Allowed caller to pass extra options to _require_unshare to check for
>   support. -f -r -m -p -U have been supported by util-linux and busybox
>   for awhile and are typical options.
> - Moved _registry_cleanup to right after _begin_fstest.
> - Added "cd /;rm -rf $tmp.*" from standard cleanup to 300 cleanup.
> - Added rm -rf $test_dir before running test to ensure its in a clean state.

Thanks for this change.

Is there a known upstream 'fix' for this test? Due to it failed [1] when I tried
to run it. If there's a known fix, please use _fixed_by_kernel_commit or
_fixed_by_git_commit to point out.

Thanks,
Zorro

[1]
# uname -r
6.5.0-0.rc6.43.fc40.x86_64
# rpm -q btrfs-progs
btrfs-progs-6.3.2-3.fc39.x86_64
# ./check -s simpledev btrfs/300
SECTION       -- simpledev
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 hp-xxxxxx-01 6.5.0-0.rc6.43.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 13:32:24 UTC 2023
MKFS_OPTIONS  -- /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

btrfs/300       - output mismatch (see /root/git/xfstests/results//simpledev/btrfs/300.out.bad)
    --- tests/btrfs/300.out     2023-08-16 17:53:23.408870265 +0800
    +++ /root/git/xfstests/results//simpledev/btrfs/300.out.bad 2023-08-16 17:54:02.925281855 +0800
    @@ -15,4 +15,4 @@
     -rw-r--r-- fsgqa fsgqa ./snapshot/1
     -rw-r--r-- fsgqa fsgqa ./snapshot/2
     -rw-r--r-- fsgqa fsgqa ./snapshot/3
    -drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
    +drwxr-xr-x root root ./snapshot/subsubvol
    ...
    (Run 'diff -u /root/git/xfstests/tests/btrfs/300.out /root/git/xfstests/results//simpledev/btrfs/300.out.bad'  to see the entire diff)
Ran: btrfs/300
Failures: btrfs/300
Failed 1 of 1 tests

SECTION       -- simpledev
=========================
Ran: btrfs/300
Failures: btrfs/300
Failed 1 of 1 tests

> v3:
> - Fixed whitepsace in 300.out due to find command not using './' before %P
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
> common/rc           |  5 +++++
>  tests/btrfs/300     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 +++++++++++++++++
>  tests/overlay/020   |  7 +------
>  4 files changed, 73 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..18ea0f02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,11 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +_require_unshare() {
> +	unshare -f -r -m -p -U $@ true &>/dev/null || \
> +		_notrun "unshare: command not found, should be in util-linux"
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..1e4dc7b1
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,49 @@
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
> +_register_cleanup "cleanup"
> +
> +_supported_fs btrfs
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +
> +test_dir="${TEST_DIR}/${seq}"
> +cleanup() {
> +	rm -rf $test_dir
> +	cd /
> +	rm -rf $tmp.*
> +}
> +
> +rm -rf $test_dir
> +mkdir $test_dir
> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshare
> +# sets the namespace for the running shell. The test must run in one user
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};
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

