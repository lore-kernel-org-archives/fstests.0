Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675126;
	b=hOdM0TQ2Hja12GeY3yON0HcSnwhgA7TEppYJ+LgllieiyzotyngRisMSitYEXegebzUj
	 F65d4HJ61Lu32GirULNhDkjKubdfN2orSx6BU7xP0F/8E8EAzXuU1ls+DF0hjMXVes2Ww
	 wOFi4uePX0VM1uROfz3D7gtQySMAdz2FnUpgHr+nQ1adIbpWfqOsJkAQ0J00q59MuRDzq
	 nt3FnYsqy1hW6BOuIl7CZCZwT+roNlK9hMibxMFXLmfick56Tz2R4FYZ+tN8e4s95FvHd
	 O18WuenulXpt4NsDTifvC7YMn784sZ6fJV+zZ9itwL3lanhfpfQPQbFYQ+ah+rlWu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675126;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=0lqPMoLckk3hk/311uwxxNzds097FyRJTNyo3yq7jD8=;
	b=cdSVEhdXC2QG/O8luiyIoiK/zzm0C6dc3vU0a6RnB217Mxq+DNWIeua+MQqy0kP9h82z
	 P1x6wcymAspl0fMkjPtQL+P2fJKEDDloPCEbL6Y/dPdVzdD6mZ/oDzB91Gasiu7qqo5d9
	 YZK50Gwn/hRzPWhiQxNMPTX6PI39JapBBMJfwBX0fQUx4CPN0+mK8DYvuH1xdz5K35ofN
	 PmRedQ/tciMl9HadpopXRs5ZvtzTXLNyFur8J0vNenpSwtjjP8CEe/ZOb+HZWffVgKlSV
	 POlmqE/dULhEtoyvwZmYG+jB/qxuYv5ooa39hPpVbfvk0EYKMSWWYWdDUmXe2LPLsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtbqYbVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16623606A334
	for <fstests@vger.kernel.org>; Sat, 14 Nov 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtbqYbVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69FB1F000C6
	for <fstests@vger.kernel.org>; Sat, 14 Nov 2026 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675125;
	bh=0lqPMoLckk3hk/311uwxxNzds097FyRJTNyo3yq7jD8=;
	h=References:In-Reply-To:From:Date:Subject:To;
	b=ZtbqYbVxoeri4zNJQ3dyD7gG+iev/MsFY9pFTaGD1NEb/jhJjrjC4k4wZEozkjT5j
	 gK0qHBxwddmlJYb4fyjsjJ7R6NMdJFu/6AsZoBmOPV0U3WPzeMCLcAiNsOSnnY15G/
	 6IGqPL5/HxUMChyrfcBhPHpCYnGpDCJi3nTq3sBXZj2XYwK6svJkLdBUS45w4ogOcd
	 Ro87Qde6s28KkYpSZTxC7zFNZfLH63yXO2obrjow1jQoufAfBP4a3MoxYHGX9SnLZj
	 anQDWZOHGySKT61xdJX7ghrrgmBrJNdd73nPp909M61knyzCGwkQqBRbm1AcV5Phzy
	 XrKI/lyJnuKQw==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-980c4258105so2267888241.2
        for <fstests@vger.kernel.org>; Sat, 14 Nov 2026 08:52:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHVAgd9apYjQ/6xxZcHKWeyLF2SH+bQf76DKgafWu88xa8nci4O5+fZTTISWdyUPD2rleQGI6zc@vger.kernel.org
X-Gm-Message-State: APuU4Z/ARaBIW7nVuHfV/LMwfj/usAlAU6BxKoBaPomcQ92iOz8rTi/z
	NzvWjUh3nYbZaWkzUuIbR50XtZHk+pctmABWfZ857y9B1dLBi7uUGbcrfBd/X40eEEek//yQH96
	iurI1VOS02blhVawDoOi9552K5X4aVPw=
X-Received: by 2002:a05:6102:510f:b0:7cc:3246:3095 with SMTP id
 ada2fe7eead31-7d64d8b73cbmr2413814137.34.1794675124824; Sat, 14 Nov 2026
 08:52:04 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <233845be4bd0fd12b4c62b5ca5243ec1ef4d44f8.1792613768.git.fdmanana@suse.com>
 <avh4IU-M5jYkc1uE@zlang-mailbox>
