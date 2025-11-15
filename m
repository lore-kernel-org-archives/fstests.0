Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3ED1F4615
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763190675; cv=none; b=jW/5wdSYaKl3fXhiLNHsnoHJaYmjiDeRO3zW0enGOxc/ftwzyAeJ+J4kP5uVaTg3UkzEfjQ5s+WKfHEtrndc8uEcgNLzmAdsTQvwpA7xwhDFSGgO59+Fe6axEEx0ENxx5SUEMmK4V8dkOB/AXbKLl1tqbEi91jCyiW6nA3zfjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763190675; c=relaxed/simple;
	bh=aZAHaoZ/Hza5sPbuD7vfNC/twcHmuKC/xfYLz9eQCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwi9w+HGS6jUFaZix6Q+qN9A+J58FJMJGgZDaXGXRfIiLHPlYdVLCuAYTDxj+6iTnnnCx1AqUwvuCKBqQve5z3Spyi/aTlznUe/Nr7vsKWBW7SOOPlWOlfqyPUIIvCSnYZkrPLkXJZ0Gef9RtH7Kg+7W7yidiaQ9FbVYhWsfoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOYg1ucv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l9Jc4o7p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOYg1ucv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l9Jc4o7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763190671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kxEM+rxM+ILX5NBxAWsY2j8Vql4si0Yh/cjGJjlRTY=;
	b=FOYg1ucvOIqrkdnDhcyq0NbU7QFfA+Fa2bgjcZtTV+Ki4sqnu10Q/79urEfLYsXKs4fDSH
	7C/Ldqnk7RC0w7uKfayO/9bK2zau/trg+n9i6gF6JDA7jIcRHouy0KNeNVtpZbGFfqKP60
	AB7PJ2W2oN9om1vKBOwGbUA3PhAiWlg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-sPJj1qgJNoe4VU50pgwB9A-1; Sat, 15 Nov 2025 02:11:09 -0500
X-MC-Unique: sPJj1qgJNoe4VU50pgwB9A-1
X-Mimecast-MFC-AGG-ID: sPJj1qgJNoe4VU50pgwB9A_1763190669
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34378c914b4so4654082a91.1
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 23:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763190669; x=1763795469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3kxEM+rxM+ILX5NBxAWsY2j8Vql4si0Yh/cjGJjlRTY=;
        b=l9Jc4o7pCS6xBo0uapTrNXj1s4UiUou8ZutLQ5oOuh9M3Mm/DSrHVIAzm5nZCMEcrA
         SaCT4GknHPD3k9qdKuZxsj2Jyc5vmIs6MQONijhkn+m3KfNu3nqKlUjiAVMc4JmJuxdM
         N8jvMCfnipPuI0iLT91W8cFa8eJ8S5rSc2YLJvdPiWun06lQwx0jLCav+Md50tYMp6N0
         lk/pyVFdSxpMYF07ppW9l0b1AWBrlJYk1uawa/4SmGLaCZ3l7b0rOf3w0jw3vuOD1GDl
         RyBlnDJtKKKXZ3ZkLrIwKyQ8lwG3/dy/mRgqPhjJjttEYErXnVLwIWLhZKWnGK0Ss10h
         z0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763190669; x=1763795469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kxEM+rxM+ILX5NBxAWsY2j8Vql4si0Yh/cjGJjlRTY=;
        b=L6Ce4yZH8XErJBpehrzu7s8lQixKUMnHT6Ewno+W/DSkwfQhOWT/ozud2J54pTdV+N
         yltldyR0Q+cTZzLTYJ5fq3wfaKnGqE4Mu3IvDlrdoYh98WF+K7p+Tf13TGsVfRApQg0P
         YWABsuNrJDFAEqCUxOeNkPhHYJS7RZqKygGGhV3PLRkDOycnK3clT/noVHzJOyD0INbc
         eaT3y40V7nl6SMzbCBLwwLQ0/jgeWnyVJb1v2ArXGRvFoGX/i+Il6kJrTTJ564ykXE11
         FjYeD1s6UvP7bqWQh3z4kgbE8bCegsN3TVIWK/hEi64Sz1QRnIvIdDker80wVh0S24kr
         U07g==
X-Forwarded-Encrypted: i=1; AJvYcCUiF1I3peK5lhpj/HHVjAoz/obYX5La8u8x5ZULR7scfkkhH2VLjUrqoBNT3kMlr4md1/bZU3Hc@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEpi0aV6SjwZl/B+P0LCFclqjTpkROrQ9ZOyQl9tmijgBJGr6
	NBim4HVa4rct3ZwyskloTsZJy+9SU7NOrCooCUtPnRBCpNWytleeGTID77LDZarxwpYuSkBap0d
	00MDUpzgvzLVrwLctXXKpOAFQ3GFOCYslVHk1z5WQotkFJfw8lPAC27KedU0=
