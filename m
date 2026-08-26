Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECA455175
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766736; cv=none; b=S3HLW3tuGMtsMl1PO/tAPlrz4yTpd44zSkFdPuajndEV0V8qQG0spNEQZXkUWAzm5Swrx7d5GwTD0VGqSAXJstKV12CEGANPHe7Kh7dmbiP58B/NuWkS33a4gZh1DrKf+xV9DO9Q1Ll/Ud42UDkV1kHb3HGFgHmogZz2R5BxeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766736; c=relaxed/simple;
	bh=DNGH0zrnlS4DjLvWpSz6eRZNRhoHtnSyecHUeJe3PHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnVfWC4+FDsS3n9haaOO5MottOeDGcrnVNz+4GeKlj5orkQiILIfkRgY/V98/r1MEbXdTPSFgX7tmqdAJzV5J4alniOt02Or891xMwK2zNBQrMBOmcAjULaz0h0wabk9SMTEur7c9Nrif7Psypbk9lsfOkpVIR8O9IDGvKyFOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdDBFsAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdDBFsAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CE41F000E9;
	Wed, 26 Aug 2026 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766725;
	bh=rNqJi1tRBFaK/b+VO0t52kafxQBdp5Z92ZtvWPwT3b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SdDBFsAwJLqeFs/X2Zv7EaNcMVza1WpTjvPzM6+IJMhj2E9m6N8ZTXl0k8An1h+iy
	 Rpn9gLwUpRDwTDL/EdjBqv+yM7e1y9zvUpIOS4qTjwXV3xhuKWPM1Y0rrITDDzeho7
	 0bftQz+a5ardXcwBMO5szIkfpWhSkUstlFY+cSYVne6hmg6ZISOf8N+W0qYZefsa1r
	 93yEDS4rSx4mW15el0UR2QgoVaDwprv9CL/4qYv+AV3SzB8nxmTh/vZyoVruH1CoPN
	 OC86QuwRPsMBl2b9pGOS6695r1pxlU4AiKGXT8cB52o5CxTWpzp+DbYQmELn4rcGOs
	 2/KX0a2lbyUKA==
Date: Thu, 27 Aug 2026 01:52:00 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] Add _require_chown as needed
Message-ID: <ao8dOPXMBJtSbTXv@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-4-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825001337.449670-4-sandeen@redhat.com>

On Mon, Aug 24, 2026 at 07:11:10PM -0500, Eric Sandeen wrote:
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

