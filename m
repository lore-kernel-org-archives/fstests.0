Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8120FAB9
	for <fstests@vger.kernel.org>; Wed, 22 Jan 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538974; cv=none; b=OfP2zjuRdJwkNH9LZW7VbPIIjSDea3mGm1RhLdAJA+6yAaCxWVItStmioKJ74TYq53GJq62lQxEHZJ+8wt6z481zJ7CcW+sqaVLn71WCr+aV8TuhRsggCwo9S1WpPvqmt2rOoJhBtgPLJizdIf7vvJSyPdO956ecvvq1VOvB9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538974; c=relaxed/simple;
	bh=sZFS0ZSWBHcQTo2CvGCw2meTn9EZzO3AVbvsBzpr+08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEG1jRY5ELNg7reH/B0mLrliS+GlsD4gaapVv5W3ed7gmh3cW1n6bm/7fIdBibMaCu8lq68rYbgjoAMNijOKJydKjingoSN6DZcjt+rW1pCymz/kFG9ExtZsJDmy45UVmJrRoAWIfxrDDnQKoB4yNzYhieeSL3oqybhp3uX5gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YyXPtLuc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YyXPtLuc"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so8978254a91.2
        for <fstests@vger.kernel.org>; Wed, 22 Jan 2025 01:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737538972; x=1738143772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5na3VqqUg5r8j3fwyZazz2qTuzNv5otCGO7PnXAHGs=;
        b=YyXPtLucShGHOIYuVGSK/8KN2xg+4gyuYkaMvLds7v6pmZ2cVPq0KrfRfrbm8FqEpN
         c8l2MySgO0Mp1Iwlq8E1j5F4xPhAvZA5vWvHVxbSrd86HO318S3QtTC1QnA7h/J3EJfV
         r9IuYCvblw8RXWkHsoIsrST5icAPEeBL7xCDTXrsIZLiKAtlJskBcSFKUOnZ8mAz7k9M
         16NfULFsKonS5b9q0g4kf7hIn8pFd2jH2faea8w1bs1yu9bF9FLAVLt8B/qMm+G9JCfB
         CCW4ifZ66qElDKCiKTmCUOyJwrF/skAXa77ghdD3oXgPRvcumwtxKS0ZZJahRet3gau6
         jfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737538972; x=1738143772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5na3VqqUg5r8j3fwyZazz2qTuzNv5otCGO7PnXAHGs=;
        b=YifaA4SKtVWWzyz1/bVKTWqev2H+eJbgeEI8Bji/qle6I0akoWEJtnaVa1I9B4s7on
         mlcCQtfRuVKrEc8z1TNkZVNbbEOoS6p5Juzng0Lf4x58WHrHEyQIsKt9aBl11NqG+h6K
         scf7HIPhSkt4jJQgXoe/47ZsLWdAVNSammvv1IYekKaWPaN4hHMhaZc2obiDcyhBaw9Y
         RTegfEDGtjrhlwHk23eUdClKetB0BSHeKemRH6GCjfDYY8v6PbQqgR3GiDFNXXwrLsOX
         TmkMiZ5etaUAhFtwDcEmHbRG10Mm3ChT+q0S5xWiatDwNN4Iy7fB7tCPuGN/7UO+Bhz6
         LiiA==
X-Forwarded-Encrypted: i=1; AJvYcCU0LmOVvOgkfz6oLeAnQ8SKUvW4DKWCDVkBVTrApB7SPBvJF1NBac1+CgPk7Pr6x8zToed/pljb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+M/j4BpVrsE5v+OuMlsocJomUJcstYVSAQA+Wru6Cn+fJe7ZF
	pnTUU5jbpoHS+OBxv1pDDFiEfBmK2JTbH75vuGmJUQggIvTRuzK6w9WQVFrycV8=
X-Gm-Gg: ASbGncvgJDyI8fr+i2Tk2mRejFSZciqKS7F/iMkWpigr2l4vxvWGi+m7RVhQbMH217f
	BMFJfb5qtW4/+d5MYFSKii2KBbHnUSsHI0UOL0uf0Vt9gTo0qvES/vSShf7OWSTVYTzNaKxs/X2
	hH67yLYolpoCarY0Qc1J0dXrMwsz8uYhJfGP7lymJhlBp94EOKG/F7vXZ1n3Nkt8doWkYjczVa8
	S1LHl9dN1rhmOgQmdH3qDmU/hefk43UvPzhOzt2E4iduKwAvKqovkCoxw02Mm+ZH8+v5cNK2LWG
	SgubGh4H6dbrYLxOdLtAllGZeuL81GuWm3XOvlx/nGuCFg==