In-Reply-To: <avh4IU-M5jYkc1uE@zlang-mailbox>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 14 Nov 2026 16:51:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4KZ-xerun6qOCxQDd4GPPj=B6KLZwa16rNQEVUKjAYDA@mail.gmail.com>
X-Gm-Features: AclHuK_pjttSZdxaRuKwogb5U38Qh2cC2BIZzwWFoyRfxpeZ7SVPYpG_nYw45pA
Message-ID: <CAL3q7H4KZ-xerun6qOCxQDd4GPPj=B6KLZwa16rNQEVUKjAYDA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test an incremental send scenario with hole punching
To: fdmanana@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 3:05=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrote=
:
>
> On Wed, Oct 21, 2026 at 09:17:25PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test an incremental send scenario where we punched a hole into a tail
> > section of a file extent item that is the last item in a leaf and the
> > next leaf in the subvolume tree was not changed (remains shared between
> > the parent and send snapshots).
> >
> > This currently fails and is fixed by the following kernel patch:
> >
> >   btrfs: send: fix missing hole punching during incremental send
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/362     | 84 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/362.out |  7 ++++
> >  2 files changed, 91 insertions(+)
> >  create mode 100755 tests/btrfs/362
> >  create mode 100644 tests/btrfs/362.out
> >
> > diff --git a/tests/btrfs/362 b/tests/btrfs/362
> > new file mode 100755
> > index 00000000..aca56540
> > --- /dev/null
> > +++ b/tests/btrfs/362
> > @@ -0,0 +1,84 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> > +#
> > +# FS QA Test 362
> > +#
> > +# Test an incremental send scenario where we punched a hole into a tai=
l section
> > +# of a file extent item that is the last item in a leaf and the next l=
eaf in the
> > +# subvolume tree was not changed (remains shared between the parent an=
d send
> > +# snapshots).
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $tmp.*
> > +     rm -fr $send_files_dir
> > +}
> > +
> > +. ./common/filter
> > +
> > +_require_test
> > +_require_scratch
> > +_require_btrfs_support_sectorsize 4096
> > +_require_xfs_io_command "fpunch"
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxx \
> > +     "btrfs: send: fix missing hole punching during incremental send"
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +first_stream=3D"$send_files_dir/1.send"
> > +second_stream=3D"$send_files_dir/2.send"
> > +
> > +# We need a very specific leaf layout where we punch a hole in the las=
t file
> > +# extent item of a leaf and the next leaf was not modified in the send=
 snapshot,
> > +# so we set a fixed size of 16K.
> > +_scratch_mkfs -n 16K >> $seqres.full 2>&1 || _fail "first mkfs failed"
> > +_scratch_mount
> > +
> > +touch $SCRATCH_MNT/foo
> > +# 205 extents of 64K each with a 64K hole between them.
> > +for ((i =3D 0; i < 410; i +=3D 2)); do
> > +     offset=3D$((i * 64 * 1024))
> > +     $XFS_IO_PROG -c "pwrite -b 64K -S 0xab $offset 64K" \
> > +             $SCRATCH_MNT/foo > /dev/null
> > +done
> > +
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> > +
> > +# Punch a hole in the last 16K of the last file extent item of the fir=
st leaf,
> > +# which starts at file offset 12845056, so 12845056 + 64K - 16K =3D 12=
894208.
> > +# This does not cause any change in the second leaf of the fs tree, so=
 it will
> > +# be shared between the snapshots.
> > +$XFS_IO_PROG -c "fpunch 12894208 16K" $SCRATCH_MNT/foo
> > +
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> > +
> > +echo "File digest in the original fs: $(_md5_checksum $SCRATCH_MNT/sna=
p2/foo)"
> > +
> > +_btrfs send -f $first_stream $SCRATCH_MNT/snap1
> > +_btrfs send -f $second_stream -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
> > +
> > +# Create a new fs and apply both send streams.
> > +_scratch_unmount
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> > +_scratch_mount
> > +
> > +_btrfs receive -f $first_stream $SCRATCH_MNT
> > +_btrfs receive -f $second_stream $SCRATCH_MNT
> > +
> > +echo "File digest in the new fs:      $(_md5_checksum $SCRATCH_MNT/sna=
p2/foo)"
> > +
> > +# Check the region we punched a hole is full of zeroes.
> > +echo "Hole data:"
> > +od -A d -t x1 -j 12894208 -N $((16 * 1024)) $SCRATCH_MNT/snap2/foo
>
>
> Can this be replaced with common helper: _hexdump ?

I don't have a strong objection to that, but honestly I prefer it as
it is because it prints the addresses in decimal format, which is more
human readable and directly matches the value passed to the hole
punching operation above, making it easier to read.

Do you want to make the change yourself, or should I send a new
version just for that?

>
> Thanks,
> Zorro
>
> > +
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/btrfs/362.out b/tests/btrfs/362.out
> > new file mode 100644
> > index 00000000..789abb53
> > --- /dev/null
> > +++ b/tests/btrfs/362.out
> > @@ -0,0 +1,7 @@
> > +QA output created by 362
> > +File digest in the original fs: a5a06694d9f7fc3245afb2f391636e44
> > +File digest in the new fs:      a5a06694d9f7fc3245afb2f391636e44
> > +Hole data:
> > +12894208 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +*
> > +12910592
> > --
> > 2.53.0
> >
> >
