Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794053223;
	b=hHM1vOxmTJsLN1XAHhe6ogjBWvD0aKjMG82j1wOsEZWmKvgCgQf5kho2Fhw9sHHw4BCj
	 H9P+xACOPLzQncjxXotuPr9a0LUF+RMTE/NXL05Ea3eKbVdBtjZzg/F6UMdZ04ZMPlmLQ
	 isw4Shyqzu/5hdbl/bcQJTRb2azLDy7IAvpCBQ0SanWkeEtSOdxp4HZn+6WoeqB289KbZ
	 f+rT8uLtPsUdvZ2kubpcd1RPvoEWtvPU1Ya269pFXdHqPiv5aPKYxpRSCxggUkMUHmycJ
	 ovK5ArtmIb3nYMStE23kdwIUgMXeCgCQ1V+3YwcXnF6sd27P0Xk8iqLMu0NRnmqQlbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6IFdt2+h74ES2iAllmb1tkzxE7Urdoz0rZFKQi7Jkp0=;
	b=yJqARl5a1qi5ZDQ6VWu7+gBWfvRWWKf6fWRi5hzrH5q1DIrtLQzSupqZsM0ttyDex70n
	 1dmKCbZFQWzo8ANCJg1VyYi0y8akYkPctPbPQ6Z/3ynkt74KcQzzWwMO+0ULEmW2jownw
	 sF8hJJikes8/tX26UMRgdaeq8hHa8/eNA7sjX8F8ZFON0FDTW6Swoj9NcCfWfVQeIgJ0d
	 9bY0a/M6I5mVNPhlksbU5PYnvs0YH6KoXekLBpcKontqOfaYaKkANnLu6VpWuPie9AP1n
	 3Z8IplkHbL8G6TymYhuLXvLS1nLaVsDyCUOV+zSWAwqcxSSnNbEyVtBsLEi/TDJPIeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxMtAa2K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75767606A32C
	for <fstests@vger.kernel.org>; Sat,  7 Nov 2026 12:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75767606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxMtAa2K
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2176282a12.3
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 04:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794053221; cv=none;
        d=google.com; s=arc-20260327;
        b=hdnFRhcU6jMOyWZu7vd5Fg//N9JAUE4xdpjkJlbeO3hqXBDq2fqgq4I1i2zkvpPuTT
         y0pECUlZRSfxmDRfcsIAHzCwyU5+dkUUeujTj7gMctnRgwpD/eXSFksxfXif1dFuDKpA
         qNFaFtIPUM6rnlRMVhx6F2RRopt5+j9PiSYrIejNkdDazmmur56e4DauUgkPO2C1CDlK
         Znuzd0VOFaKNWsZUjIQRq6g/9vRlC8lfwaEjoihUE5VU1N4569RgTrBzHQYU0DAYlZkm
         VLqHDDVh5i5KZWH2b+eY7qW0/7ww5k8KNxC9xSCoA8U+qz8y1D4gsyvXQ0JkyiWVu1AG
         Vbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IFdt2+h74ES2iAllmb1tkzxE7Urdoz0rZFKQi7Jkp0=;
        fh=VIlGCOL5rRBzh+UXY33BBwPas1hHrWaR7c2lxhPDtsM=;
        b=s9H3fdgckzfR7N9V8YnfhoiwUFdv6if9g0fi7q0Vp3RDa0Jl7MTMXceV0xw0qy9l7a
         qcM9wydrtH+OJZ/UjARoorYHqJu+fIxbLiKsUb7uLf6XU8WmSmTFJjQUgIG0jnbbiEJ7
         g89BdcFAR4ru3moN8Hvf5zFzILGuS8iq2OzcF5yQSvsVvxEGQSmbnbvIHz5z8UjedpgH
         q8a3JwR9dGtgg6YQUCox65YXz15pcNfOw2mEU+gyubBX/8qUdRzFKAPThv5qQZs3yf7W
         kyF73iF/M+2F3ipjRKb51o7FVNaV5FmDoHcgFuUymddbJyx3JBtnhIEVA6S5fDkPW0lv
         9n4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053221; x=1794658021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6IFdt2+h74ES2iAllmb1tkzxE7Urdoz0rZFKQi7Jkp0=;
        b=ZxMtAa2KkWNrppQDWh3IfTYIwwiW/ieO4PWtX9we6FTH7ecUhd5I083WUCO6I9rMx+
         OUos32+riVXy9j69OmgcrTU7oMq0OkD6pAitint68mzZf+mDIWwZI5jdkIO19f8517SV
         9HcOaXn7yfrx3UxGf2Lv8FvLAqbnUSEJxPfIXTqu6Op8EUZ+OhBk5aUiPHxKVxi3W2jG
         IewD+zAkjaPRKKWLhP/lN8smmw1QCGj6zsKpqY9tzkIo+ZMbfvnLccwKcLQysd24m+rj
         cEeGwzQZUrB0cPRY0uEgIEY43i7w9PLFHV1TRCHmfYCx0kPZ02nKMDSKboZPksxfd41+
         X6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053221; x=1794658021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IFdt2+h74ES2iAllmb1tkzxE7Urdoz0rZFKQi7Jkp0=;
        b=ZxfaSeVFCB3I5yd7qcAwZpMNguQlLrOi4329e4yBSpQhwowRaR273T++JE5X5AY/ak
         PU/ew8Q9GFJe3zzydsNOjFWGwD6mNCFfiU/bjCXbRKZW/RlGyPwEmn+18at+21Pa7phM
         sSGD9LBFTt7jg4p6zWUVTZtRO2qpLkPKcijLIwBnXYq9A/4S6mwb34c5jhN12vuSct7O
         1MclBVgRPZOxjttKMkont+m4LfqIMU6srlbueDB0FEN/62Jlhw/1OTXH0Je+b8rX5qhC
         LGxAawtLvsj0Lb58WEvarrursCgMvy2NmfYh+oxYtvwLEhu0IlaED6p7eYVu7GBDNBiV
         FN6w==
