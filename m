Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167B3D69
	for <fstests@vger.kernel.org>; Sun,  8 Dec 2024 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733638530; cv=none; b=VbDHF0tw7rXKvqNB6ebsTMwd+P9pXfPtuorS3HLch266QBdn86VoLt3c8EwK2lUzSAyaEmuXCStIUYYE6xuYUvPVP6dRxuf0UC1bVfSkz+vom7Lyi+Pc9PEYd334IG/MIBTCG0ckYKyDP9wCjQmc9VxqNZTTiQvZ54BGvRm9Ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733638530; c=relaxed/simple;
	bh=BmwThIMD1z7QmusYI+XcGgLid2R/06pNRDx84mMqT94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmdZgHkSMsH7SaEDkUCu+jKYU1G9H28aSL4So+iJCMRhmRn2w5xhb9ONre13wRyHgARpYRpPF0c9mM9tqctzslu4ZGnaVMDqWpixfJAojgXmw/lHWrFIPQ4iGOby63mlV6Kww6md939OBSz7BKSqEf+ReR48zcI25BDtGeRwZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de8eAW4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de8eAW4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733638527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnquOwcdt70D5UEdtKQkJpmqdKuW4fsAg2XyngQBEC0=;
	b=de8eAW4ZbA4K5i5j7obcheZ0uDcVt5cCn+dHcTjJxaZRiCLzBRKx33Y7Cbg8Zi/D2YgtPb
	GFMSTS0JDCkgOq8waipcPvoZRza22GH56Lwrc1OrOTyQqRWQIuLbXs8UiLg81gBRHDJknv
	HFewNKwLZ5AsBo7eHw83b/o49o2fLic=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-oeXdad7ONS6j_6dfJUmjBA-1; Sun, 08 Dec 2024 01:15:26 -0500
X-MC-Unique: oeXdad7ONS6j_6dfJUmjBA-1
X-Mimecast-MFC-AGG-ID: oeXdad7ONS6j_6dfJUmjBA
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-725e59e41d2so180211b3a.0
        for <fstests@vger.kernel.org>; Sat, 07 Dec 2024 22:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733638525; x=1734243325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnquOwcdt70D5UEdtKQkJpmqdKuW4fsAg2XyngQBEC0=;
        b=o/DwXMBPTKswqp4hrVC2M9pMEVLBA7NBUnkEhQ9yRnZ2zFwLjGSqQv5u+5rNO7lQzu
         sC8JX2/CFU6eUYVYwgRJXSLKpwfIeixlS9gwsZ2v4K0Hbu3LXKRx96b8FDK+wVPFmtiA
         PcVcUi1wOKDB4tSc+FFd88cVtrQlCBA2jBj2412MEzhgzrwzJmM8MgpirEWo5LjvQL4L
         tUcgD41wkcYaOKhI8hDyHMLZSoZGqCqdqkJMy8eit0LISwQ9oHDHA0oHyMQWl+7LSTJe
         uHZdW0bZyaxSCP5dO8zoA34FnH5HZ9oLDQVW1UU2Pv4zwA8veGvWUR3ESc9E6Y+XgFyL
         0ehg==
X-Forwarded-Encrypted: i=1; AJvYcCVcK2KHX4S7ykgXPNx2mQEjN7pvY6N+yxpdRb0Smr9po9OprEFfL7r3PmeR9qOGPHiLNch8vs29@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1RjfQ4lvHo4EnPvZJfPr7hFUgWgoi/EDxuH56FfpQxrZAqoIj
	bbuicIIxJS8FpGe0i3nbCRrnQdv17qPBSPxqM/4Wm/ccDLYgtgC4l1k+oJ5ffOGJ0pWAJBMJJ+H
	kp1PA6aVDhDcVueOKGabCeeO2x53SDNQVeXWhYLDR3+vWOWGKibf/Fk0ACuR9E18=
X-Gm-Gg: ASbGncuLMdlMF093bnTMEKQF5zDF3lwRv0P0qw/W9SoWpjao8M+zp3ou0sSe1UHiqte
	dxLRU55PyC0oPQmN/jgB6emynSHfBxJCK48rZfXsKmO/aUJsQxbyCvRAOAfB/aLRVoVmyS8dWZ1
	psaXV0ij8AGUT56L9wbjbmFy6D1CN2UR87DS886e+K5TSktMC0j7DVZxCPJnywNKD9/Q21GLl0O
	PAcRUdSOqP8Kp6VDTNmuhmGecDuaFWJXTEd5S0sqiXj6L8fULOokMGoZCAZANuUu1agQuJWhlIw
	itYptv8d0LKC5ww=
