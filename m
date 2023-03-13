Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93574C6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 14:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCMO1L (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCMO1L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 10:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AD2596F
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678717579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AC25nr1vwio8r2jmOkRu7s1WC0XKM6fJDlm/TbLRW8M=;
        b=WU86vLQzl3hmTVP7zNF0S/QY52HdQKP7QhJ3cI6I0H3y7q7x0S84Bz4fx8Kd1WPxWp4oUS
        5/gYUFx4LexiJOlnQdj5vHwqt5h6bIMLZ5EzB0tbP/TOLKrGTRcr/hzQY4DAIyemhklvmw
        /vFwvbP0upYBOvNcqIvfyIUBDkI9oDI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-gACmFNAcP7ywulLj6u9OUQ-1; Mon, 13 Mar 2023 10:26:17 -0400
X-MC-Unique: gACmFNAcP7ywulLj6u9OUQ-1
Received: by mail-pj1-f72.google.com with SMTP id t2-20020a17090a4e4200b0023d27ab43b3so324169pjl.7
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC25nr1vwio8r2jmOkRu7s1WC0XKM6fJDlm/TbLRW8M=;
        b=s9vvV8SERENq55AMHBAAC0oB5Yg4nLbL6A7iMai9puG2rTl3U6+UfBzJU1wwRUu6GL
         w3930IC5SwRqA8PLTfcMLQLogGHfx8OhktdRdrkKvE5oemQyPVrffeQU0JHtYcVpoTSd
         09xprYVSE7taQ91Ep9jdIXUDEutYzzx/vCEaJfWTQD68USsSIp/ydMf9xHPVM8d/X5yT
         dNdIgzAoPmVTWaXEC/E4UlvuAxSuEV5Qu9zTW6oAVKklSjwGqTS4DjUtpjv00xiNQZRX
         H4nvZBTyhEbBPH7Uk0njSY35zdCqdiT5rYRdCiT5on4XpLVx3Cd5f6VwpNwyAf7lMSSq
         uCMQ==
X-Gm-Message-State: AO0yUKUTlTfcmrND3Bx6QEQPIxNsiCX0f2Ei7jCG5OnRetx6s1LMrOId
        hmA5vp4M+tuTd2L4U5xCADu3WTbNI7MEbLKsArfw4xtfagBsV9qZGmC+Qazdewy0X8MYdLI02WV
        Qfsz3NuhX0Qu51foTpyoO+cSFtZDF
X-Received: by 2002:a05:6a20:7d8b:b0:cc:39c5:1241 with SMTP id v11-20020a056a207d8b00b000cc39c51241mr45059460pzj.16.1678717575982;
        Mon, 13 Mar 2023 07:26:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set+ggrS7OLXGQvINUUf/aO2OMLkskbWk5Fixoi/taXul/462/1xyqvPYP9hX7fmTFzmSSAa+3Q==
X-Received: by 2002:a05:6a20:7d8b:b0:cc:39c5:1241 with SMTP id v11-20020a056a207d8b00b000cc39c51241mr45059431pzj.16.1678717575521;
        Mon, 13 Mar 2023 07:26:15 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b00597caf6236esm4465386pfu.150.2023.03.13.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:26:14 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:26:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Rodrigo Campos <rodrigo@sdfg.com.ar>, fstests@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v2 9/9] vfs: Add tmpfs tests for idmap mounts
Message-ID: <20230313142609.oe23ocr5gou6cevp@zlang-mailbox>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-10-rodrigo@sdfg.com.ar>
 <20230313105018.n4nxsemdnp2mvbwk@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313105018.n4nxsemdnp2mvbwk@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 13, 2023 at 11:50:18AM +0100, Christian Brauner wrote:
> On Wed, Mar 08, 2023 at 12:13:43PM +0100, Rodrigo Campos wrote:
> > This patch calls all tests in the suite s_idmapped_mounts, but with a
> > tmpfs directory mounted inside a userns. This directory is setup as the
> > mount point for the test that runs nested.
> > 
> > This excercises that tmpfs mounted inside a userns works as expected
> > regarding idmap mounts.
> > 
> > As some operations don't work inside a userns, we also set
> > info.t_inside_userns to true, so operations not supported are properly
> > skipped.
> 
> I don't think t_inside_userns is used anymore so this can just be
> dropped from the commit message. Though I'm not sure whether you need to
> resend this or whether Zorro would be fine with just dropping it when he
> applies the patches.