X-Gm-Message-State: APuU4Z+FtD1tScsuElTMvCygOE3Q7mLhkTVnXoBePEMRMNsxUzzQx5Gt
	UhXCgXkmh/ipwYCXe7pcOnKUPloDy6B5xD9UoL+e4T2nMFkq/EKIjW5ttnNmdR01bCBh+wm6xM3
	ow6E3HKYhWZmwHb1hwjcxyhjqml8/b8sm0INc
X-Gm-Gg: AYBFou3d7qrHIWm7q69cFbEM+Jjl5G/bjG/HVU+RP6/XHdsBzOpOBB8OdFAxocH0YTy
	/t4sNu1k5dEHbD1DOKi4+rI5d4dIJiHjujgHRwyAqKiikutaPbZgDcuWCyrGcGgvqL2XRHDToUz
	Os4VqRmhbpZ0Lnx3mQs3dwdGgd4Ph5IioLXxvEI326XJgXgDnfA55e26LnIciS+wY5B+/YaUBEw
	shRehZKU9avbfFLo33bQH9k2038io2q2Q+VAWja053CWQaaERkVwCiyqQsylYVJO6xrCpYXbmm+
	OSSS+jBm8N7VI3N4N2ygUdzh9N045KEUlXBgXKFXcHoagUC39mWZJl0+kXBr5xZkXMlo/KQ/sna
	PZDJdujigQg5ia96E00sjxc3/Cw333YzyqlVdrxB4CQw8/qGfK0DV1V7kTritxpO2GtKeEg==
X-Received: by 2002:a05:6402:312a:b0:6b5:965f:98b2 with SMTP id
 4fb4d7f45d1cf-6b59780666bmr2775370a12.36.1794053220545; Sat, 07 Nov 2026
 04:07:00 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <773faf2a275e0a51bd38cf68f492856c.josef@toxicpanda.com> <946b46fbf1c555a47a8a9304f2ee31af.josef@toxicpanda.com>
