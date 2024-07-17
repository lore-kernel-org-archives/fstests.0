Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1617F362
	for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229627; cv=none; b=TzT/svr7KERXogGk2Yz0xZ3ueHgjlRMHZ7rVbXqDaUARdE0OLcKV3Pmk3p1RVBZdbpfQpr1rZ/SLwbshKDACbRd/lIv9EXWeymJ69NYvETThU+3aElKK5Yv9AfK+sR54kRJP1mXsRCIQAW8aFI3NbSqWKlmokyGrtrrUk+1DwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229627; c=relaxed/simple;
	bh=ztoI86M0tRnE3cOjANvgFIOAgwM6TsoQyRacx/Nrch4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udd8aQR+e8OLo3kGwTk1DlCARrQdldsO/CV+rk5qIxSDMKY10JfrZP4sq+XVHXf1tsrBvfnj/Loqd7dCPSnTWYZzPqdrHz27fkuRIv1oL5OzCLIsKBVgFbyffamuiJR7vBtdupXY5DD/rzdejzSU6KUKtPHek/rD8CT3WcqSbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akDaEPQ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akDaEPQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721229623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSrxkKH5oX3hAbxIHU7zSBxDFHpf2cFpqd3Al4ItjBs=;
	b=akDaEPQ79eklm9MiNqVbS6XoboKvx26YpFL8R402U37/TjngZg0iAtZpF4yF1PkifLs1SP
	OCgKc/bceWpdjR1PpIjRtlp7OYKon8QVDu0ksD99g7ZWwhqPfNoTNsXvvdX6CJXE2/vdaw
	Lmu3hyyxU0JniUzTxNj16uUnS6PmASY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-VCdEUKvCP0qEcAhohc5-1w-1; Wed, 17 Jul 2024 11:20:22 -0400
X-MC-Unique: VCdEUKvCP0qEcAhohc5-1w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-767c010fe18so5094878a12.2
        for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229621; x=1721834421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSrxkKH5oX3hAbxIHU7zSBxDFHpf2cFpqd3Al4ItjBs=;
        b=xAIjrKSOWqddGxt1aHDlXZFpekH1iHndTrUMp3oAUiNCToelaAi/mUy3ijwbLvzr46
         SLR2/4g2TU8dySxYQHOItoDpXi/MmgfNOXlqNfh+n5LyMQIzIx9HuAsf8/pDQsHbEIDH
         QpUJL27Oee/PyfM99F+LXlH9MLuPqABsomakEtOmbcaOVdPaI9zufD+iD01UcjLldAyt
         2xiEi/3R3o3dVuZo1e+g/dEDHr6/JM04J9kGZnNEjsYRqAnT8JcK7PN6kxvxuMOf7Os0
         cwbASsYxw6Bf8/TZqxe9Q8UjKerZT/SNvxYtxHJCx0t0sND9r5hW5eUDC7Hqwz3CJcQ2
         zpHA==
X-Gm-Message-State: AOJu0Ywu4gCOael2NAxcaqAL7HRxNO5SWLa8QN31Fe2yHQ9+gkudO/Fr
	fiE1bIgprBQE/bIlvJYo5EYtYZyJ1FmgRfDh10IFOgu/PF9iZqdogXOM1x8otISRNAxPw5wU+Sf
	6cB7Wbqy7UlXBAbU3uX18FnxNEv8uA3c1im6N4AqMDlrr/ksFBDwSDWM=
X-Received: by 2002:a05:6a20:c997:b0:1c0:e652:1b2f with SMTP id adf61e73a8af0-1c3fdd18396mr1988292637.33.1721229621172;
        Wed, 17 Jul 2024 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/ki/F3RVX1SgOVKSHoLyh6+jjbGSAxasEiuoavCPRCvKSas4A+ciKv15wZTqxvuPZFITTQ==
X-Received: by 2002:a05:6a20:c997:b0:1c0:e652:1b2f with SMTP id adf61e73a8af0-1c3fdd18396mr1988269637.33.1721229620770;
        Wed, 17 Jul 2024 08:20:20 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7dfddsm8221024b3a.101.2024.07.17.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:20:20 -0700 (PDT)
Date: Wed, 17 Jul 2024 23:20:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: test for race condition in between atomic_write
 and gc
Message-ID: <20240717152017.5i6z4nmjst26ak7f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240625030416.3553498-1-chao@kernel.org>
 <20240716105710.v76icnjhqmvjmgsd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <fba75c06-b0d9-4e92-b673-9c11314744c1@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba75c06-b0d9-4e92-b673-9c11314744c1@kernel.org>

