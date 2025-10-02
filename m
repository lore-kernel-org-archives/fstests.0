Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCC239E81
	for <fstests@vger.kernel.org>; Thu,  2 Oct 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389243; cv=none; b=OVWJxpfZKGPj6Ck3Nq8a9g8LE+0cRKzvpYzsJovGXY8yjXyQeYTnwDl38pzTPQWk8UvWwOcA9SLtPYe7oF9pZYEPSUQifXNA4t0ZJ/j0aelascishkqlDh5ZYMGLlmS/PZgpuxapsxD9bETHQxoXLUOhQ3HWEuKagzg+8FosMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389243; c=relaxed/simple;
	bh=FBscNO4Osp8fJCrRhXQDU2USDsG0KLIXJoOhhs49+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiT3VC4YtMpY58lkkqpHMv6wbRrw7kEZeOeVyuRIVdPlM3sLLb3uAkoANvcwQB+tifRzm0fQBcEIBreU8Vp+TXtmHMh8bp82lX3veP+a+dWZxkcefOsj9S29cQCW7LgchcwFayExlBAoKnlH7jxYRNND9Bcl6xNNVFfc9e210VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXt9ytX4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXt9ytX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759389237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnZ27ieYTOSFRfY/wHn6jiluEoUMobm+VDg/9WPXtb0=;
	b=SXt9ytX4+QPlNebkOb5lWN3TfwTCIeD5gnmHi3tm/rKHnFyh6L9KlaBbLqOoDepysaDo+6
	ur8oPh/T2UohoboBDDf4me5qfGxQi8SNbwz9E6Rn0NZuVEDExiF3H0nDIcaKlZR8FkNKug
	XU3HruAFmfd5boGKFA/ljjOzb+Oy5Iw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-QYrsnL42ObKfORd-XhVQRA-1; Thu, 02 Oct 2025 03:13:55 -0400
X-MC-Unique: QYrsnL42ObKfORd-XhVQRA-1
X-Mimecast-MFC-AGG-ID: QYrsnL42ObKfORd-XhVQRA_1759389234
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so7156115ad.1
        for <fstests@vger.kernel.org>; Thu, 02 Oct 2025 00:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389234; x=1759994034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnZ27ieYTOSFRfY/wHn6jiluEoUMobm+VDg/9WPXtb0=;
        b=KfV6oDdawkA71NknwVTqTfEr5VhEC5IoLQ4u7OSaqm8UrY7VY9Ls7d3D94vzU/tcb+
         WbjvmAYWq1WvrLQr9z4QHg5Vqjd8iMdMq56dgcsebnhQBeQWv4KVSe9ANGjMQWHL+MFS
         O/Jb9GjJcJwVD96u1kF5ySGtOL3c7s8yuQjCWwsnKGNIGgBAnP3sRQkkzCi75WTJ2vCY
         V6tMigxYwBpr7deII0qOZAdYbAiIwRtwViBo24C6BPmSspNC0ax+VSPnApMPxV9KfpRI
         3+xVIP0corGO6WTSuPmhV8wAs1TOvZO8ywmijTLr+uN9r3B8y1pgWVLaYi+DhrnkxSAQ
         yOSA==
X-Gm-Message-State: AOJu0YzRCYKGg3iLo8ftqN8jQETgl+m6fpa+6T+DjRVpKAtR2y8OfTIg
	obHiUmq0Fq9ZCv9i+cNMYhwOi5bvuSXs32AS63VgM7T05fyy32feQcDcfpJesNSWoObDGGL5DbC
	X2eaj8g47TpVSlhSeHYceRgPmBKBKZjWj/lk4ZKUB2Lr6Z36F6d4felVrjIk=
