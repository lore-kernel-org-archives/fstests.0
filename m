Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DDC13D
	for <fstests@vger.kernel.org>; Thu, 31 Jul 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957290; cv=none; b=VxFwRLmmN/F4IaJcVrT9X9S0uJ61a8u2h3ha+V6cQUs545lwc0i3C9+/Fjp34KIOokWt4jTBpNVltms58xLqe/JIPtQpekV5qLtFD8IbWcOnhuPQlF7n7PAIqgyfYL+jTqyOTrbRInGvIbORbhE9dRmKV3lKbsSrR2PLawV4fHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957290; c=relaxed/simple;
	bh=QYwHQ2K71dnmvtOfsyMDstzFHOeZmcYar5B/lhiB2Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5uCKCI2lH79GnZFKcwPNFNzFFVR8I8NI9HyaASxv3tu3pTvxEwQrQfKt2YErFSFiIzr3FyIQ7t5gNrpKIEsbxvs6facsl7hJ1APA5pGBtM93ZleW2W7OlWCOee9gYcZxL0mqGX8IYQUNcVEBN9Dg7ZRKCG1m0dEQIrjKZjpFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGAJJOO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGAJJOO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753957287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cU/mlk4+cjmiO8gLxsuVy22IbNZYIuo83j9UVNANkxs=;
	b=VGAJJOO0R5ok/5NwjhW6IVpNQBSiVTUwufCUkJ35PUy7KAnudrwdtkauq98UpLB6+bss1i
	Wc27eLn2JEEKfidI0ELuClLqTyZycIuKk+VyMPy6iamHG14tuLtngufflSt8f7IQ1GtvZO
	AVU574KIt+XigwXj2OWP1gXsC6L/CmY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-IUfiNpvKMUGwQPfRxaGjoA-1; Thu, 31 Jul 2025 06:21:26 -0400
X-MC-Unique: IUfiNpvKMUGwQPfRxaGjoA-1
X-Mimecast-MFC-AGG-ID: IUfiNpvKMUGwQPfRxaGjoA_1753957285
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso209961a12.3
        for <fstests@vger.kernel.org>; Thu, 31 Jul 2025 03:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957285; x=1754562085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU/mlk4+cjmiO8gLxsuVy22IbNZYIuo83j9UVNANkxs=;
        b=NNUa5QwhTtCyb4+YzFLSnXpvn71JM/V6kmu20gGCMQXUapEYQLAhR4tW1WO7Rl1ZuB
         l1BJ5ce9GrVjpLHh9q9e+cZKHgAVv61Zi+wVllN+iMT8az1081St73osWlrnP4zQUzb4
         NNdyjK7THATxnQ8uATf1Bjr0eHEqrO462nagiU8Y2vcuAw2MXTbmTP7+Oyk6wqrwE10n
         EN6p4iEFDs1di1s+dGH2ulPE1cAEGAhu7gF0L0Y2ekS9qqR8K/MhK0IFwvwDiwcATB65
         6jFfSm3dBAIR+79Mdr5AoEiVdIojyeYfrKM3bcKkm7ISwIqISZuWUqK+vIP3ojThELSt
         GjwA==
X-Forwarded-Encrypted: i=1; AJvYcCVMc4zWMlDvZURTHrblLFhtKp9+NJgn3QaFG3ebzm4p80uJvo4mUDeQOeEUkI5BtpaHg104Xhs2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mNrM7WvBFVK7++Is7CmXqov2PLXFOJB+XJvuAVicA29oe5cd
	vlXajn7ngAQNuASxXV5Lwf498mu4CQRRyER51ATrJHSQ3eFTYLINNn1PFg0xiyX5DHqFk9VGyIZ
	xuIv8ar4yJ7XV8B5e8sOcwVIu0UKvJpOvLhO9SwraJ732q+AUtahlTEQu3Rw=
