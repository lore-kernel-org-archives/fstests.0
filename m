Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FA4C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Apr 2022 12:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiDDMn0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbiDDMn0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 08:43:26 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675062F3AE
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 05:41:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o15so6138925qtv.8
        for <fstests@vger.kernel.org>; Mon, 04 Apr 2022 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JV51gAVSfUCxvzoDHAWx5Hv076fxQ+iApAkFPjg0Hx4=;
        b=RWV4McOK3VvaF6av1kQxf1CK2+t2NbEgt/gZBCYKt+fpRlHFm1TnbZrA0ckoo8rvva
         a7si/bWvqPtyvjTHC4qs/DFGjSdwYT9x0cdIvLTVXS6hpDq02sE8FUGT3G4HjtSOKVnL
         HXPHlJoHUaUrXk9pf/XfeH+XdicQbWdh2z9GFlsV2GI5AVBcYPLIgi0yE3cgQ/PWiFSE
         gxqgarIMm8hJ7f0ZW8nS4gmZ+g8fzmQ1xIRm6PTR1SDuAspMfYG2i5Ww1mnZWKIzySrx
         T5G41cgtL+POlZHMemMsT4dP9Ay2sKR1QXLOODLo9xV7P8NqUSODrpb9Z2yGNKVwLKHK
         /ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JV51gAVSfUCxvzoDHAWx5Hv076fxQ+iApAkFPjg0Hx4=;
        b=G/tleUOx9sJj1k4jVH4mIuFrSxQOe9/bHPzkuGmbypRQrX+gQJ44Jp8vs9yv155hr+
         lFqnD5uTAJHdAzDu/3EEVJdC5SODF9ChII1hpwYbzD6g/SmD58JnbD9ZzABbQCu/URBf
         R5vpidYSzexB+EkBkMKlzvJS2ZHhSRYzj1Hax6NhQiBb4ZE1pHTGcoZbxR+ndaDLap0o
         m4gG7o27KGUq48bj+HJDRrjX8KqpRAZzhFmVgiLidwjEnigtJZgOZdf1WcZT8szDK/rq
         zWvuknQahScKW6n1EGq0RVkOIPZRgr+DKqi0M2gwuHYjsV9TJWlyGIV3CUSIEI1RcLtz
         wRHw==
X-Gm-Message-State: AOAM533NvX7sKIXkXCIWuKfIc7x4j48qxL3rIK7DNH+8kl2cxQxQAGTh
        yeaH/oKjTezsAJ/Zu3GdaX4Be4+BnlRS/UET90w=
X-Google-Smtp-Source: ABdhPJxwXiyWkkb2EQVir3sMpRFi0c6hejN4NhomQ6FwNDUqRdC1ZaSXS7L/bhepst7/uxXaBsPhnBVWAm33lPmg1yE=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr17299813qtx.2.1649076089541; Mon, 04
 Apr 2022 05:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220404105159.1567595-1-brauner@kernel.org> <20220404105159.1567595-21-brauner@kernel.org>
In-Reply-To: <20220404105159.1567595-21-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Apr 2022 15:41:17 +0300
Message-ID: <CAOQ4uxgW75aqHTPyOqYPPjS1hX8ANzu2K3j89HyFxrK587d+wg@mail.gmail.com>
Subject: Re: [PATCH v4] common: allow to run all tests on idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 4, 2022 at 1:55 PM Christian Brauner <brauner@kernel.org> wrote:
>
> In addition to the generic and filesystem-specific idmapped mount
> testsuites that already exist upstream today add simple infrastructure
> so any test can be run on idmapped mounts simply by setting
> IDMAPPED_MOUNTS=true in the config file or section. The main user for
> now will be overlay to verify it works correctly on idmapped mounts.
>
> Note that the infrastructure is completely generic so every filesystem that
> supports idmapped mounts can simply run all of their tests idmapped. But
> note that not all ways to create a mount have been converted yet. That
> includes e.g. _dmthin_mount and direct calls to _mount in various tests.
>
> In addition, there will be corner-cases. For example, xfs doesn't allow
> bulkstat on idmapped mounts because it is a filesystem wide operation,
> i.e. you can retrieve information for any inode in the filesystem so the
> operation cannot be scoped reasonably under a single mount. So xfstests
> testing bulkstat will fail as it's blocked. Similar for some btrfs
> ioctl()s.
>
> While we could of course restrict this testmode to -overlay for which we
> know things work correctly we should not do this. It would mean that
> people won't start using it and so we won't see issues unless someone
> sits down and goes through more than 1000 tests and figures out for each
> individual one whether it needs to be skipped or not.
>
> So instead allow this mode but for all filesystems so people can start
> running and reporting failures and we can fix them up or block them as
> we detect them.
>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: <fstests@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

