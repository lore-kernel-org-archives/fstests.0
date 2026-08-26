Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889C2236F2
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760556; cv=none; b=hHTrZ9ngpuhgBvMg76nMONzMCZ1Piqp/l5crPpTBgpVtmA8wl2S1dnxWrb7dNDhyDZQ50/vfSdfQLUvVTtUvWrLOdO66dHvxz/juYloT+hgODhbV5sssCpfT66FYj3xLXNJh5cfkr9l3oYBWikFiNEYBx5GdP61Xh61GajpFxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760556; c=relaxed/simple;
	bh=6v5cCObz24LjExUYDiPPI8JaCMPRlge+3e2r0yxEhz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Duz2UaBcTVcpNEBkNemZYSVDTOEElT9adkdvLnPomVKvUnVpqyG6VNiW4NwGU00DTvCtBDAv4b0aNnvcAC6XSLO8NPh0IX1CkpOUSBvcdwWE8C3AwLuLGbh8hOQe5p7MOFXkzwTuJC4hQMGL8bE1MxlRoLoJTGrcfTZ0Tm99dUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD4FwTUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD4FwTUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDF21F000E9;
	Wed, 26 Aug 2026 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760554;
	bh=LYFRqwRBwheutzC+Rcu/lf6KDDI++WTB8b1pslTqRoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KD4FwTUd7oTulVuiJ8mRM7kHliUCORODdgYfLdRAlaUy5wC/BaGmmpdSplarDczsx
	 ik2qYYyJHu4THRSvGdbX3TZ6Rnq7FdMB1GyLyWyVuUIfJHJpqXzeh2Zc+0ex2kOrcQ
	 OuZG8UU+t2jxnZoy14ESQcyB6oC3IbMJBpIMBS4huzzCZAzSEDlGENQKSt9VTNLEUn
	 tRU3FRzJlaTwg89mV9HXOKDzQFGj1zGDDsAQKWwmhv4Q6QeDIahw9qcxW09gDpNUYd
	 5CggGOL9L3k2xB8c2KZnqoXAmeeBRkHn/Z6Zedl/OUiKH53oqg7wFiETM1t/LxhC3C
	 e30WtbwUdnmCg==
Date: Thu, 27 Aug 2026 00:09:05 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] Add _require_chmod as needed
Message-ID: <ao8MydLN9zutR5hB@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-3-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825001337.449670-3-sandeen@redhat.com>