X-Received: by 2002:a05:6a00:3d43:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-725e4b9a8a5mr1686199b3a.16.1733638524785;
        Sat, 07 Dec 2024 22:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNDGgxM/iYVcqibRxt7AtEck9Yzn/UlOBsvHQiSZlBjzXBuz3EXucFgpM+ubocCAJmYypuUA==
X-Received: by 2002:a05:6a00:3d43:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-725e4b9a8a5mr1686172b3a.16.1733638524242;
        Sat, 07 Dec 2024 22:15:24 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725db428754sm1460954b3a.181.2024.12.07.22.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:15:23 -0800 (PST)
Date: Sun, 8 Dec 2024 14:15:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH 00/40] fstests: concurrent test execution
Message-ID: <20241208061520.nfdwfajwyyw2xfdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241129042216.u2f2sl5pc553gxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241207000917.GA7824@frogsfrogsfrogs>
 <Z1TiAdDQSrebz3Y8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1TiAdDQSrebz3Y8@dread.disaster.area>

On Sun, Dec 08, 2024 at 11:02:09AM +1100, Dave Chinner wrote:
> On Fri, Dec 06, 2024 at 04:09:17PM -0800, Darrick J. Wong wrote:
> > On Fri, Nov 29, 2024 at 12:22:16PM +0800, Zorro Lang wrote:
> > > On Wed, Nov 27, 2024 at 03:51:30PM +1100, Dave Chinner wrote:
> > > > Hi folks,
> > > > 
> > > > This patchset introduces the ability to run fstests concurrently
> > > > instead of serially as the current check script does. A git branch
> > > > containing this patchset can be pulled from here:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/dgc/xfstests-dev.git check-parallel
> > > 
> > > Hi Dave,
> > > 
> > > I've merged your "check-parallel" branch, and rebase on fstests'
> > > patches-in-queue branch (which is nearly the next release). I just
> > > pushed a new branch "for-dave-check-parallel" which fixed all
> > > conflicts. It'll be "next next" release, feel free to update base
> > > on that. I'll test that branch too :)
> > 
> > I ran this through my test infrastructure at zorro's request.  I saw a
> > bunch of loop dev errors trickle out:
> > 
> > --- xfs/129.out
> > +++ xfs/129.out.bad
> > @@ -2,3 +2,6 @@
> >  Create the original file blocks
> >  Reflink every other block
> >  Create metadump file, restore it and check restored fs
> > +losetup: /dev/loop0: detach failed: No such device or address
> > +Cannot destroy loop device /dev/loop0
> > +(see /var/tmp/fstests/xfs/129.full for details)
> 
> Almost certainly I missed the conversion of names in
> _xfs_verify_metadump_v1() from "data_loop" to "md_data_loop_dev"
> and such. common/metadump is liley missing "unset md_data_loop_dev"
> after destroying the loop devices, too.
> 
> Not sure why that isn't triggering on my setup, trivial to fix. I'll
> sort it out and fold it back into the original loopdev cleanup
> patch in the set.
> 
> > and I noticed the runtimes for running serially went way up.
> 
> Not seeing that here; I don't think any of the changes I've made
> should affect the runtime of a normal check test pass; the tests
> should take the same time to run or run faster after this patchset,
> even serially...

Hi Dave,

I replied several emails for this issue:

https://lore.kernel.org/fstests/20241207195101.hfg3m4pgghoo7ebv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#mb1da5dddd053dcd5ed8ec15c45ce8e3fa55c2d38

I've tried to fix this and all other small issues on "for-dave-check-parallel"
branch:

  # git clone -b for-dave-check-parallel git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Could you take a look at it? Currently my test passed on this branch. As
my original plan, I'd like to merge for-dave-check-parallel branch onto
for-next and push in this week.

So if no one has other critical issue to report, I'll push it as plan. Then
we can fix later issues, and other's patches can move on.

Thanks,
Zorro

> 
> > Not sure
> > if that was because my dev tree has a bunch of metadir fixes in it or
> > not; will run that again over the weekend with upstream tot to see if it
> > that brings the total runtime back down.
> 
> OK.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

