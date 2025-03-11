Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A84199FBA
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727970; cv=none; b=YVin3DJGb25Ay5hqPIhSy17QmrtZsVbcx0s5sJVsNrNaSupY2iqJV+00oR2iY36QQg8OhPwYQ28PJ41YXH6DI4W/1zvGr2mqLSjGZA5ygKMtn97VN70PYBI2WbL0f3Ha1RaZ/1cmlrDFAKNOJP8cZbBZ8R7Yy5MmUmV9XodgPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727970; c=relaxed/simple;
	bh=3Ln4F14YP/h+ZxbuqTzOaFyUr7PkbSz3fcJH2sxb7Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhcNRVP+mntqKDzudIj/cs3cW30x+sURrGmFK/u05QFiVXKp0Uq2zNULZXqyqkD5qcrWfF3pYcfF9foWh8rKnLQB179LI6dSxHt9+1cN/BJzoml0DFAx6nY3IIhCKALgkZ5//kAVYC6Ci60ZuNxXl00ovz/FCTw1BDY7VYHcxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=m91XHOTE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="m91XHOTE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so65772145ad.0
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741727968; x=1742332768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhvF91j8QAWGZT8Ko79zlX4hWPyLZFoRaCgvhr0uQSA=;
        b=m91XHOTEFpGvdFK8Ne9NS0jX9yPx3xrbJ/69MUO6/u/liVbDp6U1QiarpyW1vZEjyO
         bWogj/x7pVEpyfGVtPEx1QOkrYxXKAzOuliXUaW14PliNjuG8Km/D9x7tLjw/eniIfLO
         c9D6KiiS2yTJwlq3J0RB2ZvGwewrvN+DX4pOcf+PN71VcqIU84ruoEThI2xXo8i/okyI
         +w+gGL2on4YqL66ZtFBPA9u72AWvs7RsTmWsmGbziBXMxVkhk4Dk/ruPDtoqOIfGK1Wi
         a33VZs045oKbe4yeutMUeKFwyiu0V/ysGLakbQ4RVXZwZhUybWmMlnBnRIZuJC+eS0Og
         cnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727968; x=1742332768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhvF91j8QAWGZT8Ko79zlX4hWPyLZFoRaCgvhr0uQSA=;
        b=bSiC9AktUWLi7qSnxXyZiP7cSAWRBOfTul8QXeYplDgITmZBfkUJuSedLl5ydlC9ll
         /VmpMzv6P6U2D2W57vdbu+5Zl9vhrlqZQx4VP2I0WihAp6dQQsD3Z7FR/GD12KREcLgW
         wNTW0iuwXrslCTqMaVy306z5XShmnbCMPTQ1IYiMdk8lgR8iJedBlubOgbNeUoBVxhkT
         od3dB6OOInH2/T7gvXKXnGRzeComBH6VWgW4rcZN+DgIrsLsHpR+xCJW7Zo0WAIpNmBi
         9RPJo8TPQfNKDre3POivDdqE9OYBMDOfmKpwFTiqOVe/HmF1W9xL2/ZKW44y1WF+BlNz
         Ruyw==
X-Forwarded-Encrypted: i=1; AJvYcCXUPcT1dHzv1bjBx9HqKpohtDLlVDb8kfpu3iiWbkpwMuk7Tifn9S2e2Zny3JNOX5plgG/ABrlh@vger.kernel.org
X-Gm-Message-State: AOJu0YwpitVGAMcuvL1yhKAb4jBbuog6siWEE6KNZUrEPtAs26O3zMZn
	vxqbVNrueGojyZPtSzM82xjxTgOMK8yr6bMsjLSG+XSmcrlGCPpsHt37iGnGu7wm8M8pRbjcdgl
	y
X-Gm-Gg: ASbGncvFhEEXtm2fA4GpEoyqDCuUEhiKEjnhvN8LSJPpaM5d3NdiokCx8zC/usxj0tJ
	KkilAwCjJ3xuFQdZ2VnIu3NlthpC0yN2MN2aCBVvDNKNdTUWxavxLZTwayaeFuI1DBEG/SB2Kr/
	x9bVLotVolyMDxRo6gdW0C6IKbCW4U6DvCX6tSyxht2m9VmUr1I6x/G52Yf+yAsCAGbW2NlWc9W
	W3489qXrPSB0Uk+aKy9opwIBGQ+B3W2vqAT2RYUc/ntZLoFnsrm8lU0R4H+FLC7q9JKR/0b5bZM
	7QaboFSQiNsQ231oztyUdNqUh/wv3NxuF/17n55aRj5NZLLGBzWmlV9fOWqkDJpH+GAqvocERmC
	wtfgUmJ0anQjRGLLjXQMr