I can help to do this change, but ...

> 
> A few minor comments below.

... as you have more review points below, and need to change more things. To
avoid misunderstanding, it would be better to let the author do the change,
refer to you review points.

Thanks,
Zorro

> 
> > 
> > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > ---
> >  src/vfs/Makefile                |   4 +-
> >  src/vfs/tmpfs-idmapped-mounts.c | 298 ++++++++++++++++++++++++++++++++
> >  src/vfs/tmpfs-idmapped-mounts.h |  15 ++
> >  src/vfs/utils.h                 |   2 +
> >  src/vfs/vfstest.c               |  13 +-
> >  tests/tmpfs/001                 |  27 +++
> >  tests/tmpfs/001.out             |   2 +
> >  tests/tmpfs/Makefile            |  24 +++
> >  8 files changed, 382 insertions(+), 3 deletions(-)
> >  create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
> >  create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
> >  create mode 100755 tests/tmpfs/001
> >  create mode 100644 tests/tmpfs/001.out
> >  create mode 100644 tests/tmpfs/Makefile
> > 
> > diff --git src/vfs/Makefile src/vfs/Makefile
> > index 1b0b364b..4841da12 100644
> > --- src/vfs/Makefile
> > +++ src/vfs/Makefile
> > @@ -4,10 +4,10 @@ TOPDIR = ../..
> >  include $(TOPDIR)/include/builddefs
> >  
> >  TARGETS = vfstest mount-idmapped
> > -CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c
> > +CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c tmpfs-idmapped-mounts.c
> >  CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
> >  
> > -HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h
> > +HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h tmpfs-idmapped-mounts.h
> >  LLDLIBS += -pthread
> >  LDIRT = $(TARGETS)
> >  
> > diff --git src/vfs/tmpfs-idmapped-mounts.c src/vfs/tmpfs-idmapped-mounts.c
> > new file mode 100644
> > index 00000000..2db1e879
> > --- /dev/null
> > +++ src/vfs/tmpfs-idmapped-mounts.c
> > @@ -0,0 +1,298 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include "../global.h"
> > +
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <getopt.h>
> > +#include <grp.h>
> > +#include <limits.h>
> > +#include <linux/limits.h>
> > +#include <linux/types.h>
> > +#include <pthread.h>
> > +#include <pwd.h>
> > +#include <sched.h>
> > +#include <stdbool.h>
> > +#include <sys/fsuid.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <sys/xattr.h>
> > +#include <unistd.h>
> > +
> > +#include "missing.h"
> > +#include "utils.h"
> > +#include "vfstest.h"
> > +#include "idmapped-mounts.h"
> > +
> > +static int tmpfs_nested_mount_setup(const struct vfstest_info *info, int (*test)(const struct vfstest_info *info))
> > +{
> > +	char path[PATH_MAX];
> > +	int fret = -1;
> > +
> > +	/* Create mapping for userns
> > +	 * Make the mapping quite long, so all nested userns that are created by
> > +	 * any test we call is contained here (otherwise userns creation fails).
> > +	 */
> > +	struct mount_attr attr = {
> > +		.attr_set	= MOUNT_ATTR_IDMAP,
> > +		.userns_fd	= -EBADF,
> > +	};
> > +	attr.userns_fd = get_userns_fd(0, 10000, 200000);
> > +	if (attr.userns_fd < 0) {
> > +		log_stderr("failure: get_userns_fd");
> > +		goto out_no_rm;
> > +	}
> > +
> > +	if (!switch_userns(attr.userns_fd, 0, 0, false)) {
> > +		log_stderr("failure: switch_userns");
> > +		goto out_no_rm;
> > +	}
> > +
> > +	/* create separate mount namespace */
> > +	if (unshare(CLONE_NEWNS)) {
> > +		log_stderr("failure: create new mount namespace");
> > +		goto out_no_rm;
> > +	}
> 
> I think you might want to turn off mount propagation here so that the
> tmpfs mount doesn't propagate into the parent mount namespace:
> 
> 	mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0)
> 
> > +
> > +	/* Create DIR0 to mount there */
> > +	if (mkdirat(info->t_mnt_fd, DIR0, 0777)) {
> > +		log_stderr("failure: mkdirat");
> > +		goto out_no_rm;
> > +	}
> > +	if (fchmodat(info->t_mnt_fd, DIR0, 0777, 0)) {
> > +		log_stderr("failure: fchmodat");
> > +		goto out_no_umount;
> > +	}
> > +
> > +	snprintf(path, sizeof(path), "%s/%s", info->t_mountpoint, DIR0);
> > +	if (sys_mount("tmpfs", path, "tmpfs", 0, NULL)) {
> > +		log_stderr("failure: mount");
> > +		goto out_no_umount;
> > +	}
> > +
> > +	// Create a new info to use for test we will call.
> > +	struct vfstest_info nested_test_info = *info;
> 
> nit: We usually don't mix declarations and code in C code so I would
> move that struct vfstest_info to the top of the function.
> 
> > +	nested_test_info.t_mountpoint = strdup(path);
> > +	if (nested_test_info.t_mountpoint == NULL) {
> 
> nit: more idiomatic  
> if (!nested_test_info.t_mountpoint)
> 
> > +		log_stderr("failure: strdup");
> > +		goto out;
> > +	}
> > +	nested_test_info.t_mnt_fd = openat(-EBADF, nested_test_info.t_mountpoint, O_CLOEXEC | O_DIRECTORY);
> > +	if (nested_test_info.t_mnt_fd < 0) {
> > +		log_stderr("failure: openat");
> > +		goto out;
> > +	}
> > +
> > +	test_setup(&nested_test_info);
> > +
> > +	// Run the test.
> > +	if ((*test)(&nested_test_info)) {
> > +		log_stderr("failure: calling test");
> > +		goto out;
> > +	}
> > +
> > +	test_cleanup(&nested_test_info);
> > +
> > +	fret = 0;
> > +	log_debug("Ran test");
> > +out:
> > +	snprintf(path, sizeof(path), "%s/" DIR0, info->t_mountpoint);
> > +	sys_umount2(path, MNT_DETACH);
> > +out_no_umount:
> > +	if(rm_r(info->t_mnt_fd, DIR0))
> 
> nit: missing space between "if" and "("
> 
> > +		log_stderr("failure: rm_r");
> > +out_no_rm:
> > +	safe_close(attr.userns_fd);
> > +	return fret;
> > +}
> > +
> > +static int tmpfs_acls(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_acls);
> > +}
> > +static int tmpfs_create_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_create_in_userns);
> > +}
> > +static int tmpfs_device_node_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_device_node_in_userns);
> > +}
> > +static int tmpfs_fsids_mapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_fsids_mapped);
> > +}
> > +static int tmpfs_fsids_unmapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_fsids_unmapped);
> > +}
> > +static int tmpfs_expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_expected_uid_gid_idmapped_mounts);
> > +}
> > +static int tmpfs_fscaps_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts);
> > +}
> > +static int tmpfs_fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns);
> > +}
> > +static int tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns_separate_userns);
> > +}
> > +
> > +static int tmpfs_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_hardlink_crossing_idmapped_mounts);
> > +}
> > +static int tmpfs_hardlink_from_idmapped_mount(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount);
> > +}
> > +static int tmpfs_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount_in_userns);
> > +}
> > +
> > +#ifdef HAVE_LIBURING_H
> > +static int tmpfs_io_uring_idmapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped);
> > +}
> > +static int tmpfs_io_uring_idmapped_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_userns);
> > +}
> > +static int tmpfs_io_uring_idmapped_unmapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped);
> > +}
> > +static int tmpfs_io_uring_idmapped_unmapped_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped_userns);
> > +}
> > +#endif /* HAVE_LIBURING_H */
> > +
> > +static int tmpfs_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts);
> > +}
> > +static int tmpfs_protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts_in_userns);
> > +}
> > +static int tmpfs_rename_crossing_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_rename_crossing_idmapped_mounts);
> > +}
> > +static int tmpfs_rename_from_idmapped_mount(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount);
> > +}
> > +static int tmpfs_rename_from_idmapped_mount_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount_in_userns);
> > +}
> > +static int tmpfs_setattr_truncate_idmapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped);
> > +}
> > +static int tmpfs_setattr_truncate_idmapped_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped_in_userns);
> > +}
> > +static int tmpfs_setgid_create_idmapped(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped);
> > +}
> > +static int tmpfs_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped_in_userns);
> > +}
> > +static int tmpfs_setid_binaries_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts);
> > +}
> > +static int tmpfs_setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns);
> > +}
> > +static int tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns);
> > +}
> > +static int tmpfs_sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts);
> > +}
> > +static int tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts_in_userns);
> > +}
> > +static int tmpfs_sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts);
> > +}
> > +static int tmpfs_sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts_in_userns);
> > +}
> > +static int tmpfs_symlink_idmapped_mounts(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts);
> > +}
> > +static int tmpfs_symlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
> > +{
> > +	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts_in_userns);
> > +}
> > +
> > +static const struct test_struct t_tmpfs[] = {
> > +	{ tmpfs_acls,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
> > +	{ tmpfs_create_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
> > +	{ tmpfs_device_node_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs device node in user namespace",								      },
> > +	{ tmpfs_expected_uid_gid_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs expected ownership on idmapped mounts",							},
> > +	{ tmpfs_fscaps_idmapped_mounts,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts",									},
> > +	{ tmpfs_fscaps_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace",							},
> > +	{ tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns,		T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace with different id mappings",			},
> > +	{ tmpfs_fsids_mapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs mapped fsids",										      },
> > +	{ tmpfs_fsids_unmapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs unmapped fsids",										      },
> > +	{ tmpfs_hardlink_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount hardlink",								},
> > +	{ tmpfs_hardlink_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts",								},
> > +	{ tmpfs_hardlink_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts in user namespace",						},
> > +#ifdef HAVE_LIBURING_H
> > +	{ tmpfs_io_uring_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts",								      },
> > +	{ tmpfs_io_uring_idmapped_userns,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts in user namespace",					      },
> > +	{ tmpfs_io_uring_idmapped_unmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids",					      },
> > +	{ tmpfs_io_uring_idmapped_unmapped_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids in user namespace",			      },
> > +#endif
> > +	{ tmpfs_protected_symlinks_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts",						},
> > +	{ tmpfs_protected_symlinks_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts in user namespace",				},
> > +	{ tmpfs_rename_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount rename",									},
> > +	{ tmpfs_rename_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts",									},
> > +	{ tmpfs_rename_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts in user namespace",						},
> > +	{ tmpfs_setattr_truncate_idmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts",								},
> > +	{ tmpfs_setattr_truncate_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts in user namespace",					},
> > +	{ tmpfs_setgid_create_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts",			},
> > +	{ tmpfs_setgid_create_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
> > +	{ tmpfs_setid_binaries_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts",								},
> > +	{ tmpfs_setid_binaries_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace",						},
> > +	{ tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns,	T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace with different id mappings",		},
> > +	{ tmpfs_sticky_bit_unlink_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts",						},
> > +	{ tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts in user namespace",				},
> > +	{ tmpfs_sticky_bit_rename_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts",						},
> > +	{ tmpfs_sticky_bit_rename_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts in user namespace",				},
> > +	{ tmpfs_symlink_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts",									},
> > +	{ tmpfs_symlink_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts in user namespace",						},
> > +};
> > +
> > +
> > +const struct test_suite s_tmpfs_idmapped_mounts = {
> > +	.tests = t_tmpfs,
> > +	.nr_tests = ARRAY_SIZE(t_tmpfs),
> > +};
> > diff --git src/vfs/tmpfs-idmapped-mounts.h src/vfs/tmpfs-idmapped-mounts.h
> > new file mode 100644
> > index 00000000..038d86a9
> > --- /dev/null
> > +++ src/vfs/tmpfs-idmapped-mounts.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __TMPFS_IDMAPPED_MOUNTS_H
> > +#define __TMPFS_IDMAPPED_MOUNTS_H
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include "utils.h"
> > +
> > +extern const struct test_suite s_tmpfs_idmapped_mounts;
> > +
> > +#endif /* __TMPFS_IDMAPPED_MOUNTS_H */
> > +
> > diff --git src/vfs/utils.h src/vfs/utils.h
> > index f1681737..872fd96f 100644
> > --- src/vfs/utils.h
> > +++ src/vfs/utils.h
> > @@ -45,6 +45,8 @@
> >  #define DIR2 "dir2"
> >  #define DIR3 "dir3"
> >  #define DIR1_RENAME "dir1_rename"
> > +// This directory may be used by tests that call another test.
> > +#define DIR0 "dir0"
> >  #define HARDLINK1 "hardlink1"
> >  #define SYMLINK1 "symlink1"
> >  #define SYMLINK_USER1 "symlink_user1"
> > diff --git src/vfs/vfstest.c src/vfs/vfstest.c
> > index 325f04a1..f842117d 100644
> > --- src/vfs/vfstest.c
> > +++ src/vfs/vfstest.c
> > @@ -23,6 +23,7 @@
> >  #include <unistd.h>
> >  
> >  #include "btrfs-idmapped-mounts.h"
> > +#include "tmpfs-idmapped-mounts.h"
> >  #include "idmapped-mounts.h"
> >  #include "missing.h"
> >  #include "utils.h"
> > @@ -2316,6 +2317,7 @@ static void usage(void)
> >  	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
> >  	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
> >  	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
> > +	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
> >  	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
> >  	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
> >  	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
> > @@ -2340,6 +2342,7 @@ static const struct option longopts[] = {
> >  	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
> >  	{"test-setgid-create-umask",		no_argument,		0,	'u'},
> >  	{"test-setgid-create-acl",		no_argument,		0,	'l'},
> > +	{"test-tmpfs",				no_argument,		0,	't'},
> >  	{NULL,					0,			0,	  0},
> >  };
> >  
> > @@ -2480,7 +2483,7 @@ int main(int argc, char *argv[])
> >  	bool idmapped_mounts_supported = false, test_btrfs = false,
> >  	     test_core = false, test_fscaps_regression = false,
> >  	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
> > -	     test_setxattr_fix_705191b03d50 = false,
> > +	     test_setxattr_fix_705191b03d50 = false, test_tmpfs = false,
> >  	     test_setgid_create_umask = false, test_setgid_create_acl = false;
> >  
> >  	init_vfstest_info(&info);
> > @@ -2529,6 +2532,9 @@ int main(int argc, char *argv[])
> >  		case 'l':
> >  			test_setgid_create_acl = true;
> >  			break;
> > +		case 't':
> > +			test_tmpfs = true;
> > +			break;
> >  		case 'h':
> >  			/* fallthrough */
> >  		default:
> > @@ -2622,6 +2628,11 @@ int main(int argc, char *argv[])
> >  			goto out;
> >  	}
> >  
> > +	if (test_tmpfs) {
> > +		if (!run_suite(&info, &s_tmpfs_idmapped_mounts))
> > +			goto out;
> > +	}
> > +
> >  	fret = EXIT_SUCCESS;
> >  
> >  out:
> > diff --git tests/tmpfs/001 tests/tmpfs/001
> > new file mode 100755
> > index 00000000..37f5439e
> > --- /dev/null
> > +++ tests/tmpfs/001
> > @@ -0,0 +1,27 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Rodrigo Campos Catelin.  All Rights Reserved.
> > +#
> > +# FS QA Test 001
> > +#
> > +# Test that idmapped mounts behave correctly with tmpfs filesystem.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick idmapped
> > +
> > +# get standard environment, filters and checks
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs tmpfs
> > +_require_idmapped_mounts
> > +_require_test
> > +
> > +echo "Silence is golden"
> > +
> > +$here/src/vfs/vfstest --test-tmpfs --device "$TEST_DEV" \
> > +	        --mount "$TEST_DIR" --fstype "$FSTYP"
> > +
> > +status=$?
> > +exit
> > diff --git tests/tmpfs/001.out tests/tmpfs/001.out
> > new file mode 100644
> > index 00000000..88678b8e
> > --- /dev/null
> > +++ tests/tmpfs/001.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 001
> > +Silence is golden
> > diff --git tests/tmpfs/Makefile tests/tmpfs/Makefile
> > new file mode 100644
> > index 00000000..b464b22b
> > --- /dev/null
> > +++ tests/tmpfs/Makefile
> > @@ -0,0 +1,24 @@
> > +#
> > +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> > +#
> > +
> > +TOPDIR = ../..
> > +include $(TOPDIR)/include/builddefs
> > +include $(TOPDIR)/include/buildgrouplist
> > +
> > +GENERIC_DIR = generic
> > +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
> > +DIRT = group.list
> > +
> > +default: $(DIRT)
> > +
> > +include $(BUILDRULES)
> > +
> > +install:
> > +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> > +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> > +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> > +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> > +
> > +# Nothing.
> > +install-dev install-lib:
> > -- 
> > 2.39.2
> > 
> 

