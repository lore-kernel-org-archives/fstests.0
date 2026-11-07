Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794052741;
	b=oicXXtzVW/fER+SdwT+xcnawj2W2pRoFF0qJlqYb227zWJCEu8fe3u0AFn5ZZWuVJdLc
	 cOI9/QS4L8+LlpqqthMleKxZ3bOVMATPZPrMYGRY3PQw4CIP18Cdl0pu56gByQNXBEs+j
	 dhqxWyTR+Ghdl5oeHHBce/IRsVRgCz22rZU5b6z9eV4muoBI4rbZdODzZ5JA8C1857cx5
	 kk4nfap2r61EhSVpxCRt+T0rOz9zCn8FRYyhzoGvG6tcsVK8qT+ll7xE7/ejsOQ5bqn4+
	 WItsPKFRFpsP/W5jdjs3u3MesLXUdNOxOVpLrGm2BTbJZOrBz8FHDWuT3E4ccGC4S2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q13f0r4fzicCIGzxwWvYYPPU13RbKTYFwpHpZwEJdRE=;
	b=oGCBqXyESrF/V1Ltx8bdBKk6m4uTTxQxbhK6o2FrjYuRgae1SD1xhzzOZ83vczAXm4YF
	 UktpNF6qjKqWKJnsaK0U+LHCdAWV1PlTGBJ635UDT+L3z/HaO026g3SSWMtTEHR+qAC+w
	 TYHzlmyY1ntGZwxGEVzP1i0VTPqhHrxvYK1LB61SwaUHc+YKoqXCZaGpqnRqEyfadgotB
	 61hzPgfYan+GvEac8sBxbT0Vb1Kz0b+0qCMGC7nGyttZ4icTasWZx4yWFznJJY+DLx1qs
	 XmREXk+LgAB6HdXfJvqmcdEvuUpAhl0izGa7gd4Ra8Y8jW/uBoSyZ/GVB/wl7a0HvzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nW6/vjQB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C5606A326
	for <fstests@vger.kernel.org>; Sat,  7 Nov 2026 11:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nW6/vjQB
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so1579192a12.2
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 03:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794052739; cv=none;
        d=google.com; s=arc-20260327;
        b=qOecsOinwfuF7jaGVDcbeRBWT0ArCt5Uktn8c4qJg1ucIurU/Bq7bZMxMlPJu6y2YZ
         SLRiMokhxOkwA+UPitvI+tq9ZMSJbXmjiu/rdRGAS8C3GCP0JqgfchfJyoru/w/89uPn
         L6p4ZhpBLgtE39jdyT3CKWDdSn/mfFKuJkXNNaHrrFWqke2jtmYeFJ96kbk9tcaD8Xpg
         qjJ/6Isz24TgZQQAr8sOE9e4LVvEf10U9YL/Y9xb5tDbkkX/5cSGSzsmNOY8av7c4lrI
         PPO0TqPTYhSoq4rKkke3QqdsjumTI3U5Zn94JDPB0sOi1RkWfJsO/4eGX+e+vaKsDRGf
         e0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q13f0r4fzicCIGzxwWvYYPPU13RbKTYFwpHpZwEJdRE=;
        fh=VIlGCOL5rRBzh+UXY33BBwPas1hHrWaR7c2lxhPDtsM=;
        b=mQgGHK5qSYCIgwD3PA8tr5pbBkZSBbxit689decg25zD7zqwz6U309TLuqeoU8cS7K
         EO4SEZiHlaRbequH/o5BOtvMEOoUtb+SBD0HDk04TSLxZxEiwJxaXZ/+6NyvOZ9RjS9V
         uZdUpeCLAQAf4D0YUlM56QcDZOzMdi7M1m1bEJNf4UgZxIsFnMRW4SOfuCXY3PkBARXm
         HJBsK1y8IFlHF0PotDc2kQImRw4YIG0pdniTZtKYjJop8G76NOJJsSCOBiIecUM/l0F7
         4f0RnUisRm76wEbpY8gcmADJbspaP856+9qE27JDOBLuPGsu5ACIX8hsay3XJbuOFGVs
         jgFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794052739; x=1794657539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q13f0r4fzicCIGzxwWvYYPPU13RbKTYFwpHpZwEJdRE=;
        b=nW6/vjQBB+3SCTsMwM6f3lXrIGj9GbNoTfNwqUldGZt3wWYXx/4nsng6JvKWnDZuCq
         QIB8qN+Ik3NP04AmVcutbWcJgjsgCauHuVNbu1J2qurxmFZx4lFetsf8GomVnl9j6Uob
         jitZf+AN42+8/twWPAl0JrSU8TMLJ/p+arUfjt0vcuLGLqdTwrlHlJCSNn+/h/FYYSp+
         if9Sut1Ei9wbVQB8zMAu5mxE+dzusmigGxMvcBQwO+DK9YNfbWsT9hZBGmQGPVHUQkAA
         d3Jd7xFdHRkLben49Frr1piozEr5BvItS4O/XMJzMf5Fm4fvcaMexpOALHRADjV8uKDd
         WwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794052739; x=1794657539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q13f0r4fzicCIGzxwWvYYPPU13RbKTYFwpHpZwEJdRE=;
        b=dqGF8JM1vskaxz2vAf24nCCXsdW6zG97i9j5qXJ1VbG4D12XSV8C+xdUyBGeYXk64T
         TWete5wVJmfpPNbRghI6fFBIDjbyxfrgUTs178m1RYSnjoSf/HJbF2uKoS702EV53Drw
         czdJsO7jowkTAVO37EovC0RimXkU0uaN5faELy2I/NCn+U0//jtM7wUwoejyJpyliitj
         Iy4KFtQZRfCmAptDm6GTM6lAmjfobPw6fUw4TBE0TrQTh+/moZKlazzAP+UDdEcbTx0X
         ZGGsZ1ulQWC5aouYfdIpya8ACRQzONUvIoxLZgrvgsWyoMgLVBFWgYqhc6qcRTn55X2v
         VljQ==
