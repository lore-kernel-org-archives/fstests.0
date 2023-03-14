Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CFBC6FD1C
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNOsO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCNOsC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 10:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E1222DF
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678805231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/vYyYiAcM+iyltX+KbSu/4I62F5jfg5YEL0a5MJWr0=;
        b=cAL7bcqSYpapQ8UC/QK2i8DsI1PcSe97dBsaP1VTZ0DVWHmn/eePbAZg2NC0WuzFcBtJ0i
        FeSaUSaGlRRA5lZMHmoEP3o3YIX9qejHWpToZxWMTwDVUMhVxNCRzp1vwSxcr7/QL/gKPJ
        lQapOo3iZv+IjGeZlnlYhWyE/kjsabY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-xcpzagcbP0uJhx2dNzfq8Q-1; Tue, 14 Mar 2023 10:47:09 -0400
X-MC-Unique: xcpzagcbP0uJhx2dNzfq8Q-1
Received: by mail-pl1-f197.google.com with SMTP id i6-20020a170902c94600b0019d16e4ac0bso8879480pla.5
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 07:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/vYyYiAcM+iyltX+KbSu/4I62F5jfg5YEL0a5MJWr0=;
        b=vpjcYxTDkh29//E3mkQNNIxYexZ+C3Suh4PheL2RENg4veXhqtb3KtSdxtGtCPwzfW
         oPK3ztJRVG1qPGelGHS+g45l7Xyx5AKOIcJlKnloU1RCUmxb+d2IivytuxpbWjFUMGNE
         d7HyIOUvoVyzievVek3Q84wmu+UR+zNY7ew1TyZHfvWrNtlatVWcTYgnP3aqc6dVCG4R
         vZ9a4sxPHlPVDVeRn8WgcwiEixyA18xGt8ifjdEKWOWIODuTphcjKb140YDLvy4PXD94
         KqcOEF3W4B8GZGeM+azIZgwoTs1J8m9nG+n0tsSNzBimVh6FCs0pI2aIpjt689IXctZO
         qhzg==
X-Gm-Message-State: AO0yUKX70cHaMG20y3eSaGk05UIYGhU7pJd6fF2xWn7MKtKk1djZzmum
        fYD5rUG94EuixMrOz8kFo1kg1FLk04y2bVetJAybqXSucecWWlTs74mf1avNUYstZ+RyqnIrySN
        LRle8YmIKqYr965TeDbbkJng9NVkf
X-Received: by 2002:a17:902:ba83:b0:19d:14c:e590 with SMTP id k3-20020a170902ba8300b0019d014ce590mr31301255pls.9.1678805227998;
        Tue, 14 Mar 2023 07:47:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set/kgX+fPvxJRPc4iwP3neLqlE+cIg85XoPgWS/pwowodOGXIVBwtQt24iZzQy8yJvs0Ge6m3A==
X-Received: by 2002:a17:902:ba83:b0:19d:14c:e590 with SMTP id k3-20020a170902ba8300b0019d014ce590mr31301238pls.9.1678805227443;
        Tue, 14 Mar 2023 07:47:07 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kx15-20020a170902f94f00b0019f387f2dc3sm1904235plb.24.2023.03.14.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:47:07 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:47:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4 9/9] vfs: Add tmpfs tests for idmap mounts
Message-ID: <20230314144703.uq7wpw2g2qlmerz5@zlang-mailbox>
References: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
 <20230314114511.128207-10-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314114511.128207-10-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 14, 2023 at 12:45:11PM +0100, Rodrigo Campos wrote:
> This patch calls all tests in the suite s_idmapped_mounts, but with a
> tmpfs directory mounted inside a userns. This directory is setup as the
> mount point for the test that runs nested.
> 
> This excercises that tmpfs mounted inside a userns works as expected
> regarding idmap mounts.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

This verion looks good to me, so ...
Reviewed-by: Zorro Lang <zlang@redhat.com>

Just curious, did you use "--no-prefix" option or use some similar configuration
to generate this patchset. I have to use "-p0" to merge this patchset :)

Thanks,
Zorro

