Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E02139E
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653437; cv=none; b=PIhlCgkdUOhQWJobouQu0bnm4Lkc2PBBoLMxAP7Vlip0GBpzq/oNBAc0Em9KlGKsApghDHmGGvTHGW+cJKpKOIlTENtxSpeefQnNACxOEY1rKboNXCjVLTRhL/vZ0h5I2saruYVluKVRe8Sco9xOQHeRr8V/16IirKdHEom+x8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653437; c=relaxed/simple;
	bh=OdniFsC3mhuHraGH+4bZH6v14TDQgzuNgIGonO/f19k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryFJBUcmjjPIY0rwuI4qAg43mL/dtcQ29GOE/YTrYpS5mR/O5jTadZuzvKyHMPDeM2xFiF3De3ZGoWLfq/QtjvK3W/EFFyzhIF3dlpqgZYKGZx8FeudNReYOYOc/zTC76Sr+gLNsGhOHihEDnrS8oXz+uAeTZMYkVO9BOyTL3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPtfCQEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPtfCQEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729653435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3syr6L7EVL9DqRlN1xjhF+CIYtl5tQ4nqIVDNZKGBMs=;
	b=gPtfCQECohnbt/vjeYTIixTSzUTteKK3zrAd2shEwcqzGK49xOgs16bq5VBcMPnlFKBA+d
	B1dVqbs/Dw0BvQ4oTQ4BdpOxk/ox5pLPZY0POs1txcT4Bl0ePpiNQS+JL7RQPz/4PW3b4p
	mqitpAhmRebZIJlj8l0yw6S3ppZ1AlI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-e33VFX0mMC6x5texYbx3BQ-1; Tue, 22 Oct 2024 23:17:13 -0400
X-MC-Unique: e33VFX0mMC6x5texYbx3BQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2cc47ce63so5976361a91.3
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 20:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653432; x=1730258232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3syr6L7EVL9DqRlN1xjhF+CIYtl5tQ4nqIVDNZKGBMs=;
        b=NJMcdn6RLZOpxWNOriz87nG7ewjS4g6QGqabs9tgfldzFUm+IlZw6M5Mbs8h24mXYl
         jVDGN7dZe4ifTKeci0z9E8UcoWGiVw1jgYCB+tUwK3/ryFvxySSshJpTQ74Gte2p7tdR
         1Ucl8eK3BpagCHADqIdp7h2lLJjtQttLNjbYL3IFJ8iYfi8UP/weW7mvtbfsqu2fu90N
         mcpyOo7WTyigxLBwkUClLCQnUx0vU3Y5k9+uu6LBXSLqxB3532HNSTPkSrB04hxTsbMF
         B+QarG2OxUOfwqhbV25U+asYd5i12uazdhnsPKV9lvsHaCSMkruHUdwWvL2/5WQWswfL
         HFMw==
X-Gm-Message-State: AOJu0YyZMahb9uf+oeUfY1TJ+hfon5qijnQMqZAovh8yELZOg6IGxw5V
	/ttKynNIIatjKkrQrJ+rWeddc53Yy3jh8RI1Q0/qe7pdFx8z3SLkw2TgTflt1S78n91IcjDyBbU
	cATgQcDvkTeqDg/dw74DqfIOT3z8FuxCipGIZCyp7m2K2kPbeaJuUB4o=
X-Received: by 2002:a17:90b:4f8b:b0:2e2:b41b:8544 with SMTP id 98e67ed59e1d1-2e76b618ceamr1174639a91.21.1729653432553;
        Tue, 22 Oct 2024 20:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIPEYdpLVj7IWPwuK4xsW5PKZPdsC72atURkmmaIcf02Te6kpxz8N+slNsieR7KOGhQInY3g==
X-Received: by 2002:a17:90b:4f8b:b0:2e2:b41b:8544 with SMTP id 98e67ed59e1d1-2e76b618ceamr1174622a91.21.1729653432199;
        Tue, 22 Oct 2024 20:17:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df714f5sm220881a91.33.2024.10.22.20.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:17:11 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:17:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241023031707.povvhtilr66bv2vi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015025106.3203676-1-chao@kernel.org>
 <20241023023744.nvnuavzus26gjdj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <6ffdf1df-e4a3-4799-81d4-22f206beb720@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffdf1df-e4a3-4799-81d4-22f206beb720@kernel.org>

On Wed, Oct 23, 2024 at 10:53:09AM +0800, Chao Yu wrote:
> On 2024/10/23 10:37, Zorro Lang wrote:
> > On Tue, Oct 15, 2024 at 10:51:05AM +0800, Chao Yu wrote:
> > > This is a regression test to check whether f2fs handles dirty
> > > data correctly when checkpoint is disabled, if lfs mode is on,
> > > it will trigger OPU for all overwritten data, this will cost
> > > free segments, so f2fs must account overwritten data as OPU
> > > data when calculating free space, otherwise, it may run out
> > > of free segments in f2fs' allocation function, resulting in
> > > panic.
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   tests/f2fs/006     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/006.out |  6 ++++++
> > >   2 files changed, 58 insertions(+)
> > >   create mode 100755 tests/f2fs/006
> > >   create mode 100644 tests/f2fs/006.out
> > > 
> > > diff --git a/tests/f2fs/006 b/tests/f2fs/006
> > > new file mode 100755
> > > index 00000000..b359ef8f
> > > --- /dev/null
> > > +++ b/tests/f2fs/006
> > > @@ -0,0 +1,52 @@
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
> > > +# of free segments in f2fs' allocation function, resulting in
> > > +# panic.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_cleanup()
> > > +{
> > > +	rm -f $img
> > > +	_scratch_unmount >> $seqres.full
> > > +	cd /
> > > +	rm -r -f $tmp.*
> > > +}
> > > +
> > > +_require_scratch
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount >> $seqres.full
> > > +
> > > +img=$SCRATCH_MNT/f2fs.img
> > > +mnt=$SCRATCH_MNT/f2fs.mnt
> > > +testfile=$mnt/testfile
> > > +
> > > +mkdir $mnt
> > > +dd if=/dev/zero of=$img bs=1M count=100 2>/dev/null
> > > +$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
> > > +sync
> > > +
> > > +# use mode=lfs to let f2fs always triggers OPU
> > > +mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt
> > 
> > Hi Chao,
> > 
> > Is the loop device necessary? What if use SCRATCH_DEV and SCRATCH_MNT directly?
> 
> Hi Zorro,
> 
> It uses loop device to limit image size, so that we can speed
> up padding steps of the test since it depends on ENOSPC state.
> 
> Or maybe we can mkfs.f2fs $SCRATCH_DEV w/ specified sector size?
> Any suggestion?

Can scratch_mkfs_sized() help? I saw it supports f2fs.

Thanks,
Zorro

> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
> > > +
> > > +# it may run out of free space of f2fs and hang kernel
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> > > +dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
> > > +
> > > +mount -o remount,checkpoint=enable $mnt
> > > +umount $mnt
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> > > new file mode 100644
> > > index 00000000..a2c7ba48
> > > --- /dev/null
> > > +++ b/tests/f2fs/006.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 006
> > > +50+0 records in
> > > +50+0 records out
> > > +dd: error writing '/mnt/scratch_f2fs/f2fs.mnt/testfile': No space left on device
> > > +3+0 records in
> > > +2+0 records out
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

