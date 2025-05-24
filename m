Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35B1DB365
	for <fstests@vger.kernel.org>; Sat, 24 May 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069553; cv=none; b=n3qcnCvgmWKvG+Y5rwLvVyBf6Sr8W4gfiTwFFytGFuX4E4DpBgF4IEaEdmfUfF33UfXYAvmAMOLCbL+Y6O3vpJ5A6ANzwpr/EU17a8UXK+EWYpphaq5wagzRfAmHdVdjIPGijz0FgwRDXv68ZfkKw+r5jsgGZW+WUZ2K5ts4xTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069553; c=relaxed/simple;
	bh=Fabv+duZmVBVspO5OsrfwMl2W+HRWlMuUF5mkGX0UVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODZh3aRYBcLNCGPPHyhC3fSH1/PMXFOx0J+/Q3jjgEGqR7MzzRXhFBFAD4uCLFzzu+HjnIStteGNNwyLzTjGf8ajpMJcW1odbjNuAjtuu/yrAinKc4h3si2WBXR2CGIiYrVMNRqxB86XgkTzf0MsCFbjoQIezfM6o0aEX/w0EFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpt+5naU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpt+5naU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748069550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6ntayVSbMHKAnivRXqeJJBh6EwS1D/6PChDHFH+YX4=;
	b=Gpt+5naUZv+3Zhkq/v47ZRz9ctfyavBihB/gP65AF5LPSv16OVWZi2dh3nSoSQKFXMOf6n
	ypbB6mI18AXju2j200R0PsMzxdnMa5nJ4VOo7kcHTdCh2YYr+GlZfV/jwkDzfnmY4up7xM
	r+RaOjBnjfKdeqs54TWzjKW9CRznJ6w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-tESTJmM_MtyPUy5IjtrMQw-1; Sat, 24 May 2025 02:52:28 -0400
X-MC-Unique: tESTJmM_MtyPUy5IjtrMQw-1
X-Mimecast-MFC-AGG-ID: tESTJmM_MtyPUy5IjtrMQw_1748069547
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2371b50cabso624579a12.0
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 23:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069547; x=1748674347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ntayVSbMHKAnivRXqeJJBh6EwS1D/6PChDHFH+YX4=;
        b=o22I5KwXEq1sUd5ntRL15prRRSqFRQPnVuEdCwixh7e6HM26Rtd5mH2zQYqPLWFPcH
         UcdhR1poJDiWEXcSW9vqwJfMjYbDvOo77071+kbqizno264lQQjYA4b3hzK+BQHf3JYY
         s+0t50xymWvbxmTZIdNvhEvHuXXsXJ5drkDPQLNY+3Mtf76yLcoJijfYQ4YcRN5axOYf
         +1ntR7S9c+0Su4fJORta2PR6xD7QUhG0AVj8NaG81lRK+lnCvtKusHTsdCxbxTMiy4cG
         XGV4hFynUUSKzmBA++OkhB8QZxDE00DHPNfs8aRvdvVehAku7x6PqObZJ7rMJadT9D0n
         b4FQ==
X-Gm-Message-State: AOJu0YywIuaXc15lu/l7S3deF0QTCBoDEjtwKEQDvNApAWf4fnRl+AsJ
	wSviCpBVV3+yM0ARWghq6gQ2f5/qsojwDLJ1kQ27g9mz/P1hXETjjCpS8PpanssVhDrLYtSjDg3
	2OSWH9tHqtyvV80b3Q5uBQS3uwUadc8JVZHFMWidHy6+mG452/vOSDlVLm44=
X-Gm-Gg: ASbGncsbHLrpNd1lbpF/UiI8btpe16aprGcc7BGaRHtuq2pGOFl9HEjJ/mzzjgZPbBG
	SP78MmPRy0BVLLFpdKUQkx5fE6qRZb74xWBSw4o3hOJoATF+m2JXQOQWU+XH3hzcC1/7N3Ur6CY
	Ll+Fmeu8WjB0mHJC1SGmjG/r14uGVkBlRfL2UxfA/0FJNRWjnOngt1ocsbvw3mYuFEGHChSDkWG
	E1xaVAJotrrrnGQed9RilNFs+XmgKrNZBUQ/ooIXtQ+V5xK5xKhEoTrowgzw0bq2Gs3AuHbdoe6
	FAiZod2fRLoRa1MdokT8S7ZsR6UDjXHbzWDxrYMY7sZks+nmtmex
X-Received: by 2002:a05:6a21:999d:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-2188c1e7e29mr3532888637.3.1748069546913;
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTUtqF4Y+WOIsa6cEhIkowJGqGE/U+Qoq22RZnoHHlJyf8tY9Un5tIJHvXQYS1yZGk+FZe9Q==
X-Received: by 2002:a05:6a21:999d:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-2188c1e7e29mr3532872637.3.1748069546555;
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d1b2sm14247368b3a.66.2025.05.23.23.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
Date: Sat, 24 May 2025 14:52:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
Message-ID: <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>

On Sat, May 24, 2025 at 03:47:16PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/24 15:14, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/5/24 13:38, Anand Jain 写道:
> > > Zorro,
> > > 
> > > Please pull this branch containing fixes for btrfs testcases.
> > > 
> > > Thank you.
> > > 
> > > The following changes since commit
> > > e161fc34861a36838d03b6aad5e5b178f2a4e8e1:
> > > 
> > >    f2fs/012: test red heart lookup (2025-05-11 22:30:30 +0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://github.com/asj/fstests.git staged-20250523
> > > 
> > > for you to fetch changes up to c4781d69797ce032e4c3e11c285732dc11a519e3:
> > > 
> > >    fstests: btrfs/020: use device pool to avoid busy TEST_DEV
> > > (2025-05-14 09:49:15 +0800)
> > > 
> > > ----------------------------------------------------------------
> > > Johannes Thumshirn (1):
> > >        fstests: btrfs: add git commit ID to btrfs/335
> > > 
> > > Qu Wenruo (2):
> > >        fstests: btrfs/220: do not use nologreplay when possible
> > >        fstests: btrfs/020: use device pool to avoid busy TEST_DEV
> > 
> > There is another patch that got reviewed but not yet included, and it's
> > again related to nologreplay (this time it's norecvoery):
> > 
> > https://lore.kernel.org/linux-btrfs/20250519052839.148623-1-wqu@suse.com/
> 
> Nevermind, Zorro has already included this in the queue.

Yeah, I've gathered some other patches due to I want to start my regression
test on Friday night, to catch up the release on Sunday.

You might care about below commits too, they're in patches-in-queue branch,
feel free to check, and tell me if I missed anything:

  f405f5f6c fstests: generic/537: remove the btrfs specific mount option
  3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
  282e4fe8c btrfs/023: add to the quick group
  3c21ae673 btrfs: add tests that exercise raid profiles to the raid group

Thanks,
Zorro

> 
> Sorry for the noise.
> Qu
> 
> > 
> > Thanks,
> > Qu>
> > >   tests/btrfs/020     | 49 ++++++++++++++++
> > > +--------------------------------
> > >   tests/btrfs/020.out |  2 +-
> > >   tests/btrfs/220     |  7 ++-----
> > >   tests/btrfs/335     |  4 ++--
> > >   4 files changed, 22 insertions(+), 40 deletions(-)
> > > 
> > 
> > 
> 
> 

