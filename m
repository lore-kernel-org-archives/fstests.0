Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB883224
	for <fstests@vger.kernel.org>; Sat, 30 Nov 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732934109; cv=none; b=ELOz/ZxzeiUkIndXKKRCHIdpt5tMszc9QB28IIv8CO9k54unITrtJVd7CanmYPcNtJYd3T38DUNITghfV/O+NbkdFG9DmiV3EkOdyQR3ChWWyzqkTEmEH/p7V+wlGtFxveDi21TMnO2Tc5T77uFsNBVVWvEkE7xvQIhdiAHELgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732934109; c=relaxed/simple;
	bh=V+705lLootH3gFFIo6rL1nyE/kOoZJRGVa4XHPMatzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO+a9AFNN3Y1O5sdnkbTw5Tirr9QFFbCT46AOm5dC19JN4JKhQ/zObhdx+gqz/+25jJo3MQL0Iwf/Qbmktc8dErwWhAYwDDNGuXpY7KJ5CyfHmKMv4EzGvZMTviDiCZImFKrbSIQ+1EkF3tgjTbLDQdMjTkIIzJl8iJoJpO3/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3mpXDnM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3mpXDnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732934106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRo2KbDQnQMeAvl7fs2iPFZIruyhSS3YkXYEiVVjcaE=;
	b=C3mpXDnM9hNDVPoZuXHjsJBkrVJGoR1rgbvwcU8ixd7hoSkg69zh/YNXNPBbTpa2Wr7KtX
	zIMl6gJI8pXJ4DUDc8U8RdLxhOfsL94IowBkyvrBRVaoYjv4R5gK0SRnTe13/vZazeJNbm
	J70kO62edfLm33jvKFjUm+cMfGxZa54=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-S_OMKYIuNJmdFO5QSJTv3A-1; Fri, 29 Nov 2024 21:35:04 -0500
X-MC-Unique: S_OMKYIuNJmdFO5QSJTv3A-1
X-Mimecast-MFC-AGG-ID: S_OMKYIuNJmdFO5QSJTv3A
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2129bf203d9so29479885ad.0
        for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 18:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732934102; x=1733538902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRo2KbDQnQMeAvl7fs2iPFZIruyhSS3YkXYEiVVjcaE=;
        b=KT+bjtI4kFYUzQgeyEx48ALJKpiV/tmPa0u+Rnx51wWseAKXLmwr8WOlU5JsKptvpz
         dndcnFOhUoIQdrElNn/QShfqzu+HNA7AV0626Gk5MdpzDD7w3dqpWXkt0giwJuNpoPiM
         pcaWmePEjYvX+WVfdZOZ8UmF5Kmx+3wuXc1GcqIFoZIFWV+gJ03bkCZoJyjk92EttvuS
         MmRPifCJTbLwC3sRYH6DQcyAQWd9fv1sMPVX4qWsiwuJz21Be6npXHZx+hup/g7Alv0d
         l5IJeR7opTRzvDpLmpwT8PPLFfDeAxMWiZhL9scNISy+SQ4D/24Nn9wIfxrCrpA0jNYS
         bbqg==
X-Gm-Message-State: AOJu0Yw44x8q5q7lg41FDv1iuhtBzH/2/4SknulBENkjxI1QsaPA8e1R
	Jocp15Kf3ekEHPazG3blhCpQ8lEYZJC48DRF3nVOElk8gY8vdTh7x0x6WCRkYO+hkUCbzAU+UKL
	5ssHyoQB0F3rPG3tM1iEwQZRjClk963+6vpXM1ZVEDbeliyEPrBO782c=
X-Gm-Gg: ASbGncu/PkSzVxB3bdb/cmjdVaW02ClLCtle1wWiTKD80Syeh6SI/fDEf2JHiW6SB6D
	JGtgfvAlVFlHuDUX0oYfK6M/3pbVkkKmv0DqE4xNc8UMmCxkqiQkdL9cLPtVs3SA94XRsjqy9q6
	heZ/Z9JUrbufJbWpEXcEU+7ZDYQDSjpa/3VXMUXMhez0ibCfds92t0qC1lhWhTNYv0A4NfQtSfH
	YQxo6jfuFvTOFZATRUDywNzSRLKuXnBnNfh5oGT470C7xb/2v6DrtxqD2Pzcz+qAwfDrvND6763
	JJY4hYgiKkZoyyk=
