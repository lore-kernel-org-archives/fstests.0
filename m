Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36031D7994
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192269; cv=none; b=TCbUKf9eekPOp4BHFuqZ+GZGNo0ppPSuxxRU7+NOrW/ZrAzCU3C//VENhKRiuv5Gtf7g6ezD8JFyfkUQ7yUE2Bm588EbUAXWCQ+zACkn4vGggrC7n1KKC4KSZV2VSjhmeNDyZABs+Go5/Z2UTmXTHOEQLKXFbcp7tmXnhEa2m10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192269; c=relaxed/simple;
	bh=InFXADZdYbcn/S1PeW2+0CT6g3Jy5QhUJTDZ5o9A++U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPUi7+gGoyf+GmB3H1NeLAg8lp722rmcNEBA+HBcvQgmsdiDnxLXEKpmU55WwZ7VvS8eG0Z9VPCQ0z9lMlmczsKCRCIKbsOpmaaAIM8vHduwXKoopXpT433P2JS6T+sb202MrPkZHrqI5whDwsnyZLtWL7tpRyh3HQ8tl13N0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMMIXmMs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMMIXmMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730192265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+VK9FfkQO2fpVwYxdxEEmHb9xMJtqTdpcSiRIzUgN0=;
	b=BMMIXmMsZoA5d13E6mvY5v2FWHHkUgpJw5sJk/kzhc5qISx9376OiR1JhCZGSwN0ocJUsq
	mbXkxd56k+lgHOwGtG9HXaHwl8+ocU7y5shG1tZVYZ2Vha4lEQPfGaSOlEEkOCo9nXTk3b
	0tNtN5J49vj/LvVyNI25AeFdRde9WNA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Iuf-ntSEMqm9mpCGvunzOw-1; Tue, 29 Oct 2024 04:57:43 -0400
X-MC-Unique: Iuf-ntSEMqm9mpCGvunzOw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20e67b82aa6so58185525ad.0
        for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 01:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192262; x=1730797062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+VK9FfkQO2fpVwYxdxEEmHb9xMJtqTdpcSiRIzUgN0=;
        b=d05AQoWGEm16lCHbIhDZsNQDjQb2il8GPbAIJFQ+s2MYlaHL6cytp2cUNDQRJe+7j0
         5+hzzV98Cuykywn+HscHH3uicvEyZCnVbANoTDcnsGhUVKnj47KVH9Yw+Hj7uyi7blOE
         5vCKLbzE74e8e1eRHwYN57IV5SD1vYzy+4ndGEJYYZuOv19Gf9LoMKQ2Jz8zvRAnKTnD
         uAuBoowFYet9H+eIXIa6HUrvDRAFRApIsJd+jo6u/H3M+JyB2Mzh//VxAFS7RW3++5bU
         dfT8k4vmL8DWXKPvVzDq3YzGHggksECQ5kCmyK1eQBuR5U0vOWKzIt5el8Tj+L+NmFAw
         M7TQ==
X-Gm-Message-State: AOJu0Yx4a3SzWN020Ma2YHSqeU0e1eWsb2on9ZpNN27yDuTXDgQTXzAP
	YMeYi2qWPLH25V5HZmXrHhkOiGlH2WGhwTYDYCv3iJiYhdz976BtPOZuuJ/g2vgDT6rbUjmPw3B
	+376vK03IG4pKY66IW2SAMWD3tTEGwHgdRW59yLy4QhH+azqjMUoA3S0=
X-Received: by 2002:a17:902:f612:b0:20c:8f78:67be with SMTP id d9443c01a7336-210c6c3e341mr176223325ad.40.1730192262147;
        Tue, 29 Oct 2024 01:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcZsIOTrd+Iy1sZfJI5vYbW2mYAaKN3wSCAZMYb14CDeMLJcPOxxhhj42zywedf0qGGvPQ3w==
X-Received: by 2002:a17:902:f612:b0:20c:8f78:67be with SMTP id d9443c01a7336-210c6c3e341mr176223205ad.40.1730192261813;
        Tue, 29 Oct 2024 01:57:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf702f1sm62297555ad.105.2024.10.29.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:57:41 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:57:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241029085735.equs7ce55lcelgff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
 <20241029060919.gxyywjp3gykaqnuc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <324c9b1a-ca86-43a4-8c3a-990199c714bc@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324c9b1a-ca86-43a4-8c3a-990199c714bc@kernel.org>