one nit below could be addressed later.

> ---
> /* v2 */
> unchanged
>
> /* v3 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Add more detailed explanation about the current state and
>     expectations of the newly added IDMAPPED_MOUNTS support.
>
> /* v4 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Document new IDMAPPED_MOUNTS env variable in README and add an
>     [idmapped] section to README.overlay.
> ---
>  README         |  5 +++++
>  README.overlay |  6 +++++-
>  common/config  |  1 +
>  common/overlay |  2 ++
>  common/rc      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/README b/README
> index 9f01aa10..0f98035c 100644
> --- a/README
> +++ b/README
> @@ -78,6 +78,11 @@ Preparing system for tests:
>              - setenv TEST_LOGDEV "device for test-fs external log"
>               - setenv TEST_RTDEV "device for test-fs realtime data"
>               - if TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
> +             - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped
> +               mounts. While this option is supported for all filesystems
> +               currently only -overlay is expected to run without issues. For
> +               other filesystems additional patches and fixes to the test suite
> +               might be needed.
>               - if SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
>                 environment variable set to "yes" will enable their use.
>               - setenv DIFF_LENGTH "number of diff lines to print from a failed test",
> diff --git a/README.overlay b/README.overlay
> index 39e25ada..ec4671c3 100644
> --- a/README.overlay
> +++ b/README.overlay
> @@ -31,7 +31,8 @@ partly supported with './check -overlay'. Only multi-section files that
>  do not change FSTYP and MKFS_OPTIONS can be safely used with -overlay.
>
>  For example, the following multi-section config file can be used to
> -run overlay tests on the same base fs, but with different mount options:
> +run overlay tests on the same base fs, but with different mount options, and on
> +top of idmapped mounts:
>
>   [xfs]
>   TEST_DEV=/dev/sda5
> @@ -46,6 +47,9 @@ run overlay tests on the same base fs, but with different mount options:
>   OVERLAY_MOUNT_OPTIONS="-o redirect_dir=off"
>   OVERLAY_FSCK_OPTIONS="-n -o redirect_dir=off"
>
> + [idmapped]
> + IDMAPPED_MOUNTS=true
> +
>  In the example above, MOUNT_OPTIONS will be used to mount the base scratch fs,
>  TEST_FS_MOUNT_OPTS will be used to mount the base test fs,
>  OVERLAY_MOUNT_OPTIONS will be used to mount both test and scratch overlay and
> diff --git a/common/config b/common/config
> index 479e50d1..1033b890 100644
> --- a/common/config
> +++ b/common/config
> @@ -647,6 +647,7 @@ _overlay_config_override()
>         # Set fsck options, use default if user not set directly.
>         export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
>         [ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +       export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"

This line has no purpose here.

It does not matter yet because overlayfs mount itself cannot be idmapped
so there is no need to test idmapped overlayfs mount, but if you did want
to allow that, the code would need to look like this:

export OVL_BASE_IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
export IDMAPPED_MOUNTS="$OVERLAY_IDMAPPED_MOUNTS"

and in _overlay_config_restore:

[ -z "$OVL_BASE_IDMAPPED_MOUNTS" ] || \
    export IDMAPPED_MOUNTS=$OVL_BASE_IDMAPPED_MOUNTS

Then, code dealing with idmapped layers would check the variable
OVL_BASE_IDMAPPED_MOUNTS and code dealing with idmapped
overlayfs mount would check the generic variable IDMAPPED_MOUNTS.

In the config file there would be two possible config vars:
OVERLAY_IDMAPPED_MOUNTS - use idmapped overlayfs mount
IDMAPPED_MOUNTS - use idmapped overlayfs layers

Same as the roles of OVERLAY_MOUNT_OPTIONS and
MOUNT_OPTIONS that are documented in README.overlay.

P.S. the implementation of OVERLAY_FSCK_OPTIONS seems a bit
broken (no restore), but fsck.overlay tool is not very alive, so probably
nobody is using this feature.

Bottom line, I do not know if and when you intend to add support for
idmapped overlayfs mounts, until then, there is no action item.
Unless you want to follow my instructions and use
OVL_BASE_IDMAPPED_MOUNTS semantics already to make the
code a bit more clear. I leave the decision to you or to the maintainer.
Just wanted to put this on record.

Thanks,
Amir.
