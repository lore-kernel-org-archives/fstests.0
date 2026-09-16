Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA71448382
	for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544229; cv=pass; b=SuszH8tCfZ4ONLXja/3REUGMLLRioMvJXqNnzH6bRPgdKwNAF9Waz1nMRXF1hX1fdJ+vTWcdD7VEwNZYTxgDjwddcxjWkogsjQmMwzJUWz2tKDm9sjLVvIKrZL5fn8wadLB+0gFNSgsB7pjJnMC2PB65ra7Npdx6NCfO3gKbdGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544229; c=relaxed/simple;
	bh=XDvwmq2vS+N8cMi9XBqt4ebBuqRz92ju3VeHuXNf3Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXv/FV420dXtrmQKE6JSUdiDFeCDuavMxI98UTMzAcAYoGscZAYZNIkG5NMmtI2BDInGQ9NRhKs8/VDvA9V9aN2OdJ9Ndc6YkFSJ4MD6pUXnKPTU7CO9I0LVEmxZEQv3Wp6FDAH1eYPqOLxk60ae3IvG4qUOH0iMB8y3dkS+RE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0HVwO42; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0HVwO42"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so92799066b.0
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 00:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789544213; cv=none;
        d=google.com; s=arc-20260327;
        b=hQyYjGLgVqmOGBZmRCFBihveMiri+gc5m/SnUdvoAISqtf8LxvSBZoW5BC9hWKciow
         MKZQqstfhzRHFMwl+38MtDQdCpmgzPCzPbzYVUaJx9WcizkqlAfhiBRuzF48RzksSMgz
         5S9G7X2DTkQPV/ngxLgjdLCmql1ysoqdvMWawtPyyNh1aJr4QgOUiro4hOJj1591ZJbV
         +vkPz0Hsbv/fQRaoQs+ASLb4TWU9cQvXt0buBAm6doABFtkIUewt9nQKCEUUgvYMsMcJ
         wmXWdQLW23t2DTX0CmyvO6URjkS1kca3JI1Ddrc1bvcp5JUt/Wck4vXNwusBXjy8COJG
         0PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hbOtejfCRE1ecl2pzaBt9XM5QkQmHMG/TxSZvn7HqSg=;
        fh=eW8f3VYcB8wgxVAJ8YhHCa1ZUrGHqjIiaoLmujEtgG0=;
        b=Yz23GFtdqyFDm1E18RItTXu6xtkdM4VdCoQGsEqbp4ymUZV48MjFrl+Emh5Ueks9+T
         kqtIuwvSynoMbDqCFjhyvUXjRajSAiQa0Pgi4NqRIZCI4Q7kYo5cnfXIRUglto3/Yu18
         DQ0kFJDECwXB20JM1sORKaFnp73j1kGLaSLdpKZfpVvlDLDM/XMA83ba3bduoLnw3EVS
         ZzVyMfxQ/CIuxd9oaOLFM+8V6IhV1sJsd/0dga2UDs7HZsP7B4WNokaeR0X7x4rgdi57
         moaFryVFQyy/HFRxXHrRUdcDaoP54R9CCjPWky+GrWgjDYKLxzECqM7ckxmomZnXfVLN
         LkkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544213; x=1790149013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hbOtejfCRE1ecl2pzaBt9XM5QkQmHMG/TxSZvn7HqSg=;
        b=m0HVwO42CAreuoieFL+lsY+AWYzgi5rOcXTSNW7EXkaJN9EjFDMfzOwzN9MIRj7CJH
         glvmqrEoqln5qP342FISRP80/K7pGCTnCcHm/fad7FlLoN0YGavuW2EclHt26PMsuwlZ
         r88azQkz+PGdRZLKr0NHiPC8nRchCPC3vx+EVTXL2AzW3F3DyTeTIls2OWcdkkyhQqw8
         X9OPKl+nBdFV1iyORI2BcnTD9TFnNcHbXZY29M64ns4pb3ciPKkEyXCLvECPoelDZ90x
         8ApS+TcZYPf92CESJLkeJCfQ9ON0C66XnmIX6n9agT3KoryMYJ9f6a7gu8F548na9gMf
         FpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544213; x=1790149013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbOtejfCRE1ecl2pzaBt9XM5QkQmHMG/TxSZvn7HqSg=;
        b=jQvkxiGScIlO0tuJ0QF/XFCXRDu5fe8wjt5GR00bq9WaRuLphAPHx0ttvzrzaqQgJE
         gDnHLCaTAMLbvYBCRNMWL2zd+ZGAEGrs7ad+hXpCbYqMZRhJR7H5bdefauVe+XkSB2t5
         UoYdWj0PCTMaxEuqJiP2tLezojTLWeKHvTSoUHscIdcqRByvn5nLjwh55D/6iM9FZ/AW
         gIzqscJdqlJSuNildlf3iiHRtA5mDCCSqhGHbT6PhU8F1oufYMboF0uO1GZQHqWbduO7
         PK76UjuN10zsQhc0/8A00uwQoyOfs+r1inuGAs4MdMBEHj8V7e+FVSYMrK1CKJEp0c1i
         vrSQ==
