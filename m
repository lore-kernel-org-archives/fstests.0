Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA517C67
	for <fstests@vger.kernel.org>; Fri,  7 Jun 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737138; cv=none; b=ikZnzquu/WA66aUFDLByunX8PSExr+VLlEsxJJnP/J0a9ThoO8F4Seig87XDw+elIQjB348ULj62EZvZ4d21941rOM+Ekgn3IpCWUnA8BssBybPRHi1nDbdXGpSvDnvKKTyE7yWmAjMPJ1efd9pkMU9Rrxy5eu7euuDR3oLfPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737138; c=relaxed/simple;
	bh=3SasVotL65io6uI7nMzbdDXNOu6jy8RgTynsQOR3UL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lufpszXieEKI1OifE88iHWXede0L1akAfUyUQNoob+VJnKkPdNrJUsGLTF/+i008IDRAL0hIIL6TQb7miK4Vc2XNXc/4NhySl24GKF6N3jdPVumLRBpFjk9oGA5niRfmpjVe8EmCDimj4PFi1S/XMXk2Awwb3t4ETAINfR4or/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBnvKIEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBnvKIEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717737135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPEPQEShKUN+FEA3EreDIyeanqmPf4X97UtQry/w8Yo=;
	b=VBnvKIEcIzEdyZrHKsgPk7VXtsFENyofzsliv9pED1gt2ShFykrpXDclRhoUCe3jalOnPj
	ErtVtKK1nDGL+x6+YkYRvOlQbYbzitL2HkzYzq4zwdXaZi9kcU9dnydX+PlsVAXTYjqhQt
	EYzRfdfTGvI33iIBgFfxrXzRwTd+Pzg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570--xh4cfYaMMefiJrQFt90kw-1; Fri, 07 Jun 2024 01:12:14 -0400
X-MC-Unique: -xh4cfYaMMefiJrQFt90kw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2c9ae984aso18446a91.1
        for <fstests@vger.kernel.org>; Thu, 06 Jun 2024 22:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717737133; x=1718341933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPEPQEShKUN+FEA3EreDIyeanqmPf4X97UtQry/w8Yo=;
        b=c9crzPS9b0ip1JkVpyR3Y59BJCn07QcF1bxIXilNvqbfHKebQYMMFsSJ9BmjKLL/xP
         rEWGLZ8uMb9G8xEDTFPg30Wt3VoAqUV/l1n3obtfi3iT4hum6zFDIO6kQ39trEp6Dtxi
         b29uBBPXgGGri1u4FFmowCnRq5Jk0d8rzREF+5dH0Hnx9d2EUsDVKzLQfiqJsVOLU6jH
         e/UyiXM902ZcUD+F3FRj8x4FtijI+c+fY8D7ISFZ9vAqTGk3amgKAIlxGOIX+FAlNtqP
         Ba7xdK2WDcltVgiFYhGS3eDN+o+yYtwFldwg3Rj6LCyXg0G1FPv+RGfp2tcTGXqs/uX6
         yrQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZe/8q4Ncc5bhB+lV0XvnIxZWiV9YcWe5erDcPk8gjDu0e6Cskt7SK7qLkgLWbNBU5fB3t+TH7vlbfvnQAGa8slpIxQ9Rb3g==
X-Gm-Message-State: AOJu0YxmDxykfdMQEaqoSzwLPXMzQ9UnTAZpcR7bW+Lp5W1ztpqqRyS2
	TBGQEKKSfVECQGUXn5gkZJ0kXORDUSpYvXNAQX5GC5/kcbl/vhXzbJsCls2a8OcxZUJDjn5Li/Z
	JYpxvuiefWyb0wbvY7hv6y3oH1qXwhFgsPIUFrhSei7U9M/DtDCk89KA=
X-Received: by 2002:a17:90a:df0d:b0:2c2:e22:787e with SMTP id 98e67ed59e1d1-2c2bcc6b302mr1473549a91.33.1717737132523;
        Thu, 06 Jun 2024 22:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4rLHzdkdz9xZ7yysa4ldbujDYaCD9ERGYpr3ddUQeAHTghrU6rxTpd9275bsjRsSJcVe6CA==
X-Received: by 2002:a17:90a:df0d:b0:2c2:e22:787e with SMTP id 98e67ed59e1d1-2c2bcc6b302mr1473531a91.33.1717737131818;
        Thu, 06 Jun 2024 22:12:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c495093sm2620723a91.53.2024.06.06.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 22:12:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:12:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>

On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> On Fri, May 24, 2024 at 9:58 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This is a regression test for a Btrfs bug, but there's nothing
> > Btrfs-specific about it. Since it's a race, we just try to make the race
> > happen in a loop and pass if it doesn't crash after all of our attempts.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> > Changes from v1 [1]:
> >
> > - Added missing groups and requires.
> > - Simplified $XFS_IO_PROG calls.
> > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> >   reliably.
> > - Removed all of the file creation and dump-tree parsing since the only
> >   file on a fresh filesystem is guaranteed to be at the end of a leaf
> >   anyways.
> > - Rewrote to be a generic test.
> >
> > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> >
> >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/745.out |  2 ++
> >  2 files changed, 46 insertions(+)
> >  create mode 100755 tests/generic/745
> >  create mode 100644 tests/generic/745.out
> >
> > diff --git a/tests/generic/745 b/tests/generic/745
> > new file mode 100755
> > index 00000000..925adba9
> > --- /dev/null
> > +++ b/tests/generic/745
> 
> Btw, generic/745 already exists in the for-next branch (development is
> based against that branch nowadays).
> 
> > @@ -0,0 +1,44 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > +#
> > +# FS QA Test 745
> > +#
> > +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> > +# prealloc while extending i_size, then fdatasync. This is a regression test
> > +# for a Btrfs crash.
> > +#
> > +. ./common/preamble
> > +. ./common/attr
> > +_begin_fstest auto quick log preallocrw dangerous
> > +
> > +_supported_fs generic
> > +_require_scratch
> > +_require_attrs
> > +_require_xfs_io_command falloc -k
> 
> Since this is now a generic test and we're using direct IO, also:
> 
> _require_odirect
> 
> > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > +       "btrfs: fix crash on racing fsync and size-extending write into prealloc"
> 
> Because it's now a generic test, it should be:
> 
> [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ....
> 
> Otherwise it looks good to me, so with that:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks Filipe, merged this patch with above review points, more details refer to
"patches-in-queue" branch. Feel free to have more review points before I push
to for-next :)

Thanks,
Zorro

> 
> Thanks.
> 
> > +
> > +# -i slows down xfs_io startup and makes the race much less reliable.
> > +export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +blksz=$(_get_block_size "$SCRATCH_MNT")
> > +
> > +# On Btrfs, since this is the only file on the filesystem, its metadata is at
> > +# the end of a B-tree leaf. We want an ordered extent completion to add an
> > +# extent item at the end of the leaf while we're logging prealloc extents
> > +# beyond i_size after an xattr was set.
> > +for ((i = 0; i < 5000; i++)); do
> > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
> > +done
> > +
> > +# If it didn't crash, we're good.
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > new file mode 100644
> > index 00000000..fce6b7f5
> > --- /dev/null
> > +++ b/tests/generic/745.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 745
> > +Silence is golden
> > --
> > 2.45.1
> >
> >
> 

