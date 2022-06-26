Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED2C43334
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jun 2022 06:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiFZGnP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Jun 2022 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFZGnO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Jun 2022 02:43:14 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01381EE04
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 23:43:12 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id j15so3091933vkp.5
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7GWeZ+wfw/ISMiyP3p3ynFRlLDvcp3iHo90IF9hMZI=;
        b=l0DaGZ6+uBqdHXole/Qlovu9el/lWiFLIIstada8L8oQDvT4mO0FZ7OS48vy4yTqRZ
         H1K+8rv9QgqstgcUTnbkOkRJAy4keCwaM9M/je2wqgd+WsVCpe1x4sB3VSKtwaUdrox9
         9sjmuKC9jmWVO/PCtInt7cMCdS2Djwj/1cDACu/PVREWl5CJlEiwoz1nS8bKZdMnNIRn
         0jYzzZS3EuAeHyTy9PCzw4cs8vJtfjDNCCCkF+fTQ7XY2Qyf76gstMiU1svghKRR80pP
         17MR3fdjxhzWUvhI+3m5aXiwLO3kyL3ryXDe7lL7yZaXHOy2MKwsaDB3b+oamEPX7HnW
         D5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7GWeZ+wfw/ISMiyP3p3ynFRlLDvcp3iHo90IF9hMZI=;
        b=ihHTComtlEoCbEmOkfOSsWLMCfVrapUQ8MXacJ/LbU1E5SDmso8LFoZ8fY7t/8Zgnp
         R8AavuqG/bmja3PC6jSsT6kPSbM8FvJO7i3qYu2fuP5JT0oKEdaIRurE7ZkzdMsdiaEA
         hQh0riaF7QVMP1LYUkzgWkhZjWH/90VPsnoLIxOV30epnMZZkYdVQgYh57CM95VEfU7T
         RecE49wGcKq3aWzmVYzvp73yT//vcyof+wP6eL37djj+7msIer0pVxrRJc6IayB3znmI
         maUbIlH1d/+TOdvgFRKWNTihPCRNLg+/WLuvGIq1yozVJIXBNSy5zkKsLjIGXhDTYPc+
         qFOQ==
X-Gm-Message-State: AJIora/wrZ1LuZBZkHq8cGsZiqYMo3O70/1bPE8TubFmg2f2gcQp/WeO
        SJHUiYscr4IDEvQ44F1we7bxbXNuAh6+7b+qjH8=
X-Google-Smtp-Source: AGRyM1tqFIIr2iElL1WKCqQSOpTVPY+Z6tYas39CFTfTZQNb6trRjaiq38trqFeNj1tN+LKl+oydSrJwguWawxLV50o=
X-Received: by 2002:a1f:eec2:0:b0:36c:1c9b:465f with SMTP id
 m185-20020a1feec2000000b0036c1c9b465fmr2507847vkh.3.1656225792066; Sat, 25
 Jun 2022 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220615092826.2333847-1-brauner@kernel.org>
