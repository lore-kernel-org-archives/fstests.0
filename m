Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA6C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Jan 2022 04:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiAPEwh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:52:37 -0500
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:37566 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiAPEwg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Jan 2022 23:52:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0410798-0.000771631-0.958149;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MdlukGg_1642308753;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MdlukGg_1642308753)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 16 Jan 2022 12:52:33 +0800
Date:   Sun, 16 Jan 2022 12:52:33 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/2] idmapped-mounts: always run generic vfs tests
Message-ID: <YeOkkS8Vj41dTjvS@desktop>
References: <20220113132421.865002-1-brauner@kernel.org>
 <20220113132421.865002-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113132421.865002-2-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 13, 2022 at 02:24:21PM +0100, Christian Brauner wrote:
> Make it possible to always run all the tests in the testsuite that don't
> require idmapped mounts. Now all filesystems can benefit from the
> generic vfs tests that we currently implement. This means setgid
> inheritance and other tests will be run for all filesystems not matter
> if they support idmapped mounts or not.
> 
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: fstests@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 184 ++++++++++++++------------
>  tests/generic/633                     |   1 -
>  2 files changed, 98 insertions(+), 87 deletions(-)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index a78a901f..5f304108 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -125,6 +125,9 @@ int t_dir1_fd;
>  /* temporary buffer */
>  char t_buf[PATH_MAX];
>  
> +/* whether the underlying filesystem supports idmapped mounts */
> +bool t_fs_allow_idmap;
> +
>  static void stash_overflowuid(void)
>  {
>  	int fd;
> @@ -2867,10 +2870,7 @@ out:
>  static int fscaps(void)
>  {
>  	int fret = -1;
> -	int file1_fd = -EBADF;
> -	struct mount_attr attr = {
> -		.attr_set = MOUNT_ATTR_IDMAP,
> -	};
> +	int file1_fd = -EBADF, fd_userns = -EBADF;
>  	pid_t pid;
>  
>  	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
> @@ -2884,8 +2884,8 @@ static int fscaps(void)
>  		return 0;
>  
>  	/* Changing mount properties on a detached mount. */
> -	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> -	if (attr.userns_fd < 0) {
> +	fd_userns = get_userns_fd(0, 10000, 10000);
> +	if (fd_userns < 0) {
>  		log_stderr("failure: get_userns_fd");
>  		goto out;
>  	}
> @@ -2901,7 +2901,7 @@ static int fscaps(void)
>  		goto out;
>  	}
>  	if (pid == 0) {
> -		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +		if (!switch_userns(fd_userns, 0, 0, false))
>  			die("failure: switch_userns");
>  
>  		/*
> @@ -2949,7 +2949,7 @@ static int fscaps(void)
>  		goto out;
>  	}
>  	if (pid == 0) {
> -		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +		if (!switch_userns(fd_userns, 0, 0, false))
>  			die("failure: switch_userns");
>  
>  		if (!expected_dummy_vfs_caps_uid(file1_fd, 0))
> @@ -2977,8 +2977,8 @@ static int fscaps(void)
>  	fret = 0;
>  	log_debug("Ran test");
>  out:
> -	safe_close(attr.userns_fd);
>  	safe_close(file1_fd);
> +	safe_close(fd_userns);
>  
>  	return fret;
>  }
> @@ -13783,95 +13783,96 @@ static const struct option longopts[] = {
>  
>  struct t_idmapped_mounts {
>  	int (*test)(void);
> +	bool require_fs_allow_idmap;
>  	const char *description;
>  } basic_suite[] = {
> -	{ acls,								"posix acls on regular mounts",									},
> -	{ create_in_userns,						"create operations in user namespace",								},
> -	{ device_node_in_userns,					"device node in user namespace",								},
> -	{ expected_uid_gid_idmapped_mounts,				"expected ownership on idmapped mounts",							},
> -	{ fscaps,							"fscaps on regular mounts",									},
> -	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",									},
> -	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",							},
> -	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings",			},
> -	{ fsids_mapped,							"mapped fsids",											},
> -	{ fsids_unmapped,						"unmapped fsids",										},
> -	{ hardlink_crossing_mounts,					"cross mount hardlink",										},
> -	{ hardlink_crossing_idmapped_mounts,				"cross idmapped mount hardlink",								},
> -	{ hardlink_from_idmapped_mount,					"hardlinks from idmapped mounts",								},
> -	{ hardlink_from_idmapped_mount_in_userns,			"hardlinks from idmapped mounts in user namespace",						},
> +	{ acls,								true,	"posix acls on regular mounts",									},
> +	{ create_in_userns,						true,	"create operations in user namespace",								},
> +	{ device_node_in_userns,					true,	"device node in user namespace",								},
> +	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
> +	{ fscaps,							false,	"fscaps on regular mounts",									},
> +	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
> +	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
> +	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
> +	{ fsids_mapped,							true,	"mapped fsids",											},
> +	{ fsids_unmapped,						true,	"unmapped fsids",										},
> +	{ hardlink_crossing_mounts,					false,	"cross mount hardlink",										},
> +	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
> +	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
> +	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
>  #ifdef HAVE_LIBURING_H
> -	{ io_uring,							"io_uring",											},
> -	{ io_uring_userns,						"io_uring in user namespace",									},
> -	{ io_uring_idmapped,						"io_uring from idmapped mounts",								},
> -	{ io_uring_idmapped_userns,					"io_uring from idmapped mounts in user namespace",						},
> -	{ io_uring_idmapped_unmapped,					"io_uring from idmapped mounts with unmapped ids",						},
> -	{ io_uring_idmapped_unmapped_userns,				"io_uring from idmapped mounts with unmapped ids in user namespace",				},
> +	{ io_uring,							false,	"io_uring",											},
> +	{ io_uring_userns,						false,	"io_uring in user namespace",									},
> +	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
> +	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
> +	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
> +	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
>  #endif
> -	{ protected_symlinks,						"following protected symlinks on regular mounts",						},
> -	{ protected_symlinks_idmapped_mounts,				"following protected symlinks on idmapped mounts",						},
> -	{ protected_symlinks_idmapped_mounts_in_userns,			"following protected symlinks on idmapped mounts in user namespace",				},
> -	{ rename_crossing_mounts,					"cross mount rename",										},
> -	{ rename_crossing_idmapped_mounts,				"cross idmapped mount rename",									},
> -	{ rename_from_idmapped_mount,					"rename from idmapped mounts",									},
> -	{ rename_from_idmapped_mount_in_userns,				"rename from idmapped mounts in user namespace",						},
> -	{ setattr_truncate,						"setattr truncate",										},
> -	{ setattr_truncate_idmapped,					"setattr truncate on idmapped mounts",								},
> -	{ setattr_truncate_idmapped_in_userns,				"setattr truncate on idmapped mounts in user namespace",					},
> -	{ setgid_create,						"create operations in directories with setgid bit set",						},
> -	{ setgid_create_idmapped,					"create operations in directories with setgid bit set on idmapped mounts",			},
> -	{ setgid_create_idmapped_in_userns,				"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
> -	{ setid_binaries,						"setid binaries on regular mounts",								},
> -	{ setid_binaries_idmapped_mounts,				"setid binaries on idmapped mounts",								},
> -	{ setid_binaries_idmapped_mounts_in_userns,			"setid binaries on idmapped mounts in user namespace",						},
> -	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
> -	{ sticky_bit_unlink,						"sticky bit unlink operations on regular mounts",						},
> -	{ sticky_bit_unlink_idmapped_mounts,				"sticky bit unlink operations on idmapped mounts",						},
> -	{ sticky_bit_unlink_idmapped_mounts_in_userns,			"sticky bit unlink operations on idmapped mounts in user namespace",				},
> -	{ sticky_bit_rename,						"sticky bit rename operations on regular mounts",						},
> -	{ sticky_bit_rename_idmapped_mounts,				"sticky bit rename operations on idmapped mounts",						},
> -	{ sticky_bit_rename_idmapped_mounts_in_userns,			"sticky bit rename operations on idmapped mounts in user namespace",				},
> -	{ symlink_regular_mounts,					"symlink from regular mounts",									},
> -	{ symlink_idmapped_mounts,					"symlink from idmapped mounts",									},
> -	{ symlink_idmapped_mounts_in_userns,				"symlink from idmapped mounts in user namespace",						},
> -	{ threaded_idmapped_mount_interactions,				"threaded operations on idmapped mounts",							},
> +	{ protected_symlinks,						false,	"following protected symlinks on regular mounts",						},
> +	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
> +	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
> +	{ rename_crossing_mounts,					false,	"cross mount rename",										},
> +	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
> +	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
> +	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
> +	{ setattr_truncate,						false,	"setattr truncate",										},
> +	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
> +	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
> +	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
> +	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
> +	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
> +	{ setid_binaries,						false,	"setid binaries on regular mounts",								},
> +	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
> +	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
> +	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
> +	{ sticky_bit_unlink,						false,	"sticky bit unlink operations on regular mounts",						},
> +	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
> +	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
> +	{ sticky_bit_rename,						false,	"sticky bit rename operations on regular mounts",						},
> +	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
> +	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
> +	{ symlink_regular_mounts,					false,	"symlink from regular mounts",									},
> +	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
> +	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
> +	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
>  };
>  
>  struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
> -	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
> +	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
>  };
>  
>  struct t_idmapped_mounts t_nested_userns[] = {
> -	{ nested_userns,						"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
> +	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
>  };
>  
>  struct t_idmapped_mounts t_btrfs[] = {
> -	{ btrfs_subvolumes_fsids_mapped,				"test subvolumes with mapped fsids",								},
> -	{ btrfs_subvolumes_fsids_mapped_userns,				"test subvolumes with mapped fsids inside user namespace",					},
> -	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		"test subvolume deletion with user_subvol_rm_allowed mount option",				},
> -	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
> -	{ btrfs_subvolumes_fsids_unmapped,				"test subvolumes with unmapped fsids",								},
> -	{ btrfs_subvolumes_fsids_unmapped_userns,			"test subvolumes with unmapped fsids inside user namespace",					},
> -	{ btrfs_snapshots_fsids_mapped,					"test snapshots with mapped fsids",								},
> -	{ btrfs_snapshots_fsids_mapped_userns,				"test snapshots with mapped fsids inside user namespace",					},
> -	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		"test snapshots deletion with user_subvol_rm_allowed mount option",				},
> -	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
> -	{ btrfs_snapshots_fsids_unmapped,				"test snapshots with unmapped fsids",								},
> -	{ btrfs_snapshots_fsids_unmapped_userns,			"test snapshots with unmapped fsids inside user namespace",					},
> -	{ btrfs_delete_by_spec_id,					"test subvolume deletion by spec id",								},
> -	{ btrfs_subvolumes_setflags_fsids_mapped,			"test subvolume flags with mapped fsids",							},
> -	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		"test subvolume flags with mapped fsids inside user namespace",					},
> -	{ btrfs_subvolumes_setflags_fsids_unmapped,			"test subvolume flags with unmapped fsids",							},
> -	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		"test subvolume flags with unmapped fsids inside user namespace",				},
> -	{ btrfs_snapshots_setflags_fsids_mapped,			"test snapshots flags with mapped fsids",							},
> -	{ btrfs_snapshots_setflags_fsids_mapped_userns,			"test snapshots flags with mapped fsids inside user namespace",					},
> -	{ btrfs_snapshots_setflags_fsids_unmapped,			"test snapshots flags with unmapped fsids",							},
> -	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		"test snapshots flags with unmapped fsids inside user namespace",				},
> -	{ btrfs_subvolume_lookup_user,					"test unprivileged subvolume lookup",								},
> +	{ btrfs_subvolumes_fsids_mapped,				true,	"test subvolumes with mapped fsids",								},
> +	{ btrfs_subvolumes_fsids_mapped_userns,				true, 	"test subvolumes with mapped fsids inside user namespace",					},
> +	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		true, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
> +	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
> +	{ btrfs_subvolumes_fsids_unmapped,				true, 	"test subvolumes with unmapped fsids",								},
> +	{ btrfs_subvolumes_fsids_unmapped_userns,			true, 	"test subvolumes with unmapped fsids inside user namespace",					},
> +	{ btrfs_snapshots_fsids_mapped,					true, 	"test snapshots with mapped fsids",								},
> +	{ btrfs_snapshots_fsids_mapped_userns,				true, 	"test snapshots with mapped fsids inside user namespace",					},
> +	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		true, 	"test snapshots deletion with user_subvol_rm_allowed mount option",				},
> +	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
> +	{ btrfs_snapshots_fsids_unmapped,				true, 	"test snapshots with unmapped fsids",								},
> +	{ btrfs_snapshots_fsids_unmapped_userns,			true, 	"test snapshots with unmapped fsids inside user namespace",					},
> +	{ btrfs_delete_by_spec_id,					true, 	"test subvolume deletion by spec id",								},
> +	{ btrfs_subvolumes_setflags_fsids_mapped,			true, 	"test subvolume flags with mapped fsids",							},
> +	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		true, 	"test subvolume flags with mapped fsids inside user namespace",					},
> +	{ btrfs_subvolumes_setflags_fsids_unmapped,			true, 	"test subvolume flags with unmapped fsids",							},
> +	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		true, 	"test subvolume flags with unmapped fsids inside user namespace",				},
> +	{ btrfs_snapshots_setflags_fsids_mapped,			true, 	"test snapshots flags with mapped fsids",							},
> +	{ btrfs_snapshots_setflags_fsids_mapped_userns,			true, 	"test snapshots flags with mapped fsids inside user namespace",					},
> +	{ btrfs_snapshots_setflags_fsids_unmapped,			true, 	"test snapshots flags with unmapped fsids",							},
> +	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		true, 	"test snapshots flags with unmapped fsids inside user namespace",				},
> +	{ btrfs_subvolume_lookup_user,					true, 	"test unprivileged subvolume lookup",								},
>  };
>  
>  /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
>  struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
> -	{ setattr_fix_968219708108,					"test that setattr works correctly",								},
> +	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
>  };
>  
>  static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
> @@ -13883,6 +13884,15 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
>  		int ret;
>  		pid_t pid;
>  
> +		/*
> +		 * If the underlying filesystems does not support idmapped
> +		 * mounts only run vfs generic tests.
> +		 */
> +		if (t->require_fs_allow_idmap && !t_fs_allow_idmap) {
> +			log_debug("Skipping test %s", t->description);
> +			continue;
> +		}
> +
>  		test_setup();
>  
>  		pid = fork();
> @@ -14011,13 +14021,15 @@ int main(int argc, char *argv[])
>  	if (t_mnt_fd < 0)
>  		die("failed to open %s", t_mountpoint_scratch);
>  
> -	/*
> -	 * Caller just wants to know whether the filesystem we're on supports
> -	 * idmapped mounts.
> -	 */
> +	t_fs_allow_idmap = fs_allow_idmap();
>  	if (supported) {
> -		if (!fs_allow_idmap())
> +		/*
> +		 * Caller just wants to know whether the filesystem we're on
> +		 * supports idmapped mounts.
> +		 */
> +		if (!t_fs_allow_idmap)
>  			exit(EXIT_FAILURE);
> +
>  		exit(EXIT_SUCCESS);
>  	}
>  
> diff --git a/tests/generic/633 b/tests/generic/633
> index 67501177..38280647 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -15,7 +15,6 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
>  # real QA test starts here
>  
>  _supported_fs generic
> -_require_idmapped_mounts

Removed by accident or is it intentional?

Thanks,
Eryu

>  _require_test
>  
>  echo "Silence is golden"
> -- 
> 2.32.0
