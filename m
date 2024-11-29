Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA372C18C
	for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919600; cv=none; b=hTOZMC7FgxvkrDeZSnfQsqHS5g7uRlfk7MKIbs46VMJ/ll+S/6pPw3AokOAzbrUkdFSTpxLcNXiW5ipAfowQ4sX1UqOpiK1vA+BecakhqosXwu1UVFrup9YLTDXv2qdQXk9iSFRMERhlQGdnYRpXoUHXmsXmGWjoeni4xwWWtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919600; c=relaxed/simple;
	bh=smo4zO9am+0WqnxE52MxceU+U5b0u5No7cZHLc1yKaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxH7NzXfpVFF3/mrHUXTDzest5aEgJrFKMU+WrZHC6FtbSPbLy62mq2GAJ8Cvk7n/mZZ8gWoZAXyww3+tJscwTpJaf4nVf+mjg6n6wPVtIG1qjdmb0QJq9QNOcgp/HwoAsEgei0WtnduNT/lTQ7YNxgN1ihhYSyUU2LXFTL70Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jkhXIH5W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jkhXIH5W"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21288ce11d7so21093245ad.2
        for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732919598; x=1733524398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxZxFatpMzd8tyEoP01LrEudajQ7iUXyM9pfoab0RxQ=;
        b=jkhXIH5WSynQL34KgGvEeNRCi+dME9ipzLnUHvUhSMchTh8p7p38586qGDjbLhh4hz
         5oOBX0hnQGjhgWYvoIC+UljaWvVc0gAVsiy3RNUe7HKGXWrO1YZ+0Da4wxUQCllsjEAW
         +DSEon88ACjlR1fi5NJuyJkj2gToDJZ46bB/DliTfZId1ed5TSbfVzcj1+fGAuBIuPyZ
         VnP6TqDXuLQN8c28eT3NZ6GVnjAoswCFpenWGK11L9rpiNfogoEj7Rx5p96ka3hDzhnJ
         +NmlsstuJmFlOpLBDcRNuO7ttooLrcQW2XLaWhA/sAixPoKIUR117aqmWg5izvrW6Zue
         mb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919598; x=1733524398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxZxFatpMzd8tyEoP01LrEudajQ7iUXyM9pfoab0RxQ=;
        b=M5sp1TsVZMtFl3cqn0TGUyXvwGse4DlGZ6iVlrlMNjBldHSgtYnrZ9w98YORhpZZKH
         qqS342pTqbXG5nynx+95Zen+kRCbaHAYeJVphSeB0VwaZWFFpmFJMhu52GOGMCnyB3Ab
         K5K2DYJ+9+sLqJL9058XjZdtCNHPlubtlZ3l2QELDk//q1ad/uRMbQtsUyh/xVY56mKu
         iVX5dm0uJ6E1XhwLsGQJAWxkFQm68iKjNpntA9d2s+mMOD78y3NCKD1TeV3EXwpZ83dI
         Vgxh/ZnN1EGxAbBY1UuNkaFE2ixLS0oZU+01mQYno8GyVX8EuohvMfVnrVYgGDe/zojD
         wHbw==
X-Gm-Message-State: AOJu0YwlCWN5Je1gi/aP3SBoX1m8PHo7AwfRrdtiDaGwvlkQN1qBVXaZ
	KLtkxhgD8yQ7Efm3gDzuf5o2NG2VCPAYyryiGTJeS/13GiicTrLYwxF1DLL2+WY=
X-Gm-Gg: ASbGncvfvwDizRDhPBKau1iAz1eFAnf3X+goUhlMFpcRgxD2t/6HAexhcJajg8XTkHK
	cnXiDLjArvCeyWBE+8UNZX1mm/QFg/7qQPPQTGIvsHxhMpsEErPBf5brZL/zoYrYjSmqcVmc74m
	foHUk/eaNGixbFVutThbOHvNK2H0t1cMrzK3gHAErlXgLx13aUu9lfVigEutMx4HymIb9SWqVhM
	tfXHRD2vUhiTX7vW+sNKWUddVxldzh7JM2Vf8UiRzCGJ7DbYF9vYgpGHtffbgi0DZB9FKKcgBts
	5GW4vxzN5ixdaxfr+ns8ouP62A==
