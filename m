Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0E198E9B
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163683; cv=none; b=ahBwHBiWiOyWR/biOTLlSCYZggyJtoCeJpnddlcYOO0l04aNXpKl0c5XygROVdFax8+sB0s32UPrp8scaEol/KdWcKZnLq8Lax3B7rRpFfMiZ7KsRUkifRmvdOS9TYHpoEdZPfizvl15VeKxqYkMpBtr3hDNPA1/BuYYP9xpTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163683; c=relaxed/simple;
	bh=DtbO3r2s0j76BIs6Ffl+0uBOgnz0YgHm4VHlGhIUtjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2/7ZJYqZKafoCw57ExaXiAKOhEtlpU5y+hgT/1NBuG/BHTRb0Va3TDH5oPHCQpz9TaWj3Y8jEN/J4zuWZkB4VVkfGp935pjTJYocIeToyT5PtapdtTWZIf4NIcrDr90QaC+wWN5TNmRiqv33jyd1tLEqpzYjevXmlHivGFSMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfUFHiuR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfUFHiuR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S6ib9l1DK4vHAQjPyW40H5e/41gkSoFyJQWaqvpTVU=;
	b=JfUFHiuRTHvhiGNRz5aHEaGli5AOKMiKqHnx+3Ra5Srm0QAYq9xrN7W8hoaH3meWW5HSrs
	2JnwDh4acdseeYh/BhWG9+z1GFEXwDoZffYMP+JHTO0EghI2/0A0w5rgGZh19T+4zf87ix
	GdsZYOWKnzMoZwB3n4zc+w81vU/qyMA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-7FUWyMpcOeqwWt1bgKPFNw-1; Thu, 10 Jul 2025 12:07:57 -0400
X-MC-Unique: 7FUWyMpcOeqwWt1bgKPFNw-1
X-Mimecast-MFC-AGG-ID: 7FUWyMpcOeqwWt1bgKPFNw_1752163677
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31220ecc586so1208281a91.2
        for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 09:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163677; x=1752768477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S6ib9l1DK4vHAQjPyW40H5e/41gkSoFyJQWaqvpTVU=;
        b=b9v7OQELEzcLbcj+r0Eo79joqFYSfrBlrruG0E/0bUpcUGBaTl9on3xlxCxeir3llW
         KPd5dXWFo/ZQqI97C2TtcZnRPzHqmoxI9E6GjWuHZY7itwNkwshNOGdRTvdNbT7z8DOJ
         isZG2F/upY/DYnxH57SIFIdgpWcuem9Jj5awpL09cMKAZbBXsdgKWQGeiGbkySIrIPqu
         +2QPjyCpgLQrRELDG5kDHz0ZUxXAlIDbKbzBSdToujY/o/HhlaA5y0+QLRbTlmh3CeEo
         8ZmQFNlPng5UxCqfe+9AgHrYQHVzMueTyPzE0Ah8zTFW8ZX5FViWmzpQXiE+9DxmMK6R
         GF7A==
X-Gm-Message-State: AOJu0Yzw59twuy4WWPljvg3SwrDXO/rFA+Uma70k3U6sjH1JZPU7aaiX
	D7LC3iACDHA2PhGp3TW9YfRP3BUl95MIgpv+rGI1lN78gtUSw+Nz8ZSOGS3VuhS7qZRKSL6md8o
	a3BiFqTI3unFtwrju7g+hmoTtrLzXbpshbzPJbFCfcxmZfFwuEVp1V5XdnPc=
X-Gm-Gg: ASbGncvgfk7SwN4PhnN/GMdMB7D8W9gkBpdtgiF7Ro4NHxtLdmrRNd6nTvlOgEPVl/r
	yUvSC9QFop0jz1KQABO/nLhO8Hj6z3DR1ORAGZL0fj/t55MNwcDvDNslWXkEBgJw5/Svm0tFk89
	0n/jbaeVBaMwFcF02iXLlps9nrPxGwGa6Jgz6ulIPvl+1kRum8UrTIFWPxFvuTYGZj61zeSiliS
	aVyOF4PI3bUmrFhtgOwozbILQdA9LENvcWJrl3wrdLjiMBO/Ok76U6AWTY3N/4tVntyYaMSv2sf
	L2omncVw858GiDYvwKWBfsExJHWGDWUHKtFYBlVdkyWxAqqzefwQ/RSu2D/bR+w=
X-Received: by 2002:a05:6a21:b95:b0:21f:50d9:dde with SMTP id adf61e73a8af0-22cd59ffe34mr11131145637.5.1752163676311;
        Thu, 10 Jul 2025 09:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/eWl5mrGN4itlRFZlA555g55yBF6fWT1l1eVNbgeOSVbnV62pbBn7FT2J7oe07aAYBA9l/g==