X-Gm-Message-State: AFuF++l/IU5exBECcPRU+/O0CftuAID1hPzoELfabhmU8TP92CNk+RYC
	VG6RP0Khupu2QztDHKLORU+xic++uj6Tq2APnUVxannEOXDKBILNyLSlVM5Kl+JKnHWaHrJLY0T
	OknDbGI/ZHO+RztoXy1yodeGpjSP07v88aC5UCow=
X-Gm-Gg: AYBFou30aZJUtaTDIGqEdCFUXr/t1ZhL7g8wRS8E8KcobZ8NmPPS4uddAjb2wM2oDW7
	g8Q+JlVU8qqUNolgn7RFxeFojpAnDRjq6Uwt/kJr2vyf/J8zOeZ294sqntPyL0Ku2qTm6GWI51W
	SQVk8v4enWHP3w1QwRGxmNtQ/01Cj9MfAVAXdS4SnZNGzfNCnQq0xLn+pWEjbVDXG9lDsKbsSpK
	AcfHR75XIu6UjMhzPsfyVlwe2ewHxahdyXFF7UwBIhozTD+8Ard/EtpUVMdjvEj7nv0s/HbpP8R
	zWnl+OciPbEF+9qNEMgvuH7gqoVpVU7O+hMyYpE6G4RYeIWhae7q6/rt
X-Received: by 2002:a17:906:6296:b0:c26:1dc7:bc42 with SMTP id
 a640c23a62f3a-c29e521bf1amr80479966b.22.1789544213421; Wed, 16 Sep 2026
 00:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915153608.5197-1-prabhakar.pujeri@dell.com> <20260915153608.5197-3-prabhakar.pujeri@dell.com>
In-Reply-To: <20260915153608.5197-3-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Sep 2026 09:36:42 +0200
X-Gm-Features: AcwNN1XyeI4orwrrUgmVdtkbbvJkoTyz0K63H6EYVi6Gs4ySVjZVql9yrfkrt9A
Message-ID: <CAOQ4uxg=BeVMNOWzZW0SN8ScbsYYCH9v01Qu9uBQViwh_qzwoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/overlay: use _require_scratch_overlay_features
 for xino
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:36=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> overlay/041, 043, 044, 067, 070 and 071 open-code their xino probes:
> a mount with -o xino=3Don|off followed by a selective grep of the mount
> options.  Now that _check_overlay_feature handles param-less options,
> fold all six onto _require_scratch_overlay_features xino and delete
> the open-coded variants.  The behavior is unchanged - a kernel that
> does not support xino rejects the probe mount and the test notruns.
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  tests/overlay/041 |  6 ++----
>  tests/overlay/043 |  6 ++----
>  tests/overlay/044 |  6 ++----
>  tests/overlay/067 |  4 ++--
>  tests/overlay/070 |  7 ++-----
>  tests/overlay/071 | 12 +++---------
>  6 files changed, 13 insertions(+), 28 deletions(-)
>


Nice cleanup!
Thanks for following up on this

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

(see one note below)