X-Google-Smtp-Source: AGHT+IGXcQbpBtv0Z4uzefVRre42CC8Zm4RidRQ6eAvBZxdUpZgTuU2J221uIzNDcspYk0j8iW81LA==
X-Received: by 2002:a17:902:e883:b0:215:4fbf:11e1 with SMTP id d9443c01a7336-2154fbf147amr32338635ad.19.1732919597737;
        Fri, 29 Nov 2024 14:33:17 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c39f4d7sm3134435a12.69.2024.11.29.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 14:33:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tH9Y1-00000004gGl-2ek1;
	Sat, 30 Nov 2024 09:33:13 +1100
Date: Sat, 30 Nov 2024 09:33:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 16/40] fstests: use udevadm wait in preference to settle
Message-ID: <Z0pBKWBlXLBxwK3D@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-17-david@fromorbit.com>
 <20241129171009.GF9425@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129171009.GF9425@frogsfrogsfrogs>

On Fri, Nov 29, 2024 at 09:10:09AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 27, 2024 at 03:51:46PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > When running lots of tests in parallel, there are lots of
> > filesystems and block devices changing state. This generates a lot
> > of udev events when means the udev event queue is rarely empty.
> > Unfortunately, an empty event queue is what udev settling waits
> > upon. Hence calling UDEV_SETTLE_PROG can mean waiting for a lot of
> > time for other tests to stop generating udev events.
> > 
> > For the majority of cases, what we care about is that udev has
> > performed device node addition or removal, not that there are no
> > udev events pending. Recent(-ish) systemd releases support 'udevadm
> > wait' to wait for a specific file to be created or unlinked rather
> > than waiting for the event that does that work to be completed.
> > 
> > Hence we don't have to wait for the udev event queue to empty,
> > just for the udev event that does the device node manipulation to
> > complete.
> > 
> > Introduce detection of 'udevadm wait' support and a _udev_wait()
> > wrapper function to use it if it is available. If it isn't, the use
> > the existing UDEV_SETTLE_PROG behaviour.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/config     | 35 +++++++++++++++++++++++++----------
> >  common/rc         | 25 ++++++++++++++++---------
> >  tests/btrfs/291   |  5 +++--
> >  tests/generic/081 |  6 +++---
> >  tests/generic/108 |  7 +++----
> >  tests/generic/459 |  6 +++---
> >  6 files changed, 53 insertions(+), 31 deletions(-)
> > 
> > diff --git a/common/config b/common/config
> > index fcff0660b..41b8f29d1 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -165,7 +165,7 @@ export XFS_MDRESTORE_PROG="$(type -P xfs_mdrestore)"
> >  export XFS_ADMIN_PROG="$(type -P xfs_admin)"
> >  export XFS_GROWFS_PROG=$(type -P xfs_growfs)
> >  export XFS_SPACEMAN_PROG="$(type -P xfs_spaceman)"
> > -export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
> > +#export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
> 
> If you have problems with online fsck, please report them to the mailing
> list.

Thank you for finding this, Darrick, but there is absolutely no need
to treat me like a n00b who doesn't know how kernel development
works.

I simply forgot I did this when debugging the hundreds of
busy-after-unmount failures that were occurring whilst trying to get
this patchset to work.

I turned off scrub while I debugged these issues to reduce the
amount of noise and variations in the end-of-test failures, and I
simply never noticed that I had left this hunk in the patch.

So, nothing wrong with scrub, just a simple case of missing one line
of debug changes in a patchset that touches 400+ files....

Removed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
