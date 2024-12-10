Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D822612
	for <fstests@vger.kernel.org>; Tue, 10 Dec 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792131; cv=none; b=IZyR0L242YRrLDh1mseAp/tD3lQz0EAm1UZVBOMvB9q5bA+gwwrQaNHGuAPMheS2M9im+AfMVwPA1GyeH7vkHJM/HFcizBUFdHoFYw0ffukAMQeExc/3Q0KiNwU9eYzzybOZZuPu+X/5MQJy6qd2zR7ViuaitPLxCuSsgPt/wpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792131; c=relaxed/simple;
	bh=cJBo/GFpwBb+Pyb2eYFgDOOtRbG6prdhQkpj8fpfU64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLu9wJwXQd5aA1zW+E1ihXFZgO1vA+o8geQL/2rWP61b+TOXHe7mxCjCVq+P6ZQk5eTfsjLmPeTdlySxenUJiRNpkoj5eIHPwAuaYQ4liWn6FudjrIIV2i+rfmFWdTaUOjW4EJYfrQMoWTXXbYVphkVSyFMSJ/7PH/RS6TqcCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ldk7F3y6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ldk7F3y6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216634dd574so7810385ad.2
        for <fstests@vger.kernel.org>; Mon, 09 Dec 2024 16:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733792129; x=1734396929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awfl4bC2xy2M/1Ke4i9mI0+EXuYTlUTybWGykmiKDwY=;
        b=ldk7F3y6jVs/BukMi/jzZvl2VFVJARz9MQ/bszvOmxj+j/bszKOAOMa6s2Z6HVtJm0
         IaJMOVYZf1pX8HgVfrXuwKSIa+Q8xouTtX+yXfw5eNaEw4gnfBgckVDafgRV11MHvyZg
         keIngk14r7ITnlScJa/BG3eJ5Sy9mtuUe4ynXVJB8ujxh813jUe66Rt+rkkMVdsqJDQ2
         mg8wkJ9mXL6aOmGG5ezPYU0Uovj/fF098Ld+13dBisQQCnJxy5e2/HPSHfT9HxieVC6Q
         qR32OAX/tYKgP4N4eLuAt2mo6EDbFWcyFQV0rRYTJfhFil/94b9jrnrfoPBVYcEZRDfR
         EXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792129; x=1734396929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awfl4bC2xy2M/1Ke4i9mI0+EXuYTlUTybWGykmiKDwY=;
        b=WODH8m3pivDpEFt7JlF3EbhkHB8cmfWJPbyJuOWnV2r/wVleO0KOHUM7tHSZwq6sdo
         g1kN0QfpLGXo1dYtMPh9C334x8lE/bYEM2areW9UCO4YujNg3dLJ5x2XygaVIN2gJTTm
         kTSKuH+eL8yr31x9oTCQAnVL9S0x8SuRJvdhbOeZWNIJebj8cIBiTyihJRpmiHnbCKTr
         GYohBcpeSbQkf/Z1BC2z7MH1tqmdaPkYatubTYxVB2BarHPnMR+tHL8/GLdEHsGPQMT8
         amHo8NuDgtOrSG7kvZU2NXkQ97BvP7r+geUJpSWAP8JZlaGojnfaqywqcZe0VxLW14V1
         9hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Od/EFgbgiOsrb0tYxhtPg1TXgCReB44tY06fp7U59GAnYyCbV3MVK2fHLxmedhEOv4vPDrDl@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/DnORFnmgSP5eexNn6d6DRKVjfU3LNwkj/omk3zLJG3nWK9P
	f9/eEiEBQPuPBk9OOhA+LRPvepHDs+6473NpqafsX2Ular8GBOP3AJyOD3slQtQ=
X-Gm-Gg: ASbGncvvYpdFqxVU//x5vCROPZ2N45xJnwyCAizVsI7EhRTJPqcdCht7clUpkf9RLzL
	yVjUymJyMHuIV+hoTtoSSAueG98eLRw/BpinVZm2PP1c/EPp7jlgDC7FwtkB1BWXF17BWEpriGM
	G/nUoe4p4MKyIVpTrsPRWodsmTnl4v6oE2YxxwmvHGtjGmQUfsPJsh9dLlApIyZLCokN7zl7B/P
	eiVL3bhZlxXHhOhkSLOzR1dCzBj90C/0/BdW1d+veGMRvDzZJ01qFErD98yrs2+MoocTMt0FLTx
	N/BtzGHY5g5AxfykvR/8cbbqftk=
