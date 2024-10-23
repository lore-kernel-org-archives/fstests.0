Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A751384BF
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656761; cv=none; b=BS6rTYeFQ5yRGoABEWW75QaqMFTyk2mmdXFtK/qkZidQSiLOlIxmxoabyiEOEJKrk66pEk3fqv3o03dkuA1ZHDLzuGfdZ3qbz0o2V7se1Ryhsl0uiBw6ESzIBGdwkwgQn4SC3Pwp9I3waOE6/2K6JA5Cgma8VPfN075dfg2wOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656761; c=relaxed/simple;
	bh=ly+gAL6FWqxVw1uhSK12MfSlG2GA1IdyXowrlEudL9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHXZpFFedMEJ7nQO4sxEq0nPlGy6CG9o0d1ExAj2G2Z6PVsuh75adh2OP9Yl8FOdj7FkF8XJsuTXDuoufyLw/4Vz5wjEnQftZA84yrHerdREeYxV1FtNe/fgeJYlHwEgT4yvX+gU+yfVV1V78uoWuYyknuOynxkuN4nK6H/ZAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2zHKCVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2zHKCVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729656758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+37vG64ySEsAwS8ZgQPLClCj9m5wCkSNkm3JVrJz12Y=;
	b=M2zHKCVVW6seaCIXb+HGSHGqVSGTOMHciKnWXtYkUwr7JSmE5kUT2Kag5Bdypof4gdr4T+
	IUylS5qh/7beUS5XtmFEoajnXl9yagpXcEm2bH+LD0pmF0p5QKiL30s46jsw6nsxOORV/c
	2b9E+ox5iLfHrjAbCNCh0MJPDppQXTE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-BKYz9H55P2iXFxCFZwikoQ-1; Wed, 23 Oct 2024 00:12:35 -0400
X-MC-Unique: BKYz9H55P2iXFxCFZwikoQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e3d74e5962so7675445a91.0
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 21:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656754; x=1730261554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+37vG64ySEsAwS8ZgQPLClCj9m5wCkSNkm3JVrJz12Y=;
        b=T0rmZhlMMiAcqso/47Diq2tiRzw4vsyhiZkV1eOrDpNJO70OAAMDTTqDpBCu5SyMn7
         NXtzP2l51NKqKwvysf7eRY23RI8jmyGydQdZhuLLuSA5oy+q2mauBjE45xkwh4HtihiW
         M1G2a6W0z4+aPhywROlZLYD4AIgvqt19oj+jWvH0AE1AnmcISw2NYrVQRwIf+RSA/1n9
         SZ/sUBPySr3uQWHNtZp4AJG6Dn75LYz7nyFg9DpAvajo3JptvIMLiU/tkPEbfKpelnQX
         BY5aYJ/gfrc+aEvm1OfmtwasnwbM3uA5sJf1j0ynb2ShK40/RgfYewEbnYTEJrxtqC6D
         tbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNeINCn+/WKGb7Tl5hhk3V+H5mPQCo9OpnIQD0xBQw5SUg1hRy4ys9IgrFxJmSK721cpo25p+b@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmDejITutmgvyTHVdS0blhQcONUuJWiCsXhdmmYHO3kDpsfmP
	SBj+rrzjvU7iBMW13p/md0HIXsIZzVU/RP2s2+0enJU4+VQKpTQSprRev3RikvFYy1ah1hadnDB
	eg8v6Z+COrNAoiKdra5j2v/rpL7iYSdr6MxKmAueSUSXNLN5vmYsARyo=
X-Received: by 2002:a17:90a:de8e:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e76b5b59a9mr1498294a91.8.1729656754486;
        Tue, 22 Oct 2024 21:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnHxPU6fpRamKmjky29NIoWmZ5rFzNRJcaN1vCYWtFkjg8Vtc28xndO+DadjjYyyVSmx4fRQ==
