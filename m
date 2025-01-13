Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B7182CD
	for <fstests@vger.kernel.org>; Mon, 13 Jan 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774675; cv=none; b=Fc6cG/M8c6XfduCMriMv/nPsqjyO0BC5vcDdY5uWFuo1v6KCdw3dAmYQCKLTTOFijUMq5OmP6flhO4F3DsQLFqVgc1V1Y0bUkodUgmP4U6rvpp+dBjzakN5Lz7z5GWuOzvXDgQPxkXB8JINffKJRKvQ7CN0YqaT4XWpX+QIjtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774675; c=relaxed/simple;
	bh=b6vJsQhv2fOrs/Xp6ID4EaLOyerDw6q4LHmMqhWMkP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWzvye6WrDzyBmtbX1gzD0x2pPIedmeyBcy7hr7H0/jjrvrTusVg8rAxYpLxcad7QIOpdeCW57w7Qzurxhf771Fy0Ov0fNYwLCbWSu+fdb6h+ZzrR42vJBgI1medTS63KuudwauD/5ZYEGw1Ico7BxfWVezk1fG3RDVCN7rMUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFLhbPPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFLhbPPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736774672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yf0rsNp3vB2Ria237LOeGIQXHqbUdQf5YPxQ8mR7Y3A=;
	b=FFLhbPPCzjt7yMVProZ/6s7pUJg/+DpxDow16d6qBU5ZkmhYTUAMqO/WdRbYfp2MNff4Cu
	wckf46osbyWluzVQ4j7aK2BlPYG8OmKP7ZdY4fqG9SEGO3Yw8qMb4Rntluc6lv+MZGrtIs
	cDD1A225/rz04NkwNATwL/H67GQYn4M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-gavGfS05PcCKFL5YVznpLw-1; Mon, 13 Jan 2025 08:24:31 -0500
X-MC-Unique: gavGfS05PcCKFL5YVznpLw-1
X-Mimecast-MFC-AGG-ID: gavGfS05PcCKFL5YVznpLw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-218ad674181so93166405ad.1
        for <fstests@vger.kernel.org>; Mon, 13 Jan 2025 05:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736774670; x=1737379470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf0rsNp3vB2Ria237LOeGIQXHqbUdQf5YPxQ8mR7Y3A=;
        b=VQY1yl/9VRS4JBYm8qZ+cYcYs1uJ7b8uw3rF0bVOn+eQpNVcmmJ0SKK5BSSQbvauus
         xtgWtHrqwfom6Tfs3T7bQskVzstFRoDO55wllolu9F27MB/pp5ojhyQYsQzYX1Yg0Pyc
         Hx8A+g9GnbA/VLGBBfC+S+qk29d8EQkguxGeG1jYb5OFV97lWOIJMRxIr7KlX5+p/xpY
         hYI77Bdt8soYrZ1mes8cnQZ7wUWJbZljzaF8XfiJrgwfxNeBYx0kCExwOaYhoWEt+HSm
         kHDMqOLlRXveyzU3Q1dv9sBsF84RCgTC++zDszPpy6Hsz1PcYCF6DW/TiLgSGP5OwUJb
         zs2A==
X-Forwarded-Encrypted: i=1; AJvYcCViCobInstTKVc/+S27Ffa79x34AjeaikKojEcgEZTi3tk+YwaEaQuk7rd3NQ3hWmng+qJJ+VUj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FE24dmXZinQsoY2dkYDvlJ4erlx2B4+/RLKFVrrqNWM5Gc3u
	/hcfqomyHtuzYjDq6+Lqq2dzTTv74fGPNUv9UozB8Hg+bH5MsXVX6sjL4i15bIaGuOD0X26W5hj
	DYGZ0XDMyh5BxW7Mqg6qh22DVH4xKkJiLCDqnahHk9eUPLQ1N+T+CrAQ=
X-Gm-Gg: ASbGncvVizs7XdmAvjZgXQkdLD+D5WJ2kvsGq2uiY6pFhwX1A1ucxDLzWxh1mGQFPeF
	U+khpW/xZ+PgWOHf/jL9Jl32K/VvqCX6q6XoiMdPUXZKD1qU1nrwlo6DQBE3Jdc2GEF307hnKnI
	9CZUyTWnubBMRLcMQJOmgql37iciSBpPYbIdwJXNp7/E9/cPAe0XCfn4gZScdu3HGD4+cyyZGXX
	IcrzTJJ5TVwPc5rGiw9gnpnZ4JnieYV3YZLu+TqUG0uVN849186otI3rtC/B3rFQJqpymXpwsAG
	i+aNXov3IgJIqAjvdtwXuw==
