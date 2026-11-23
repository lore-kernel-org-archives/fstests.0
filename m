Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433933;
	b=N2O9Sh4fS2zwB1azDdo1yAvRKE3scAuT9oMHHymnnOe+IdLjH3+ohNH1aQFgIaIsfyyk
	 m9ZB7c50jG2u9cVdIdK6CfV9kAwMHj5KdcouvHmUwBhU0+PdcTsV1IidC8jonugLW4FQx
	 I4UrYW+9102AE7Ytj3pbN/Lol0H7ePa2j2pD1+NV7cE4sqq9RcPoutnkSHeL2OxisadIL
	 yEM3Al7l5zPGW7zpSVR0PhuAjXdtyt3hCvZ3XQupMWL+0CC55yPoS+WhCRV5vqXxYKzL8
	 Qh+1kRJwLquSVVKz88fnac7u+aUKDO6jTUvdmqQ0QFZfBmmOuHZjBMCu1H/386qdx1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433933;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=EESa4efnMBGbslzdH6n69Ux8BQjtF8swLUwkYQsgcZ0=;
	b=jUXCrnVaNHoO/1QhriCtHRn7h+FZ4u+6qnj0bZW3z8mBv6Qcg4o0pdp7AdEqc9T2exct
	 y5ckX8ZRyiMKmDXxm9NH8eSdC8LH0ISd/fu/hjm7K7iDflgN8qCfsX2MBku062SSghDf1
	 NECBjjsHgtYRzToiS2k2fGueuMTpz1ZNhATGGcvvAmGOFsZJl2BwR105AK/jIGWVP2DfH
	 y/WTsQ/JG2efUQO6ske0siKLccJRFkjG8cUMM2hHiwsqjHfPCyte713VHJclug/CN7cH8
	 1fjaaGQjjx18BKkt3/UAKge2sDP+AB4pjSp2ywsmTEdgt7KNQqfvz5os0LbBnBLS9Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5rzUMKy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9C606A31A
	for <fstests@vger.kernel.org>; Mon, 23 Nov 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5rzUMKy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568531F000D2
	for <fstests@vger.kernel.org>; Mon, 23 Nov 2026 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795433932;
	bh=EESa4efnMBGbslzdH6n69Ux8BQjtF8swLUwkYQsgcZ0=;
	h=References:In-Reply-To:From:Date:Subject:To;
	b=n5rzUMKykJfaq+yZW5aWt2gYe5j1reE3JWNn1PI6LlpNbGgoY6/EjQUQeLmYXLmnH
	 XIw24AJ7gvIT5p0pdSuRXp7LDTk4apRsXxIQCKFp1yuMFh/729gG31I+G4rRxiCRsL
	 Hkt+IVOG/430j10Rr3WF2gZT4fvTpOAEwj1Vr8EWPauwIqSfao+DiLJ/kHxUuvA8ui
	 4KxhCDE6bkr833EqSg20F/1NxUNr9ohk3Tu87zuhyhVWLTsyCWQ6w0/t1bWC3PcKSv
	 a4/k1wD5H31ByeTsejCkJFepBabdjp2fjqR+MCiDM773rp0PAnBiWVkf2YHrWLHzvq
	 hhlJYX9egXfxA==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso740552241.0
        for <fstests@vger.kernel.org>; Mon, 23 Nov 2026 03:38:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHKDGVVivZ7zQGT4FQ2HltrhXUO8bcuOopaaOnjqm03bUpMp/iIe2jZDRe25K80VnsHy669Xw/e@vger.kernel.org
X-Gm-Message-State: APuU4Z+1W197jd0ZrUK8xbN+L76am81x+ZLUBQiKCXctb6REApIccfOD
	9aTBu/Bz76b0XlXP9KX9scfG54bTrjVLYVap4oVmZdFQgP00eonYzwNxvupgcKfGw0mqgLcNdzb
	D89KwE4hVYhCg7ogV5MIcOtb8/U1VssM=
X-Received: by 2002:a05:6102:84c8:b0:7a7:19aa:f0d4 with SMTP id
 ada2fe7eead31-7d7396a6e4dmr3039522137.33.1795433931441; Mon, 23 Nov 2026
 03:38:51 -0800 (PST)
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
 <avh4IU-M5jYkc1uE@zlang-mailbox> <CAL3q7H4KZ-xerun6qOCxQDd4GPPj=B6KLZwa16rNQEVUKjAYDA@mail.gmail.com>
 <avjP-YcABrnO5RZ1@zlang-mailbox>
In-Reply-To: <avjP-YcABrnO5RZ1@zlang-mailbox>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Nov 2026 11:38:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4mW3eMDeSCTeG3HYhJtz62jf=v8EZFKV8mu_+izcDF9A@mail.gmail.com>
X-Gm-Features: Aa3M54qmJgmHPaHVUXl2YeqmIZhSv3jOmAyA6rKxhQ6BxWX5wPrwtgAnlEPxy1c
Message-ID: <CAL3q7H4mW3eMDeSCTeG3HYhJtz62jf=v8EZFKV8mu_+izcDF9A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test an incremental send scenario with hole punching
To: Filipe Manana <fdmanana@kernel.org>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:21=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrote=
:
>
> On Sat, Nov 14, 2026 at 04:51:27PM +0000, Filipe Manana wrote:
> > On Sat, Nov 14, 2026 at 3:05=E2=80=AFPM Zorro Lang <zlang@kernel.org> w=
rote:
> > >
> > > On Wed, Oct 21, 2026 at 09:17:25PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test an incremental send scenario where we punched a hole into a ta=
il
> > > > section of a file extent item that is the last item in a leaf and t=
he
> > > > next leaf in the subvolume tree was not changed (remains shared bet=
ween
> > > > the parent and send snapshots).
> > > >
> > > > This currently fails and is fixed by the following kernel patch:
> > > >
> > > >   btrfs: send: fix missing hole punching during incremental send
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  tests/btrfs/362     | 84 +++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  tests/btrfs/362.out |  7 ++++
> > > >  2 files changed, 91 insertions(+)
> > > >  create mode 100755 tests/btrfs/362
> > > >  create mode 100644 tests/btrfs/362.out
> > > >
> > > > diff --git a/tests/btrfs/362 b/tests/btrfs/362
> > > > new file mode 100755
> > > > index 00000000..aca56540
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/362
> > > > @@ -0,0 +1,84 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 362
> > > > +#
> > > > +# Test an incremental send scenario where we punched a hole into a=
 tail section
