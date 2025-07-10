Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD62288C8D
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132580; cv=none; b=SBBApQwNkk07X/fgNuvIv5EjOe0SeP+3uCyNnfX4fcAtdMOYhXy1ClODH/EPq9KmUK0Nv3ss4eP+tFAj9ioph9tdofaWu1rxid0jt71sFEbnf+3itLpCxWK+E0lGNMN+MmpA44AN6GOPT4v+by1YO/GhU/GgRiOS49JPlYiwLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132580; c=relaxed/simple;
	bh=R8EipCxdU3PVl0tdLEk0mFFad9Gdcz9No/wiCW3k7/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjXXwTRhDleQYDctfhTrsl6MpQkepsDizFgA/sO8E0aN6ignmLcFDi8m0cbfW+GneySiSXoKthnPDOLf58mqpgyKs6gZOQhp0TguOrsogxX7nGqi21Xbjf1pWBzpW+I0/QeLVX1gv4vMwhGphVwfJAnDKiwGMi7Al5dMr9pdv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e57HCEhY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e57HCEhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752132577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fepGkfCQMKLcAnWI7GqA+ecbi4ubuIxZYETmUVYEd94=;
	b=e57HCEhYXFcZ2Tz8WhvspKi85Q1SQdaskHfAg3zjxfUKCrKVHsKo9FinSFcypEKz2BKZ/f
	oxeZiQUG9YNL4XqIalzoVjIBp4ulA1mB9pf2D5ld6LArwCY953EgSAIsQ8uSwySe+WJdHN
	0bR2SuAu22xQsIrLv6jKMSfxXCjWVmo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-0SfNyEDMOmuJhgvFgwMxwg-1; Thu, 10 Jul 2025 03:29:34 -0400
X-MC-Unique: 0SfNyEDMOmuJhgvFgwMxwg-1
X-Mimecast-MFC-AGG-ID: 0SfNyEDMOmuJhgvFgwMxwg_1752132574
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23536f7c2d7so11854175ad.2
        for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 00:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752132574; x=1752737374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fepGkfCQMKLcAnWI7GqA+ecbi4ubuIxZYETmUVYEd94=;
        b=Q31va2uMIVW1ncLz0yNQsYpbsIQ0imXLH0rlyEavje/MYk/VL0H2iWzGQ1gWMjg5WR
         Q0/otbk9ghbeoK/fctIgTcqR+7UzaNM5fA/bXYn69xymue9Og0FnOximUB0/eGyv9u4v
         sZlBhLN4k9IBvD+NkmUDT3Zdi0urN/DUTiPcEZTSUKbQ7wPxddCtXEJk8oX0nUSIOYNs
         1n6jU3DRF2KKc41YUAEz0a2RrYf4vtB+KSz/cEJ0weyW3WemSVAdNSw4actwuqMukn+u
         KyqQwyWSWvC3zU2vZ5uyWJ2moql3CR4gNuKWNi94uAhaXtclaEBno/4NbrKJ918gOL+u
         NG4Q==
X-Gm-Message-State: AOJu0YxR0zXYav5883fHyX2LfvPSfoG7NRWMfKI1vyHvAvajNpMCcjgE
	a51De15OqaWDKJOMZpQlPvfya4Gyyp6m6URA6ckoXjZOpLYxtUFEyznXRJ5+CFc5/D0jg58GtPE
	tZSDxyIfmgyxlquD5dnIo1S/iR2bTBUHl7b/P8ExzgLHXki4T6beBGE6nLKA=
X-Gm-Gg: ASbGnctXO+XW6o8r03G1i7n7/YhtHPbZd140fz71qpZ06QvQofszno8sLZUy72WLRdU
	4rX372F4yua5SUwHipnWcpTfYmqgQVdc02Yis/mVBuyzPfcfhmqANCYTsthGLlmv6gD03qlW6yJ
	/qQG8o9/4vJ5lssSSH2qrmGZQKvGR5/bmMO0gCChNcxnOf2OFItmsy3HHYJRqjs2AFhaHcqOVvV
	ZM0tmvjF2kjEoMYRFXbspmbKwWN55ISJ1FSuH9jzMY1fQyb+1pe/QmPWTfPUyYzTNYPS1jj2eef
	Vlj+RuBNFUajRSXLyLCAvvEIaEZe8owweQIjVbVHNaUXZIXWbpcF9vEzt/XsSDo=
X-Received: by 2002:a17:903:2445:b0:234:c549:da10 with SMTP id d9443c01a7336-23de4895596mr24082905ad.47.1752132573847;
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKYKaiXyhmhsXDpt36xy6hcE+/2REseEbAF6LNznJ+WbhqMKbD4EV9+KnuZDFxJ/w7JT4tuQ==
X-Received: by 2002:a17:903:2445:b0:234:c549:da10 with SMTP id d9443c01a7336-23de4895596mr24082665ad.47.1752132573501;
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm12218015ad.189.2025.07.10.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:29:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>

On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that overwriting a file with mmap when the filesystem has no more
> space available for data allocation works. The motivation here is to check
> that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> 
> This currently fails with btrfs but it's fixed by a kernel patch that has
> the subject:
> 
>    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/211.out |  6 +++++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/211
>  create mode 100644 tests/generic/211.out
> 
> diff --git a/tests/generic/211 b/tests/generic/211
> new file mode 100755
> index 00000000..c77508fe
> --- /dev/null
> +++ b/tests/generic/211
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 211
> +#
> +# Test that overwriting a file with mmap when the filesystem has no more space
> +# available for data allocation works. The motivation here is to check that
> +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw mmap
> +
> +. ./common/filter
> +
> +_require_scratch
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> +
> +# Use a 512M fs so that it's fast to fill it with data but not too small such
> +# that on btrfs it results in a fs with mixed block groups - we want to have
> +# dedicated block groups for data and metadata, so that after filling all the
> +# data block groups we can do a NOCOW write with mmap (if we have enough free
> +# metadata space available).
> +fs_size=$(_small_fs_size_mb 512)
> +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> +	_fail "mkfs failed"

_scratch_mkfs_sized calls _notrun if it fails:

  _scratch_mkfs_sized()
  {
        _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
  }

So you can let it _notrun:
_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1

or you'd like to _fail:

_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
	 _fail "mkfs failed"

> +_scratch_mount
> +
> +touch $SCRATCH_MNT/foobar
> +
> +# Set the file to NOCOW mode on btrfs, which must be done while the file is
> +# empty, otherwise it fails.
> +if [ $FSTYP == "btrfs" ]; then
> +	_require_chattr C
> +	$CHATTR_PROG +C $SCRATCH_MNT/foobar
> +fi
> +
> +# Add initial data to the file we will later overwrite with mmap.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now fill all the remaining space with data.
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1

As this's a generic test case, I'm wondering if the common/populate:_fill_fs()
helps?

Thanks,
Zorro

> +
> +# Overwrite the file with a mmap write. Should succeed.
> +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> +	     -c "mwrite -S 0xcd 0 1M" \
> +	     -c "munmap"              \
> +	     $SCRATCH_MNT/foobar
> +
> +# Cycle mount and dump the file's content. We expect to see the new data.
> +_scratch_cycle_mount
> +_hexdump $SCRATCH_MNT/foobar
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/211.out b/tests/generic/211.out
> new file mode 100644
> index 00000000..71cdf0f8
> --- /dev/null
> +++ b/tests/generic/211.out
> @@ -0,0 +1,6 @@
> +QA output created by 211
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +100000
> -- 
> 2.47.2
> 
> 

