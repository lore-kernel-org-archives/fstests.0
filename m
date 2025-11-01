Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6B34D3B9
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996997; cv=none; b=CL8pmrqC0iq5n7WfvJ3RJTQvRCAO6OdkmZxgft2+t1fUdwYbD5bDBBsu5U6NzqLG/x/JtcWiNHDUgPjg2GSkhx+VSVlCqjwtswuuk2XpexB5shB1d2DG52eI3nmJHQQtseYVVwHXiwSIsHT3Si3S/AWjrEgDOXWCxEr4rT0jNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996997; c=relaxed/simple;
	bh=wlRLY6uDnNXYDAhFpmqPQuWhBeWre6jGZ//wRh13LYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD4IGlZgaIoJnoKZKnpawxQ7Y8vuBijLNj6rccOHVOaIGQmaHK2dFA+bJFygC5a0YnEYF64KplWsw8lSwlw9f2fM1keLKsmyt4v+XGhw0usJuMlwkycVGdq0t3yT0mLrV4FuwqTp0RPeRSWNftO3Y2oGBmhsYfvcYWtYj+zB/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFJoR69G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mrAAgdvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFJoR69G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mrAAgdvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761996994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIsRkIhH+bZhgQijuzS+jvtdtvGAtq9Atz+fRk2pF5w=;
	b=JFJoR69Gzl0oLv3fOuCzbe1TKZFINqtP8cjllymU1jPhjUpW+Kl83deGRMedgYXejP1/Pj
	C9Bng5pN5rSH+Een1/tf5iFJt+Zj1wYgNTX3eZ3qJgU8Ri0zYpJuk9yd0wzXITutF1GWdz
	F7HAZ+U1MG27eCuqx3xOMdlc23fMF84=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Tfc6ctwnNsmvpwnOqbYSxQ-1; Sat, 01 Nov 2025 07:36:33 -0400
X-MC-Unique: Tfc6ctwnNsmvpwnOqbYSxQ-1
X-Mimecast-MFC-AGG-ID: Tfc6ctwnNsmvpwnOqbYSxQ_1761996992
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956a694b47so1503875ad.1
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761996992; x=1762601792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIsRkIhH+bZhgQijuzS+jvtdtvGAtq9Atz+fRk2pF5w=;
        b=mrAAgdvKlVRz8GyqkytkGzttSOIfmKLXRWUedvkCrTYE3qYX+ZUjTa+RpZh+vd0qDb
         uQd4kfHf5xdZtMR3adg3TLeAKZBKqRZw3bO4fuTtiUYj3KFEM7wIZ6PCJVDNMqr88sLR
         toIOhXbZ6AQYF5u94GKhckdKJAaOG7XLjLSoJgZBZyJHZ4nlmFvbiKEKze7Xj697LEYo
         iImS0SLe8hWHSZzUDb+6BBVzsYyLIx3oD1hAs2Yn0/+YZ86JpwsjTTJR2x8DfwDDr5jl
         r68rqYe+s1aHZjzDdXqR0UwYz7j6ftPp2JkMtHDZ8f7YXsqtWu78WlRj9WJKPk1DP6Fe
         JcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761996992; x=1762601792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIsRkIhH+bZhgQijuzS+jvtdtvGAtq9Atz+fRk2pF5w=;
        b=BFLreDypJoXWyhljAUu5CNguS60R4wuBnzkEVp3fGdIxivLaXZ4sm/5i4/SBrv+60+
         GxKVpyObBon/qnebUb5Qck4AnoKgBmH0Umtv9W5kdYu8SdDiqBh/u7mZpNPtUf674a5c
         J5AXV5b62t1dALa9IgS+mTXKV24ZGtXdbV3rTT9d8fvZ8PIfJS0GjMH80gkSMr+Uc8FL
         YHqUxT8rzhh9NZU4ntRPm/FyG8L3L0iYaX+XtpFnOLEDpjxKJhEaCZyz8KMTOAuRIo9t
         dEdm2hk2+hYHkThergUdTLCPUSVqystQBZCs7LNWrdVQjnRVHJRha/rsfHcWIE3GIsmD
         YW+g==
X-Forwarded-Encrypted: i=1; AJvYcCW9GAYryEvveM2GRYP5bGt7hUZ3DqVjOinVcpQlzG/9pmPmnUS5Brz7KMp/E/zb2zdYBJS2nP7V@vger.kernel.org
X-Gm-Message-State: AOJu0YwSt3s6oct460+5r2vf7Wht2wDlLWjlmIUJEzcCU2V5iQjX1Crm
	pyA/dDAG8FCeIKoueThjdSFFSGhvm/+zaEk5vNQNUUmSsoc+oDG1slByMwWm7pacO90GFidJPnS
	XI7kbSRTt5iIjrLc76C5bUSpqlv+sJ6X5dDkq2ytQ8SviSk8hpcHhn2N3X4k=
