Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDBC43334
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiFYPRa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiFYPR3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 11:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B265C225
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656170247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9tZ8lbs+3SD0O3/pKhOyTX4YkScID0lxN7/Q4QUEzA=;
        b=fvzxvWEeJtSmxz6r9tYLvDQbCO3p+hWLqFa74Ytt/DE+Gdtt7EJ+/NeCgJe1Ju7CBwEj8z
        TFUS0lzteAcoZ5qPusUQSoozteqIl71AQqYONCB+OFTtNllV+pruxdi646hlLCmT+SlGw4
        CM4USb/Y642IdV77Jm0r1dTZAoKROto=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-fUFXJfFpOlW9rIDHu40yQw-1; Sat, 25 Jun 2022 11:17:23 -0400
X-MC-Unique: fUFXJfFpOlW9rIDHu40yQw-1
Received: by mail-qv1-f72.google.com with SMTP id jv13-20020a05621429ed00b0047048fce5bdso5405060qvb.5
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9tZ8lbs+3SD0O3/pKhOyTX4YkScID0lxN7/Q4QUEzA=;
        b=6TgTr335oRU6zacfWH5auxqXoUTGiDPBy3tf6vOu+U5UATfhzW+JIuP0zAZ2n6qPOj
         YdIXOdGeWWbFog18m8bTJZ2ZjmnIGZBKvonsrsJZzDY5PJ/4AuYzMbzSK9adJf/Wktop
         qrJrWQT4dR9Gin4rI9ZN9whUJ14TyxoVXRDktL25OE6eWaLe2aIfhHXELUU18SIiN90n
         XFd47K4BjHNB7Lx//J2XFuEMIC3YKzNh5H+rWUb7lWm5QSWJWF1kU9WSQx+RwODWDl7n
         nTS94z1byjZhZuTaFHv3j/DR9/JeekJ0Mw3/q4o/hiuK+/sVCBREcSGii7PGXyLizqCA
         lo9w==
X-Gm-Message-State: AJIora9GWWbPK3ei8GwHlh7AvJaZyc8JxLaWNNUVS3LPtHTC6Ny9zZ07
        hCAbBz/KU78k2KTSDGNJL9vebtFXiJobll/xq15rW+MZ+RyilwvwiuXapq9IOIcKxk4fnus3ujN
        mxZlyoD3P4Z9eEkMiJQ==
X-Received: by 2002:ad4:5744:0:b0:464:52f2:c2d9 with SMTP id q4-20020ad45744000000b0046452f2c2d9mr3261168qvx.95.1656170242618;
        Sat, 25 Jun 2022 08:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbDzxnqaSyT8Tpz7AjUJJ6PHOaAm7AqP7lPG7cKBVFlsknfiYz29zbK0Nq6Q+C6P0vSxXP/g==
X-Received: by 2002:ad4:5744:0:b0:464:52f2:c2d9 with SMTP id q4-20020ad45744000000b0046452f2c2d9mr3261147qvx.95.1656170242337;
        Sat, 25 Jun 2022 08:17:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 194-20020a370acb000000b006a8b6848556sm4222112qkk.7.2022.06.25.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:17:21 -0700 (PDT)
Date:   Sat, 25 Jun 2022 23:17:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v3] generic/692: test group ownership change
Message-ID: <20220625151715.vxlq2wflms2ykcju@zlang-mailbox>
References: <20220615092826.2333847-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615092826.2333847-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 15, 2022 at 11:28:26AM +0200, Christian Brauner wrote:
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

We really make this test case become more complicated than its v1 version,
for covering overlayfs on top of idmapped mounts.

I'm wondering if it's worth splitting this case to two cases, one similar
as v1 to cover the original regression test, the other expand for overlayfs,
although that will cause some duplicate testing steps use?

If most of you prefer this v3 version, I'd like to get more review points.