X-Google-Smtp-Source: AGHT+IGqnljlmWkCwyeuT5IRVnvY1dyzpvO9FeJb3CeODJslSbPfz2qD3NIIQBBce0MIrogdYAxA1w==
X-Received: by 2002:a17:902:d48b:b0:215:97a3:5ec5 with SMTP id d9443c01a7336-21669fc2252mr46853565ad.22.1733792129135;
        Mon, 09 Dec 2024 16:55:29 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216316d8086sm43178745ad.223.2024.12.09.16.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:55:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tKoX7-00000008mmk-3Dr8;
	Tue, 10 Dec 2024 11:55:25 +1100
Date: Tue, 10 Dec 2024 11:55:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH 00/40] fstests: concurrent test execution
Message-ID: <Z1eRfYIBuZETB8rI@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241129042216.u2f2sl5pc553gxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241207000917.GA7824@frogsfrogsfrogs>
 <Z1TiAdDQSrebz3Y8@dread.disaster.area>
 <20241208061520.nfdwfajwyyw2xfdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208061520.nfdwfajwyyw2xfdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Dec 08, 2024 at 02:15:20PM +0800, Zorro Lang wrote:
> On Sun, Dec 08, 2024 at 11:02:09AM +1100, Dave Chinner wrote:
> > On Fri, Dec 06, 2024 at 04:09:17PM -0800, Darrick J. Wong wrote:
> > > On Fri, Nov 29, 2024 at 12:22:16PM +0800, Zorro Lang wrote:
> > > > On Wed, Nov 27, 2024 at 03:51:30PM +1100, Dave Chinner wrote:
> > > > > Hi folks,
> > > > > 
> > > > > This patchset introduces the ability to run fstests concurrently
> > > > > instead of serially as the current check script does. A git branch
> > > > > containing this patchset can be pulled from here:
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dgc/xfstests-dev.git check-parallel
> > > > 
> > > > Hi Dave,
> > > > 
> > > > I've merged your "check-parallel" branch, and rebase on fstests'
> > > > patches-in-queue branch (which is nearly the next release). I just
> > > > pushed a new branch "for-dave-check-parallel" which fixed all
> > > > conflicts. It'll be "next next" release, feel free to update base
> > > > on that. I'll test that branch too :)
> > > 
> > > I ran this through my test infrastructure at zorro's request.  I saw a
> > > bunch of loop dev errors trickle out:
> > > 
> > > --- xfs/129.out
> > > +++ xfs/129.out.bad
> > > @@ -2,3 +2,6 @@
> > >  Create the original file blocks
> > >  Reflink every other block
> > >  Create metadump file, restore it and check restored fs
> > > +losetup: /dev/loop0: detach failed: No such device or address
> > > +Cannot destroy loop device /dev/loop0
> > > +(see /var/tmp/fstests/xfs/129.full for details)
> > 
> > Almost certainly I missed the conversion of names in
> > _xfs_verify_metadump_v1() from "data_loop" to "md_data_loop_dev"
> > and such. common/metadump is liley missing "unset md_data_loop_dev"
> > after destroying the loop devices, too.
> > 
> > Not sure why that isn't triggering on my setup, trivial to fix. I'll
> > sort it out and fold it back into the original loopdev cleanup
> > patch in the set.
> > 
> > > and I noticed the runtimes for running serially went way up.
> > 
> > Not seeing that here; I don't think any of the changes I've made
> > should affect the runtime of a normal check test pass; the tests
> > should take the same time to run or run faster after this patchset,
> > even serially...
> 
> Hi Dave,
> 
> I replied several emails for this issue:
> 
> https://lore.kernel.org/fstests/20241207195101.hfg3m4pgghoo7ebv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#mb1da5dddd053dcd5ed8ec15c45ce8e3fa55c2d38
> 
> I've tried to fix this and all other small issues on "for-dave-check-parallel"
> branch:
> 
>   # git clone -b for-dave-check-parallel git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> Could you take a look at it? Currently my test passed on this branch. As
> my original plan, I'd like to merge for-dave-check-parallel branch onto
> for-next and push in this week.

If it fixes the reported failure, then I'm fine with that.

Unfortunately, the machine I've been developing this code on has now
been dead for a week and a half (main board failure), and the vendor
doesn't seem to care about the "NBD on-site" warranty SLA...

I have no idea when it'll be fixed, so if what you've done works for
everyone else right now, I'll clean up the remaining things I
noticed when I've got the machine back up and running and can test
this stuff again...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
