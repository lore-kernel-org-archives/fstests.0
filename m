Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD2839FD
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416844; cv=none; b=ZrWHEkyApivoYzkgu8kel/Cs0ptNQbOxjCW+bfKGAUCRwMFLPlu88Qui+yiQya00EXkav5vWR1hGavYMmhfDBmKarhpMcSdl3TRFM3i5nAsgmMDDh+CEXWe1fgb7neIHLKRTxRvz24M0eBPa3tp8NsJtzDZE9gNUOmTUQ5/tJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416844; c=relaxed/simple;
	bh=sl3NZg/H3Ya+TKg5nhl+XBR7XQBH/oAeU8KQaxX4Yvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZWVPswz3yUbkh5Q/sb+JBGSKbXN4iuZwuFSqc13NXAoalZJi23bb/m/NISf+voPzzZ45SRfXY8A2X2uf6u4Oyzer0IhSftzIq9YNIiQSWC3H49aEjHI0JPwXq3/KWix7y6yEv6mqPo95qIljplu99R0SpeokDcUDM5J3OXAoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaHv9VDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaHv9VDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JF5ATlFoA3P09P5Xy++iQ3BRPGQZKgC3ZfKmhIW9z4=;
	b=GaHv9VDoPG6DQgRS35D8RdJWZlXR/mga5I2cOiEzEU+eQBeUzDyUU0UashxkZ/NTWw5fpG
	9HkXTby61bEcWh2gbofpzy7pVPdnnFxg2E2TKhrW9Je7pQDLa2b4ANDHnDKojv6YxiyVmH
	Mt3wpzH3IHqBxyNQX466sMhiaVuJ35s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-NDwKGMpOOWKgFXcsMPxsTw-1; Mon, 29 Apr 2024 14:53:58 -0400
X-MC-Unique: NDwKGMpOOWKgFXcsMPxsTw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e2b1b90148so48531445ad.2
        for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 11:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416837; x=1715021637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JF5ATlFoA3P09P5Xy++iQ3BRPGQZKgC3ZfKmhIW9z4=;
        b=PvFL6dYOJHoypHFIRgMCIY5rHrUUXlksu2/mcmvhY8DUawDHurrC+i8Q4E7ItdvPnV
         Mk7Y+EN93djUXTeCQEExfCGUXhXPW4kVpyJbJ/4wLurCyIOuqZwYrUHo3DaImXaN0xoQ
         w58kcrodkuAnLC+pdBLAl8xj4smC3hFqVuORTg2GPErjAkzI88Sr0ubHuuhjIPVqv7uV
         0+hHbyz/Z9eYQVeLXAm0l5+dhbPEL5EbxlK2+5vtAYN7Yw/u02fCDHrv+ob2Smm6vaQL
         tJulJ0deyQRuptYROL24qSzsHHbRFF4kgIBJHOFgsDu1A98mCoSYNHuVLmBrcHwld3VK
         UIpA==
X-Forwarded-Encrypted: i=1; AJvYcCX0YgBUsBj/6sCyLNDjwJf0+/T+cE72ugpxr0gx52cvn2vuZsonetyskurdsKT5pgn80VMu7n2d28nLJHnBmBl5NBHdhFSuJg==
X-Gm-Message-State: AOJu0YyQ8h6/alDcyWLtYnxuhGiNTPPwgzYkxJxlawKud7xI2wytcn2K
	lI8aOESIgHSvtsqN96OZUGBYN/XmjXxG5bNKvXzClRKCqfNKISSYcq0kzx1nR3P5AD13MhNN8/+
	VjPUFXnfm+n3WPxHZZ/mT4V5uqq1YNLUCZEYXCE6qrwjjTybtN6zw/Uo=
X-Received: by 2002:a17:903:1c4:b0:1e3:c5d0:9fb8 with SMTP id e4-20020a17090301c400b001e3c5d09fb8mr13622860plh.42.1714416837423;
        Mon, 29 Apr 2024 11:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGRctPqVwYYrKmBKlwkywp0QSRPPwHvax8S/0iQJN/USC6zk78f9p0Cd0m7TF4815sarvyQ==
X-Received: by 2002:a17:903:1c4:b0:1e3:c5d0:9fb8 with SMTP id e4-20020a17090301c400b001e3c5d09fb8mr13622833plh.42.1714416836878;
        Mon, 29 Apr 2024 11:53:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e8d180766dsm18622150plh.278.2024.04.29.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:53:56 -0700 (PDT)