In-Reply-To: <20220615092826.2333847-1-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 26 Jun 2022 09:43:00 +0300
Message-ID: <CAOQ4uxjEhPqdN3HjB9si2XPptDH+ea7BNLapf4j8=zUxdxHURA@mail.gmail.com>
Subject: Re: [PATCH v3] generic/692: test group ownership change
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 15, 2022 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
>
> When group ownership is changed a caller whose fsuid owns the inode can
> change the group of the inode to any group they are a member of. When
> searching through the caller's groups we failed to use the gid mapped
> according to the idmapped mount otherwise we fail to change ownership.
> Add a test for this.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: <fstests@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> /* v2 */
> - Zorro Lang <zlang@redhat.com>:
>   - various minor fixes
>
> - Christian Brauner (Microsoft) <brauner@kernel.org>:
>   - Expand test to also cover overlayfs on top of idmapped mounts.
>
> /* v3 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Switch from calls to the mount binary to _overlay_mount_dirs helper.
>
> - Christian Brauner (Microsoft) <brauner@kernel.org>:
>   - Expand test to also cover non-idmapped mounts.
> ---
>  tests/generic/692     | 195 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/692.out |  49 +++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100755 tests/generic/692
>  create mode 100644 tests/generic/692.out
>
> diff --git a/tests/generic/692 b/tests/generic/692
> new file mode 100755
> index 00000000..20579334
> --- /dev/null
> +++ b/tests/generic/692
> @@ -0,0 +1,195 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
> +#
> +# FS QA Test 692
> +#
> +# Test that users can changed group ownership of a file they own to a group
> +# they are a member of.
> +#
> +# Regression test for commit:
> +#
> +# 168f91289340 ("fs: account for group membership")
> +#
> +. ./common/preamble
> +. ./common/overlay
> +_begin_fstest auto quick perms attr idmapped mount
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $SCRATCH_MNT/target-mnt 2>/dev/null
> +       $UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
> +       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +       rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +_supported_fs ^overlay
> +_require_extra_fs overlay
> +_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"

This requirement is a synonym for "very ancient filesystem"
_require_idmapped_mounts is a much stronger requirement
you can drop this one.

> +_require_scratch
> +_require_chown
> +_require_idmapped_mounts
> +_require_test_program "vfs/mount-idmapped"
> +_require_user fsgqa2
> +_require_group fsgqa2
> +# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
> +_require_user fsgqa
> +_require_group fsgqa
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +user_foo=`id -u fsgqa`
> +group_foo=`id -g fsgqa`
> +user_bar=`id -u fsgqa2`
> +group_bar=`id -g fsgqa2`
> +
> +setup_tree()
> +{
> +       mkdir -p $SCRATCH_MNT/source-mnt
> +       chmod 0777 $SCRATCH_MNT/source-mnt
> +       touch $SCRATCH_MNT/source-mnt/file1
> +       chown 65534:65534 $SCRATCH_MNT
> +       chown 65534:65534 $SCRATCH_MNT/source-mnt
> +       chown 65534:65535 $SCRATCH_MNT/source-mnt/file1
> +
> +       mkdir -p $SCRATCH_MNT/target-mnt
> +       chmod 0777 $SCRATCH_MNT/target-mnt
> +}
> +
> +# Setup an idmapped mount where uid and gid 65534 are mapped to fsgqa and uid
> +# and gid 65535 are mapped to fsgqa2.
> +setup_idmapped_mnt()
> +{
> +       $here/src/vfs/mount-idmapped \
> +               --map-mount=u:65534:$user_foo:1 \
> +               --map-mount=g:65534:$group_foo:1 \
> +               --map-mount=u:65535:$user_bar:1 \
> +               --map-mount=g:65535:$group_bar:1 \
> +               $SCRATCH_MNT/source-mnt $SCRATCH_MNT/target-mnt
> +}
> +
> +# We've created a layout where fsgqa owns the target file but the group of the
> +# target file is owned by another group. We now test that user fsgqa can change
> +# the group ownership of the file to a group they control. In this case to the
> +# fsgqa group.
> +change_group_ownership()
> +{
> +       local path="$1"
> +
> +       stat -c '%U:%G' $path
> +       _user_do "id -u --name; id -g --name; chgrp $group_foo $path"
> +       stat -c '%U:%G' $path
> +       _user_do "id -u --name; id -g --name; chgrp $group_bar $path > /dev/null 2>&1"
> +       stat -c '%U:%G' $path
> +}
> +
> +reset_ownership()
> +{
> +       local path="$SCRATCH_MNT/source-mnt/file1"
> +
> +       echo ""
> +       echo "reset ownership"
> +       chown 65534:65534 $path
> +       stat -c '%u:%g' $path
> +       chown 65534:65535 $path
> +       stat -c '%u:%g' $path
> +}
> +
> +run_base_test()
> +{
> +       mkdir -p $SCRATCH_MNT/source-mnt
> +       chmod 0777 $SCRATCH_MNT/source-mnt
> +       touch $SCRATCH_MNT/source-mnt/file1
> +       chown $user_foo:$group_foo $SCRATCH_MNT
> +       chown $user_foo:$group_foo $SCRATCH_MNT/source-mnt
> +       chown $user_foo:$group_bar $SCRATCH_MNT/source-mnt/file1
> +
> +       echo ""
> +       echo "base test"
> +       change_group_ownership "$SCRATCH_MNT/source-mnt/file1"
> +       rm -rf "$SCRATCH_MNT/source-mnt"
> +}
> +
> +# Basic test as explained in the comment for change_group_ownership().
> +run_idmapped_test()
> +{
> +       echo ""
> +       echo "base idmapped test"
> +       change_group_ownership "$SCRATCH_MNT/target-mnt/file1"
> +       reset_ownership
> +}
> +
> +lower="$SCRATCH_MNT/target-mnt"
> +upper="$SCRATCH_MNT/ovl-upper"
> +work="$SCRATCH_MNT/ovl-work"
> +merge="$SCRATCH_MNT/ovl-merge"
> +
> +# Prepare overlayfs with metacopy turned off.
> +setup_overlayfs_idmapped_lower_metacopy_off()
> +{
> +       mkdir -p $upper $work $merge
> +       _overlay_mount_dirs $lower $upper $work \
> +                           overlay $merge -ometacopy=off || \
> +                           _notrun "overlayfs doesn't support idmappped layers"

I agree with Zorro that this is going to limit running the base test
on LTS 5.15.y (for example).

One option is to not use _notrun.
You could split this to another test as the common solution
in fstests.
You could make your own "skip test case" logic, i,e.:

setup_overlayfs_idmapped_lower_metacopy off && \
   run_overlayfs_idmapped_lower_metacopy off

setup_overlayfs_idmapped_lower_metacopy on && \
   run_overlayfs_idmapped_lower_metacopy on

This is a very standard practice in LTP and its built in support
for test case arrays.

The problem is with fstests, there is no way to make that
test case skip visible to the test runner. Splitting to two
tests is the only way to communicate the result
"this test passed and that test did not run" to the user.

> +}
> +
> +# Prepare overlayfs with metacopy turned on.
> +setup_overlayfs_idmapped_lower_metacopy_on()
> +{
> +       mkdir -p $upper $work $merge
> +       _overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
> +}

Those helpers are exactly the same. on/off could be passed as parameter.

> +
> +reset_overlayfs()
> +{
> +       $UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
> +       rm -rf $upper $work $merge
> +}
> +
> +# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
> +# test explained in the comment for change_group_ownership() passes with
> +# overlayfs mounted on top of it.
> +# This tests overlayfs with metacopy turned off, i.e., changing a file copies
> +# up data and metadata.
> +run_overlayfs_idmapped_lower_metacopy_off()
> +{
> +       echo ""
> +       echo "overlayfs idmapped lower metacopy off"
> +       change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
> +       reset_overlayfs
> +       reset_ownership
> +}
> +
> +# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
> +# test explained in the comment for change_group_ownership() passes with
> +# overlayfs mounted on top of it.
> +# This tests overlayfs with metacopy turned on, i.e., changing a file tries to
> +# only copy up metadata.
> +run_overlayfs_idmapped_lower_metacopy_on()
> +{
> +       echo ""
> +       echo "overlayfs idmapped lower metacopy on"
> +       change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
> +       reset_overlayfs
> +       reset_ownership
> +}

Exactly the same. on/off can be passed as parameter.

Thanks,
Amir.