X-Gm-Gg: ASbGncsPHm2s1eQ0BESeTneUeJmqTLs7SDcdvKmkfjzHKaCiOpr7VkaZZSCk2d8mEyt
	4LcYqRZT5usMqhwfQhpjXYWN6ZQW3HXdjwbq6FLcy645yXN8iqQO+S8RiR9jNEABSemnabPye7r
	SOZvy9QmD8Xueeug33PvZiaGdKiqHRbi7/bahGrBWKh/iLE2Aik+GuD6NqNzlzjakByGBmnWYp/
	QoSk5gy7OK5OBunI8xKmpiQy4UFEVJvGSYgvtvpr8ar5lcoX+ZR/PA19x9N/BUwQufAYhv+sfAP
	mNlF2sCvlE1MQOiI1bRpgPIw0W6LzSFv4X/EjoEJH6aXKd9ojc8AuyQLraYaIEp6bJANzECHSuh
	E+nwi
X-Received: by 2002:a05:6a20:72a6:b0:21c:f778:6736 with SMTP id adf61e73a8af0-23dc0ff8ec8mr11986622637.27.1753957285308;
        Thu, 31 Jul 2025 03:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm7kTadKIUZ98WHXFMjADbVfxzuxVYjdYVhZQ2wd3MAOo33eJmn1Jd5U+julIwWsBOCv3Orw==
X-Received: by 2002:a05:6a20:72a6:b0:21c:f778:6736 with SMTP id adf61e73a8af0-23dc0ff8ec8mr11986593637.27.1753957284946;
        Thu, 31 Jul 2025 03:21:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f907sm1256844b3a.8.2025.07.31.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:21:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:21:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: lots of mounts/remounts of the test file system?
Message-ID: <20250731102120.evnmx33me5hl7hnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <aH87hl9NUmiqqvU-@infradead.org>
 <20250729142951.GR2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729142951.GR2672039@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 07:29:51AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 22, 2025 at 12:19:34AM -0700, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I've been hacking on some (XFS) code that in this state of development
> > requires a mount options to be passed for every mount, and I noticed
> > that even when running without a SCRATCH_DEV I have to add the required
> > option to MOUNT_OPTIONS and not just TEST_FS_MOUNT_OPTS, which is a bit
> > odd.  I've been trying to track it down and despite multiple attempts
> > failed to find my way through the bash code for it.
> > 
> > But what is even more odd is that when running just a single test (e.g.
> > generic/001), the test fs gets mounted four times, with the second
> > and fourth time failing to apply the mount options.
> 
> Huh, I observe the same thing.  I wonder why it does that, but bash is
> pretty awful for tracing and there's no obvious explanation. :(

I tried to run generic/001 on xfs, then I got below dmesg output:

->[2252223.939937] XFS (sda5): Mounting V5 Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95
  [2252223.963840] XFS (sda5): Ending clean mount
  [2252224.892093] XFS (dm-3): Mounting V5 Filesystem 1de154c4-41cd-4b49-a09c-a55532f58ee9
  [2252224.910117] XFS (dm-3): Ending clean mount
  [2252224.950702] XFS (dm-3): Unmounting Filesystem 1de154c4-41cd-4b49-a09c-a55532f58ee9
  [2252226.047099] XFS (sda5): Unmounting Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95
->[2252226.168554] XFS (sda5): Mounting V5 Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95
  [2252226.190181] XFS (sda5): Ending clean mount

  [2252226.208104] run fstests generic/001 at 2025-07-31 17:18:04

  [2252230.614153] XFS (sda5): Unmounting Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95
->[2252230.755666] XFS (sda5): Mounting V5 Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95
  [2252230.776979] XFS (sda5): Ending clean mount
  [2252230.820463] XFS (sda5): Unmounting Filesystem 364c2734-5bec-4d6a-8057-6ced2ea53e95

Some lines are outputed before "run fstests generic/001", some lines after it.

------
Before that line, my testing (./check generic/001) tried to mount TEST_DEV (sda5) twice,
tried to mount SCRATCH_DEV (dm-3) once. Let's focus on TEST_DEV. By enable bash
DEBUG_XTRACE (bash -x) in check and generic/001, I found these two places which
mount $TEST_DEV in check:

1) _test_mount
2) _check_test_fs -> _check_xfs_filesystem -> _mount_or_remount_rw
------

------
After that line, my testing tried to mount TEST_DEV once, that comes from:

1) _check_filesystems -> _check_test_fs
------

So the "_check_xfs_filesystem" set ok=1 by default, then does $XFS_REPAIR_PROG,
and set ok=0 if it returns non-zero. Then if "ok isn't 0 and type=xfs", calls
_mount_or_remount_rw to mount. This generates extra mount operations.

Thanks,
Zorro


> 
> --D
> 