> diff --git a/tests/overlay/041 b/tests/overlay/041
> index 36491b8f..4d2c830d 100755
> --- a/tests/overlay/041
> +++ b/tests/overlay/041
> @@ -23,6 +23,7 @@ _require_scratch_nocheck
>  _require_test
>  _require_attrs trusted
>  _require_test_program "t_dir_type"
> +_require_scratch_overlay_features xino
>
>  lowerdir=3D$OVL_BASE_TEST_DIR/$seq-ovl-lower
>  rm -rf $lowerdir
> @@ -41,10 +42,7 @@ workdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_WORK
>  # not use bit 63 in inode number of the test files, because bit 63 is us=
ed by
>  # overlayfs to indicate the layer. Let's just assume that this is true f=
or all
>  # tested filesystems and if we are wrong, the test may fail.
> -_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o xino=3Don ||=
 \
> -       _notrun "cannot mount overlay with xino=3Don option"
> -_fs_options $SCRATCH_DEV | grep -q "xino=3Don" || \
> -       _notrun "cannot enable xino feature"
> +_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o xino=3Don
>
>  test_dir=3D$SCRATCH_MNT/test_dir/
>
> diff --git a/tests/overlay/043 b/tests/overlay/043
> index 7325c653..efb99cd5 100755
> --- a/tests/overlay/043
> +++ b/tests/overlay/043
> @@ -33,6 +33,7 @@ _require_test_program "af_unix"
>  _require_test_program "t_dir_type"
>  # Require redirect_dir for renaming a merge directory
>  _require_scratch_feature redirect_dir
> +_require_scratch_overlay_features xino
>
>  lowerdir=3D$OVL_BASE_TEST_DIR/$seq-ovl-lower
>  rm -rf $lowerdir
> @@ -57,10 +58,7 @@ workdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_WORK
>  # not use bit 63 in inode number of the test files, because bit 63 is us=
ed by
>  # overlayfs to indicate the layer. Let's just assume that this is true f=
or all
>  # tested filesystems and if we are wrong, the test may fail.
> -_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o redirect_dir=
=3Don,xino=3Don || \
> -       _notrun "cannot mount overlay with xino=3Don option"
> -_fs_options $SCRATCH_DEV | grep -q "xino=3Don" || \
> -       _notrun "cannot enable xino feature"
> +_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o redirect_dir=
=3Don,xino=3Don
>
>  FILES=3D"dir file symlink chrdev blkdev fifo socket"
>
> diff --git a/tests/overlay/044 b/tests/overlay/044
> index 4d04d883..08e38dfd 100755
> --- a/tests/overlay/044
> +++ b/tests/overlay/044
> @@ -26,6 +26,7 @@ _require_scratch_nocheck
>  _require_test
>  _require_scratch_feature index
>  _require_test_program "t_dir_type"
> +_require_scratch_overlay_features xino
>
>  # Record inode numbers in format <ino> <nlink>
>  function record_ino_nlink()
> @@ -73,10 +74,7 @@ workdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_WORK
>  # not use bit 63 in inode number of the test files, because bit 63 is us=
ed by
>  # overlayfs to indicate the layer. Let's just assume that this is true f=
or all
>  # tested filesystems and if we are wrong, the test may fail.
> -_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o index=3Don,x=
ino=3Don || \
> -       _notrun "cannot mount overlay with xino=3Don option"
> -_fs_options $SCRATCH_DEV | grep -q "xino=3Don" || \
> -       _notrun "cannot enable xino feature"
> +_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o index=3Don,x=
ino=3Don
>
>  rm -f $tmp.*
>
> diff --git a/tests/overlay/067 b/tests/overlay/067
> index bb09a604..d3f98f17 100755
> --- a/tests/overlay/067
> +++ b/tests/overlay/067
> @@ -25,6 +25,7 @@ _fixed_by_kernel_commit 9c6d8f13e9da \
>  # them explicity after test.
>  _require_scratch_nocheck
>  _require_test
> +_require_scratch_overlay_features xino
>
>  # Lower is on test partition
>  lower=3D$OVL_BASE_TEST_DIR/$OVL_LOWER-$seq
> @@ -47,8 +48,7 @@ echo wrong > $realfile
>  # Mount an overlay on $SCRATCH_MNT with lower layer on test partition
>  # and middle and upper layer on scratch partition.
>  # Disable xino, so not all overlay inodes are on the same st_dev.
> -_overlay_scratch_mount_dirs $middle:$lower $upper $work -o xino=3Doff ||=
 \