Thanks,
Zorro

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
> +	cd /
> +	$UMOUNT_PROG $SCRATCH_MNT/target-mnt 2>/dev/null
> +	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
> +	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +	rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +_supported_fs ^overlay
> +_require_extra_fs overlay
> +_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
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
> +	mkdir -p $SCRATCH_MNT/source-mnt
> +	chmod 0777 $SCRATCH_MNT/source-mnt
> +	touch $SCRATCH_MNT/source-mnt/file1
> +	chown 65534:65534 $SCRATCH_MNT
> +	chown 65534:65534 $SCRATCH_MNT/source-mnt
> +	chown 65534:65535 $SCRATCH_MNT/source-mnt/file1
> +
> +	mkdir -p $SCRATCH_MNT/target-mnt
> +	chmod 0777 $SCRATCH_MNT/target-mnt
> +}
> +
> +# Setup an idmapped mount where uid and gid 65534 are mapped to fsgqa and uid
> +# and gid 65535 are mapped to fsgqa2.
> +setup_idmapped_mnt()
> +{
> +	$here/src/vfs/mount-idmapped \
> +		--map-mount=u:65534:$user_foo:1 \
> +		--map-mount=g:65534:$group_foo:1 \
> +		--map-mount=u:65535:$user_bar:1 \
> +		--map-mount=g:65535:$group_bar:1 \
> +		$SCRATCH_MNT/source-mnt $SCRATCH_MNT/target-mnt
> +}
> +
> +# We've created a layout where fsgqa owns the target file but the group of the
> +# target file is owned by another group. We now test that user fsgqa can change
> +# the group ownership of the file to a group they control. In this case to the
> +# fsgqa group.
> +change_group_ownership()
> +{
> +	local path="$1"
> +
> +	stat -c '%U:%G' $path
> +	_user_do "id -u --name; id -g --name; chgrp $group_foo $path"
> +	stat -c '%U:%G' $path
> +	_user_do "id -u --name; id -g --name; chgrp $group_bar $path > /dev/null 2>&1"
> +	stat -c '%U:%G' $path
> +}
> +
> +reset_ownership()
> +{
> +	local path="$SCRATCH_MNT/source-mnt/file1"
> +
> +	echo ""
> +	echo "reset ownership"
> +	chown 65534:65534 $path
> +	stat -c '%u:%g' $path
> +	chown 65534:65535 $path
> +	stat -c '%u:%g' $path
> +}
> +
> +run_base_test()
> +{
> +	mkdir -p $SCRATCH_MNT/source-mnt
> +	chmod 0777 $SCRATCH_MNT/source-mnt
> +	touch $SCRATCH_MNT/source-mnt/file1
> +	chown $user_foo:$group_foo $SCRATCH_MNT
> +	chown $user_foo:$group_foo $SCRATCH_MNT/source-mnt
> +	chown $user_foo:$group_bar $SCRATCH_MNT/source-mnt/file1
> +
> +	echo ""
> +	echo "base test"
> +	change_group_ownership "$SCRATCH_MNT/source-mnt/file1"
> +	rm -rf "$SCRATCH_MNT/source-mnt"
> +}
> +
> +# Basic test as explained in the comment for change_group_ownership().
> +run_idmapped_test()
> +{
> +	echo ""
> +	echo "base idmapped test"
> +	change_group_ownership "$SCRATCH_MNT/target-mnt/file1"
> +	reset_ownership
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
> +	mkdir -p $upper $work $merge
> +	_overlay_mount_dirs $lower $upper $work \
> +			    overlay $merge -ometacopy=off || \
> +			    _notrun "overlayfs doesn't support idmappped layers"
> +}
> +
> +# Prepare overlayfs with metacopy turned on.
> +setup_overlayfs_idmapped_lower_metacopy_on()
> +{
> +	mkdir -p $upper $work $merge
> +	_overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
> +}
> +
> +reset_overlayfs()
> +{
> +	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
> +	rm -rf $upper $work $merge
> +}
> +
> +# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
> +# test explained in the comment for change_group_ownership() passes with
> +# overlayfs mounted on top of it.
> +# This tests overlayfs with metacopy turned off, i.e., changing a file copies
> +# up data and metadata.
> +run_overlayfs_idmapped_lower_metacopy_off()
> +{
> +	echo ""
> +	echo "overlayfs idmapped lower metacopy off"
> +	change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
> +	reset_overlayfs
> +	reset_ownership
> +}
> +
> +# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
> +# test explained in the comment for change_group_ownership() passes with
> +# overlayfs mounted on top of it.
> +# This tests overlayfs with metacopy turned on, i.e., changing a file tries to
> +# only copy up metadata.
> +run_overlayfs_idmapped_lower_metacopy_on()
> +{
> +	echo ""
> +	echo "overlayfs idmapped lower metacopy on"
> +	change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
> +	reset_overlayfs
> +	reset_ownership
> +}
> +
> +run_base_test
> +
> +setup_tree
> +setup_idmapped_mnt
> +run_idmapped_test
> +
> +setup_overlayfs_idmapped_lower_metacopy_off
> +run_overlayfs_idmapped_lower_metacopy_off
> +
> +setup_overlayfs_idmapped_lower_metacopy_on
> +run_overlayfs_idmapped_lower_metacopy_on
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/692.out b/tests/generic/692.out
> new file mode 100644
> index 00000000..1cb01f8e
> --- /dev/null
> +++ b/tests/generic/692.out
> @@ -0,0 +1,49 @@
> +QA output created by 692
> +
> +base test
> +fsgqa:fsgqa2
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +
> +base idmapped test
> +fsgqa:fsgqa2
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +
> +reset ownership
> +65534:65534
> +65534:65535
> +
> +overlayfs idmapped lower metacopy off
> +fsgqa:fsgqa2
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +
> +reset ownership
> +65534:65534
> +65534:65535
> +
> +overlayfs idmapped lower metacopy on
> +fsgqa:fsgqa2
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +fsgqa
> +fsgqa
> +fsgqa:fsgqa
> +
> +reset ownership
> +65534:65534
> +65534:65535
> 
> base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
> -- 
> 2.34.1
> 