X-Received: by 2002:a17:902:e741:b0:215:50fb:ae4a with SMTP id d9443c01a7336-21550fbb41dmr42717745ad.0.1732934101885;
        Fri, 29 Nov 2024 18:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJmszacrjBRKCI0EA3vvfuWNilME0i7JoTuouq52HmSGiQRw/sS3Yhhhi+68Kd/hqwnYd6TA==
X-Received: by 2002:a17:902:e741:b0:215:50fb:ae4a with SMTP id d9443c01a7336-21550fbb41dmr42717485ad.0.1732934101479;
        Fri, 29 Nov 2024 18:35:01 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f56f7sm37392285ad.32.2024.11.29.18.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 18:35:01 -0800 (PST)
Date: Sat, 30 Nov 2024 10:34:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 16/40] fstests: use udevadm wait in preference to settle
Message-ID: <20241130023457.d5r3o7vgd6fqzwkc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-17-david@fromorbit.com>
 <20241129171009.GF9425@frogsfrogsfrogs>
 <Z0pBKWBlXLBxwK3D@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0pBKWBlXLBxwK3D@dread.disaster.area>

On Sat, Nov 30, 2024 at 09:33:13AM +1100, Dave Chinner wrote:
> On Fri, Nov 29, 2024 at 09:10:09AM -0800, Darrick J. Wong wrote:
> > On Wed, Nov 27, 2024 at 03:51:46PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > When running lots of tests in parallel, there are lots of
> > > filesystems and block devices changing state. This generates a lot
> > > of udev events when means the udev event queue is rarely empty.
> > > Unfortunately, an empty event queue is what udev settling waits
> > > upon. Hence calling UDEV_SETTLE_PROG can mean waiting for a lot of
> > > time for other tests to stop generating udev events.
> > > 
> > > For the majority of cases, what we care about is that udev has
> > > performed device node addition or removal, not that there are no
> > > udev events pending. Recent(-ish) systemd releases support 'udevadm
> > > wait' to wait for a specific file to be created or unlinked rather
> > > than waiting for the event that does that work to be completed.
> > > 
> > > Hence we don't have to wait for the udev event queue to empty,
> > > just for the udev event that does the device node manipulation to
> > > complete.
> > > 
> > > Introduce detection of 'udevadm wait' support and a _udev_wait()
> > > wrapper function to use it if it is available. If it isn't, the use
> > > the existing UDEV_SETTLE_PROG behaviour.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  common/config     | 35 +++++++++++++++++++++++++----------
> > >  common/rc         | 25 ++++++++++++++++---------
> > >  tests/btrfs/291   |  5 +++--
> > >  tests/generic/081 |  6 +++---
> > >  tests/generic/108 |  7 +++----
> > >  tests/generic/459 |  6 +++---
> > >  6 files changed, 53 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/common/config b/common/config
> > > index fcff0660b..41b8f29d1 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -165,7 +165,7 @@ export XFS_MDRESTORE_PROG="$(type -P xfs_mdrestore)"
> > >  export XFS_ADMIN_PROG="$(type -P xfs_admin)"
> > >  export XFS_GROWFS_PROG=$(type -P xfs_growfs)
> > >  export XFS_SPACEMAN_PROG="$(type -P xfs_spaceman)"
> > > -export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
> > > +#export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
> > 
> > If you have problems with online fsck, please report them to the mailing
> > list.
> 
> Thank you for finding this, Darrick, but there is absolutely no need
> to treat me like a n00b who doesn't know how kernel development
> works.
> 
> I simply forgot I did this when debugging the hundreds of
> busy-after-unmount failures that were occurring whilst trying to get
> this patchset to work.
> 
> I turned off scrub while I debugged these issues to reduce the
> amount of noise and variations in the end-of-test failures, and I
> simply never noticed that I had left this hunk in the patch.
> 
> So, nothing wrong with scrub, just a simple case of missing one line
> of debug changes in a patchset that touches 400+ files....
> 
> Removed.

Thanks Darrick and Dave, this's a big patchset, warm welcome more
review/test from anyone :) I've prepared a "for-dave-check-parallel"
branch which merged Dave's "check-parallel" branch onto fstests next
release(this weekend), and fixed some conflict. I also removed above
comment mark and re-pushed. Feel free to merge&update code or
review&test on that, I'm testing on it too :)

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

