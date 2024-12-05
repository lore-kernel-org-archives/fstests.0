Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF002163A8
	for <fstests@vger.kernel.org>; Thu,  5 Dec 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393170; cv=none; b=pnDOf5rBjCTXQA1cCbchlgGINjVkMvmLhvLGfufy7YPo32JWOFTaUGF2hswcF1XfU1CcQQ68oj6VumhVPNEIGvaJoMKiEfudFNxOlnFvU3ucy8MN98PQo7WxwcOiC49U3lUOli/c697e7AcXt2OBbaKQoMf53iPsEBNT4U3STvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393170; c=relaxed/simple;
	bh=3Vg3OSf6aRJHMRvcYmh+/NPsWaawQe5od+aaxSAnyg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGNtKz4X8tC9iqEXTYwMXZlBsC/SayINLjltMKdSAyIhwr3efAdue/rG9CpZexzei+deHIsbFFRxsSR/bnHY8GENjsVxmRetMYpaYBmfoirUYleojPOW9feaLwMBWcE36tkITuK/Jy9+MruKHaAw95GTReSpcnpL6uPdMLqdnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOWJa0Zj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOWJa0Zj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733393167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Aaesvd5ZrbgVZCPFAwwFllsiZjmrFVYPfF7S7GHMxM=;
	b=DOWJa0ZjkoiJmEHg7PXKPn9I3NIwFgP4kIx074vcH63KqbHNEusZ4SMMpd28SGcuLrdEMc
	d3EVLVAIS4+nlk+SxdQmC566iCgVSw2xzG+kwR4C7kjaG84vbwWxlkTzMNr8VxwhVVXy7h
	X4VNal+5N9dYLmeny+Byfi/Tf5ar9PI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-w5iY1wmLPYeu7G9LRVsqYA-1; Thu, 05 Dec 2024 05:06:06 -0500
X-MC-Unique: w5iY1wmLPYeu7G9LRVsqYA-1
X-Mimecast-MFC-AGG-ID: w5iY1wmLPYeu7G9LRVsqYA
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5f20ac940a0so637017eaf.1
        for <fstests@vger.kernel.org>; Thu, 05 Dec 2024 02:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393166; x=1733997966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Aaesvd5ZrbgVZCPFAwwFllsiZjmrFVYPfF7S7GHMxM=;
        b=wg2AZVE9lm4kWZk2pIwWa65gr8QPFUNH0SGxxkKBfJkHMgirgH5iURbZkUPf1FowSj
         6sou9NMEAQQ6GZp16Yji0HephX/Tw4KY9AqIIiirw8qeUYr7g50EPfBXVMn+Rq96TzXd
         yFTQOZ53UWK7fLNbLQaTiUc8j1xsHjN9fO9o+Z/jE2dfzvR0v8ydd1nRRsRgj725cwm6
         avQj+Ab0cqbW18CWMPoB9I6Zp4lNYs5Lo16zPuJ1tMzekhRGB+FLhgPZGJGBcHq6tR7B
         P4yD/B/lyg8JJVBochsaA+5oSGC+hdffSDR7poHciDQLp1bwS7ZYmDkCc4u8JXPLnDGq
         EtJw==
X-Gm-Message-State: AOJu0Yy4htfeu2Sl4Ed4gjF+bLMsAJrHMUM/2KMz9D8qIVU0XlWXRIg8
	W6gBU+PtGfAv6MOCWe5lEVCq44ziAXPONWpktwUYzbD3YcVhKhSJ7BYWrAZW/lUXDYuEXrYN0J/
	9/o7nxDm8k939rflEjQVBa8X0KVZdyMRodTTGVSI0sgT6Usu6eNy1wAM9oPuLJ4RRlA==
X-Gm-Gg: ASbGncvNkoXs9I60n86LeezMdf9gYSKo2LAb0m3aBEcq8pSnhNkR2wVk7WrLT+OC/Il
	C8Bj8LPloNCZ1s3JeZUW3ZE+jHSg2bX8QhoTPgGy/f8HbL+WEc9jDJjkWS3nBPRU+d4srhSZz9k
	zIas1JMiYzLhahRtDbslB2zewD0TurGYxZN59iUIWCWWr6AcMq+40y7fyOIz5iAgUbfGSpy9VEz
	19pjyzIdT9fJd4b31UoYQrrLBOfkYfsQ5u9HElbPZ1vXIl1KK+ATPXHOiacH/00C4D8o52CB7sJ
	lUg4QfSaUeB+bew=