X-Gm-Message-State: APuU4Z9M+OTC7XIKS32SiRZhraPtKNLxO3AzDBEc1W8uTj3yNs4+GDWL
	qkJHP2dgAyBkyb/ACjTMYZlpvvQCCJhcWXwysYcUJqn2iQhykSBrQcYrmud+PxujxajnZSlMe/8
	cuNrrg4F8Xl6ooxqC1grv3quc+xGSZYg=
X-Gm-Gg: AYBFou2sXTfB5p/4VQjODNb6Cy01jJHCIxUbP+I3+sGDppN9c0LdiktJVfyBLNEXiZS
	q7dPfwWr9IsmQ32kZsWnTcvc0Vu7mULXHgcvD8UCWL3M33Gj1U2bbfP25C72OrKikgA0jcBoCNP
	jnt09Rvo5+xxNvMhNKNMF8EZzB3RljwdoGgoQVYNgxE9DWuwhwjQYagtz7z0lLEvvetHxIePDD+
	AyL21RN3ZmY33/Bqq+R7FlLkzB6ZK9nx7QQKEBpzJ3Ao2uChOBIFmjxsLyPT+LwbSg8mD6ngV0v
	+3HvIdO++J25TUsE0mhxJi2wCCfTS+rrZIGMmY92JMjd303sYNO21zF410k035VJqJE8kx1e7U7
	Zbs2bDSfB4DNEWxP+4hiuGXPtkLelFNUX4k1/0KDjo1vPdKXvzHwStehYWm22hV7M/5TfYjrHRc
	n+UYQOzAS7mJtlTdPW
X-Received: by 2002:a05:6402:158c:b0:6b5:6ba3:5860 with SMTP id
 4fb4d7f45d1cf-6b5977f129emr3451363a12.17.1794052739133; Sat, 07 Nov 2026
 03:58:59 -0800 (PST)
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
Date: Sat, 7 Nov 2026 12:58:47 +0100
X-Gm-Features: AclHuK_HxGgSBDeYi4hnUu0Wi124NC2EkW8RKHxAPKX0yEMcnxsiWq0XD1MH14E
Message-ID: <CAOQ4uxikdcS-uPh57F8vPLNBo88pjbjtn_kws0z2=gOvOLKGCA@mail.gmail.com>
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

Nice! Thanks.

What's the deal with Claude's number allocations?
There is an unused test number range 090..099.

In tests/overlay it's just because I started the unionmount
tests in offset 100, but I think that in fstests we often reallocate
numbers for tests that were deleted.


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

This seems wrong.
When one specified default mount options for the entire ./run
they are not expected to affect tests that set those options explicitly
I think the right thing to do is that this test always explicitly
requests fsync=3D and where you did not provide fsync=3D provide
fsync=3Dauto instead.

Also, please add:
_require_scratch_overlay_features fsync

But it doesn't work without my fix:
https://lore.kernel.org/fstests/20261106155832.3867017-1-amir73il@gmail.com=
/

Yes this test could technically run on older kernels and skip the
unsupported options but I don't think it's important that it would.

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

Please echo label also to stdout and include it in golden output
so if something fails it is easier to see right away in the diff which
mode had failed.

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

I think adding auto to modes instead is sufficient
and avoids the default fsync=3Doff issue

> +       for mode in relaxed on strict; do
> +               do_test $how -o fsync=3D$mode
> +       done
> +       do_test $how -o redirect_dir=3Don,metacopy=3Don

This makes for odd test coverage.
No coverage for metacopy=3Don,fsync=3Drelaxed (assuming default is off)
No coverage for redirect_dir=3Doff,fsync=3Drelaxed (assuming default is on)
I guess there is no escape from another X2 dimension of meta in on off
and do_test $how -o fsync=3D$mode,redirect_dir=3D$meta,metacopy=3D$meta

Thanks,
Amir.