X-Gm-Gg: ASbGncurFkvNmwjsZLp1YQfjKRdUn9l/w6zPHswqn1NNhfp1o4HDwJTL8dR6f0Efcf9
	69zIpAUo4q49g3SlSeKn/Daa+9d9dlMTjqSEKhsOeYAzMOze+VTeAd88Zn6jYMl+4VA/ADcRXTn
	v7HA87p/c0kHbszIBhXmMiK0PtaY31zzWFVMaG3HDcM0iaEyQVaXHiyxnCPj+Uho6zK2UI9U2lR
	CW5eduEJQ2X2OE11lR67mxgqApnJfUokDGNYAtM4+1lYCA/LnEI1lmcw8R+qwYbgQpUj74rvBSl
	Low6RnmkyFrytWnSFHaRvvg+pC+6CDrbgQkvkFDMMy4OsJie/kY4xw5nXRGVEq5SQ8ba2NXHrlA
	qLNQOev/4W7MXCKwPslGoEGc0WzfF7alHLgoyIZUtkhSXPPtaaw==
X-Received: by 2002:a17:90b:1d43:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-343f9e906d0mr6550310a91.4.1763190668666;
        Fri, 14 Nov 2025 23:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG/QUwy31mBdY/Czc4In3AH4dGm3tfdN//D8XClqCeFEZ7rH93TTAXIu9TDEX1tB5kJBH+Ig==
X-Received: by 2002:a17:90b:1d43:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-343f9e906d0mr6550288a91.4.1763190668163;
        Fri, 14 Nov 2025 23:11:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07952f8sm11419937a91.9.2025.11.14.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 23:11:07 -0800 (PST)
Date: Sat, 15 Nov 2025 15:11:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] overlay: add tests for casefolded layers
Message-ID: <20251115071102.pelohvzihg4aafse@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251114194852.1344740-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251114194852.1344740-1-amir73il@gmail.com>

On Fri, Nov 14, 2025 at 08:48:52PM +0100, Amir Goldstein wrote:
> Overalyfs did not allow mounting layers with casefold capable fs
> until kernel v6.17 and did not allow casefold enabled layers
> until kernel v6.18.
> 
> Since kernel v6.18, overalyfs allows this kind of setups,
> as long as the layers have consistent encoding and all the directories
> in the subtree have consistent casefolding.
> 
> Create test cases for the following scenarios:
> - Mounting overlayfs with casefold disabled
> - Mounting overlayfs with casefold enabled
> - Lookup subdir in overlayfs with mismatch casefold to parent dir
> - Change casefold of underlying subdir while overalyfs is mounted
> - Mounting overlayfs with strict enconding, but casefold disabled
> - Mounting overlayfs with strict enconding casefold enabled
> - Mounting overlayfs with layers with inconsistent UTF8 version
> 
> Co-developed-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi Zorro,
> 
> I fixed the bug you found with tmpfs.
> 
> Please note that I did not assign a sequential test number because
> I wanted to let you assign a non conflicting number when you merge it.

Thanks Amir :) This version looks good to me, just one question below...

> 
> Thanks,
> Amir.
> 
> Chages since v1:
> - Fix test run with tmpfs (needed _scratch_mount_casefold_strict)
> - unmount MNT1/MNT2 in cleanup
> - Use _mount _unmount helpers
> 
>  tests/generic/999     | 242 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  13 +++
>  2 files changed, 255 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..c315b8ba
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,242 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 CTERA Networks. All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Test overlayfs error cases with casefold enabled layers
> +#
> +# Overalyfs did not allow mounting layers with casefold capable fs
> +# until kernel v6.17 and with casefold enabled until kernel v6.18.
> +# Since kernel v6.17, overalyfs allows the mount, as long as casefolding
> +# is disabled on all directories.
> +# Since kernel v6.18, overalyfs allows the mount, as long as casefolding
> +# is consistent on all directories and encoding is consistent on all layers.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount casefold
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	_unmount $merge 2>/dev/null
> +	_unmount $MNT1 2>/dev/null
> +	_unmount $MNT2 2>/dev/null

... I saw you mount $MNT1 and $MNT2 at first, then mount $merge:

  mount_casefold_version "utf8-12.1.0" $MNT1
  mount_casefold_version "utf8-11.0.0" $MNT2
  ...
  mount_overlay $lowerdir (which mount on $merge)