On Wed, Jul 17, 2024 at 10:12:16AM +0800, Chao Yu wrote:
> On 2024/7/16 18:57, Zorro Lang wrote:
> > On Tue, Jun 25, 2024 at 11:04:16AM +0800, Chao Yu wrote:
> > > Test that we will simulate sqlite atomic write logic w/ below steps:
> > > 1. create a regular file, and initialize it w/ 0xff data
> > > 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> > > 3. write transaction data
> > > 4. trigger foreground GC to migrate data block of the file
> > > 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> > > 6. check consistency of transaction w/ in-memory and on-disk data
> > > This is a regression test to check handling of race condition in
> > > between atomic_write and GC.
> > 
> > Hi Chao,
> > 
> > Sorry for the late reviewing. As this's a regression test, so which onne
> > kernel commit fix this known issue, please specify it by:
> > 
> > _fixed_by_kernel_commit $commit_id $commit_subject
> 
> Hi Zorro,
> 
> Since the fixed patch has not been merged yet, so what about adding this line
> after merging the fix?

Oh, sure, but generally they'd like to use "xxxxxxxxxxxx" to be the $commit_id
(as a reminder) if there's not an assured id number. Then replace the "xxxxxx...."
with the right id number after the patch merged. But it depends on you, just
don't forget that :)

Thanks,
Zorro

> 
> > 
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Cc: Daeho Jeong <daehojeong@google.com>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   tests/f2fs/003     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/003.out | 11 +++++++++
> > >   2 files changed, 72 insertions(+)
> > >   create mode 100755 tests/f2fs/003
> > >   create mode 100644 tests/f2fs/003.out
> > > 
> > > diff --git a/tests/f2fs/003 b/tests/f2fs/003
> > > new file mode 100755
> > > index 00000000..d8311c4c
> > > --- /dev/null
> > > +++ b/tests/f2fs/003
> > > @@ -0,0 +1,61 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. f2fs/003
> > > +#
> > > +# Test that we will simulate sqlite atomic write logic w/ below steps:
> > > +# 1. create a regular file, and initialize it w/ 0xff data
> > > +# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
> > > +# 3. write transaction data
> > > +# 4. trigger foreground GC to migrate data block of the file
> > > +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> > > +# 6. check consistency of transaction w/ in-memory and on-disk data
> > > +# This is a regression test to check handling of race condition in
> > > +# between atomic_write and GC.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +. ./common/filter
> > > +
> > > +_supported_fs f2fs
> >      ^^^^^
> > This line is not necessary now.
> > 
> > > +_require_scratch
> > > +_require_xfs_io_command "pwrite"
> > 
> > pwrite is a basic command of xfs_io, so I think this line is not necessary.
> > 
> > > +_require_xfs_io_command "fpunch"
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount >> $seqres.full
> > > +
> > > +dbfile=$SCRATCH_MNT/dbfile
> > > +foo=$SCRATCH_MNT/foo
> > > +bar=$SCRATCH_MNT/bar
> > > +
> > > +$XFS_IO_PROG -c "pwrite 0 512k -S 0xff" -c "fsync" -f $dbfile >> $seqres.full
> > > +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $foo >> $seqres.full
> > > +sync
> > > +
> > > +# start atomic_write on dbfile & write data to dbfile
> > > +$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
> > 
> > As there's a background process, shouldn't we do kill and wait in _cleanup
> > to make sure unmount won't hit EBUSY?
> > 
> > > +$XFS_IO_PROG -c "fpunch 0 2m" $foo >> $seqres.full
> > > +$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $bar >> $seqres.full
> > > +
> > > +# persist all dirty data
> > > +sync
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +
> > > +# trigger foreground GC to migrate data block of atomic_file
> > > +$F2FS_IO_PROG gc 1 $SCRATCH_MNT > /dev/null 2>&1
> > > +
> > > +# wait for atomic_write commit completion
> > > +sleep 5
> > > +# print in-memory data
> > > +od -x $dbfile
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +# print on-disk data
> > > +od -x $dbfile
> > 
> > There's a common helper named "_hexdump" in common/rc, can that be used?
> > 
> > > +
> > > +_scratch_unmount
> > 
> > The SCRATCH_DEV will be unmounted at the end of the test, don't need to
> > do this manually if it's not a necessary test step.
> 
> Let me update this patch according to your comments, thanks.
> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
> > > new file mode 100644
> > > index 00000000..d6c8a637
> > > --- /dev/null
> > > +++ b/tests/f2fs/003.out
> > > @@ -0,0 +1,11 @@
> > > +QA output created by 003
> > > +0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > > +*
> > > +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
> > > +*
> > > +2000000
> > > +0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > > +*
> > > +0400000 ffff ffff ffff ffff ffff ffff ffff ffff
> > > +*
> > > +2000000
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

