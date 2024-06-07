Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9931581F2
	for <fstests@vger.kernel.org>; Fri,  7 Jun 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754674; cv=none; b=Qblmlx36l8nTforfwzLfBWlQ2MKs/6RuoCGDTc2+/jhqal/8Z+7yKJ1k4p96mcfon8r2Euf9+M+0c3ezyuX3uOZlMI0O5pAnlcnJAqeIviHU6C6LE42cT+lkd700goExjPicrCtAucNZIOfl3HLtxyofn6ZLsg3PktlyIsM2qUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754674; c=relaxed/simple;
	bh=xrzjx5Aq+dptHpPLsPeCd9sgbKk8a9QVZjEIgYhxQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qae0vpBvxohkzLRldmr7aWwrZk4z6sjoya13nCXP4FCDAN7RQXIUx5KBDjbLAfF4pe1wb1L/FqObs8TTfW4QFtzAlmDVFFxf0b2fCViIbGr5rTmDM4y7Zuvcl4mOfUjDN3kqlSXdYTGKL4WmHwkI1qW5nhRxD7BGId5Gh7S9NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZ0kchGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ0kchGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuRHwHrKIs/kBu+JXKDmRZuG3VFYdHYQoP0SpNwkv2Y=;
	b=eZ0kchGbuk4ChTo1z5bQcA2EL5SvKtA5IPw2Edsf8Qerp/QPetuWeigDdOGtEUh2xfQKwu
	XdzFd8WvMKGXNmXHtjEGh/iJeBXUBl5zvJARRCDO1yKfA1wnVMc7uyECWKUhOwAmdCYuxn
	pUxX/wEP6GzHM6b2DzBX1V7/9O3TnDI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-AqMBRiOlNYmXRMXC8ne_Bg-1; Fri, 07 Jun 2024 06:04:28 -0400
X-MC-Unique: AqMBRiOlNYmXRMXC8ne_Bg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f64b60a92eso20874375ad.3
        for <fstests@vger.kernel.org>; Fri, 07 Jun 2024 03:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754667; x=1718359467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuRHwHrKIs/kBu+JXKDmRZuG3VFYdHYQoP0SpNwkv2Y=;
        b=hkD8EQi8PUlZFSsm2qMb/UjoEZQftahiPA1JU5MiRpCzuxKRek16AwxiXCGhZWn4Vn
         ReJN9MV6yA0u0+89eWpNPYwKIEgj3ZrTkVzaBuC9YQXDMVecAsld/NqF3ZvvTJ/jq1Nw
         iSWUZwznSjdy7qFLflbCf8ie8ICyrtnkC1gFzO3k5kz6r8K4l9rcg4h5CHxy5HqI12Yc
         f4iSDf0jEUK3qEQqDfppczL1nghDkv5KR1B2z5Vu5+7L6d/J9jYuXQaxwajNBWxnRp9I
         fwpVe5/me9BrlBpNBCgzOG0VcsMo4vvOjKzBbpchrK84MRzZzKGbF7jTIi7+sOdpoW7c
         E3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUP9Coar4K4vEm1GmS3SztkMq0OmjVVx768cmZSg7epQrSWw4bAwv7Be0rl+6TuTjvQ1CyDSwKaGRFl/nPK4ZOVraq6GO6qpw==
X-Gm-Message-State: AOJu0YxMN+llrIzukGujy3uSyoxzabuw2c2byOxOmJbKM+WWnJwrBbqD
	6DwEBCFzmZGjfaJvLws+fVZAohinfyhNUYbPv9nrNXO5IKkPS4PxCleRtMfHasyRsUeNN78ca/h
	2in3fPNXgS6f0qQnRguCs1i/Ab7dBC48QScOuLVm9mBDtlbUvby12+gA=
X-Received: by 2002:a17:902:d492:b0:1f6:8ae4:50de with SMTP id d9443c01a7336-1f6d039b624mr24338775ad.61.1717754667346;
        Fri, 07 Jun 2024 03:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz4V08Sbc7JnmBOQn1Qg435qayhIO2865bh6E7voBCHkxmxJl3hP8uY7EOXHAl5Lau0+EMvg==
X-Received: by 2002:a17:902:d492:b0:1f6:8ae4:50de with SMTP id d9443c01a7336-1f6d039b624mr24338405ad.61.1717754666684;
        Fri, 07 Jun 2024 03:04:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80de1esm30270765ad.294.2024.06.07.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:04:26 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:04:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607100422.w7k7spmyg7s6xfv4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
 <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 10:43:47AM +0100, Filipe Manana wrote:
