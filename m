Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D91E883C
	for <fstests@vger.kernel.org>; Thu, 14 Nov 2024 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560802; cv=none; b=kSGogIy9p9ZblreNJxXSQXbsIl1jtKxCenxNPXQ4UZFCy22hi1Pz0i55CQtgMOFOsJBTBvDMDoKRqLwyTBAYY+2oq+YtYcVy/xHNVoxZnJ+OLtj7QyhWWaFGbpqF1/aJ8LujlnHDZwz7WcUHJEHC3/iy44no3mCAkuZYKma35ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560802; c=relaxed/simple;
	bh=enuntdKQPmJre8NuZeNRVHeONSPVYY6AUVaUSdHjUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc4cJUBaMYEB1to4D4PiyFTsI9fMCTHcQV9IexdbgyIhCAiT2Sc9oRQSWPG9VvUmxEGWL/f5z1noezarYJDPDRyuDFtSy/Gajn/EmmOkeyM7waOHA8KOs+t/vMa0ioD6ZZ5HDnzLkpC8xtlZUddyTpI/UXrKDveK8JW2i88rryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbV+cpgA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbV+cpgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731560798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Jqud2IVP7zzdxUPZ1oFxPggl+KE559/PDaSdzFX4Zc=;
	b=GbV+cpgAwbLwsPPizUEIP26ES5XeFL7IuNHQKq1DROAn8JUIDeLjT3K9igy4CNdNgdpddB
	4zzT1mGSWElvUf9pNC5HBh5BUjWAVRfloohYsEQDAyvK+OouVPDSl5X/OP+CWe18WkLVtt
	1XehHmcQhildWhckOLJSFnq9y8MbaSc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-4Iq7fKKMP5aMxt20F0UXhQ-1; Thu, 14 Nov 2024 00:06:36 -0500
X-MC-Unique: 4Iq7fKKMP5aMxt20F0UXhQ-1
X-Mimecast-MFC-AGG-ID: 4Iq7fKKMP5aMxt20F0UXhQ
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e8641f2a7so216412b3a.2
        for <fstests@vger.kernel.org>; Wed, 13 Nov 2024 21:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731560795; x=1732165595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jqud2IVP7zzdxUPZ1oFxPggl+KE559/PDaSdzFX4Zc=;
        b=hM/dm81X/EjCQf4O0vc5p1h0u4zyKsKjckVBL1BYeH/TirUoMcx/jQPf7PDTWSfYuf
         Llr1fdKimziCE4LaP3kppS/5PGaGFTFUJMIsOl3MrZWLQY4+sacmKd/k9E/TT5g37KPt
         Mv2vBq/jGDecyzz63OYUEr1aYW3wS26oSo+etD1CZCNUYAIR+lIlTW7uJm2VkIKu4rUM
         EBweEILmA1RyPIPbAML/n48jHB0AF3jmqQnjGjPpUybEVbtg7jla2jN13J+rrtrwAE/G
         RIxT4CTCIBZeaauitdPqIyIxKDlkv0/FE5P+8lAEwFV8x/+spsk7QTNVnZ4HfpVUL1AY
         mzfw==
X-Forwarded-Encrypted: i=1; AJvYcCUuJd+KkJf0eJE+9t0FITur7rpUJcWGsm/2+vko4FuZ742JLRcFMAiwRpD5s4NYfKSQg9TQ67TP@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb1ZczkHnoJdMuuIOQFHKlE6+GiCnPwCMzWk1jjTphvNxBPdB
	0g7Gfkcga7aglwKGx33rD7hdHY27ux0PQzRN2G1VTIXFp8QR9O6eXAXNfLP25PKWJ02QOc/D9dT
	VwcoPP1bAQW8RLiPHgwTWkzWIfSmK+/QYxT33T5mtLEEkKOvv+6w0uIc=
X-Received: by 2002:a05:6a00:3d52:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-72469c5e105mr1298448b3a.2.1731560795596;
        Wed, 13 Nov 2024 21:06:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuZOyu69HMTCM/PQvXkY9mQ4vqvkoyLnNsxniyDlDhlOoV1Q7kRd65EDOQphDAaMsYZIa6pg==
X-Received: by 2002:a05:6a00:3d52:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-72469c5e105mr1298421b3a.2.1731560795129;
        Wed, 13 Nov 2024 21:06:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a6e7b40sm329640b3a.58.2024.11.13.21.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 21:06:34 -0800 (PST)
Date: Thu, 14 Nov 2024 13:06:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Message-ID: <20241114050631.x3urk2ti4ukgtaai@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
 <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>