X-Received: by 2002:a05:6a21:b95:b0:21f:50d9:dde with SMTP id adf61e73a8af0-22cd59ffe34mr11131009637.5.1752163674865;
        Thu, 10 Jul 2025 09:07:54 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0ffasm2638390a12.30.2025.07.10.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:07:54 -0700 (PDT)
Date: Fri, 11 Jul 2025 00:07:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710160750.q6sgqrfbazsxi2og@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>

On Thu, Jul 10, 2025 at 12:47:30PM +0100, Filipe Manana wrote:
> On Thu, Jul 10, 2025 at 8:29 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that overwriting a file with mmap when the filesystem has no more
> > > space available for data allocation works. The motivation here is to check
> > > that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> > >
> > > This currently fails with btrfs but it's fixed by a kernel patch that has
> > > the subject:
> > >
> > >    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/211.out |  6 +++++
> > >  2 files changed, 64 insertions(+)
> > >  create mode 100755 tests/generic/211
> > >  create mode 100644 tests/generic/211.out
> > >
> > > diff --git a/tests/generic/211 b/tests/generic/211
> > > new file mode 100755
> > > index 00000000..c77508fe
> > > --- /dev/null
> > > +++ b/tests/generic/211
> > > @@ -0,0 +1,58 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 211
> > > +#
> > > +# Test that overwriting a file with mmap when the filesystem has no more space
> > > +# available for data allocation works. The motivation here is to check that
> > > +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick rw mmap
> > > +
> > > +. ./common/filter
> > > +
> > > +_require_scratch
> > > +
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +     "btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> > > +
> > > +# Use a 512M fs so that it's fast to fill it with data but not too small such
> > > +# that on btrfs it results in a fs with mixed block groups - we want to have
> > > +# dedicated block groups for data and metadata, so that after filling all the
> > > +# data block groups we can do a NOCOW write with mmap (if we have enough free
> > > +# metadata space available).
> > > +fs_size=$(_small_fs_size_mb 512)
> > > +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> > > +     _fail "mkfs failed"
> >
> > _scratch_mkfs_sized calls _notrun if it fails:
> >
> >   _scratch_mkfs_sized()
> >   {
> >         _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
> >   }
> >
> > So you can let it _notrun:
> > _scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1
> >
> > or you'd like to _fail:
> >
> > _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> >          _fail "mkfs failed"
> 
> The fail makes more sense to me - having the _scratch_mkfs_sized()
> calling _notrun doesn't make sense to me at the moment.

OK, so you can use _try_scratch_mkfs_sized.

> 
> >
> > > +_scratch_mount
> > > +
> > > +touch $SCRATCH_MNT/foobar
> > > +
> > > +# Set the file to NOCOW mode on btrfs, which must be done while the file is
> > > +# empty, otherwise it fails.
> > > +if [ $FSTYP == "btrfs" ]; then
> > > +     _require_chattr C
> > > +     $CHATTR_PROG +C $SCRATCH_MNT/foobar
> > > +fi
> > > +
> > > +# Add initial data to the file we will later overwrite with mmap.
> > > +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
> > > +
> > > +# Now fill all the remaining space with data.
> > > +blksz=$(_get_block_size $SCRATCH_MNT)
> > > +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
> >
> > As this's a generic test case, I'm wondering if the common/populate:_fill_fs()
> > helps?
> 
> Because the intention is to exhaust data space and leave enough
> metadata space free so that the NOCOW write can be done, as Qu already
> replied before.
> In btrfs we have space divided in two sections (block groups): one for
> data and one for metadata.
> Metadata is always COWed in btrfs by design, data can be NOCOWed
> (chattr +C or prealloc extents for the first write) - as longs as
> there's enough metadata space available (every data write requires
> updating some metadata).
> 
> If this is too specific or hard to comprehend, I can move the test
> case into tests/btrfs/ (we have a few similar to this scenario iirc).
> Let me know if I shall move it into tests/btrfs/.

Thanks for the detailed explanation from you and Qu:) If so, maybe
_get_file_block_size better than _get_block_size?

I think we can keep this case in generic directory, it's a btrfs bug reproducer
and it won't break other fs test. If someone fs hopes to change that "fill fs"
part, we can use if...else... so maybe you can add more comments about why btrfs
need this dd operation rather than _fill_fs things, to avoid others change this
part in the future.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +# Overwrite the file with a mmap write. Should succeed.
> > > +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> > > +          -c "mwrite -S 0xcd 0 1M" \
> > > +          -c "munmap"              \
> > > +          $SCRATCH_MNT/foobar
> > > +
> > > +# Cycle mount and dump the file's content. We expect to see the new data.
> > > +_scratch_cycle_mount
> > > +_hexdump $SCRATCH_MNT/foobar
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/generic/211.out b/tests/generic/211.out
> > > new file mode 100644
> > > index 00000000..71cdf0f8
> > > --- /dev/null
> > > +++ b/tests/generic/211.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 211
> > > +wrote 1048576/1048576 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > > +*
> > > +100000
> > > --
> > > 2.47.2
> > >
> > >
> >
> 