X-Google-Smtp-Source: AGHT+IGVBB1rbn6pfySQ8altonFCZ413KkUydLD5vc3K3vg1akys2KNK7XO2hDJzh89YQnQz3WHELg==
X-Received: by 2002:a05:6a00:90a3:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-72dafb367d4mr30943232b3a.16.1737538972426;
        Wed, 22 Jan 2025 01:42:52 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab848b08sm10544500b3a.71.2025.01.22.01.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 01:42:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taXG5-0000000929G-21ZX;
	Wed, 22 Jan 2025 20:42:49 +1100
Date: Wed, 22 Jan 2025 20:42:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/23] common: fix pkill by running test program in a
 separate session
Message-ID: <Z5C9mf2yCgmZhAXi@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974197.1927324.9208284704325894988.stgit@frogsfrogsfrogs>
 <Z48UWiVlRmaBe3cY@dread.disaster.area>
 <20250122042400.GX1611770@frogsfrogsfrogs>
 <Z5CLUbj4qbXCBGAD@dread.disaster.area>
 <20250122070520.GD1611770@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122070520.GD1611770@frogsfrogsfrogs>

On Tue, Jan 21, 2025 at 11:05:20PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 22, 2025 at 05:08:17PM +1100, Dave Chinner wrote:
> > On Tue, Jan 21, 2025 at 08:24:00PM -0800, Darrick J. Wong wrote:
> > > On Tue, Jan 21, 2025 at 02:28:26PM +1100, Dave Chinner wrote:
> > > > On Thu, Jan 16, 2025 at 03:27:15PM -0800, Darrick J. Wong wrote:
> > > > > c) Putting test subprocesses in a systemd sub-scope and telling systemd
> > > > > to kill the sub-scope could work because ./check can already use it to
> > > > > ensure that all child processes of a test are killed.  However, this is
> > > > > an *optional* feature, which means that we'd have to require systemd.
> > > > 
> > > > ... requiring systemd was somewhat of a show-stopper for testing
> > > > older distros.
> > > 
> > > Isn't RHEL7 the oldest one at this point?  And it does systemd.  At this
> > > point the only reason I didn't go full systemd is out of consideration
> > > for Devuan, since they probably need QA.
> > 
> > I have no idea what is out there in distro land vs what fstests
> > "supports". All I know is that there are distros out there that
> > don't use systemd.
> > 
> > It feels like poor form to prevent generic filesystem QA
> > infrastructure from running on those distros by making an avoidable
> > choice to tie the infrastructure exclusively to systemd-based
> > functionality....
> 
> Agreed, though at some point after these bugfixes are merged I'll see if
> I can build on the existing "if you have systemd then ___ else here's
> your shabby opencoded version" logic in fstests to isolate the ./checks
> from each other a little better.  It'd be kinda nice if we could
> actually just put them in something resembling a modernish container,
> albeit with the same underlying fs.

Agreed, but I don't think we need to depend on systemd for that,
either.

> <shrug> Anyone else interested in that?

check-parallel has already started down that road with the
mount namespace isolation it uses for the runner tasks via
src/nsexec.c.

My plan has been to factor more of the check test running code
(similar to what I did with the test list parsing) so that the
check-parallel can iterate sections itself and runners can execute
individual tests directly, rather than bouncing them through check
to execute a set of tests serially. Then check-parallel could do
whatever it needed to isolate individual tests from each other and
nothing in check would need to change.

Now I'm wondering if I can just run each runner's check instance
in it's own private PID namespace as easily as I'm running them in
their own private mount namespace...

Hmmm - looks like src/nsexec.c can create new PID namespaces via
the "-p" option. I haven't used that before - I wonder if that's a
better solution that using per-test session IDs to solve the pkill
--parent problem? Something to look into in the morning....

-Dave.

-- 
Dave Chinner
david@fromorbit.com