> > > > +# of a file extent item that is the last item in a leaf and the ne=
xt leaf in the
> > > > +# subvolume tree was not changed (remains shared between the paren=
t and send
> > > > +# snapshots).
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick send
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +     cd /
> > > > +     rm -fr $tmp.*
> > > > +     rm -fr $send_files_dir
> > > > +}
> > > > +
> > > > +. ./common/filter
> > > > +
> > > > +_require_test
> > > > +_require_scratch
> > > > +_require_btrfs_support_sectorsize 4096
> > > > +_require_xfs_io_command "fpunch"
> > > > +
> > > > +_fixed_by_kernel_commit xxxxxxxxxx \
> > > > +     "btrfs: send: fix missing hole punching during incremental se=
nd"
> > > > +
> > > > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > > > +
> > > > +rm -fr $send_files_dir
> > > > +mkdir $send_files_dir
> > > > +
> > > > +first_stream=3D"$send_files_dir/1.send"
> > > > +second_stream=3D"$send_files_dir/2.send"
> > > > +
> > > > +# We need a very specific leaf layout where we punch a hole in the=
 last file
> > > > +# extent item of a leaf and the next leaf was not modified in the =
send snapshot,
> > > > +# so we set a fixed size of 16K.
> > > > +_scratch_mkfs -n 16K >> $seqres.full 2>&1 || _fail "first mkfs fai=
led"
> > > > +_scratch_mount
> > > > +
> > > > +touch $SCRATCH_MNT/foo
> > > > +# 205 extents of 64K each with a 64K hole between them.
> > > > +for ((i =3D 0; i < 410; i +=3D 2)); do
> > > > +     offset=3D$((i * 64 * 1024))
> > > > +     $XFS_IO_PROG -c "pwrite -b 64K -S 0xab $offset 64K" \
> > > > +             $SCRATCH_MNT/foo > /dev/null
> > > > +done
> > > > +
> > > > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> > > > +
> > > > +# Punch a hole in the last 16K of the last file extent item of the=
 first leaf,
> > > > +# which starts at file offset 12845056, so 12845056 + 64K - 16K =
=3D 12894208.
> > > > +# This does not cause any change in the second leaf of the fs tree=
, so it will
> > > > +# be shared between the snapshots.
> > > > +$XFS_IO_PROG -c "fpunch 12894208 16K" $SCRATCH_MNT/foo
> > > > +
> > > > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> > > > +
> > > > +echo "File digest in the original fs: $(_md5_checksum $SCRATCH_MNT=
/snap2/foo)"
> > > > +
> > > > +_btrfs send -f $first_stream $SCRATCH_MNT/snap1
> > > > +_btrfs send -f $second_stream -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/s=
nap2
> > > > +
> > > > +# Create a new fs and apply both send streams.
> > > > +_scratch_unmount
> > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> > > > +_scratch_mount
> > > > +
> > > > +_btrfs receive -f $first_stream $SCRATCH_MNT
> > > > +_btrfs receive -f $second_stream $SCRATCH_MNT
> > > > +
> > > > +echo "File digest in the new fs:      $(_md5_checksum $SCRATCH_MNT=
/snap2/foo)"
> > > > +
> > > > +# Check the region we punched a hole is full of zeroes.
> > > > +echo "Hole data:"
> > > > +od -A d -t x1 -j 12894208 -N $((16 * 1024)) $SCRATCH_MNT/snap2/foo
> > >
> > >
> > > Can this be replaced with common helper: _hexdump ?
> >
> > I don't have a strong objection to that, but honestly I prefer it as
> > it is because it prints the addresses in decimal format, which is more
> > human readable and directly matches the value passed to the hole
> > punching operation above, making it easier to read.
> >
> > Do you want to make the change yourself, or should I send a new
> > version just for that?
>
> If I were to change it, I'd have to merge the kernel patch above, rebuild=
 and
> install the kernel, run the tests, and then update the .out file.
> Never mind, just using od works fine too, since the _hexdump helper was
> originally introduced to replace the widespread use of the hexdump comman=
d
> anyway. Anyway, no need to send a new version. If I find some time, I'll
> make the change myself, or merging it directly :)

Are you planning to make that change, expecting me to do something, or
did you simply forget to push it to the patches-in-queue branch?

Thanks.

>
> Thanks,
> Zorro
>
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > > +
> > > > +# success, all done
> > > > +_exit 0
> > > > diff --git a/tests/btrfs/362.out b/tests/btrfs/362.out
> > > > new file mode 100644
> > > > index 00000000..789abb53
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/362.out
> > > > @@ -0,0 +1,7 @@
> > > > +QA output created by 362
> > > > +File digest in the original fs: a5a06694d9f7fc3245afb2f391636e44
> > > > +File digest in the new fs:      a5a06694d9f7fc3245afb2f391636e44
> > > > +Hole data:
> > > > +12894208 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > +*
> > > > +12910592
> > > > --
> > > > 2.53.0
> > > >
> > > >
> >