X-Gm-Gg: ASbGncvRQ/ZrswGJAcC0LAWfn6VSFSzxgJbJhdmgSGMs36Zlzkmpeglfrae+yMdSQPf
	z9TFJm8p+qge2k5yT9IrbCPcocBzHf2DX0EvwpRcx5H6KiXizb3Lx7+MpkC13FaepUOJbTer1bs
	NbOlh7gWi9ItBrDl7QR9woNUOAG/MI0fTgNsEPoDANzRNGe1c2ZvoQqqHWz3+kDN5erkNny2yUL
	JUic+UPX15RyLznK3vQ8DzCWovo8J9fe5Aw1w4oNmxj2xwxi+MqFSRCnfh/14uzGIZkDGmS8dDo
	Iddio2oVCoF3XizFeonah44Ez0PyPhKLWdDqV0SCNfpkd5jIQUMHZWtcYLlfMHePRSa/1ji7750
	NhcEOdgbO2g==
X-Received: by 2002:a17:902:ebc8:b0:261:cb35:5a0e with SMTP id d9443c01a7336-28e7f4dafbemr67568525ad.57.1759389234273;
        Thu, 02 Oct 2025 00:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQB3n307tLwZdG10MItso7oQUjbG7xbdVGGydSZYosB0LXus2LOnyLPLkmvn7ogR4JYi6y4Q==
X-Received: by 2002:a17:902:ebc8:b0:261:cb35:5a0e with SMTP id d9443c01a7336-28e7f4dafbemr67568235ad.57.1759389233648;
        Thu, 02 Oct 2025 00:13:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399bc196c3sm3310645a91.0.2025.10.02.00.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:13:53 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:13:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"ethanwu@synology.com" <ethanwu@synology.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"ethan198912@gmail.com" <ethan198912@gmail.com>
Subject: Re: [PATCH] ceph/006: test snapshot data integrity after punch hole
 operations
Message-ID: <20251002071348.57mqzt6iqvlnf7hf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250930075743.2404523-1-ethanwu@synology.com>
 <7d9866d591e7fe4e5f3336aaa13107db402a608d.camel@ibm.com>
 <d6b17cbb-3504-4c3c-9f31-35c538248503@Mail>
 <cc9d84c5a3b683ccd7c86fcede503e07b048e94c.camel@ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc9d84c5a3b683ccd7c86fcede503e07b048e94c.camel@ibm.com>

