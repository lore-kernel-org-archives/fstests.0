Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262E4ABBB1
	for <fstests@vger.kernel.org>; Thu,  1 Oct 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845389; cv=none; b=EsBLUUuv2g4InsIgNQoM+EH78qBfuTTRCCXMRMQANEc/ZPPYi5XZ1i3h1U5q6acaKTdn6RMULEZwAG+7sX7pqMQOc+9rVcSrDxdupbSy6kIYmTMbQL+2GcrLobPe2uCgDY7oLuFJcC5KRND0XIM73L9pec1sHR0DR5U831X/I8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845389; c=relaxed/simple;
	bh=WIxDIG4TyiPEF8cCXYtoM5quoKhAafLriJwrav1T4ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsU7UlNOjDJ2sLcQaOMVkHaWVH5mrg6ihkYd08cVWkBF2/qGAEmIQI174mxpu83fG/c5C/m0M+PmtaDytNDsERvqP8yVAHFFPMTd5QbPNqH/fyAR3gkNOd/QokVJ0UGcCSL/EaCvz/Iv3SrD/VSGR70yNdLqZ7o+e671wyjfTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuGMU2ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuGMU2ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB291F00899
	for <fstests@vger.kernel.org>; Thu,  1 Oct 2026 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845388;
	bh=6ZiS/EF6u2m2ExrKmxU/pR7BGQvwAGmRySaGgDNgJ+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kuGMU2ls5B/dSmLciQRrGpHwWDHTb2/l66LY1WHpAYXNnA04FbwBZNEC/J46U/SNy
	 Fh3xReEsjfc6fb/QrrP8Zdp+J4qs21bcYSQFenR1ERENOXz4+b/iiERqoUoAkU2XW9
	 xFK9ysUhYyAp22XzwvdsDJdUUmfG/9Rb+futuR760IqzfVL8Atxk4obOBBc8QTeLJ9
	 SSyNEKuXDKtHBFZ2r7pcyrWM92VYJ+gyD4HcELenqC+X8NxGH8tstl2V+ych72ck13
	 gQGLYlxmWpmB/tZEEdSeXjz0BZw+Mw0xjmJXwE1jkje9RzVAZ2iAlld3sQognNl4Mm
	 rsQbdaKvVNJ6g==
Received: by mail-vs2-f35.google.com with SMTP id ada2fe7eead31-7bf9eb881f7so396210137.2
        for <fstests@vger.kernel.org>; Thu, 01 Oct 2026 02:03:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBTx1XyZAiIaXB9woc/SDqC3GblJqua88ZXM3TEKKDcMChIEBL3RrcGTCHYIrlYSAjloTjvZhH@vger.kernel.org
X-Gm-Message-State: AFq9FYLf/FDbxOYHMEOiUt7ExBJS1Rg/evnoq1KM4Z5Ae4ACunPJVbjU
	X4Ks17uZy7i/rqNauzZhmVzz5uLL7RAs15x31HWrEvtwLyxgfTtUO/4KqqmiFRmetv9HLuIBule
	yIbdNKHjIgPLndO1IvogfcYT2YjhafHY=
X-Received: by 2002:a05:6102:c10:b0:7a7:19aa:8a83 with SMTP id
 ada2fe7eead31-7be73e9aae5mr1261470137.30.1790845387082; Thu, 01 Oct 2026
 02:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001041008.39697-1-wqu@suse.com>
In-Reply-To: <20261001041008.39697-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 1 Oct 2026 10:02:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H43RxYEF-Ye5B_Qc1VpiG+L06eP27xcg7gnmvF-_7KagA@mail.gmail.com>
X-Gm-Features: AclHuK_YyTZlMPPP1pxj257QODloX2gIwyUO-RNVpJY34F1j4suTsrKArk3kZbQ
Message-ID: <CAL3q7H43RxYEF-Ye5B_Qc1VpiG+L06eP27xcg7gnmvF-_7KagA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a new test case to verify degraded
 RMW writes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:10=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> This is a regression test for a recent reported bug.
>
> The test workload is pretty straightforward:
>
> - Create a 4 disks RAID5 or RAID6 btrfs
>
> - Destroy one disk and mount the btrfs degraded
>
> - Use fio to do a workload meeting all the following conditions
>   * Triggering a RMW write
>     This is done by using buffered write with 8 4K writes.
>     The total write will not fulfill a full stripe, thus it will
>     always go through RMW.
>
>   * Some blocks of the full stripe have csum and some do not
>     This is done by pre-allocating the target file before testing, so
>     every full stripe does not have any csum by default.
>
>     Then after some writes, there will be checksum for those new writes,
>     resulting blocks with mixed data checksum.
>
>   * Detect RMW failure
>     This is done through fdatasync.
>
> For unpatched kernels, the fio will always fail pretty early, meanwhile
> patched kernels can finish the full 15 seconds runs on both RAID5 and
> RAID6 profiles.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/357     | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/357.out |  2 ++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/btrfs/357
>  create mode 100644 tests/btrfs/357.out
>
> diff --git a/tests/btrfs/357 b/tests/btrfs/357
> new file mode 100755
> index 00000000..f2c04285
> --- /dev/null
> +++ b/tests/btrfs/357
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 357
> +#
> +# Make sure on degraded RAID5/6, RMW writes won't return false errors
> +# when some blocks do not have checksums.
> +#
> +. ./common/preamble
> +
> +_begin_fstest auto raid volume
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: raid56: do not verify the content if there is no data che=
cksum"
> +
> +_require_command "$WIPEFS_PROG" wipefs
> +_require_scratch_dev_pool 4
> +_scratch_dev_pool_get 4
> +
> +fio_job_file=3D$tmp.fio
> +cat > $fio_job_file << EOF
> +[sync_randwrite]
> +directory=3D$SCRATCH_MNT
> +rw=3Drandwrite
> +filesize=3D512M
> +bs=3D4K
> +fdatasync=3D8

There's no need for fdatasync, a regular fsync would trigger the issue.
On btrfs fdatasync does the same as a regular fsync.

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +time_based
> +fallocate=3Dposix
> +runtime=3D15
> +EOF
> +
> +_require_fio "$fio_job_file"
> +
> +# The target to remove for degraded mount.
> +dev2=3D"${SCRATCH_DEV_NAME[1]}"
> +
> +workload()
> +{
> +       local profile=3D$1
> +       _scratch_pool_mkfs "-m raid1 -d $profile" >> $seqres.full 2>&1
> +       $WIPEFS_PROG -fa "$dev2" >> $seqres.full 2>&1
> +       _scratch_mount -o degraded
> +
> +       # The fio job will do fsync after 8 4K writes, which is not enoug=
h to
> +       # fill a full stripe and always trigger RMW.
> +       # And the target file is preallocated, after some writes a full s=
tripe
> +       # can have blocks with csum and some blocks without csum.
> +       #
> +       # Unpatched kernels will try to verify the checksum even if there=
 is no
> +       # csum and fail the RMW, causing fio to fail.
> +       $FIO_PROG $fio_job_file >> $seqres.full 2>&1
> +       if [ $? -ne 0 ]; then
> +               echo "fio failed on degraded $profile"
> +       fi
> +       _scratch_unmount
> +}
> +
> +workload raid5
> +workload raid6
> +
> +_scratch_dev_pool_put
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/357.out b/tests/btrfs/357.out
> new file mode 100644
> index 00000000..25875c6d
> --- /dev/null
> +++ b/tests/btrfs/357.out
> @@ -0,0 +1,2 @@
> +QA output created by 357
> +Silence is golden
> --
> 2.51.2
>
>