I doubt there's any filesystem that supports `chmod` but not `chown`.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/093 | 1 +
>  tests/generic/099 | 1 +
>  tests/generic/105 | 1 +
>  tests/generic/219 | 1 +
>  tests/generic/230 | 1 +
>  tests/generic/235 | 1 +
>  tests/generic/237 | 1 +
>  tests/generic/244 | 1 +
>  tests/generic/305 | 1 +
>  tests/generic/318 | 1 +
>  tests/generic/326 | 1 +
>  tests/generic/327 | 1 +
>  tests/generic/328 | 1 +
>  tests/generic/375 | 1 +
>  tests/generic/379 | 1 +
>  tests/generic/380 | 1 +
>  tests/generic/400 | 1 +
>  tests/generic/444 | 1 +
>  tests/generic/462 | 1 +
>  tests/generic/505 | 1 +
>  tests/generic/566 | 1 +
>  tests/generic/572 | 1 +
>  tests/generic/587 | 1 +
>  tests/generic/597 | 1 +
>  tests/generic/598 | 1 +
>  tests/generic/603 | 1 +
>  tests/generic/681 | 1 +
>  tests/generic/682 | 1 +
>  tests/generic/709 | 1 +
>  tests/generic/710 | 1 +
>  tests/generic/721 | 1 +
>  31 files changed, 31 insertions(+)
> 
> diff --git a/tests/generic/093 b/tests/generic/093
> index 9c3c855b..e1291019 100755
> --- a/tests/generic/093
> +++ b/tests/generic/093
> @@ -29,6 +29,7 @@ filefilter()
>  _require_test
>  _require_attrs security
>  _require_user
> +_require_chown
>  _require_chmod
>  _require_test_program "writemod"
>  _require_command "$SETCAP_PROG" "setcap"
> diff --git a/tests/generic/099 b/tests/generic/099
> index cf54e96b..40b795e1 100755
> --- a/tests/generic/099
> +++ b/tests/generic/099
> @@ -48,6 +48,7 @@ _cleanup()
>  
>  _require_test
>  _require_chmod
> +_require_chown
>  _require_runas
>  
>  _acl_setup_ids
> diff --git a/tests/generic/105 b/tests/generic/105
> index a74dc726..180e7418 100755
> --- a/tests/generic/105
> +++ b/tests/generic/105
> @@ -26,6 +26,7 @@ _cleanup()
>  
>  
>  _require_scratch
> +_require_chown
>  _require_acls
>  
>  _acl_setup_ids
> diff --git a/tests/generic/219 b/tests/generic/219
> index 64282385..7c47762e 100755
> --- a/tests/generic/219
> +++ b/tests/generic/219
> @@ -17,6 +17,7 @@ _begin_fstest auto quota quick mmap
>  _require_scratch
>  _require_quota
>  _require_user
> +_require_chown
>  _require_group
>  _require_odirect
>  
> diff --git a/tests/generic/230 b/tests/generic/230
> index 793e3a8f..05eb9024 100755
> --- a/tests/generic/230
> +++ b/tests/generic/230
> @@ -17,6 +17,7 @@ _begin_fstest auto quota quick
>  _require_scratch
>  _require_quota
>  _require_user
> +_require_chown
>  _require_chmod
>  
>  test_files()
> diff --git a/tests/generic/235 b/tests/generic/235
> index 037c29e8..c880c620 100755
> --- a/tests/generic/235
> +++ b/tests/generic/235
> @@ -17,6 +17,7 @@ _begin_fstest auto quota quick
>  _require_scratch
>  _require_quota
>  _require_user
> +_require_chown
>  
>  do_repquota()
>  {
> diff --git a/tests/generic/237 b/tests/generic/237
> index 266b3d69..2c686dee 100755
> --- a/tests/generic/237
> +++ b/tests/generic/237
> @@ -25,6 +25,7 @@ _cleanup()
>  # only Linux supports fallocate
>  _require_test
>  _require_runas
> +_require_chown
>  
>  _acl_setup_ids
>  _require_acls
> diff --git a/tests/generic/244 b/tests/generic/244
> index b6803512..c508f01b 100755
> --- a/tests/generic/244
> +++ b/tests/generic/244
> @@ -26,6 +26,7 @@ _cleanup()
>  
>  _require_quota
>  _require_scratch
> +_require_chown
>  
>  _scratch_mkfs >> $seqres.full 2>&1
>  
> diff --git a/tests/generic/305 b/tests/generic/305
> index 373abf57..04c0f223 100755
> --- a/tests/generic/305
> +++ b/tests/generic/305
> @@ -21,6 +21,7 @@ _require_xfs_io_command "fiemap"
>  _require_quota
>  _require_nobody
>  _require_user
> +_require_chown
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/318 b/tests/generic/318
> index 033c0611..0c5c19c8 100755
> --- a/tests/generic/318
> +++ b/tests/generic/318
> @@ -34,6 +34,7 @@ file=$SCRATCH_MNT/file1
>  _require_scratch
>  _acl_setup_ids
>  _require_acls
> +_require_chown
>  _require_ugid_map
>  _require_userns
>  ns_acl1=0
> diff --git a/tests/generic/326 b/tests/generic/326
> index d16e95aa..3fc04143 100755
> --- a/tests/generic/326
> +++ b/tests/generic/326
> @@ -22,6 +22,7 @@ _require_quota
>  _require_nobody
>  _require_odirect
>  _require_user
> +_require_chown
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/327 b/tests/generic/327
> index 9102cbd6..2fffacab 100755
> --- a/tests/generic/327
> +++ b/tests/generic/327
> @@ -20,6 +20,7 @@ _require_xfs_io_command "fiemap"
>  _require_quota
>  _require_nobody
>  _require_user
> +_require_chown
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/328 b/tests/generic/328
> index db785475..27160ec2 100755
> --- a/tests/generic/328
> +++ b/tests/generic/328
> @@ -21,6 +21,7 @@ _require_quota
>  _require_nobody
>  _require_odirect
>  _require_user
> +_require_chown
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/375 b/tests/generic/375
> index 1e2ee334..81d3de22 100755
> --- a/tests/generic/375
> +++ b/tests/generic/375
> @@ -16,6 +16,7 @@ _begin_fstest auto quick acl perms
>  
>  _require_test
>  _require_chmod
> +_require_chown
>  _require_runas
>  _require_acls
>  
> diff --git a/tests/generic/379 b/tests/generic/379
> index 9e5889b9..28d004fe 100755
> --- a/tests/generic/379
> +++ b/tests/generic/379
> @@ -23,6 +23,7 @@ _cleanup()
>  
>  
>  _require_scratch
> +_require_chown
>  _require_quota
>  _require_xfs_quota_foreign
>  
> diff --git a/tests/generic/380 b/tests/generic/380
> index 8d772a96..0a619768 100755
> --- a/tests/generic/380
> +++ b/tests/generic/380
> @@ -19,6 +19,7 @@ _begin_fstest quota auto quick
>  # Modify as appropriate.
>  
>  _require_scratch
> +_require_chown
>  _require_quota
>  _require_xfs_quota_foreign
>  
> diff --git a/tests/generic/400 b/tests/generic/400
> index 77970da6..48d54f65 100755
> --- a/tests/generic/400
> +++ b/tests/generic/400
> @@ -19,6 +19,7 @@ _begin_fstest auto quick quota
>  
>  _require_quota
>  _require_scratch
> +_require_chown
>  
>  _scratch_mkfs >> $seqres.full 2>&1
>  
> diff --git a/tests/generic/444 b/tests/generic/444
> index 9094743e..1018e85d 100755
> --- a/tests/generic/444
> +++ b/tests/generic/444
> @@ -16,6 +16,7 @@ _begin_fstest auto quick acl perms
>  
>  _require_test
>  _require_chmod
> +_require_chown
>  _require_runas
>  _require_acls
>  
> diff --git a/tests/generic/462 b/tests/generic/462
> index d886a26e..0dc0d98b 100755
> --- a/tests/generic/462
> +++ b/tests/generic/462
> @@ -20,6 +20,7 @@ _begin_fstest auto quick dax mmap
>  # Modify as appropriate.
>  _require_test
>  _require_chmod
> +_require_chown
>  _require_scratch_dax_mountopt "dax"
>  _require_test_program "t_mmap_write_ro"
>  # running by unpriviliged user is not necessary to reproduce
> diff --git a/tests/generic/505 b/tests/generic/505
> index eb44573b..ca815d42 100755
> --- a/tests/generic/505
> +++ b/tests/generic/505
> @@ -25,6 +25,7 @@ _begin_fstest shutdown auto quick metadata
>  
>  
>  _require_scratch
> +_require_chown
>  _require_scratch_shutdown
>  
>  _scratch_mkfs >/dev/null 2>&1
> diff --git a/tests/generic/566 b/tests/generic/566
> index a6ec82fd..87db8095 100755
> --- a/tests/generic/566
> +++ b/tests/generic/566
> @@ -27,6 +27,7 @@ _require_scratch
>  _require_quota
>  _require_xfs_quota_foreign
>  _require_user
> +_require_chown
>  
>  _qmount_option "grpquota"
>  _scratch_mkfs > $seqres.full
> diff --git a/tests/generic/572 b/tests/generic/572
> index 97656c4b..c3059eb2 100755
> --- a/tests/generic/572
> +++ b/tests/generic/572
> @@ -28,6 +28,7 @@ _cleanup()
>  
>  _require_scratch_verity
>  _require_chmod
> +_require_chown
>  _disable_fsverity_signatures
>  
>  _scratch_mkfs_verity &>> $seqres.full
> diff --git a/tests/generic/587 b/tests/generic/587
> index 49fcade7..c252dab7 100755
> --- a/tests/generic/587
> +++ b/tests/generic/587
> @@ -20,6 +20,7 @@ _begin_fstest auto quick rw prealloc quota
>  . ./common/quota
>  
>  _require_user
> +_require_chown
>  _require_quota
>  _require_xfs_io_command "falloc"
>  _require_scratch
> diff --git a/tests/generic/597 b/tests/generic/597
> index 62f83cd6..3aef67a1 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -28,6 +28,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_test
>  _require_chmod
> +_require_chown
>  _require_sysctl_variable fs.protected_symlinks
>  _require_sysctl_variable fs.protected_hardlinks
>  _require_user fsgqa2
> diff --git a/tests/generic/598 b/tests/generic/598
> index 5b9db69e..52541b3e 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -35,6 +35,7 @@ _require_group fsgqa2
>  _require_user fsgqa
>  _require_group fsgqa
>  _require_chmod
> +_require_chown
>  
>  USER1=fsgqa2
>  USER2=fsgqa
> diff --git a/tests/generic/603 b/tests/generic/603
> index 853d3b16..bb0fb4a7 100755
> --- a/tests/generic/603
> +++ b/tests/generic/603
> @@ -116,6 +116,7 @@ _require_quota
>  _require_user
>  _require_group
>  _require_chmod
> +_require_chown
>  
>  _scratch_mkfs >$seqres.full 2>&1
>  _scratch_enable_pquota
> diff --git a/tests/generic/681 b/tests/generic/681
> index dc425201..651ee157 100755
> --- a/tests/generic/681
> +++ b/tests/generic/681
> @@ -23,6 +23,7 @@ _begin_fstest auto quick quota
>  _require_quota
>  _require_user
>  _require_scratch
> +_require_chown
>  
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _qmount_option usrquota
> diff --git a/tests/generic/682 b/tests/generic/682
> index a3bb42ac..80846463 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -24,6 +24,7 @@ _require_quota
>  _require_user
>  _require_scratch
>  _require_chmod
> +_require_chown
>  
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _qmount_option usrquota
> diff --git a/tests/generic/709 b/tests/generic/709
> index e3994d00..04460556 100755
> --- a/tests/generic/709
> +++ b/tests/generic/709
> @@ -15,6 +15,7 @@ _begin_fstest auto quick fiexchange quota
>  
>  _require_xfs_io_command exchangerange
>  _require_user
> +_require_chown
>  _require_nobody
>  _require_quota
>  _require_xfs_quota
> diff --git a/tests/generic/710 b/tests/generic/710
> index 16f7276d..488c6751 100755
> --- a/tests/generic/710
> +++ b/tests/generic/710
> @@ -15,6 +15,7 @@ _begin_fstest auto quick fiexchange quota
>  
>  _require_xfs_io_command exchangerange
>  _require_user
> +_require_chown
>  _require_nobody
>  _require_quota
>  _require_xfs_quota
> diff --git a/tests/generic/721 b/tests/generic/721
> index 75d5063c..fb4eb489 100755
> --- a/tests/generic/721
> +++ b/tests/generic/721
> @@ -25,6 +25,7 @@ _require_xfs_io_command startupdate
>  _require_test_reflink
>  _require_test
>  _require_user
> +_require_chown
>  
>  filesnap() {
>  	echo "$1"
> -- 
> 2.55.0
> 
> 