On Wed, Oct 01, 2025 at 06:09:34PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2025-10-01 at 11:11 +0800, ethanwu wrote:
> > Viacheslav Dubeyko <Slava. Dubeyko@ ibm. com> 於 2025-10-01 02: 24 寫道： On Tue, 2025-09-30 at 15: 57 +0800, ethanwu wrote: > Add test to verify that Ceph snapshots preserve original file data > when the live file is modified with punch
> >  
> > Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> 於 2025-10-01 02:24 寫道：
> > 
> > 
> > > On Tue, 2025-09-30 at 15:57 +0800, ethanwu wrote:
> > > > Add test to verify that Ceph snapshots preserve original file data
> > > > when the live file is modified with punch hole operations. The test
> > > > creates a file, takes a snapshot, punches multiple holes in the
> > > > original file, then verifies the snapshot data remains unchanged.
> > > > 
> > > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > > ---
> > > >  tests/ceph/006     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/ceph/006.out |  2 ++
> > > >  2 files changed, 60 insertions(+)
> > > >  create mode 100755 tests/ceph/006
> > > >  create mode 100644 tests/ceph/006.out
> > > > 
> > > > diff --git a/tests/ceph/006 b/tests/ceph/006
> > > > new file mode 100755
> > > > index 00000000..3f4b4547
> > > > --- /dev/null
> > > > +++ b/tests/ceph/006
> > > > @@ -0,0 +1,58 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (C) 2025 Synology All Rights Reserved.
> > > > +#
> > > > +# FS QA Test No. ceph/006
> > > > +#
> > > > +# Test that snapshot data remains intact after punch hole operations
> > > > +# on the original file.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick snapshot
> > > > +
> > > > +. common/filter
> > > > +
> > > > +_require_test
> > > > +_require_xfs_io_command "pwrite"
> > > > +_require_xfs_io_command "fpunch"
> > > > +_exclude_test_mount_option "test_dummy_encryption"
> > > > +
> > > > +# TODO: Update with final commit SHA when merged
> > > > +_fixed_by_kernel_commit 1b7b474b3a78 \
> > > > + "ceph: fix snapshot context missing in ceph_zero_partial_object"
> > > > +
> > > > +workdir=$TEST_DIR/test-$seq
> > > > +snapdir=$workdir/.snap/snap1
> > > > +rmdir $snapdir 2>/dev/null
> > > > +rm -rf $workdir
> > > > +mkdir $workdir
> > > > +
> > > > +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1048576" $workdir/foo > /dev/null
> > > > +
> > > > +mkdir $snapdir
> > > > +
> > > > +original_md5=$(md5sum $snapdir/foo | cut -d' ' -f1)
> > > > +
> > > > +# Punch several holes of various sizes at different offsets
> > > > +$XFS_IO_PROG -c "fpunch 0 4096" $workdir/foo
> > > > +$XFS_IO_PROG -c "fpunch 16384 8192" $workdir/foo
> > > > +$XFS_IO_PROG -c "fpunch 65536 16384" $workdir/foo
> > > > +$XFS_IO_PROG -c "fpunch 262144 32768" $workdir/foo
> > > > +$XFS_IO_PROG -c "fpunch 1024000 4096" $workdir/foo
> > > > +
> > > > +# Make sure we don't read from cache
> > > > +echo 3 > /proc/sys/vm/drop_caches
> > > > +
> > > > +snapshot_md5=$(md5sum $snapdir/foo | cut -d' ' -f1)
> > > > +
> > > > +if [ "$original_md5" != "$snapshot_md5" ]; then
> > > > +    echo "FAIL: Snapshot data changed after punch hole operations"
> > > > +    echo "Original md5sum: $original_md5"
> > > > +    echo "Snapshot md5sum: $snapshot_md5"
> > > > +fi
> > > > +
> > > > +echo "Silence is golden"
> > > > +
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/ceph/006.out b/tests/ceph/006.out
> > > > new file mode 100644
> > > > index 00000000..675c1b7c
> > > > --- /dev/null
> > > > +++ b/tests/ceph/006.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 006
> > > > +Silence is golden
> > > 
> > > One idea has crossed my mind. I think we need to check somehow that snapshots
> > > support has been enabled. Otherwise, I believe that test will fail. But it will
> > > be better to inform about necessity to enable the snapshots support.

Weird, not sure why I didn't get this email ...

> > > 
> > > Thanks,
> > > Slava.
> > 
> > OK, I'll add the following into common/ceph
> >  
> > +# this test requires ceph snapshot support
> > +_require_ceph_snapshot()
> > +{
> > + local test_snapdir="$TEST_DIR/.snap/test_snap_$$"
> > + mkdir "$test_snapdir" 2>/dev/null || _notrun "Ceph snapshots not supported (requires fs flag 'allow_snaps' and client auth capability 'snap')"
> > + rmdir "$test_snapdir"

So ".snap" directory is a ceph specific directory for snapshot. Sorry, I never used
ceph, I'm wondering, if ceph snapshot feature isn't supported, users can't create any
directory with "." prefix, or only can't create ".snap" in ceph? Due to ".snap" directory
can be created in general filesystems (no special meaning):

  $ mkdir .snap
  $ ls -ld .snap
  drwxr-xr-x. 2 zorro zorro 6 Oct  2 15:09 .snap
  $ rm -rf .snap

Thanks,
Zorro

> > +}
> >  
> > and add 
> > +_require_ceph_snapshot
> > in ceph/006
> >  
> > is this check and error message clear enough?
> > 
> 
> Looks good. I believe it looks reasonably enough. :)
> 
> Thanks,
> Slava.