> On Fri, Jun 7, 2024 at 6:12 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> > > On Fri, May 24, 2024 at 9:58 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > From: Omar Sandoval <osandov@fb.com>
> > > >
> > > > This is a regression test for a Btrfs bug, but there's nothing
> > > > Btrfs-specific about it. Since it's a race, we just try to make the race
> > > > happen in a loop and pass if it doesn't crash after all of our attempts.
> > > >
> > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > ---
> > > > Changes from v1 [1]:
> > > >
> > > > - Added missing groups and requires.
> > > > - Simplified $XFS_IO_PROG calls.
> > > > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> > > >   reliably.
> > > > - Removed all of the file creation and dump-tree parsing since the only
> > > >   file on a fresh filesystem is guaranteed to be at the end of a leaf
> > > >   anyways.
> > > > - Rewrote to be a generic test.
> > > >
> > > > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> > > >
> > > >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/745.out |  2 ++
> > > >  2 files changed, 46 insertions(+)
> > > >  create mode 100755 tests/generic/745
> > > >  create mode 100644 tests/generic/745.out
> > > >
> > > > diff --git a/tests/generic/745 b/tests/generic/745
> > > > new file mode 100755
> > > > index 00000000..925adba9
> > > > --- /dev/null
> > > > +++ b/tests/generic/745
> > >
> > > Btw, generic/745 already exists in the for-next branch (development is
> > > based against that branch nowadays).
> > >
> > > > @@ -0,0 +1,44 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > > > +#
> > > > +# FS QA Test 745
> > > > +#
> > > > +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> > > > +# prealloc while extending i_size, then fdatasync. This is a regression test
> > > > +# for a Btrfs crash.
> > > > +#
> > > > +. ./common/preamble
> > > > +. ./common/attr
> > > > +_begin_fstest auto quick log preallocrw dangerous
> > > > +
> > > > +_supported_fs generic
> > > > +_require_scratch
> > > > +_require_attrs
> > > > +_require_xfs_io_command falloc -k
> > >
> > > Since this is now a generic test and we're using direct IO, also:
> > >
> > > _require_odirect
> > >
> > > > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > > > +       "btrfs: fix crash on racing fsync and size-extending write into prealloc"
> > >
> > > Because it's now a generic test, it should be:
> > >
> > > [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ....
> > >
> > > Otherwise it looks good to me, so with that:
> > >
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks Filipe, merged this patch with above review points, more details refer to
> > "patches-in-queue" branch. Feel free to have more review points before I push
> > to for-next :)
> 
> Btw, there's a v3 with all that addressed:
> 
> https://lore.kernel.org/fstests/8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com/
> 
> Also, looking at patches-in-queue, the test was added twice, once as
> generic/748 and once as generic/749, in two different commits.

Oh, I've merged this test case last week... sorry I forgot that. I'll keep
the g/748, and remove the g/749.

> 
> Also, unrelated, but this commit:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=patches-in-queue&id=b4c4ba99435aa7fd4f8a6e3c02938e357e137ec9
> 
> As a Signed-off-by tag for David Disseldorp instead of Reviewed-by.

Oh, this Signed-off-by tag is generated automatically by:

https://lore.kernel.org/fstests/c9e54af5-4370-4d45-a8ed-4098b06b2629@suse.com/T/#m8fc24d233b2cf3a323c94c2b8039c0f043e09023

if it's a mistake, I'll change it to Reviewed-by:

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> > >
> > > Thanks.
> > >
> > > > +
> > > > +# -i slows down xfs_io startup and makes the race much less reliable.
> > > > +export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > > > +
> > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > > +_scratch_mount
> > > > +
> > > > +blksz=$(_get_block_size "$SCRATCH_MNT")
> > > > +
> > > > +# On Btrfs, since this is the only file on the filesystem, its metadata is at
> > > > +# the end of a B-tree leaf. We want an ordered extent completion to add an
> > > > +# extent item at the end of the leaf while we're logging prealloc extents
> > > > +# beyond i_size after an xattr was set.
> > > > +for ((i = 0; i < 5000; i++)); do
> > > > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> > > > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > > > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
> > > > +done
> > > > +
> > > > +# If it didn't crash, we're good.
> > > > +
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > > > new file mode 100644
> > > > index 00000000..fce6b7f5
> > > > --- /dev/null
> > > > +++ b/tests/generic/745.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 745
> > > > +Silence is golden
> > > > --
> > > > 2.45.1
> > > >
> > > >
> > >
> >
> 