>  src/vfs/Makefile                |   4 +-
>  src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++
>  src/vfs/tmpfs-idmapped-mounts.h |  14 ++
>  src/vfs/utils.h                 |   2 +
>  src/vfs/vfstest.c               |  13 +-
>  tests/tmpfs/001                 |  27 +++
>  tests/tmpfs/001.out             |   2 +
>  tests/tmpfs/Makefile            |  24 +++
>  8 files changed, 388 insertions(+), 3 deletions(-)
>  create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
>  create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
>  create mode 100755 tests/tmpfs/001
>  create mode 100644 tests/tmpfs/001.out
>  create mode 100644 tests/tmpfs/Makefile
> 
> diff --git src/vfs/Makefile src/vfs/Makefile
> index 1b0b364b..4841da12 100644
> --- src/vfs/Makefile
> +++ src/vfs/Makefile
> @@ -4,10 +4,10 @@ TOPDIR = ../..
>  include $(TOPDIR)/include/builddefs
>  
>  TARGETS = vfstest mount-idmapped
> -CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c
> +CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c tmpfs-idmapped-mounts.c
>  CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
>  
> -HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h
> +HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h tmpfs-idmapped-mounts.h
>  LLDLIBS += -pthread
>  LDIRT = $(TARGETS)
>  
> diff --git src/vfs/tmpfs-idmapped-mounts.c src/vfs/tmpfs-idmapped-mounts.c
> new file mode 100644
> index 00000000..0899aed9
> --- /dev/null
> +++ src/vfs/tmpfs-idmapped-mounts.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include "../global.h"
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <grp.h>
> +#include <limits.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +#include <pthread.h>
> +#include <pwd.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <sys/fsuid.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <unistd.h>
> +
> +#include "missing.h"
> +#include "utils.h"
> +#include "vfstest.h"
> +#include "idmapped-mounts.h"
> +
> +static int tmpfs_nested_mount_setup(const struct vfstest_info *info, int (*test)(const struct vfstest_info *info))
> +{
> +	char path[PATH_MAX];
> +	int fret = -1;
> +	struct vfstest_info nested_test_info = *info;
> +
> +	/* Create mapping for userns
> +	 * Make the mapping quite long, so all nested userns that are created by
> +	 * any test we call is contained here (otherwise userns creation fails).
> +	 */
> +	struct mount_attr attr = {
> +		.attr_set	= MOUNT_ATTR_IDMAP,
> +		.userns_fd	= -EBADF,
> +	};
> +	attr.userns_fd = get_userns_fd(0, 10000, 200000);
> +	if (attr.userns_fd < 0) {
> +		log_stderr("failure: get_userns_fd");
> +		goto out_close;
> +	}
> +
> +	if (!switch_userns(attr.userns_fd, 0, 0, false)) {
> +		log_stderr("failure: switch_userns");
> +		goto out_close;
> +	}
> +
> +	/* create separate mount namespace */
> +	if (unshare(CLONE_NEWNS)) {
> +		log_stderr("failure: create new mount namespace");
> +		goto out_close;
> +	}
> +
> +	/* We don't want this mount in the parent mount ns */
> +	if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0)) {
> +		log_stderr("failure: mount");
> +		goto out_close;
> +	}
> +
> +	/* Create DIR0 to mount there */
> +	if (mkdirat(info->t_mnt_fd, DIR0, 0777)) {
> +		log_stderr("failure: mkdirat");
> +		goto out_close;
> +	}
> +	if (fchmodat(info->t_mnt_fd, DIR0, 0777, 0)) {
> +		log_stderr("failure: fchmodat");
> +		goto out_rm;
> +	}
> +
> +	snprintf(path, sizeof(path), "%s/%s", info->t_mountpoint, DIR0);
> +	if (sys_mount("tmpfs", path, "tmpfs", 0, NULL)) {
> +		log_stderr("failure: mount");
> +		goto out_rm;
> +	}
> +
> +	// Create a new info to use for the test we will call.
> +	nested_test_info = *info;
> +	nested_test_info.t_mountpoint = strdup(path);
> +	if (!nested_test_info.t_mountpoint) {
> +		log_stderr("failure: strdup");
> +		goto out;
> +	}
> +	nested_test_info.t_mnt_fd = openat(-EBADF, nested_test_info.t_mountpoint, O_CLOEXEC | O_DIRECTORY);
> +	if (nested_test_info.t_mnt_fd < 0) {
> +		log_stderr("failure: openat");
> +		goto out;
> +	}
> +
> +	test_setup(&nested_test_info);
> +
> +	// Run the test.
> +	if ((*test)(&nested_test_info)) {
> +		log_stderr("failure: calling test");
> +		goto out;
> +	}
> +
> +	test_cleanup(&nested_test_info);
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	snprintf(path, sizeof(path), "%s/" DIR0, info->t_mountpoint);
> +	sys_umount2(path, MNT_DETACH);
> +out_rm:
> +	if (rm_r(info->t_mnt_fd, DIR0))
> +		log_stderr("failure: rm_r");
> +out_close:
> +	safe_close(attr.userns_fd);
> +	return fret;
> +}
> +
> +static int tmpfs_acls(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_acls);
> +}
> +static int tmpfs_create_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_create_in_userns);
> +}
> +static int tmpfs_device_node_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_device_node_in_userns);
> +}
> +static int tmpfs_fsids_mapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_fsids_mapped);
> +}
> +static int tmpfs_fsids_unmapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_fsids_unmapped);
> +}
> +static int tmpfs_expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_expected_uid_gid_idmapped_mounts);
> +}
> +static int tmpfs_fscaps_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts);
> +}
> +static int tmpfs_fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns);
> +}
> +static int tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns_separate_userns);
> +}
> +
> +static int tmpfs_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_hardlink_crossing_idmapped_mounts);
> +}
> +static int tmpfs_hardlink_from_idmapped_mount(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount);
> +}
> +static int tmpfs_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount_in_userns);
> +}
> +
> +#ifdef HAVE_LIBURING_H
> +static int tmpfs_io_uring_idmapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped);
> +}
> +static int tmpfs_io_uring_idmapped_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_userns);
> +}
> +static int tmpfs_io_uring_idmapped_unmapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped);
> +}
> +static int tmpfs_io_uring_idmapped_unmapped_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped_userns);
> +}
> +#endif /* HAVE_LIBURING_H */
> +
> +static int tmpfs_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts);
> +}
> +static int tmpfs_protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts_in_userns);
> +}
> +static int tmpfs_rename_crossing_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_rename_crossing_idmapped_mounts);
> +}
> +static int tmpfs_rename_from_idmapped_mount(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount);
> +}
> +static int tmpfs_rename_from_idmapped_mount_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount_in_userns);
> +}
> +static int tmpfs_setattr_truncate_idmapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped);
> +}
> +static int tmpfs_setattr_truncate_idmapped_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped_in_userns);
> +}
> +static int tmpfs_setgid_create_idmapped(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped);
> +}
> +static int tmpfs_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped_in_userns);
> +}
> +static int tmpfs_setid_binaries_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts);
> +}
> +static int tmpfs_setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns);
> +}
> +static int tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns);
> +}
> +static int tmpfs_sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts);
> +}
> +static int tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts_in_userns);
> +}
> +static int tmpfs_sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts);
> +}
> +static int tmpfs_sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts_in_userns);
> +}
> +static int tmpfs_symlink_idmapped_mounts(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts);
> +}
> +static int tmpfs_symlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
> +{
> +	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts_in_userns);
> +}
> +
> +static const struct test_struct t_tmpfs[] = {
> +	{ tmpfs_acls,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
> +	{ tmpfs_create_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
> +	{ tmpfs_device_node_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs device node in user namespace",								      },
> +	{ tmpfs_expected_uid_gid_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs expected ownership on idmapped mounts",							},
> +	{ tmpfs_fscaps_idmapped_mounts,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts",									},
> +	{ tmpfs_fscaps_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace",							},
> +	{ tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns,		T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace with different id mappings",			},
> +	{ tmpfs_fsids_mapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs mapped fsids",										      },
> +	{ tmpfs_fsids_unmapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs unmapped fsids",										      },
> +	{ tmpfs_hardlink_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount hardlink",								},
> +	{ tmpfs_hardlink_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts",								},
> +	{ tmpfs_hardlink_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts in user namespace",						},
> +#ifdef HAVE_LIBURING_H
> +	{ tmpfs_io_uring_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts",								      },
> +	{ tmpfs_io_uring_idmapped_userns,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts in user namespace",					      },
> +	{ tmpfs_io_uring_idmapped_unmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids",					      },
> +	{ tmpfs_io_uring_idmapped_unmapped_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids in user namespace",			      },
> +#endif
> +	{ tmpfs_protected_symlinks_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts",						},
> +	{ tmpfs_protected_symlinks_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts in user namespace",				},
> +	{ tmpfs_rename_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount rename",									},
> +	{ tmpfs_rename_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts",									},
> +	{ tmpfs_rename_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts in user namespace",						},
> +	{ tmpfs_setattr_truncate_idmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts",								},
> +	{ tmpfs_setattr_truncate_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts in user namespace",					},
> +	{ tmpfs_setgid_create_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts",			},
> +	{ tmpfs_setgid_create_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
> +	{ tmpfs_setid_binaries_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts",								},
> +	{ tmpfs_setid_binaries_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace",						},
> +	{ tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns,	T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace with different id mappings",		},
> +	{ tmpfs_sticky_bit_unlink_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts",						},
> +	{ tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts in user namespace",				},
> +	{ tmpfs_sticky_bit_rename_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts",						},
> +	{ tmpfs_sticky_bit_rename_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts in user namespace",				},
> +	{ tmpfs_symlink_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts",									},
> +	{ tmpfs_symlink_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts in user namespace",						},
> +};
> +
> +
> +const struct test_suite s_tmpfs_idmapped_mounts = {
> +	.tests = t_tmpfs,
> +	.nr_tests = ARRAY_SIZE(t_tmpfs),
> +};
> diff --git src/vfs/tmpfs-idmapped-mounts.h src/vfs/tmpfs-idmapped-mounts.h
> new file mode 100644
> index 00000000..ed24651f
> --- /dev/null
> +++ src/vfs/tmpfs-idmapped-mounts.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __TMPFS_IDMAPPED_MOUNTS_H
> +#define __TMPFS_IDMAPPED_MOUNTS_H
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include "utils.h"
> +
> +extern const struct test_suite s_tmpfs_idmapped_mounts;
> +
> +#endif /* __TMPFS_IDMAPPED_MOUNTS_H */
> diff --git src/vfs/utils.h src/vfs/utils.h
> index f1681737..872fd96f 100644
> --- src/vfs/utils.h
> +++ src/vfs/utils.h
> @@ -45,6 +45,8 @@
>  #define DIR2 "dir2"
>  #define DIR3 "dir3"
>  #define DIR1_RENAME "dir1_rename"
> +// This directory may be used by tests that call another test.
> +#define DIR0 "dir0"
>  #define HARDLINK1 "hardlink1"
>  #define SYMLINK1 "symlink1"
>  #define SYMLINK_USER1 "symlink_user1"
> diff --git src/vfs/vfstest.c src/vfs/vfstest.c
> index 325f04a1..f842117d 100644
> --- src/vfs/vfstest.c
> +++ src/vfs/vfstest.c
> @@ -23,6 +23,7 @@
>  #include <unistd.h>
>  
>  #include "btrfs-idmapped-mounts.h"
> +#include "tmpfs-idmapped-mounts.h"
>  #include "idmapped-mounts.h"
>  #include "missing.h"
>  #include "utils.h"
> @@ -2316,6 +2317,7 @@ static void usage(void)
>  	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
>  	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
>  	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
> +	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
>  	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
>  	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
>  	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
> @@ -2340,6 +2342,7 @@ static const struct option longopts[] = {
>  	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
>  	{"test-setgid-create-umask",		no_argument,		0,	'u'},
>  	{"test-setgid-create-acl",		no_argument,		0,	'l'},
> +	{"test-tmpfs",				no_argument,		0,	't'},
>  	{NULL,					0,			0,	  0},
>  };
>  
> @@ -2480,7 +2483,7 @@ int main(int argc, char *argv[])
>  	bool idmapped_mounts_supported = false, test_btrfs = false,
>  	     test_core = false, test_fscaps_regression = false,
>  	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
> -	     test_setxattr_fix_705191b03d50 = false,
> +	     test_setxattr_fix_705191b03d50 = false, test_tmpfs = false,
>  	     test_setgid_create_umask = false, test_setgid_create_acl = false;
>  
>  	init_vfstest_info(&info);
> @@ -2529,6 +2532,9 @@ int main(int argc, char *argv[])
>  		case 'l':
>  			test_setgid_create_acl = true;
>  			break;
> +		case 't':
> +			test_tmpfs = true;
> +			break;
>  		case 'h':
>  			/* fallthrough */
>  		default:
> @@ -2622,6 +2628,11 @@ int main(int argc, char *argv[])
>  			goto out;
>  	}
>  
> +	if (test_tmpfs) {
> +		if (!run_suite(&info, &s_tmpfs_idmapped_mounts))
> +			goto out;
> +	}
> +
>  	fret = EXIT_SUCCESS;
>  
>  out:
> diff --git tests/tmpfs/001 tests/tmpfs/001
> new file mode 100755
> index 00000000..37ef0b18
> --- /dev/null
> +++ tests/tmpfs/001
> @@ -0,0 +1,27 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Rodrigo Campos Catelin (Microsoft). All Rights Reserved.
> +#
> +# FS QA Test 001
> +#
> +# Test that idmapped mounts behave correctly with tmpfs filesystem.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick idmapped
> +
> +# get standard environment, filters and checks
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs tmpfs
> +_require_idmapped_mounts
> +_require_test
> +
> +echo "Silence is golden"
> +
> +$here/src/vfs/vfstest --test-tmpfs --device "$TEST_DEV" \
> +	        --mount "$TEST_DIR" --fstype "$FSTYP"
> +
> +status=$?
> +exit
> diff --git tests/tmpfs/001.out tests/tmpfs/001.out
> new file mode 100644
> index 00000000..88678b8e
> --- /dev/null
> +++ tests/tmpfs/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git tests/tmpfs/Makefile tests/tmpfs/Makefile
> new file mode 100644
> index 00000000..46544313
> --- /dev/null
> +++ tests/tmpfs/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2023 Rodrigo Campos Catelin (Microsoft). All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +TMPFS_DIR = tmpfs
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TMPFS_DIR)
> +DIRT = group.list
> +
> +default: $(DIRT)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:
> -- 
> 2.39.2
> 