X-Received: by 2002:a17:902:ec89:b0:215:aee1:7e36 with SMTP id d9443c01a7336-215d003ed61mr94442185ad.21.1733392631353;
        Thu, 05 Dec 2024 01:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9fRZw9pSQUx/xiBPtnsD7qaYKESTTZiOAJOhjxdLJ/QVtVg+xeW2SFR258YmgQAD7UPhe1w==
X-Received: by 2002:a17:902:ec89:b0:215:aee1:7e36 with SMTP id d9443c01a7336-215d003ed61mr94442055ad.21.1733392631039;
        Thu, 05 Dec 2024 01:57:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3fab0sm9132685ad.21.2024.12.05.01.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:57:10 -0800 (PST)
Date: Thu, 5 Dec 2024 17:57:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <20241205095706.sdpijy2n23fy7rhv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-3-david@fromorbit.com>
 <20241204175715.56pvxgzeb243yodz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Z1EvGBRTcBa4yEEc@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1EvGBRTcBa4yEEc@dread.disaster.area>

On Thu, Dec 05, 2024 at 03:42:00PM +1100, Dave Chinner wrote:
> On Thu, Dec 05, 2024 at 01:57:15AM +0800, Zorro Lang wrote:
> > On Wed, Nov 27, 2024 at 03:51:32PM +1100, Dave Chinner wrote:
> > > +# Common execution handling for fsstress invocation.
> > > +#
> > > +# We need per-test fsstress binaries because of the way fsstress forks and
> > > +# tests run it in the background and/or nest it. Trying to kill fsstress
> > > +# tasks is unreliable because killing parent fsstress task does not guarantee
> > > +# that the children get killed. Hence the historic use of killall for stopping
> > > +# execution.
> > > +#
> > > +# However, we can't just kill all fsstress binaries as multiple tests might be
> > > +# running fsstress at the same time. Hence copy the fsstress binary to a test
> > > +# specific binary on the test device and use pkill to select that only that
> > > +# task name to kill.
> > > +#
> > > +# If tasks want to start fsstress themselves (e.g. under a different uid) then
> > > +# they can set up _FSSTRESS_BIN and record _FSSTRESS_PID themselves. Then if the
> > > +# test is killed then it will get cleaned up automatically.
> > > +
> > > +_FSSTRESS_BIN="$seq.fsstress"
> > > +_FSSTRESS_PROG="$TEST_DIR/$seq.fsstress"
> > 
> > Hi Dave,
> > 
> > I'm wondering if the "$seq.fsstress" can be unique name? For example, if generic/561,
> > xfs/561, btrfs/561, ext4/561 run fsstress in parallel, won't they have same
> > "561.fsstress", then "pkill -PIPE $_FSSTRESS_BIN" kills all these cases' fsstress
> > processes?
> 
> Yeah, it's not entirely unique, but it was "good enough" to solve
> the problem and move on to the next one. It should be easy enough to

Sure, it's good to move on to the next one, due to it doesn't bring
in regression for original testing way. We can improve this part
later.

> change; the reason I used $seq was because it is short, and the
> pkill man page says:
> 
> NOTES
>        The  process  name  used  for  matching is limited to the 15
>        characters present in the output of /proc/<pid>/stat.
> 
> It turns out that this 15 character limit doesn't appear to exist
> anymore.  I just checked that file on a 6.10.7 kernel, and it
> appears that there are full process names in there. pgrep (at least)
> matches on process names longer than 15 character, so I suspect that
> the man page is simply out of date here.
> 
> Hence we might be able to use something longer and more unique along
> with 'pkill -x' to match the full name. i.e. this is a solvable
> problem, but not critical to the effective working of concurrent
> test running.

Good to know that, thanks! So we can use "xfs-561-fsstress" or
"$$-$seq-fsstress" or something better idea you have :)

Thanks,
Zorro

> 
> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