> -       _notrun "cannot mount overlay with xino=3Doff option"
> +_overlay_scratch_mount_dirs $middle:$lower $upper $work -o xino=3Doff
>
>  stat $realfile >>$seqres.full
>  stat $testfile >>$seqres.full
> diff --git a/tests/overlay/070 b/tests/overlay/070
> index 36991229..c64e7907 100755
> --- a/tests/overlay/070
> +++ b/tests/overlay/070
> @@ -41,7 +41,7 @@ _require_test_program "t_dir_type"
>  _require_command "$FLOCK_PROG" "flock"
>  # We need to require all features together, because nfs_export cannot
>  # be enabled when index is disabled
> -_require_scratch_overlay_features index nfs_export redirect_dir
> +_require_scratch_overlay_features index nfs_export redirect_dir xino
>  _require_loop
>
>  lower=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
> @@ -83,10 +83,7 @@ mount_dirs()
>         # overlayfs to indicate the layer. Let's just assume that this is=
 true for all
>         # tested filesystems and if we are wrong, the test may fail.
>         _overlay_mount_dirs $SCRATCH_MNT $upper2 $work2 overlay2 $mnt2 \
> -               -o "redirect_dir=3Don,index=3Don,xino=3Don" || \
> -               _notrun "cannot mount nested overlay with xino=3Don optio=
n"
> -       _fs_options overlay2 | grep -q "xino=3Don" || \
> -               _notrun "cannot enable xino feature on nested overlay"
> +               -o "redirect_dir=3Don,index=3Don,xino=3Don"
>  }
>
>  # Unmount the nested overlay mount and check underlying overlay layers
> diff --git a/tests/overlay/071 b/tests/overlay/071
> index 2a631314..ef429d41 100755
> --- a/tests/overlay/071
> +++ b/tests/overlay/071
> @@ -45,7 +45,7 @@ _require_test_program "t_dir_type"
>  _require_command "$FLOCK_PROG" "flock"
>  # We need to require all features together, because nfs_export cannot
>  # be enabled when index is disabled
> -_require_scratch_overlay_features index nfs_export redirect_dir
> +_require_scratch_overlay_features index nfs_export redirect_dir xino
>  _require_loop
>
>  # Lower overlay lower layer is on test fs, upper is on scratch fs
> @@ -81,10 +81,7 @@ mount_dirs()
>  {
>         # Mount the underlying overlay with file handle support
>         _overlay_mount_dirs $lower $upper $work overlay1 $SCRATCH_MNT \
> -               -o "index=3Don,nfs_export=3Don,xino=3Don" || \
> -                _notrun "cannot mount overlay with xino=3Don option"
> -       _fs_options overlay1 | grep -q "xino=3Don" || \
> -               _notrun "cannot enable xino feature on overlay"
> +               -o "index=3Don,nfs_export=3Don,xino=3Don"
>
>         # Mount the nested overlay
>         # Enable redirect_dir for renaming a merge directory.
> @@ -93,10 +90,7 @@ mount_dirs()
>         # overlayfs to indicate the layer. Let's just assume that this is=
 true for all
>         # tested filesystems and if we are wrong, the test may fail.
>         _overlay_mount_dirs $SCRATCH_MNT $upper2 $work2 overlay2 $mnt2 \
> -               -o "redirect_dir=3Don,index=3Don,xino=3Don" || \
> -               _notrun "cannot mount nested overlay with xino=3Don optio=
n"
> -       _fs_options overlay2 | grep -q "xino=3Don" || \
> -               _notrun "cannot enable xino feature on nested overlay"
> +               -o "redirect_dir=3Don,index=3Don,xino=3Don"
>  }
>

Technically this used to test "enable xino feature on nested overlay"
I think there might have been a very old kernel version where this was
not supported, but I don't remember and it might be old enough that
we do not care in the context of fstests because there is no longer
an LTS kernel where this would matter.
If there is, then the test would fail and someone will complain, so I
am not concerned.

Thanks,
Amir.