X-Received: by 2002:a05:6a00:8d8e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-72d324995b4mr25243666b3a.2.1736774669917;
        Mon, 13 Jan 2025 05:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkxBQhOmyi7HwPrS3cRarRyV8tRxl/8AcFFMf/x+Ywsac25U0IBSwW6qzTguYS94cznidb7Q==
X-Received: by 2002:a05:6a00:8d8e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-72d324995b4mr25243618b3a.2.1736774669410;
        Mon, 13 Jan 2025 05:24:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e8ecacfsm6934625a12.38.2025.01.13.05.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 05:24:28 -0800 (PST)
Date: Mon, 13 Jan 2025 21:24:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
Message-ID: <20250113132425.fdu4udrobzfxpgrl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
 <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
 <20241218200927.GC6160@frogsfrogsfrogs>
 <d4c1334e-0275-453c-bdea-7878dc8c56f1@gmx.com>
 <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>

On Mon, Jan 13, 2025 at 12:00:24PM +0000, Filipe Manana wrote:
> On Wed, Dec 18, 2024 at 8:19 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > 在 2024/12/19 06:39, Darrick J. Wong 写道:
> > > On Wed, Dec 18, 2024 at 09:07:26AM +1030, Qu Wenruo wrote:
> > >>
> > >>
> > >> 在 2024/12/18 03:52, Darrick J. Wong 写道:
> > >>> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> > >>>> On Tue, Dec 17, 2024 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >>>>>
> > >>>>> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > >>>>>> The test also fails sporadically on xfs and the bug was already reported
> > >>>>>> to the xfs mailing list:
> > >>>>>>
> > >>>>>>      https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > >>>>>>
> > >>>>>
> > >>>>> This version still doesn't seem to have the fs freeze/unfreeze that Darrick
> > >>>>> asked for in that thread.
> > >>>>
> > >>>> I don't get it, what's the freeze/unfreeze for? Where should they be placed?
> > >>>> Is it some way to get around the bug on xfs?
> > >>>
> > >>> freeze kicks the background inode gc thread so that the unlinked clones
> > >>> actually get freed before the swapon call.  A less bighammer idea might
> > >>> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> > >>> collectors.
> > >>
> > >> I'm wondering why this GC things can not be done inside XFS' swapon call?
> > >>
> > >> So that we don't need some per-fs workaround in a generic test case.
> > >
> > > I suppose one could call xfs_inodegc_flush from within swapon with the
> > > swap file's i_rwsem held, but now we're blocking swapon while we wait
> > > for some unbounded number of probably unrelated unlinked inodes to be
> > > freed on the off chance that one of them shared blocks.
> > >
> > > A better answer might be to run FALLOC_FL_UNSHARE on the file, but now
> > > we're making swapon more complex and potentially issuing a lot of IO to
> > > make that happen.  If you can convince the fsdevel/mm folks that swapon
> > > is supposed to try to correct things it doesn't like in the file mapping
> > > (instead of returning EINVAL or whatever it does now) then we could add
> > > that to the syscall definition.
> 
> So how do we proceed from here?
> 
> The btrfs fix was merged into Linus' tree sometime ago (v6.13-rc5),
> and I would hate to lose test coverage in fstests.

Sure, let's move on :)

> 
> Since the bug seems to be hard to fix on XFS, shall I make the test
> _notun on xfs, or move it tests/btrfs?

Add "_supported_fs ^xfs" and some comments to explain why skiping XFS. Let's
cover the original btrfs bug at first (if there's not a good solution from
xfs for now), then deal with the xfs problem later.

Thanks,
Zorro

> Zorro?
> 
> Thanks.
> 
> >
> > Sorry that I'm no familiar with XFS to provide any help, but the swapon
> > call on btrfs is already very complex.
> >
> > It needs to verify every extent of that file is not shared, and block
> > the subvolume from being snapshotted.
> > (The extent shareness check iteslf may already cause quite some IO)
> >
> > So at least to me, a little more extra logic and IO shouldn't be a huge
> > blockage, since we're already doing exactly that since the btrfs
> > swapfile support.
> >
> > Thanks,
> > Qu
> > >
> > > --D
> > >
> > >> Thanks,
> > >> Qu
> > >>>
> > >>> --D
> > >>>
> > >>
> > >>
> > >
> >
> 