X-Google-Smtp-Source: AGHT+IGeWsyE8McypzNHrL8vFFmERDIthfi2fscLkZah+e9ANYcUSe5hH5osXrbdLi3D6T3lux0C/g==
X-Received: by 2002:a17:902:ccc9:b0:223:2aab:462c with SMTP id d9443c01a7336-22428899f43mr303773255ad.15.1741727968053;
        Tue, 11 Mar 2025 14:19:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f95fsm102886335ad.154.2025.03.11.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:19:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ts70X-0000000BshA-0S5D;
	Wed, 12 Mar 2025 08:19:25 +1100
Date: Wed, 12 Mar 2025 08:19:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Message-ID: <Z9Co3WnndML6zciA@dread.disaster.area>
References: <20250306094924.1353269-1-zlang@kernel.org>
 <20250306094924.1353269-2-zlang@kernel.org>
 <Z8mBacJNAj6gVd7N@dread.disaster.area>
 <20250306134723.x5fovpzmzemleyi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Z8oL_LAc9XQsKwd-@dread.disaster.area>
 <20250307154722.iafm7hm7qo6x54c3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307154722.iafm7hm7qo6x54c3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Mar 07, 2025 at 11:47:22PM +0800, Zorro Lang wrote:
> On Fri, Mar 07, 2025 at 07:56:28AM +1100, Dave Chinner wrote:
> > I'm talking about removing all the setsid and namspace bits that we
> > added to try to solve the need for pkill --parent. i.e. this series
> > of patches:
> > 
> > 949bdf8ea check: deprecate using process sessions to isolate test instances
> > 247ab01fa check: run tests in a private pid/mount namespace
> > 88d60f434 common: fix pkill by running test program in a separate session
> > c71349150 common/rc: hoist pkill to a helper function
> > 77548e606 common/rc: create a wrapper for the su command
> > 
> > Using private PID namespaces in check-parallel has solved the
> > original problem that required the pkill --parent usage and the
> > fsstress binary rename/copy workaround by wrapping process isolation
> > outside of each check instance. Hence check and the internal
> > check infrastructure doesn't need to ever care about process
> > isolation to solve this check-parallel problem anymore.
> 
> If "check" doesn't need these namespace isolation things, that will be good
> to me. That'll help to isolate the issues on check or on check-parallel.
> And we won't bring in regressions to check when try to fix check-parallel.
> 
> Now let me merge this patch at first, to avoid the regressions on btrfs.
> Then please feel free to send patches to remove/reduce the coupling of
> two testing ways (check and check-parallel:)

Sure.

FWIW, it's not necessary for you to test whether the merged version
of check-parallel runs correctly right now. If some other change
breaks it, I will fix it and send patches to fix it. I'm much more
concerned that changes made to support check-parallel don't break
check...

> > i.e. the isolation fix should have been made to check-parallel,
> > not to check.
> > 
> > It is not ideal to have to walk all this stuff back, but this is
> > what happens when an RFC-scope feature prototype is merged without
> > allowing adequate time for review or give the author a chance to
> > address at least one round of review comments and bug fixes before
> > it gets merged....
> 
> Sorry, I've learned from this. I thought I've given it lots of test,
> and fixed all bug reports at that time. And I asked several times
> if there's any objection about merging it in next release. As there's
> not objection from anyone in 2 weeks, so I decided to give it a chance,
> to save the super complicated rebasing workload...

Sure, not having anyone review a prototype after a couple of
weeks is pretty common - it does not mean it is ready for merge.
It typically means that the author will then post a newer, more
complete version when they are ready, and then maybe people will
look at it.

Hence my comment on where I wanted people to focus their review -
not on the check-parallel stuff, but on the generic infrastructure
changes (i.e. "get the process underway") because they were much more
important to get right than the check-parallel script.

IOWs, I was not asking anyone to bypass the normal cyclic
review-repost process - I was simply doing what ever experienced
developer does when posting a large patchset: guiding reviewers to
the important areas of the patch set to focus on first.

> Anyway, next time,
> for each complex patchset on infrastructure, I'll always give it 3+
> release cycles time. And never merge it if without 3 acks from xfs,
> ext4 and btrfs,

And that, IMO, is swinging too far the other way. If the code is
complete and ready to go and nobody will review it, then the
above rule makes it impossible for the author to get their code
merged.

now we have the opposite problem: people have to carry large
infrastructure changes for a long time because they cannot get
anyone to review it.

The normal process is to let review-and-repost cycles occur
naturally (e.g. every couple of weeks for a few versions), with the
author indicating what the important things to focus review on in
the patchset are. When that cycle reaches it's end, a request for
merge will be made (e.g. a pull request or a repost with all patches
containing RVBs). This shouldn't take months, and if the reviewers
focus on the things that the author asks them to look at first then
the important things end up being ready for merge earlier rather
than later.

IOWs, there is no need for placing arbitrary bars to jump over if the
process is allowed to follow it's natural path. Problems typically
only arise when the process is not followed, so there needs to be a
very good reason for stepping outside normal processes or having
arbitrary rules that nobody really knows when/if they might
trigger...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
