Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1DECAAA1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Aug 2022 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3LQg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiH3LQe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2022 07:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D324E97C2
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 04:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A1B461518
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 11:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF0C433C1;
        Tue, 30 Aug 2022 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661858187;
        bh=y34rSocOfMbzb7iwA6AAGafOnsiZ8eNPUUo42NfM9j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8YGM1NDrXqiNOoVBZ/+cc9f/cz5F6tRZNJfygz1M5FAVNvW0NrrrDZyTBkaMeqB5
         bhhR+LjlODbB9Paxs1tsaXf1WyY4XQy90jpJOVOPXWp4wlTzArAyNsqA654uTDyQGA
         N/c9EvVGeLqy212js1zgrf06hC4fPwVU/t3Z4YMu+ef/r52aN3HJj3mPlkMNzQ6SBk
         uKp4e3VHjZuwLTiIYmJbJDshGnmldnfdE5sqn0VlWrFcABvRSsogSoiNUiNMF0mwMY
         2wIW6TDIzuExWKzeUgfzsdAGCrQIa72vZ5/osI348iDNPTxnK3Q8YpyT1shKVKmqfv
         JHeHxXED4DQPw==
Date:   Tue, 30 Aug 2022 13:16:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: Add new setgid_create_acl test
Message-ID: <20220830111623.xqs42cula4pe2tey@wittgenstein>
References: <20220829135225.wscmhw4dqkzitcvf@wittgenste>
 <1661858003-2181-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661858003-2181-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220830110732.mjjpykrihbicqlsw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830110732.mjjpykrihbicqlsw@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 30, 2022 at 01:07:43PM +0200, Christian Brauner wrote:
> On Tue, Aug 30, 2022 at 07:13:23PM +0800, Yang Xu wrote:
> > The current_umask() is stripped from the mode directly in the vfs if the
> > filesystem either doesn't support acls or the filesystem has been
> > mounted without posic acl support.
> > 
> > If the filesystem does support acls then current_umask() stripping is
> > deferred to posix_acl_create(). So when the filesystem calls
> > posix_acl_create() and there are no acls set or not supported then
> > current_umask() will be stripped.
> > 
> > If the parent directory has a default acl then permissions are based off
> > of that and current_umask() is ignored. Specifically, if the ACL has an
> > ACL_MASK entry, the group permissions correspond to the permissions of
> > the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
> > group permissions correspond to the permissions of the ACL_GROUP_OBJ
> > entry.
> > 
> > Here we only use setfacl to set default acl or add ACL_MASK to check
> > whether inode strip  S_ISGID works correctly.
> > 
> > Like umask test, this patch is also designed to test kernel patchset behaviour
> > "move S_ISGID stripping into the vfs* helper"
> > 
> > Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  src/vfs/idmapped-mounts.c | 907 ++++++++++++++++++++++++++++++++++----
> >  src/vfs/idmapped-mounts.h |   1 +
> >  src/vfs/vfstest.c         | 356 ++++++++++++++-
> >  tests/generic/999         |  33 ++
> >  tests/generic/999.out     |   2 +
> >  5 files changed, 1218 insertions(+), 81 deletions(-)
> >  create mode 100755 tests/generic/999
> >  create mode 100644 tests/generic/999.out
> > 
> > diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> > index 01a5fbd4..c010dfa1 100644
> > --- a/src/vfs/idmapped-mounts.c
> > +++ b/src/vfs/idmapped-mounts.c
> > @@ -7664,7 +7664,6 @@ out:
> >  	return fret;
> >  }
> >  
> > -
> >  /* The current_umask() is stripped from the mode directly in the vfs if the
> >   * filesystem either doesn't support acls or the filesystem has been
> >   * mounted without posic acl support.
> > @@ -8114,94 +8113,842 @@ out:
> >  	return fret;
> >  }
> >  
> > -static const struct test_struct t_idmapped_mounts[] = {
> > -	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
> > -	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
> > -	{ device_node_in_userns,                                        true,   "device node in user namespace",                                                                },
> > -	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
> > -	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
> > -	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
> > -	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
> > -	{ fsids_mapped,                                                 true,   "mapped fsids",                                                                                 },
> > -	{ fsids_unmapped,                                               true,   "unmapped fsids",                                                                               },
> > -	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
> > -	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
> > -	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
> > -#ifdef HAVE_LIBURING_H
> > -	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
> > -	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
> > -	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
> > -	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
> > -#endif
> > -	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
> > -	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
> > -	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
> > -	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
> > -	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
> > -	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
> > -	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
> > -	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
> > -	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
> > -	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
> > -	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
> > -	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
> > -	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
> > -	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
> > -	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
> > -	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
> > -	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
> > -	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
> > -};
> > +/*
> > + * If the parent directory has a default acl then permissions are based off
> > + * of that and current_umask() is ignored. Specifically, if the ACL has an
> > + * ACL_MASK entry, the group permissions correspond to the permissions of
> > + * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
> > + * group permissions correspond to the permissions of the ACL_GROUP_OBJ
> > + * entry.
> > + *
> > + * Use setfacl to check whether inode strip S_ISGID works correctly under
> > + * the above two situations when enabling idmapped.
> > + *
> > + * Test for commit
> > + * 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
> > + */
> > +static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> > +{
> > +	int fret = -1;
> > +	int file1_fd = -EBADF, open_tree_fd = -EBADF;
> > +	struct mount_attr attr = {
> > +		.attr_set = MOUNT_ATTR_IDMAP,
> > +	};
> > +	pid_t pid;
> > +	int tmpfile_fd = -EBADF;
> > +	bool supported = false;
> > +	char path[PATH_MAX];
> > +	mode_t mode;
> >  
> > -const struct test_suite s_idmapped_mounts = {
> > -	.tests		= t_idmapped_mounts,
> > -	.nr_tests	= ARRAY_SIZE(t_idmapped_mounts),
> > -};
> > +	if (!caps_supported())
> > +		return 0;
> >  
> > -static const struct test_struct t_fscaps_in_ancestor_userns[] = {
> > -	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
> > -};
> > +	if (fchmod(info->t_dir1_fd, S_IRUSR |
> > +			      S_IWUSR |
> > +			      S_IRGRP |
> 
> This is difficult to review on list and it's not your fault but for the
> future when you see patch that seems really unclean and messed-up it can
> help to pass --minimal to git format-patch.
> 
> I'll apply locally for review.

Ok, still seems good!
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