X-Received: by 2002:a17:90a:de8e:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e76b5b59a9mr1498276a91.8.1729656754152;
        Tue, 22 Oct 2024 21:12:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df29cd5sm296434a91.1.2024.10.22.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:12:33 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:12:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Long An <lan@suse.com>
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
Message-ID: <20241023041228.d3rkmmci5vnw5ict@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
 <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
 <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>

On Tue, Oct 22, 2024 at 01:12:15PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/19 08:45, Anand Jain 写道:
> > On 18/10/24 08:04, Qu Wenruo wrote:
> > > [FALSE FAILURE]
> > > If SELinux is enabled, the test btrfs/012 will fail due to metadata
> > > mismatch:
> > > 
> > > FSTYP         -- btrfs
> > > PLATFORM      -- Linux/x86_64 localhost 6.4.0-150600.23.25-default #1
> > > SMP PREEMPT_DYNAMIC Tue Oct  1 10:54:01 UTC 2024 (ea7c56d)
> > > MKFS_OPTIONS  -- /dev/loop1
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /
> > > mnt/scratch
> > > 
> > > btrfs/012       - output mismatch (see /home/adam/xfstests-dev/
> > > results//btrfs/012.out.bad)
> > >      --- tests/btrfs/012.out    2024-10-18 10:15:29.132894338 +1030
> > >      +++ /home/adam/xfstests-dev/results//btrfs/012.out.bad
> > > 2024-10-18 10:25:51.834819708 +1030
> > >      @@ -1,6 +1,1390 @@
> > >       QA output created by 012
> > >       Checking converted btrfs against the original one:
> > >      -OK
> > >      +metadata mismatch in /p0/d2/f4
> > >      +metadata mismatch in /p0/d2/f5
> > >      +metadata and data mismatch in /p0/d2/
> > >      +metadata and data mismatch in /p0/
> > >      ...
> > > 
> > > [CAUSE]
> > > All the mismatch happens in the metadata, to be more especific, it's the
> > > security xattrs.
> > > 
> > > Although btrfs-convert properly convert all xattrs including the
> > > security ones, at mount time we will get new SELinux labels, causing the
> > > mismatch between the converted and original fs.
> > > 
> > > [FIX]
> > > Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
> > > xattrs, and that should fix the false alert.
> > > 
> > > Reported-by: Long An <lan@suse.com>
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1231524
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/012 | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > > index b23e039f4c9f..5811b3b339cb 100755
> > > --- a/tests/btrfs/012
> > > +++ b/tests/btrfs/012
> > > @@ -32,6 +32,11 @@ _require_extra_fs ext4
> > >   BASENAME="stressdir"
> > >   BLOCK_SIZE=`_get_block_size $TEST_DIR`
> > > +# Override the SELinux mount options, or it will lead to unexpected
> > > +# different security.selinux between the original and converted fs,
> > > +# causing false metadata mismatch during fssum.
> > > +export SELINUX_MOUNT_OPTIONS=""
> > > +
> > 
> > SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the system,
> > so disabling SELinux will suffice.
> 
> Are you suggesting to disable SELinux just to pass the test case?
> 
> Then it doesn't sound correct to me at all.
> 
> It should be the test case to adapt to all kinds of systems, not the
> other way.

Hi Anand, I think Qu is right, it's not worth disable the whole SELinux
(at the beginning of fstests running), just for a single test case.
I just hope to make sure btrfs forks agree this's a failure which should
be fixed in test side, but not change the selinux config for btrfs-progs.
If you're sure about it, I'll merge this patch :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > -------
> > fstests/common/config:
> > if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> >          : ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
> >          export SELINUX_MOUNT_OPTIONS
> > fi
> > ----------
> > 
> > Thanks, Anand
> > 
> > >   # Create & populate an ext4 filesystem
> > >   $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >       _notrun "Could not create ext4 filesystem"
> > 
> > 
> 
> 