X-Gm-Gg: ASbGncuHkwiqT1uFArbkm+VZaaIt3AyevoW0HvGYTCM0KsAhcwxDr3rjlX1jNYZpOaT
	Y1Sozh+YWh7dRyMx9hk4L6XeiQkRrlsrOkHpyv5uFeLVPCD2dviwXJADSR+GVu1wcHXfid/pgrY
	K6pZWU9etud3UeY4U0fpGMTP5QF802/0s4YjWrwgPNdtJkCRCYXtpjO8sx8Z7YBs56MdiJntMRh
	rUTZ2L8Y5aqhZuFJoRNOsLiW4GNyPcah4XVd/ifVz6yjLmkJ5GqI1F4z7960P4aZpXs21iyem8u
	WJZHGjcqr0RVh7LctpXWqg0uinfjPEtAeK/0TaGU3rrgapUtKBU2UEgPz6alv6qiQqJU7x+CQDO
	JiaRKO5wtUnNbaT0g42+ymK1VcXn/qtn878rkbCw=
X-Received: by 2002:a17:902:ea10:b0:295:6427:87d4 with SMTP id d9443c01a7336-2956427c161mr9294115ad.50.1761996992135;
        Sat, 01 Nov 2025 04:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB2bqJdMwAGzdVozD3IHVy8NMDBRyks5TsV4HkX0U3KFDVCGcAPs5IxLsIKIOfCosbn7t8Ng==
X-Received: by 2002:a17:902:ea10:b0:295:6427:87d4 with SMTP id d9443c01a7336-2956427c161mr9293875ad.50.1761996991710;
        Sat, 01 Nov 2025 04:36:31 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29531a1965esm47091105ad.6.2025.11.01.04.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:36:31 -0700 (PDT)
Date: Sat, 1 Nov 2025 19:36:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: wangxg.fnst@cn.fujitsu.com, fstests@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	fdmanana@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
Message-ID: <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>

On Tue, Oct 21, 2025 at 02:27:46PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 9/26/25 22:07, Zorro Lang wrote:
> > On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
> > > When this test was ran with btrfs with 64k sector/block size, it
> > > failed with
> > > 
> > >       QA output created by 371
> > >       Silence is golden
> > >      +fallocate: No space left on device
> > >      +pwrite: No space left on device
> > >      +fallocate: No space left on device
> > >      +pwrite: No space left on device
> > >      +pwrite: No space left on device
> > >      ...
> > > 
> > > This is what is going on:
> > > 
> > > Let us see the following set of operations:
> > > 
> > > --- With 4k sector size ---
> > > $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
> > > $ mount /dev/loop0 /mnt1/scratch/
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> > > 
> > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> > > wrote 83886080/83886080 bytes at offset 0
> > > 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
> > > 
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
> > > 
> > > $ sync
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M   82M   95M  47% /mnt1/scratch
> > > 
> > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> > > wrote 83886080/83886080 bytes at offset 0
> > > 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
> > > 
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M  137M   40M  78% /mnt1/scratch
> > > 
> > > $ sync
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M  162M   15M  92% /mnt1/scratch
> > > 
> > > Now let us repeat with 64k sector size
> > > --- With 64k sector size ---
> > > $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
> > > $ mount /dev/loop0 /mnt1/scratch/
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> > > 
> > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
> > > wrote 83886080/83886080 bytes at offset 0
> > > 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
> > > $
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M   24M  175M  12% /mnt1/scratch
> > > 
> > > $ sync
> > > $ df -h /dev/loop0
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/loop0      256M  104M   95M  53% /mnt1/scratch
> > > 
> > > $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
> > > pwrite: No space left on device
> > > 
> > > Now, we can see that with 64k node size, 256M is not sufficient
> > > to hold 2 files worth 80M. For 64k, we can also see that the initial
> > > space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
> > > because of higher node size, more metadata space is getting used.
> > > This test requires the size of the filesystem to be at least capable
> > > to hold 2 80M files.
> > > Fix this by increasing the fs size from 256M to 330M.
> > Thanks for this detailed explanation. As this's a ENOSPC test, so we
> > must make sure this case still can uncover the original bug, before
> > increasing the fs size. Can you make sure that? Or maybe we can replace
> > that "80M" with a variable (according to "Avail" size).
> 
> Hi Filipe, Zorro, Wang,
> 
> The original commit message of generic/371 says that this test catches some
> excess space usage issues. Is(Are) there any patch(es) that fix this issue -
> so that I can remove the commits and check if the test expectedly fails with
> slightly large fssize i.e, 330M?
> 
> I did find some related commits [1] and I ran the test with 330M and
> 256M(the default size) after removing the commits[1] but the test passes
> with both the filesystem sizes. So I am guessing, this is not the patch that
> can test generic/371.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/

Hi,

I'm not familiar with btrfs patches, but from the commit history, I suspect
it *might* be related with below commit:

commit 18513091af9483ba84328d42092bd4d42a3c958f
Author: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Date:   Mon Jul 25 15:51:40 2016 +0800

    btrfs: update btrfs_space_info's bytes_may_use timely

Or "c0d2f6104e8ab2eb75e58e72494ad4b69c5227f8" :)

Thanks,
Zorro

> 
> --NR
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   tests/generic/371 | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/371 b/tests/generic/371
> > > index b312c450..95af308e 100755
> > > --- a/tests/generic/371
> > > +++ b/tests/generic/371
> > > @@ -19,7 +19,7 @@ _require_scratch
> > >   _require_xfs_io_command "falloc"
> > >   test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
> > > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > > +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
> > >   _scratch_mount
> > >   # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
> > > -- 
> > > 2.34.1
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

