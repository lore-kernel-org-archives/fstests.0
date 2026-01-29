Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E9313281
	for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702326; cv=none; b=qxBWdhmO1rgmClu64LB/PqNy7w6/7+HuWu3cfLC39MtkV2rv+9IBLoHg8qp87kaAvOccIJVjMGbQ30RLtAaphGbSYCssCxMSZt0vql9A9H7eu1hPtzBn12Yk4pyJTnGOarqBQJ77M6kGsJBFMgnVf+x1jWELj9WCia56l1B3zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702326; c=relaxed/simple;
	bh=LM0pwr5VwKDQf9Go9PuamwhUycB2ddoLMbe0H5hYlcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3OdEEsgn4XqaX71geVLHbHinaEXq3jbjIL1SCzKf9iAToXeLuFy607JAa5r3ZvmvcqQf9AYEXW4AqV5+wZ39fxRcam9Kq+mCh3acJJr0d8bs5C0PJsQ7zisdSJBeswXOZ7D4lOgRJ0Tx+XxzwJCrOM7HPLCar+4Ngr9Lyo2vxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZMJRFm3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXm9d96E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZMJRFm3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXm9d96E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769702324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apCKPKBIrhcrO46w9enTAYFAtIDJ2exy9qDRblUJW5k=;
	b=WZMJRFm3xlaT/2XIzqnRtS3RjYhDMcRmNm4iq+bg8Zx36rG/qnKTlPlrbjM2vaOIOWn17l
	moTRXc+MkhRLcQher+KLvve8ta0j8Fkf/cpDn8kVYbnpg/ZpdRVuRDwukob9lO79IS+I2Y
	w3RFzi2I0vqJpRT/EENa6QKf4hKdvog=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-BuPw1zHCNnWDgBtx1-RhbA-1; Thu, 29 Jan 2026 10:58:41 -0500
X-MC-Unique: BuPw1zHCNnWDgBtx1-RhbA-1
X-Mimecast-MFC-AGG-ID: BuPw1zHCNnWDgBtx1-RhbA_1769702319
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0d058fc56so8435685ad.3
        for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769702319; x=1770307119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apCKPKBIrhcrO46w9enTAYFAtIDJ2exy9qDRblUJW5k=;
        b=bXm9d96Ewtlu/7P8YvsMUNASK5lBojHpvG/7cTEJ1q4Sq7UxPd9Owxe+2uWY8oXByC
         l0rOZyLm2MTcTol9Gia4A9VDYmGtkMeSrOBfT+CjVkvt9/ydYJbeGigdZABWyzOO/Gxq
         cnQuWE4fbaGOUfNXSy+CTV+5s/BT/kWxFi06bZS2ht46XXVNlDPlhy4aSz1KXKqXau7e
         NHqhZWMBIX6vMLhyqWe3CuHw4UEATfTClsrUSFuY5JlIn3mrEWvJVFfQxYR/k1X0+Bp9
         2i2Uq9t7WxiIk7g7ky1aWzQw+bETNLusGjpc7yyu7hoD+kMQ49o7jvw0K/k1QRTzJfqK
         5zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702319; x=1770307119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apCKPKBIrhcrO46w9enTAYFAtIDJ2exy9qDRblUJW5k=;
        b=gwzHU2v7ybYpmMSqHqCmuYIvux1FmwcZaRUtwl20ERX1VER43Bk21469rOG8QNd+ED
         fPNhskrtC3CohjdfQQpSQeZsIPK1Uv1LQzx56Op3hwY+2pBXK1I8v5dzMenEJ3h0cxiv
         xdTtGrHQOxyWCx5MqFDX97/AA6//l8FfbejC32s3e94SQW+kxizQDQBhdLoVH/oIB+YK
         GtxOsQ2Aiyq/PRSy8Yb3uC9hBJDB+2HmAacehrnNiBK25595IhAgbpRemovR1qhMUmJ3
         18/TS62RdAMaUqpSV+H34K4ZOoeq28aKF3hR4UknxCjqgEoNL/ERucOqsIeehxnefXwI
         zS4w==
X-Forwarded-Encrypted: i=1; AJvYcCVgPfhRt41ohnk7XvZjpjfx6dcGZrZNPTaVQcrpd32MFecCp5guldHVgs/aEIUVNhTNJ78XeRMY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6K2n94L8dGg7eyPrYZBVBCN8LiL2eK1IHIkraGYurmG/2FfX
	zV3k4NKQT6R7MoD3Ys74He3XFUFENbl8CxcK74TKVs9CW+g46HnW1NiXJ8n0F4nAG1KFrHoxFRF
	OmHrm2ZlJU2sCGWKRh+4Qqrls9jpgoEKJmMx55E0DzyVPiduGxrflt4kMEzM=