On Mon, Aug 24, 2026 at 07:11:09PM -0500, Eric Sandeen wrote:
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Maybe we need a helper likes `_require_posix_fs` to filter out non-POSIX
filesystems such as exFAT, NTFS, and CIFS etc :)

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/093 | 1 +
>  tests/generic/099 | 1 +
>  tests/generic/184 | 1 +
>  tests/generic/193 | 1 +
>  tests/generic/230 | 1 +
>  tests/generic/256 | 1 +
>  tests/generic/314 | 1 +
>  tests/generic/317 | 1 +
>  tests/generic/355 | 1 +
>  tests/generic/370 | 1 +
>  tests/generic/375 | 1 +
>  tests/generic/378 | 1 +
>  tests/generic/444 | 1 +
>  tests/generic/449 | 1 +
>  tests/generic/462 | 1 +
>  tests/generic/495 | 1 +
>  tests/generic/514 | 1 +
>  tests/generic/535 | 1 +
>  tests/generic/572 | 1 +
>  tests/generic/573 | 1 +
>  tests/generic/581 | 1 +
>  tests/generic/597 | 1 +
>  tests/generic/603 | 1 +
>  tests/generic/622 | 1 +
>  tests/generic/636 | 1 +
>  tests/generic/641 | 1 +
>  tests/generic/673 | 1 +
>  tests/generic/674 | 1 +
>  tests/generic/675 | 1 +
>  tests/generic/682 | 1 +
>  tests/generic/683 | 1 +
>  tests/generic/684 | 1 +
>  tests/generic/685 | 1 +
>  tests/generic/686 | 1 +
>  tests/generic/687 | 1 +
>  tests/generic/688 | 1 +
>  tests/generic/698 | 1 +
>  tests/generic/699 | 1 +
>  tests/generic/726 | 1 +
>  tests/generic/727 | 1 +
>  tests/generic/792 | 1 +
>  41 files changed, 41 insertions(+)
> 
> diff --git a/tests/generic/093 b/tests/generic/093
> index 047cc821..9c3c855b 100755
> --- a/tests/generic/093
> +++ b/tests/generic/093
> @@ -29,6 +29,7 @@ filefilter()
>  _require_test
>  _require_attrs security
>  _require_user
> +_require_chmod
>  _require_test_program "writemod"
>  _require_command "$SETCAP_PROG" "setcap"
>  _require_command "$GETCAP_PROG" "getcap"
> diff --git a/tests/generic/099 b/tests/generic/099
> index 980fd38f..cf54e96b 100755
> --- a/tests/generic/099
> +++ b/tests/generic/099
> @@ -47,6 +47,7 @@ _cleanup()
>  #
>  
>  _require_test
> +_require_chmod
>  _require_runas
>  
>  _acl_setup_ids
> diff --git a/tests/generic/184 b/tests/generic/184
> index c82876d9..81663a65 100755
> --- a/tests/generic/184
> +++ b/tests/generic/184
> @@ -13,6 +13,7 @@ _begin_fstest metadata auto quick
>  . ./common/filter
>  
>  _require_test
> +_require_chmod
>  _require_mknod
>  
>  rm -f $TEST_DIR/null
> diff --git a/tests/generic/193 b/tests/generic/193
> index ba557428..4e23f33d 100755
> --- a/tests/generic/193
> +++ b/tests/generic/193
> @@ -49,6 +49,7 @@ _filter_files()
>  
>  _require_test
>  _require_user
> +_require_chmod
>  _require_chown
>  
>  test_root=$TEST_DIR/$seq.$$.root
> diff --git a/tests/generic/230 b/tests/generic/230
> index a8caf5a8..793e3a8f 100755
> --- a/tests/generic/230
> +++ b/tests/generic/230
> @@ -17,6 +17,7 @@ _begin_fstest auto quota quick
>  _require_scratch
>  _require_quota
>  _require_user
> +_require_chmod
>  
>  test_files()
>  {
> diff --git a/tests/generic/256 b/tests/generic/256
> index fe8be022..eba2ba32 100755
> --- a/tests/generic/256
> +++ b/tests/generic/256
> @@ -19,6 +19,7 @@ _require_xfs_io_command "fpunch"
>  _require_scratch
>  _require_user
>  _require_test
> +_require_chmod
>  
>  testfile=$TEST_DIR/256.$$
>  
> diff --git a/tests/generic/314 b/tests/generic/314
> index 65f7f9d9..b0fdd567 100755
> --- a/tests/generic/314
> +++ b/tests/generic/314
> @@ -15,6 +15,7 @@ _begin_fstest auto quick perms
>  _require_test
>  _require_user
>  _require_chown
> +_require_chmod
>  _require_sgid_inheritance
>  
>  rm -rf $TEST_DIR/$seq-dir
> diff --git a/tests/generic/317 b/tests/generic/317
> index 1afec6a7..67dcbf91 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -33,6 +33,7 @@ file=$SCRATCH_MNT/file1
>  
>  _require_scratch
>  _require_user
> +_require_chmod
>  _require_ugid_map
>  _require_userns
>  _require_chown
> diff --git a/tests/generic/355 b/tests/generic/355
> index 6b4f7eba..443c17a3 100755
> --- a/tests/generic/355
> +++ b/tests/generic/355
> @@ -14,6 +14,7 @@ _begin_fstest auto quick perms
>  
>  _require_test
>  _require_user
> +_require_chmod
>  _require_odirect
>  _require_chown
>  
> diff --git a/tests/generic/370 b/tests/generic/370
> index b5d942de..1b04eab1 100755
> --- a/tests/generic/370
> +++ b/tests/generic/370
> @@ -23,6 +23,7 @@ _fixed_by_fs_commit btrfs 03018e5d8508 \
>      "btrfs: fix swap file activation failure due to extents that used to be shared"
>  _fixed_by_fs_commit xfs 2d873efd174b "xfs: flush inodegc before swapon"
>  
> +_require_chmod
>  _require_scratch_swapfile
>  _require_scratch_reflink
>  _require_cp_reflink
> diff --git a/tests/generic/375 b/tests/generic/375
> index eb675144..1e2ee334 100755
> --- a/tests/generic/375
> +++ b/tests/generic/375
> @@ -15,6 +15,7 @@ _begin_fstest auto quick acl perms
>  . ./common/attr
>  
>  _require_test
> +_require_chmod
>  _require_runas
>  _require_acls
>  
> diff --git a/tests/generic/378 b/tests/generic/378
> index 5a6bd2b0..7c3a8d93 100755
> --- a/tests/generic/378
> +++ b/tests/generic/378
> @@ -20,6 +20,7 @@ _begin_fstest auto quick metadata
>  
>  _require_test
>  _require_user
> +_require_chmod
>  _require_hardlinks
>  
>  # Setup testfile and its hardlink
> diff --git a/tests/generic/444 b/tests/generic/444
> index 31e0e43e..9094743e 100755
> --- a/tests/generic/444
> +++ b/tests/generic/444
> @@ -15,6 +15,7 @@ _begin_fstest auto quick acl perms
>  . ./common/attr
>  
>  _require_test
> +_require_chmod
>  _require_runas
>  _require_acls
>  
> diff --git a/tests/generic/449 b/tests/generic/449
> index 9cf814ad..370b0db1 100755
> --- a/tests/generic/449
> +++ b/tests/generic/449
> @@ -19,6 +19,7 @@ _begin_fstest auto quick acl attr enospc
>  # Modify as appropriate.
>  _require_scratch
>  _require_test
> +_require_chmod
>  _require_acls
>  _require_attrs trusted
>  
> diff --git a/tests/generic/462 b/tests/generic/462
> index 49b0df40..d886a26e 100755
> --- a/tests/generic/462
> +++ b/tests/generic/462
> @@ -19,6 +19,7 @@ _begin_fstest auto quick dax mmap
>  
>  # Modify as appropriate.
>  _require_test
> +_require_chmod
>  _require_scratch_dax_mountopt "dax"
>  _require_test_program "t_mmap_write_ro"
>  # running by unpriviliged user is not necessary to reproduce
> diff --git a/tests/generic/495 b/tests/generic/495
> index dd18693b..4cc4c646 100755
> --- a/tests/generic/495
> +++ b/tests/generic/495
> @@ -12,6 +12,7 @@ _begin_fstest auto quick swap
>  # Import common functions.
>  . ./common/filter
>  
> +_require_chmod
>  _require_scratch_swapfile
>  _require_test_program mkswap
>  _require_test_program swapon
> diff --git a/tests/generic/514 b/tests/generic/514
> index a2086a25..02537b21 100755
> --- a/tests/generic/514
> +++ b/tests/generic/514
> @@ -15,6 +15,7 @@ _begin_fstest auto quick clone
>  
>  _require_scratch_reflink
>  _require_user
> +_require_chmod
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> diff --git a/tests/generic/535 b/tests/generic/535
> index 9f552ee8..c8e193cc 100755
> --- a/tests/generic/535
> +++ b/tests/generic/535
> @@ -34,6 +34,7 @@ _cleanup()
>  
>  
>  _require_scratch
> +_require_chmod
>  _require_dm_target flakey
>  
>  _scratch_mkfs >/dev/null 2>&1
> diff --git a/tests/generic/572 b/tests/generic/572
> index 80356760..97656c4b 100755
> --- a/tests/generic/572
> +++ b/tests/generic/572
> @@ -27,6 +27,7 @@ _cleanup()
>  . ./common/verity
>  
>  _require_scratch_verity
> +_require_chmod
>  _disable_fsverity_signatures
>  
>  _scratch_mkfs_verity &>> $seqres.full
> diff --git a/tests/generic/573 b/tests/generic/573
> index d3f3296c..3f056b57 100755
> --- a/tests/generic/573
> +++ b/tests/generic/573
> @@ -24,6 +24,7 @@ _cleanup()
>  
>  _require_scratch_verity
>  _require_user
> +_require_chmod
>  _require_chattr ia
>  _disable_fsverity_signatures
>  
> diff --git a/tests/generic/581 b/tests/generic/581
> index 2773c910..b36a1b89 100755
> --- a/tests/generic/581
> +++ b/tests/generic/581
> @@ -29,6 +29,7 @@ _cleanup()
>  . ./common/encrypt
>  
>  _require_user
> +_require_chmod
>  _require_scratch_encryption -v 2
>  
>  _scratch_mkfs_encrypted &>> $seqres.full
> diff --git a/tests/generic/597 b/tests/generic/597
> index b97265fb..62f83cd6 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -27,6 +27,7 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _require_test
> +_require_chmod
>  _require_sysctl_variable fs.protected_symlinks
>  _require_sysctl_variable fs.protected_hardlinks
>  _require_user fsgqa2
> diff --git a/tests/generic/603 b/tests/generic/603
> index 9b5e8245..853d3b16 100755
> --- a/tests/generic/603
> +++ b/tests/generic/603
> @@ -115,6 +115,7 @@ _require_setquota_project
>  _require_quota
>  _require_user
>  _require_group
> +_require_chmod
>  
>  _scratch_mkfs >$seqres.full 2>&1
>  _scratch_enable_pquota
> diff --git a/tests/generic/622 b/tests/generic/622
> index e8ead300..cb0f5828 100755
> --- a/tests/generic/622
> +++ b/tests/generic/622
> @@ -77,6 +77,7 @@ _cleanup()
>  # This test uses the shutdown command, so it has to use the scratch filesystem
>  # rather than the test filesystem.
>  _require_scratch
> +_require_chmod
>  _require_scratch_shutdown
>  _require_metadata_journaling
>  _require_xfs_io_command "pwrite"
> diff --git a/tests/generic/636 b/tests/generic/636
> index 2ae74310..402fc917 100755
> --- a/tests/generic/636
> +++ b/tests/generic/636
> @@ -13,6 +13,7 @@ _begin_fstest auto quick swap
>  # Import common functions.
>  . ./common/filter
>  
> +_require_chmod
>  _require_scratch_swapfile
>  _require_test_program mkswap
>  _require_test_program swapon
> diff --git a/tests/generic/641 b/tests/generic/641
> index a6efcd4c..809204d9 100755
> --- a/tests/generic/641
> +++ b/tests/generic/641
> @@ -15,6 +15,7 @@ _begin_fstest auto quick swap collapse
>  . ./common/filter
>  
>  _require_scratch
> +_require_chmod
>  _require_scratch_swapfile
>  _require_test_program mkswap
>  _require_test_program swapon
> diff --git a/tests/generic/673 b/tests/generic/673
> index 6c54ade8..832fdd72 100755
> --- a/tests/generic/673
> +++ b/tests/generic/673
> @@ -16,6 +16,7 @@ _begin_fstest auto clone quick perms
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_scratch_reflink
>  
>  _scratch_mkfs >> $seqres.full
> diff --git a/tests/generic/674 b/tests/generic/674
> index 41fbdeb7..e5a32782 100755
> --- a/tests/generic/674
> +++ b/tests/generic/674
> @@ -16,6 +16,7 @@ _begin_fstest auto clone quick perms dedupe
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_scratch_dedupe
>  _require_xfs_io_command dedupe
>  
> diff --git a/tests/generic/675 b/tests/generic/675
> index 87dfbdfe..e648182e 100755
> --- a/tests/generic/675
> +++ b/tests/generic/675
> @@ -17,6 +17,7 @@ _begin_fstest auto clone quick
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_scratch_reflink
> diff --git a/tests/generic/682 b/tests/generic/682
> index 6914a549..a3bb42ac 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -23,6 +23,7 @@ _begin_fstest auto quick quota
>  _require_quota
>  _require_user
>  _require_scratch
> +_require_chmod
>  
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _qmount_option usrquota
> diff --git a/tests/generic/683 b/tests/generic/683
> index 883905da..226d2758 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=falloc
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> diff --git a/tests/generic/684 b/tests/generic/684
> index 9cdfe4ab..7595f58a 100755
> --- a/tests/generic/684
> +++ b/tests/generic/684
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=fpunch
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> diff --git a/tests/generic/685 b/tests/generic/685
> index 55672550..aa7fc848 100755
> --- a/tests/generic/685
> +++ b/tests/generic/685
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=fzero
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> diff --git a/tests/generic/686 b/tests/generic/686
> index a3fa8e06..03270a7d 100755
> --- a/tests/generic/686
> +++ b/tests/generic/686
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=finsert
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> diff --git a/tests/generic/687 b/tests/generic/687
> index 0c4b09d2..cd564a7d 100755
> --- a/tests/generic/687
> +++ b/tests/generic/687
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=fcollapse
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> diff --git a/tests/generic/688 b/tests/generic/688
> index 77db2946..1d16261d 100755
> --- a/tests/generic/688
> +++ b/tests/generic/688
> @@ -23,6 +23,7 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command falloc
> diff --git a/tests/generic/698 b/tests/generic/698
> index 0029df90..a0cccfe7 100755
> --- a/tests/generic/698
> +++ b/tests/generic/698
> @@ -26,6 +26,7 @@ _fixed_by_kernel_commit 168f91289340 \
>  	"fs: account for group membership"
>  _require_scratch
>  _require_chown
> +_require_chmod
>  _require_idmapped_mounts
>  _require_test_program "vfs/mount-idmapped"
>  _require_user fsgqa2
> diff --git a/tests/generic/699 b/tests/generic/699
> index 2a6f857d..6e94043f 100755
> --- a/tests/generic/699
> +++ b/tests/generic/699
> @@ -25,6 +25,7 @@ _require_extra_fs overlay
>  
>  _require_scratch
>  _require_chown
> +_require_chmod
>  _require_idmapped_mounts
>  _require_test_program "vfs/mount-idmapped"
>  _require_user fsgqa2
> diff --git a/tests/generic/726 b/tests/generic/726
> index d2a2a2ce..a6c12133 100755
> --- a/tests/generic/726
> +++ b/tests/generic/726
> @@ -23,6 +23,7 @@ _begin_fstest auto fiexchange quick
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_xfs_io_command exchangerange
>  _require_xfs_io_command startupdate
>  _require_scratch
> diff --git a/tests/generic/727 b/tests/generic/727
> index 9551e47c..92d3743c 100755
> --- a/tests/generic/727
> +++ b/tests/generic/727
> @@ -24,6 +24,7 @@ _begin_fstest auto fiexchange quick
>  
>  # Modify as appropriate.
>  _require_user
> +_require_chmod
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command exchangerange
> diff --git a/tests/generic/792 b/tests/generic/792
> index d1896728..c457ad6d 100755
> --- a/tests/generic/792
> +++ b/tests/generic/792
> @@ -22,6 +22,7 @@ _cleanup()
>  . ./common/dmflakey
>  
>  _require_scratch
> +_require_chmod
>  _require_test_program unlink-fsync
>  _require_dm_target flakey
>  
> -- 
> 2.55.0
> 
> 