In-Reply-To: <946b46fbf1c555a47a8a9304f2ee31af.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Nov 2026 13:06:48 +0100
X-Gm-Features: AclHuK-zVATIg6Gk8mVw-rQ_hLYsZPX-NTgQvvXAu66wGyyrF04T-5x1OrXMqDw
Message-ID: <CAOQ4uxgRcHWg2TAeCbUNL-Af6Or=Q=z10kEGLjd56pW645dseQ@mail.gmail.com>
Subject: Re: [PATCH fstests v2] overlay: test that syncfs and unmount persist
 all changes
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 1:31=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> overlayfs is about to stop syncing the whole upper filesystem on syncfs(2=
)
> and unmount.  With fsync=3Drelaxed it only writes the upper inodes that w=
ere
> modified through the overlay, so it has to know about all of them.
>
> Modify an overlay in many ways: new files and directories, data and
> metadata copy up, stores through a shared mapping, sendfile, copy_range,
> an O_TMPFILE, a short and a long symlink, hard links, renames, whiteouts,
> a file written before the inode caches are dropped.  Then sync or unmount
> the overlay, shut down the base filesystem without flushing its log, cycl=
e
> the mounts and check that nothing has changed.
>
> Do that with the default mount options, with every fsync mode that syncs
> and with redirect_dir=3Don,metacopy=3Don.  Options that the kernel does n=
ot
> know are skipped.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1: https://lore.kernel.org/r/773faf2a275e0a51bd38cf68f492856c.josef@toxi=
cpanda.com
>
> v1->v2:
> - Added a symlink that's too long to be stored in the inode. (Christian)
>
> This is for "ovl: only sync what was written through the overlay" [1], Am=
ir
> suggested a test like this in his review.
>
> It passes without the series on ext4 and xfs, there it skips fsync=3Drela=
xed
> and fsync=3Don, and it passes with the series. With the series and the
> function that marks the overlay inode dirty turned into a no-op it fails =
in
> the default, fsync=3Drelaxed and metacopy rounds, the file data is gone.
>
> [1] https://lore.kernel.org/r/20261106-b4-ovl-containerized-sync-v4-0-6dd=
de0b7dd8a@toxicpanda.com
>
>  tests/overlay/118     | 182 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/118.out |   2 +
>  2 files changed, 184 insertions(+)
>  create mode 100755 tests/overlay/118
>  create mode 100644 tests/overlay/118.out
>
> diff --git a/tests/overlay/118 b/tests/overlay/118
> new file mode 100755
> index 00000000..f9c98eff
> --- /dev/null
> +++ b/tests/overlay/118
> @@ -0,0 +1,182 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Josef Bacik.  All Rights Reserved.
> +#
> +# FS QA Test 118
> +#
> +# Test that syncfs(2) on an overlay, and unmounting one, persist everyth=
ing
> +# that was modified through it.
> +#
> +# overlayfs used to sync the whole upper filesystem for that.  With
> +# fsync=3Drelaxed it only writes the upper inodes that were modified thr=
ough this
> +# overlay, so it has to know about all of them.
> +#
> +# Modify the overlay in every way we can think of, sync it, shut down th=
e base
> +# filesystem without flushing its log, cycle the mounts and check that n=
othing
> +# has changed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick shutdown copyup whiteout mmap redirect metacopy
> +
> +. ./common/attr
> +
> +_require_scratch
> +_require_scratch_shutdown
> +_require_metadata_journaling $SCRATCH_DEV
> +_require_xfs_io_command "syncfs"
> +_require_xfs_io_command "sendfile"
> +_require_xfs_io_command "copy_range"
> +_require_xfs_io_command "-T"
> +_require_xfs_io_command "flink"
> +_require_attrs
> +_require_chown
> +_require_mknod
> +# These never sync
> +_exclude_scratch_mount_option "volatile" "fsync=3Doff"
> +
> +lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
> +
> +create_lower()
> +{
> +       local f
> +
> +       # This leaves the base filesystem mounted
> +       _scratch_mkfs >> $seqres.full 2>&1
> +
> +       mkdir -p $lowerdir/dir $lowerdir/rmdir $lowerdir/mvdir
> +       for f in append truncate mmap chmod chown chown_append xattr link=
 \
> +                rename remove dir/append rmdir/file mvdir/file; do
> +               $XFS_IO_PROG -f -c "pwrite -S 0x6c 0 256k" $lowerdir/$f \
> +                       >> $seqres.full
> +       done
> +
> +       # These were not written through the overlay, so it does not have=
 to
> +       # sync them.
> +       $XFS_IO_PROG -c "syncfs" $OVL_BASE_SCRATCH_MNT
> +}
> +
> +modify()
> +{
> +       local m=3D$SCRATCH_MNT
> +
> +       # New files and directories
> +       $XFS_IO_PROG -f -c "pwrite -S 0x61 0 1m" $m/new >> $seqres.full
> +       mkdir $m/newdir
> +       $XFS_IO_PROG -f -c "pwrite -S 0x62 0 64k" $m/newdir/new >> $seqre=
s.full
> +       $XFS_IO_PROG -f -c "pwrite -S 0x63 0 64k" $m/dir/new >> $seqres.f=
ull
> +       ln -s new $m/symlink
> +       # Too long to be stored in the inode
> +       ln -s $(printf 'a%.0s' $(seq 1000)) $m/longsymlink
> +       mkfifo $m/fifo
> +
> +       # Copy up, then change the data
> +       $XFS_IO_PROG -c "pwrite -S 0x64 256k 64k" $m/append >> $seqres.fu=
ll
> +       $XFS_IO_PROG -c "pwrite -S 0x65 256k 64k" $m/dir/append >> $seqre=
s.full
> +       $XFS_IO_PROG -c "truncate 4k" $m/truncate
> +
> +       # Stores through a shared mapping, also after a syncfs, no msync
> +       $XFS_IO_PROG -c "mmap -rw 0 256k" -c "mwrite -S 0x66 0 64k" \
> +               -c "syncfs" -c "mwrite -S 0x67 64k 64k" $m/mmap >> $seqre=
s.full

Sashiko is right to note that this syncfs add an explicit fsync that could =
hide
unmount non-persist bugs?

> +
> +       # The other ways to write data
> +       $XFS_IO_PROG -f -c "sendfile -i $m/link 0 256k" $m/sendfile \
> +               >> $seqres.full
> +       $XFS_IO_PROG -f -c "copy_range -l 256k $m/link" $m/copy_range
> +       $XFS_IO_PROG -T -c "pwrite -S 0x69 0 64k" -c "flink $m/tmpfile" $=
m \
> +               >> $seqres.full
> +
> +       # Copy up, then change the metadata
> +       chmod 640 $m/chmod
> +       chown 1234:1234 $m/chown
> +       $SETFATTR_PROG -n user.test -v value $m/xattr
> +
> +       # With metacopy=3Don the first one only copies up the metadata
> +       chown 1234:1234 $m/chown_append
> +       $XFS_IO_PROG -c "pwrite -S 0x6a 256k 64k" $m/chown_append \
> +               >> $seqres.full
> +
> +       # Names
> +       ln $m/link $m/link2
> +       mv $m/rename $m/renamed
> +       # Without redirect_dir=3Don mv gets EXDEV and copies the director=
y
> +       mv $m/mvdir $m/mvdir2
> +       rm $m/remove
> +       rm -r $m/rmdir
> +
> +       # An overlay inode that nobody holds on to
> +       $XFS_IO_PROG -f -c "pwrite -S 0x68 0 1m" $m/evicted >> $seqres.fu=
ll
> +       echo 2 > /proc/sys/vm/drop_caches

Sashiko is right to claim that this drop caches is meaningless with the
snapshot() that follows?

> +}
> +
> +# No inode numbers, no timestamps, and no sizes and link counts of direc=
tories
> +snapshot()
> +{
> +       local f
> +
> +       cd $SCRATCH_MNT
> +       find . | LC_ALL=3DC sort | while read -r f; do
> +               if [ -L "$f" ]; then
> +                       echo "$f $(stat -c '%F %u:%g' "$f") $(readlink "$=
f")"
> +               elif [ -f "$f" ]; then
> +                       echo "$f $(stat -c '%F %a %u:%g %h %s' "$f")" \
> +                            "$(md5sum < "$f")"
> +               else
> +                       echo "$f $(stat -c '%F %a %u:%g' "$f")"
> +               fi
> +       done
> +       _getfattr --absolute-names -n user.test xattr 2>&1
> +       cd - > /dev/null
> +}
> +
> +# <syncfs|umount> [mount options]
> +do_test()
> +{
> +       local how=3D$1
> +       shift
> +       local label=3D"$how${*:+ $*}"
> +
> +       echo "=3D=3D=3D $label" >> $seqres.full
> +
> +       create_lower
> +       if [ $# -eq 0 ]; then
> +               _scratch_mount
> +       elif ! _try_scratch_mount $* >> $seqres.full 2>&1; then
> +               # Not every kernel knows every option
> +               echo "cannot mount" >> $seqres.full
> +               _unmount $OVL_BASE_SCRATCH_MNT
> +               return
> +       fi
> +
> +       modify
> +       snapshot > $tmp.before
> +
> +       if [ $how =3D syncfs ]; then
> +               $XFS_IO_PROG -c "syncfs" $SCRATCH_MNT
> +               _scratch_shutdown | tee -a $seqres.full
> +               _scratch_unmount
> +       else
> +               # Only the overlay, the base filesystem stays mounted
> +               _unmount $SCRATCH_MNT
> +               _scratch_shutdown | tee -a $seqres.full
> +               _unmount $OVL_BASE_SCRATCH_MNT
> +       fi
> +
> +       _scratch_mount $*
> +       snapshot > $tmp.after
> +       cat $tmp.after >> $seqres.full
> +       diff -u $tmp.before $tmp.after | sed -e "s/^/$label: /"
> +       _scratch_unmount
> +}
> +
> +for how in syncfs umount; do
> +       do_test $how
> +       for mode in relaxed on strict; do
> +               do_test $how -o fsync=3D$mode
> +       done
> +       do_test $how -o redirect_dir=3Don,metacopy=3Don
> +done
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/overlay/118.out b/tests/overlay/118.out
> new file mode 100644
> index 00000000..3daed864
> --- /dev/null
> +++ b/tests/overlay/118.out
> @@ -0,0 +1,2 @@
> +QA output created by 118
> +Silence is golden
> --
> 2.55.0
>
