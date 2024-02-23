Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE6DDA6
	for <fstests@vger.kernel.org>; Fri, 23 Feb 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660413; cv=none; b=kD2rjQxvWz+mSeFvgSBC4rdCNS8V1ifSlHrqUQPnzacXmixUCJ/o2+QXDHO0Zh+FYJ8xGCjEEZCgrsLXgCPwqDsOHSX3pcM0V/s4cdvpPfUB8tFRrKw6NFq9aKlghAEYfyVL0PbwsdmRqNqaUuRpWFE3uJvTS28+xHgo7Bdqi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660413; c=relaxed/simple;
	bh=HUyTKm3/kixE4IM78xtx98tGvx+TYD3lsMmOQi/hV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EirwP/NEPAam1uF9tUN/ByPAfrEAlPCzzx9F8D4CC19yqHEtAGOt3+WNbun2Fn34mB2VSGl1LAmdZwy3DAZJUClP3+rPVxoxfVku9bd0yMV5pP6zF1modGWYrWI5qnj914E9H0U+ws8Ckpfm/jAsIK1Pgy8tVG+E2ATlb7kFoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=da9/hgj0; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="da9/hgj0"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso404605276.1
        for <fstests@vger.kernel.org>; Thu, 22 Feb 2024 19:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708660410; x=1709265210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0T1JHqJ2SbFtcN4PnlbSFkth1RENsJLYDjl9Fju0/KU=;
        b=da9/hgj0ohINe4z9Pu3CT9R7LWfJx24n63vWIpYIbIYih1MH1QgzgIVEo5BdZqXjB1
         eKk7goXjmL3VLdUDTS7v1daTQ0nsZakm7CK3crk3biAM/ZoSX4jVpqfpKpT6YMsOGtYd
         beOTRTxLqoSIq/3xxbvpPiQAq3QLWY8WNe4kpr7sDnBKCoGnPggTAzCM1C+0uDbnhnQE
         gbyIFlpREayY4rvXcEmE5tw/7Kn/2Stp3raxoNiOCExfcn7segrU2Nhv29SSwPeMxbYe
         d2vxIbMJgNkuxAyxPThPDHOOo7z0ZSeZrT7GO3cm7X5+1aevOr/b3+oboEibVdfkxbNN
         7Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660410; x=1709265210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T1JHqJ2SbFtcN4PnlbSFkth1RENsJLYDjl9Fju0/KU=;
        b=cplXo9yL4p0f+djzcHE+IRB81C1jfJqDM2O1ANiogDzMgzTd0XLdO+DKv3E53zmHTt
         9Ic8KMPaerj0Xz8v4qstIBwCv1/aL+pJigW/u/z/4C1Q0Kfa4AxKmjfEGnmx/oFmFn2k
         qJyUHhFCySU9QrdhUOI/7/4Zs6jJ377MfdcaP55lxHiigEQqPkIqCcZCEI12qrComyWr
         dcrCb84R7adHHNB0fPIlqC0n2zgoFfJe92mk8r3sqtGiopLUchcBcNmrCrCkC70IBstM
         J5g4H4pBURAXVKHLogOrpvM+hqHF/dDBO1UtjOsG5OdAHTO2jGAtiTwqMyZhjyj7WzUM
         xmqw==
X-Gm-Message-State: AOJu0Yw2qL5HoKjywQeeA51m/Gb52/qHM2EIuKBnlYE1987yBEX7bN1X
	JS08r8eZKLAA7QvvjFkRZcMmnq2JjmfaPT/fw8CO3LqlC59Z682V+kq7aNzTsAqLCF9be4//eK7
	X
X-Google-Smtp-Source: AGHT+IHr6kNJgxpOadllt83NUK5QFGEQLk/fJNDZ0uxKBmw7ETCADp27IZTE2tYrOXPkBf8Un6EJ9w==
X-Received: by 2002:a25:1689:0:b0:dcd:5635:5c11 with SMTP id 131-20020a251689000000b00dcd56355c11mr1028221ybw.45.1708660410164;
        Thu, 22 Feb 2024 19:53:30 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id i73-20020a636d4c000000b005b458aa0541sm11231813pgc.15.2024.02.22.19.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:53:29 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rdMcp-00AFQv-0A;
	Fri, 23 Feb 2024 14:53:27 +1100
Date: Fri, 23 Feb 2024 14:53:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <ZdgWt8gz4815Nr/F@dread.disaster.area>
References: <20240221140951.GJ355@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140951.GJ355@suse.cz>

On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> Hi,
> 
> reading [1] and how late it was found that effectively a "rm -rf /" can
> happen makes me worried about what I can expect from fstests after git
> pull. Many people contribute and the number for custom _cleanup()
> functions with unquoted 'rm' commands is just asking for more problems.
> 
> [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

I started down the _cleanup() path a couple of years ago and one of
the reasons for that was getting rid of all the open coded rm
commands that were often just plain wrong. That start was here:

https://lore.kernel.org/fstests/20220524073411.1943480-1-david@fromorbit.com/

But I got little interest except for one person picking at
irrelevant details and wanting unnecessary API and naming changes
that did nothing to really further the cleanup work.

It did seem like anyone was interested in having this code cleaned
up and so I basically couldn't find the motivation to slog through
hundreds of tests trying do stuff that nobody really seemed to care
about....

Shame, this whole problem would have not existed if that work sort
of infrastructure technical debt reduction was encouraged, and if it
did there'd only be one line of code to change... :/

> Unquoted arguments in shell scripts is IMO a big anti-pattern,
> unfortunately present everywhere in xfstests since the beginning.
> Rewriting all scripts would be quite a lot of work, could you at least
> provide safe versions of the cleanup helpers?
> 
> For example:
> 
> _rm_tmp() {
>     rm -rf -- $tmp
> }
> 
> and used as
> 
> _cleanup() {
>     _rm_tmp
> }
>
> I can send patches at least for btrfs and generic as this affects
> me but first I'd like to know that this will become standard
> coding style requirement in fstests.

I think it would adress this specific issue, but I think it doesn't
address the bigger problem that fixing cleanup behaviour requires
touching a couple of thousand tests. i.e.  it doesn't reduce the
maintenance burden of this code at all.

The vast majority of cleanup functions are identical and/or
unnecessary, so the right thing to do is to only have cleanup
functions for tests that need them, and for those that do need to
clean up to only have to clean up their own mess.

i.e. the test harness itself should be responsible for cleaning up
$tmp stuff and doing stuff like returning to the correct directory
after the test completes, not require every test to duplicate the
same cargo-culted behaviour...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