X-Gm-Gg: AZuq6aI9H79OHKeRdhf2CiHkckBKL3xri9HxLofw+1jbfgT5LRfVK0TIujcRrWqejol
	fNOvmWJGnwPDEC1dljF12VvYzRdjAjqxgKQLt2cVxAXLxsnmb3pJFVKkL6aWL8ofzFurH1chQha
	IrGT1RY4+PUiArMq+BB2X4lME32jLgybN/xwER81WlmPhA0Q4jYPHZxLPkx3jxwmVndnqSSa/Jn
	a6rDKIY1IheVi18YiwP0QldH4sX6cRv3tBFwmsWsVMeTlPzsHWAbJUOCEEf33Fm5dKlFoy8uoIJ
	4F5e0rxgwjVvFza8bNKwipoEc+MmhZ/y5vtvwdLPIv2RR9SFGI0SxHTE6gF99lBRzzW6L1kzK7m
	HviFjTlocPJ9tIXK6WlWm9ADRK+jgZ/pE9WqynIwvWMISV16ICA==
X-Received: by 2002:a17:903:2285:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a870de3412mr101668615ad.31.1769702319269;
        Thu, 29 Jan 2026 07:58:39 -0800 (PST)
X-Received: by 2002:a17:903:2285:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a870de3412mr101668385ad.31.1769702318704;
        Thu, 29 Jan 2026 07:58:38 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef44sm56412605ad.11.2026.01.29.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:58:37 -0800 (PST)
Date: Thu, 29 Jan 2026 23:58:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org, ebiggers@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260129155833.kb363lw77ivn6lqt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260126130927.11585-1-hch@lst.de>
 <20260126194146.GB5916@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126194146.GB5916@frogsfrogsfrogs>

On Mon, Jan 26, 2026 at 11:41:46AM -0800, Darrick J. Wong wrote:
> On Mon, Jan 26, 2026 at 02:08:43PM +0100, Christoph Hellwig wrote:
> > truncate(2) doesn't go through open and needs special code to block
> > it on fsverity files.  btrfs was missing this check.
> > 
> > Note that truncate(2) in current core utils uses openat and ftruncate,
> > so add our own little test program for it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> > 
> > Changes since v1:
> >  - add the new binary to .gitignore
> >  - add a _require_test_program "truncate" call
> >  - drop the _require_test call
> 
> I'm surprised that xfs_io doesn't have a truncate() wrapper but indeed
> it does not.

Yeah, xfs_io is designed to operate on open files, so its truncate command naturally
uses ftruncate (which takes a file descriptor). However, the truncate syscall requires
a "char *path". How should we handle this discrepancy if we'd like to support the
truncate syscall in xfs_io? Should we truncate the path of the currently open file?
Should we perform a close-truncate-open sequence? Or should we add a specific option
to allow the user to provide another file path?

Thanks,
Zorro

> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > 
> >  .gitignore            |  1 +
> >  src/Makefile          |  2 +-
> >  src/truncate.c        | 17 +++++++++++++++++
> >  tests/generic/788     | 38 ++++++++++++++++++++++++++++++++++++++
> >  tests/generic/788.out |  4 ++++
> >  5 files changed, 61 insertions(+), 1 deletion(-)
> >  create mode 100644 src/truncate.c
> >  create mode 100755 tests/generic/788
> >  create mode 100644 tests/generic/788.out
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 82c57f415301..2b5bedd59fce 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -212,6 +212,7 @@ tags
> >  /src/dio-writeback-race
> >  /src/unlink-fsync
> >  /src/file_attr
> > +/src/truncate
> >  
> >  # Symlinked files
> >  /tests/generic/035.out
> > diff --git a/src/Makefile b/src/Makefile
> > index d0a4106e6be8..577d816ae859 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> >  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> >  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> > -	dio-writeback-race unlink-fsync
> > +	dio-writeback-race unlink-fsync truncate
> >  
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/truncate.c b/src/truncate.c
> > new file mode 100644
> > index 000000000000..4c106d26f29e
> > --- /dev/null
> > +++ b/src/truncate.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2026 Christoph Hellwig.
> > + */
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	if (truncate(argv[1], 0) < 0) {
> > +		perror("truncate");
> > +		exit(1);
> > +	}
> > +
> > +	fprintf(stderr, "truncate succeeded\n");
> > +}
> > diff --git a/tests/generic/788 b/tests/generic/788
> > new file mode 100755
> > index 000000000000..ac4720d740f0
> > --- /dev/null
> > +++ b/tests/generic/788
> > @@ -0,0 +1,38 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 Christoph Hellwig.
> > +#
> > +# FS QA Test 788
> > +#
> > +# Test that truncate(2) is blocked on fsverity files.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick verity
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	_restore_fsverity_signatures
> > +	rm -f $tmp.*
> > +}
> > +
> > +. ./common/filter
> > +. ./common/verity
> > +
> > +_require_scratch_verity
> > +_require_test_program "truncate"
> > +
> > +_disable_fsverity_signatures
> > +
> > +_scratch_mkfs_verity &>> $seqres.full
> > +_scratch_mount
> > +
> > +fsv_file=$SCRATCH_MNT/file.fsv
> > +
> > +_fsv_scratch_begin_subtest "Using truncate(2) on a verity file fails"
> > +_fsv_create_enable_file $fsv_file
> > +$here/src/truncate $fsv_file
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/788.out b/tests/generic/788.out
> > new file mode 100644
> > index 000000000000..11074b71f3eb
> > --- /dev/null
> > +++ b/tests/generic/788.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 788
> > +
> > +# Using truncate(2) on a verity file fails
> > +truncate: Operation not permitted
> > -- 
> > 2.47.3
> > 
> > 
> 