Date: Tue, 30 Apr 2024 02:53:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: add to the quick group
Message-ID: <20240429185353.h4nait5bsifxjc42@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240427075530.1236045-1-hch@lst.de>
 <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240429155954.GB360908@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429155954.GB360908@frogsfrogsfrogs>

On Mon, Apr 29, 2024 at 08:59:54AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 28, 2024 at 01:49:53AM +0800, Zorro Lang wrote:
> > On Sat, Apr 27, 2024 at 09:55:30AM +0200, Christoph Hellwig wrote:
> > > generic/095 doesn't take more than 4 seconds on any of my test setups,
> > 
> > Yeah, it generally takes ~5 seconds. But there's a "LOAD_FACTOR", so
> 
> On what kind of storage hardware?  If it's that fast even on spinning
> rust then I guess you could double the iodepth*/numjobs computations.

On most of our testing machines, even very old (10+ years ago) with
general HP scsi disk, nothing special.

# lshw -class disk
  *-disk                    
       description: SCSI Disk
       product: LOGICAL VOLUME
       vendor: HP
       physical id: 1.0.0
       bus info: scsi@2:1.0.0
       logical name: /dev/sda
       version: 6.00
       serial: xxxxxxxxxxxxxxx
       size: 931GiB (1TB)
       capabilities: 15000rpm gpt-1.00 partitioned partitioned:gpt

# ./check generic/095
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-xxxx-xxx 6.9.0-0.rc5.20240425gite88c4cfcb7b8.47.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 25 14:21:52 UTC 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/scratch

generic/095 2s ...  2s
Ran: generic/095
Passed all 1 tests

> 
> (What happens if numjobs exceeds the 9 defined in the fio config file?)

# export LOAD_FACTOR=3; ./check generic/095
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.9.0-0.rc5.20240425gite88c4cfcb7b8.47.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 25 14:21:52 UTC 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/scratch

generic/095 3s ...  3s
Ran: generic/095
Passed all 1 tests

# export LOAD_FACTOR=4; ./check generic/095
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.9.0-0.rc5.20240425gite88c4cfcb7b8.47.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 25 14:21:52 UTC 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/scratch

generic/095 3s ... - output mismatch (see /root/git/xfstests/results//generic/095.out.bad)
    --- tests/generic/095.out   2024-03-02 20:15:52.580273536 +0800
    +++ /root/git/xfstests/results//generic/095.out.bad 2024-04-30 02:46:27.874906090 +0800
    @@ -1,2 +1,6 @@
     QA output created by 095
    +fio: first I/O failed. If /mnt/scratch/file1 is a zoned block device, consider --zonemode=zbd
    +fio: first I/O failed. If /mnt/scratch/file1 is a zoned block device, consider --zonemode=zbd
    +fio: first I/O failed. If /mnt/scratch/file1 is a zoned block device, consider --zonemode=zbd
    +fio: first I/O failed. If /mnt/scratch/file1 is a zoned block device, consider --zonemode=zbd
     Silence is golden
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/095.out /root/git/xfstests/results//generic/095.out.bad'  to see the entire diff)
Ran: generic/095
Failures: generic/095
Failed 1 of 1 tests

This failure looks like: https://lore.kernel.org/fstests/a8f03f2c-5951-4aea-856b-218326815302@kernel.dk/

# rpm -q fio
fio-3.37-1.fc41.x86_64

> 
> > before we add it into quick group, I'd like to ask
> > do you think if it's worth increasing the default LOAD_FACTOR a bit to
> > give it more stress, or move it to quick group directly?
> 
> I'd move it to the quick group.

OK, Christoph likes that too, let's move it to quick.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> --D
> 
> > > but is exercises code that handles buffered write iterations interrupted
> > > by concurrent direct I/O that no other test in the quick group does.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  tests/generic/095 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/095 b/tests/generic/095
> > > index 80448200b..9d0446e98 100755
> > > --- a/tests/generic/095
> > > +++ b/tests/generic/095
> > > @@ -7,7 +7,7 @@
> > >  # Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
> > >  #
> > >  . ./common/preamble
> > > -_begin_fstest auto rw stress
> > > +_begin_fstest auto quick rw stress
> > >  
> > >  # Import common functions.
> > >  . ./common/filter
> > > -- 
> > > 2.39.2
> > > 
> > > 
> > 
> > 
> 