On Wed, Nov 13, 2024 at 12:28:33PM +0000, Mark Harmstone wrote:
> On 12/11/24 09:37, Johannes Thumshirn wrote:
> > > 
> > On 11.11.24 15:56, Mark Harmstone wrote:
> >> Add btrfs/333 and its helper programs btrfs_encoded_read and
> >> btrfs_encoded_write, in order to test encoded reads.
> >>
> >> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
> >> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
> >> that it matches what we've written. If the new io_uring interface for
> >> encoded reads is supported, we also check that that matches the ioctl.
> >>
> >> Note that what we write isn't valid compressed data, so any non-encoded
> >> reads on these files will fail.
> >>
> >> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> >> ---
> >>    .gitignore                |   2 +
> >>    src/Makefile              |   3 +-
> >>    src/btrfs_encoded_read.c  | 175 ++++++++++++++++++++++++++++++
> >>    src/btrfs_encoded_write.c | 206 +++++++++++++++++++++++++++++++++++
> >>    tests/btrfs/333           | 220 ++++++++++++++++++++++++++++++++++++++
> >>    tests/btrfs/333.out       |   2 +
> >>    6 files changed, 607 insertions(+), 1 deletion(-)
> >>    create mode 100644 src/btrfs_encoded_read.c
> >>    create mode 100644 src/btrfs_encoded_write.c
> >>    create mode 100755 tests/btrfs/333
> >>    create mode 100644 tests/btrfs/333.out
> >>
> >> diff --git a/.gitignore b/.gitignore
> >> index f16173d9..efd47773 100644
> >> --- a/.gitignore
> >> +++ b/.gitignore
> >> @@ -62,6 +62,8 @@ tags
> >>    /src/attr_replace_test
> >>    /src/attr-list-by-handle-cursor-test
> >>    /src/bstat
> >> +/src/btrfs_encoded_read
> >> +/src/btrfs_encoded_write
> >>    /src/bulkstat_null_ocount
> >>    /src/bulkstat_unlink_test
> >>    /src/bulkstat_unlink_test_modified
> >> diff --git a/src/Makefile b/src/Makefile
> >> index a0396332..b42b8147 100644
> >> --- a/src/Makefile
> >> +++ b/src/Makefile
> >> @@ -34,7 +34,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >>    	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> >>    	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> >>    	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> >> -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
> >> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> >> +	btrfs_encoded_read btrfs_encoded_write
> >>    
> >>    EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >>    	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> >> diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
> >> new file mode 100644
> >> index 00000000..a5082f70
> >> --- /dev/null
> >> +++ b/src/btrfs_encoded_read.c
> >> @@ -0,0 +1,175 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// Copyright (c) Meta Platforms, Inc. and affiliates.
> >> +
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <string.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <unistd.h>
> >> +#include <sys/uio.h>
> >> +#include <sys/ioctl.h>
> >> +#include <linux/btrfs.h>
> > 
> > For this I need
> > 
> > +#include <linux/io_uring.h>
> > 
> > otherwise I get:
> > 
> >       [CC]    btrfs_encoded_read
> > /bin/sh ../libtool --quiet --tag=CC --mode=link /usr/bin/gcc-13
> > btrfs_encoded_read.c -o btrfs_encoded_read -g -O2 -g -O2 -DDEBUG
> > -I../include -DVERSION=\"1.1.1\" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> > -funsigned-char -fno-strict-aliasing -Wall -DHAVE_FALLOCATE
> > -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE   -lhandle -lacl -lpthread -lrt
> > -luuid -lgdbm_compat -lgdbm -laio
> >    -luring   ../lib/libtest.la
> > btrfs_encoded_read.c: In function 'encoded_read_io_uring':
> > btrfs_encoded_read.c:100:26: error: 'IORING_OP_URING_CMD' undeclared
> > (first use in this function); did you mean 'IORING_OP_LINKAT'?
> >     100 |         io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc,
> > sizeof(enc), 0);
> >         |                          ^~~~~~~~~~~~~~~~~~~
> >         |                          IORING_OP_LINKAT
> > btrfs_encoded_read.c:100:26: note: each undeclared identifier is
> > reported only once for each function it appears in
> > btrfs_encoded_read.c:101:12: error: 'struct io_uring_sqe' has no member
> > named 'cmd_op'
> >     101 |         sqe->cmd_op = BTRFS_IOC_ENCODED_READ;
> >         |            ^~
> > 
> > during compilation.
> > 
> > Not sure if a ./configure macro thingy should/would solve this.
> 
> We could do that, but elsewhere we're using liburing.h rather than the 
> kernel version.
> 
> It looks like IORING_OP_URING_CMD was added to liburing with version 
> 2.2, which came out in June 2022. I don't know whether that's old enough 
> that we can just declare it as our minimum version, whether we should be 
> probing for the liburing version, whether we should be working round 
> this somehow, or what.
> 
> Zorro, what do you think?

2022 was just 2 years ago, some downstream distributions might use old version.
I think that might be too early to leave a "2 years ago" system out of the using of
latest xfstests :)

Thanks,
Zorro

> 
> Mark
> 