On Tue, Oct 29, 2024 at 03:46:21PM +0800, Chao Yu wrote:
> On 2024/10/29 14:09, Zorro Lang wrote:
> > On Mon, Oct 28, 2024 at 10:17:59PM +0800, Chao Yu wrote:
> > > This is a regression test to check whether f2fs handles dirty
> > > data correctly when checkpoint is disabled, if lfs mode is on,
> > > it will trigger OPU for all overwritten data, this will cost
> > > free segments, so f2fs must account overwritten data as OPU
> > > data when calculating free space, otherwise, it may run out
> > > of free segments in f2fs' allocation function. If kernel config
> > > CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
> > > dd may encounter I/O error.
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v3:
> > > - explain more about behavior on kernel w/ different config
> > > - use _filter_scratch to filter $SCRATCH_MNT
> > >   tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/006.out |  6 ++++++
> > >   2 files changed, 48 insertions(+)
> > >   create mode 100755 tests/f2fs/006
> > >   create mode 100644 tests/f2fs/006.out
> > > 
> > > diff --git a/tests/f2fs/006 b/tests/f2fs/006
> > > new file mode 100755
> > > index 00000000..f9560b2b
> > > --- /dev/null
> > > +++ b/tests/f2fs/006
> > > @@ -0,0 +1,42 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. f2fs/006
> > > +#
> > > +# This is a regression test to check whether f2fs handles dirty
> > > +# data correctly when checkpoint is disabled, if lfs mode is on,
> > > +# it will trigger OPU for all overwritten data, this will cost
> > > +# free segments, so f2fs must account overwritten data as OPU
> > > +# data when calculating free space, otherwise, it may run out
> > > +# of free segments in f2fs' allocation function. If kernel config
> > > +# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
> > > +# dd may encounter I/O error.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +	"f2fs: fix to account dirty data in __get_secs_required()"
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +
> > > +_require_scratch
> > > +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
> > > +
> > > +# use mode=lfs to let f2fs always triggers OPU
> > > +_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
> > > +
> > > +testfile=$SCRATCH_MNT/testfile
> > > +
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
> > > +
> > > +# it may run out of free space of f2fs and hang kernel
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 | _filter_scratch
> > > +
> > > +_scratch_remount checkpoint=enable
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> > > new file mode 100644
> > > index 00000000..2dc9efda
> > > --- /dev/null
> > > +++ b/tests/f2fs/006.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 006
> > > +50+0 records in
> > > +50+0 records out
> > > +dd: error writing 'SCRATCH_MNT/testfile': No space left on device
> > > +3+0 records in
> > > +2+0 records out
> > 
> > Hi Chao,
> > 
> > One more question about this patch.
> > 
> > I'm wondering can this output always be matched? If the test doesn't care the dd output,
> > you can filter out them, to avoid it break golden image. Especially the second one, can
> > you be sure it always "3 in and 2 out" before returning ENOSPC?
> 
> Zorro,
> 
> I got your concern, how about using _check_dmesg to catch the kernel
> bug instead? since once the bug was triggered, f2fs will call BUG_ON
> or WARN_ON optionally anyway.

Hi Chao,

The _check_dmesg is always called at the end of each test. Except you
need a dmesg filter, or you don't need to call it manually.

My concern is "unstable output cause unexpected failure on fixed kernel".
If you think the last "dd" output is unstable and useless on fixed kernel,
you can filter it out, just let the dmesg/hang break the test.

e.g.

  # The 2nd dd might run out of space, and trigger a kernel warning or hang on
  # unfixed kernel
  dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >/dev/null
  dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 >/dev/null | _filter_scratch

or if you feel the error output isn't stable either, you can:

  # The 2nd dd might run out of space, and trigger a kernel warning or hang on
  # unfixed kernel
  dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full
  dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
  ...
  echo "Silence is golden"

Or if you need those output, please make sure it's a stable output on any fixed
system :)

Thanks,
Zorro

> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