So I think unmount $merge after umount $MNT1 and $MNT2 might (looks)
make more sense, although I saw you've tried to do unmount_overlay
before _cleanup :)

I can help to make this change when I merge it, if you agree. Others
are good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +	rm -r -f $tmp.*
> +}
> +
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/casefold
> +
> +_exclude_fs overlay
> +_require_extra_fs overlay
> +
> +_require_scratch_casefold
> +
> +# Create casefold capable base fs
> +_scratch_mkfs_casefold >>$seqres.full 2>&1
> +_scratch_mount_casefold
> +
> +# Create lowerdir, upperdir and workdir without casefold enabled
> +lowerdir="$SCRATCH_MNT/ovl-lower"
> +upperdir="$SCRATCH_MNT/ovl-upper"
> +workdir="$SCRATCH_MNT/ovl-work"
> +merge="$SCRATCH_MNT/ovl-merge"
> +
> +mount_casefold_version()
> +{
> +	option="casefold=$1"
> +	_mount -t tmpfs -o $option tmpfs $2
> +}
> +
> +mount_overlay()
> +{
> +	local lowerdirs=$1
> +
> +	_mount -t overlay overlay $merge \
> +		-o lowerdir=$lowerdirs,upperdir=$upperdir,workdir=$workdir
> +}
> +
> +unmount_overlay()
> +{
> +	_unmount $merge 2>/dev/null
> +}
> +
> +# Try to mount an overlay with casefold enabled layers.
> +# On kernels older than v6.18 expect failure and skip the test
> +mkdir -p $merge $upperdir $workdir $lowerdir
> +_casefold_set_attr $upperdir >>$seqres.full
> +_casefold_set_attr $workdir >>$seqres.full
> +_casefold_set_attr $lowerdir >>$seqres.full
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	_notrun "overlayfs does not support casefold enabled layers"
> +unmount_overlay
> +
> +# Re-create casefold disabled layers with lower subdir
> +casefolddir=$lowerdir/casefold
> +rm -rf $upperdir $workdir $lowerdir
> +mkdir -p $upperdir $workdir $lowerdir $casefolddir
> +
> +# Try to mount an overlay with casefold capable but disabled layers.
> +# Since we already verified that overalyfs supports casefold enabled layers
> +# this is expected to succeed.
> +echo Casefold disabled
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	echo "Overlayfs mount with casefold disabled layers failed (1)"
> +ls $merge/casefold/ >>$seqres.full
> +unmount_overlay
> +
> +# Use new upper/work dirs for each test to avoid ESTALE errors
> +# on mismatch lowerdir/upperdir (see test overlay/037)
> +rm -rf $upperdir $workdir
> +mkdir $upperdir $workdir
> +
> +# Try to mount an overlay with casefold disabled layers and
> +# enable casefold on lowerdir root after mount - expect ESTALE error on lookup.
> +echo Casefold enabled after mount
> +mount_overlay $casefolddir >>$seqres.full || \
> +	echo "Overlayfs mount with casefold disabled layers failed (2)"
> +_casefold_set_attr $casefolddir >>$seqres.full
> +mkdir $casefolddir/subdir
> +ls $merge/subdir |& _filter_scratch
> +unmount_overlay
> +
> +# Try to mount an overlay with casefold enabled lowerdir root - expect EINVAL.
> +# With libmount version >= v1.39, we expect the following descriptive error:
> +# mount: overlay: case-insensitive directory on .../ovl-lower/casefold not supported
> +# but we want the test to run with older libmount, so we so not expect this output
> +# we just expect a mount failure.
> +echo Casefold enabled lower dir
> +mount_overlay $casefolddir >>$seqres.full 2>&1 && \
> +	echo "Overlayfs mount with casefold enabled lowerdir should have failed" && \
> +	unmount_overlay
> +
> +# Changing lower layer root again
> +rm -rf $upperdir $workdir
> +mkdir $upperdir $workdir
> +
> +# Try to mount an overlay with casefold disabled layers, but with
> +# casefold enabled subdir in lowerdir - expect EREMOTE error on lookup.
> +echo Casefold enabled lower subdir
> +mount_overlay $lowerdir >>$seqres.full
> +ls $merge/casefold/subdir |& _filter_scratch
> +unmount_overlay
> +
> +# workdir needs to be empty to set casefold attribute
> +rm -rf $workdir/*
> +
> +_casefold_set_attr $upperdir >>$seqres.full
> +_casefold_set_attr $workdir >>$seqres.full
> +
> +echo Casefold enabled upper dir
> +mount_overlay $lowerdir >>$seqres.full 2>&1 && \
> +	echo "Overlayfs mount with casefold enabled upperdir should have failed" && \
> +	unmount_overlay
> +
> +# lowerdir needs to be empty to set casefold attribute
> +rm -rf $lowerdir/*
> +_casefold_set_attr $lowerdir >>$seqres.full
> +mkdir $casefolddir
> +
> +# Try to mount an overlay with casefold enabled layers.
> +# On kernels older than v6.18 expect failure and skip the rest of the test
> +# On kernels v6.18 and newer, expect success and run the rest of the test cases.
> +echo Casefold enabled
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	echo "Overlayfs mount with casefold enabled layers failed (1)"
> +ls $merge/casefold/ >>$seqres.full
> +unmount_overlay
> +
> +# Try to mount an overlayfs with casefold enabled layers. After the mount,
> +# disable casefold on the lower layer and try to lookup a file. Should return
> +# -ESTALE
> +echo Casefold disabled on lower after mount
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	echo "Overlayfs mount with casefold enabled layers failed (2)"
> +rm -rf $lowerdir/*
> +_casefold_unset_attr $lowerdir >>$seqres.full
> +mkdir $lowerdir/dir
> +ls $merge/dir/ |& _filter_scratch
> +unmount_overlay
> +
> +# cleanup
> +rm -rf $lowerdir/*
> +_casefold_set_attr $lowerdir >>$seqres.full
> +
> +# Try to mount an overlayfs with casefold enabled layers. After the mount,
> +# disable casefold on a subdir in  the lower layer and try to lookup it.
> +# Should return -EREMOTE
> +echo Casefold disabled on subdir after mount
> +mkdir $lowerdir/casefold/
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	echo "Overlayfs mount with casefold enabled layers failed (3)"
> +_casefold_unset_attr $lowerdir/casefold/
> +mkdir $lowerdir/casefold/subdir
> +ls $merge/casefold/subdir |& _filter_scratch
> +unmount_overlay
> +
> +# cleanup
> +rm -rf $lowerdir/*
> +
> +# Test strict enconding, but casefold not enabled. Should work
> +_scratch_umount_idmapped
> +
> +_scratch_mkfs_casefold_strict >>$seqres.full 2>&1
> +_scratch_mount_casefold_strict
> +
> +mkdir -p $merge $upperdir $workdir $lowerdir
> +
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	echo "Overlayfs mount with strict casefold disabled layers failed"
> +unmount_overlay
> +
> +# Test strict enconding, with casefold enabled. Should fail
> +# dmesg: overlayfs: strict encoding not supported
> +rm -rf $upperdir $workdir
> +mkdir $upperdir $workdir
> +
> +_casefold_set_attr $upperdir >>$seqres.full
> +_casefold_set_attr $workdir >>$seqres.full
> +_casefold_set_attr $lowerdir >>$seqres.full
> +
> +mount_overlay $lowerdir >>$seqres.full 2>&1 && \
> +	echo "Overlayfs mount with strict casefold enabled should have failed" && \
> +	unmount_overlay
> +
> +# Test inconsistent casefold version. Should fail
> +# dmesg: overlayfs: all layers must have the same encoding
> +
> +# use tmpfs to make easier to create two different mount points with different
> +# utf8 versions
> +testdir="$SCRATCH_MNT/newdir/"
> +mkdir $testdir
> +
> +MNT1="$testdir/mnt1"
> +MNT2="$testdir/mnt2"
> +
> +mkdir $MNT1 $MNT2 "$testdir/merge"
> +
> +mount_casefold_version "utf8-12.1.0" $MNT1
> +mount_casefold_version "utf8-11.0.0" $MNT2
> +
> +mkdir "$MNT1/dir" "$MNT2/dir"
> +
> +_casefold_set_attr "$MNT1/dir"
> +_casefold_set_attr "$MNT2/dir"
> +
> +mkdir "$MNT1/dir/lower" "$MNT2/dir/upper" "$MNT2/dir/work"
> +
> +upperdir="$MNT2/dir/upper"
> +workdir="$MNT2/dir/work"
> +lowerdir="$MNT1/dir/lower"
> +
> +mount_overlay $lowerdir >>$seqres.full 2>&1  && \
> +	echo "Overlayfs mount different unicode versions should have failed" && \
> +	unmount_overlay
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..ce383d94
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,13 @@
> +QA output created by 999
> +Casefold disabled
> +Casefold enabled after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/subdir': Stale file handle
> +Casefold enabled lower dir
> +Casefold enabled lower subdir
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
> +Casefold enabled upper dir
> +Casefold enabled
> +Casefold disabled on lower after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/dir/': Stale file handle
> +Casefold disabled on subdir after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
> -- 
> 2.51.1
> 

