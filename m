Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5219AD99
	for <fstests@vger.kernel.org>; Sat,  1 Mar 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838152; cv=none; b=ujflsq7pYS7v6McW3PiGqiZgIdqvV7AcVZ43eO1JE3lVWRr33d2duUyWO1AkAwe7vrkYYXhPb/7sQhfsOqWsIKKBqRCEOlCOW3icb4v54X4ABPXXTvNgDCNCm5kGbuhDBj/i9e4M0r6RdyCVP8FzSRdWWZugxeddnvHYpVB1OeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838152; c=relaxed/simple;
	bh=z0x7dSjO1JW4L9NAzv8XqvQ/qXQYJR7VA9/Z0WlcF+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okWM6THrx1OJS1QyI7bnIc0nw9J+1kGiBQ9p2/bTHl8QVDtgGv3ZH56ab0U08iA6caEm6BPn1hrTq+X9ULVrRKC5oh9ZiWX++N0A0PBv7L13uuUL6D7CrXAcB3Ex0w/KDirJrBJ+450SgmKRHYefhErtx+b85jPeu/UiJlKHrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYBeqpjx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYBeqpjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740838149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAVMH2NTtTNYJ5iF6GvO7tx7pnHYNoBmQOcPpmhtbJ0=;
	b=XYBeqpjxYx7QO8wD1+fbZ4SNhjVQsfO7RopegpG8ZLlipRYVvhvmBK9U3yjxpL1lsfgte4
	9LsJ6n3GzSLeup8nYQkotEUuuOXjKbONnVcSgMSEdI7m2XEQLMUwUI/I6UwhEXrx/uYwu4
	LajhrMnc7+Jtgt8YJCNA3RpZQiXOv9g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-WpIhmTCOOdqBkY5VSWBabA-1; Sat, 01 Mar 2025 09:08:59 -0500
X-MC-Unique: WpIhmTCOOdqBkY5VSWBabA-1
X-Mimecast-MFC-AGG-ID: WpIhmTCOOdqBkY5VSWBabA_1740838138
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22348343f5aso56087205ad.2
        for <fstests@vger.kernel.org>; Sat, 01 Mar 2025 06:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838138; x=1741442938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAVMH2NTtTNYJ5iF6GvO7tx7pnHYNoBmQOcPpmhtbJ0=;
        b=OkTx40lKiWK9ZjFk9n0PoSVMh73D5zYL0OvVipwLXu03LLikORgSHq9n9H5gEjnurn
         Yg64ZRA2lh82yUwrz5blOGK+sxFsDGl1Ui2gZ4YxkdgmDOFm5EJwTZ/HiGFRRkn0HrFA
         jtRUIQrqib+ie88VCxqO+MfPJHCSv6alU435l/6kcWR/zj2+eSaYu3lkErBZ7muiwusE
         mM8srYg4qQbQCxbjJAuuMdiWB0sqQz9/eXcijbYGn71hGGQ6aQ7gUCUW3a37EUohBz1k
         7QY+gxE1NOa7XJp8Yu5ARnKoeDB65zq6OENWNJrdndcDnbzqKjQwBz8/WJPkjaHi9J0+
         wNmg==
X-Forwarded-Encrypted: i=1; AJvYcCXamdRLBsJzJDpHZW/xlQqbbFgpwL/C9JBj76GpqxowJiglBHF3ryZeofdGYkysVFzSFz5hVFmt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zVoXM+C56yKnUun5HGp5F/xvBboc17PK0AtcltCFvizx+97n
	Mq6ipMxCoo3mE2rf1AcpILtKRGYbdRLaBFhPka/ilJDJ66dhZF1ToKG9OR+L/iV5P4lXzHKEI8K
	b07t7i/3DDjKfhk5HD6Da8ClfQkFG9o4UuOzTsJ9QqkM1ki1u/Aa9rsk=
X-Gm-Gg: ASbGncs2fts8XgrYUBYw5JTpxHIR3UUz3aBoyOvi+3lWhNCsGp5bY8rdy/NwoPFalCJ
	75FtpMtOaqLMpXHPS2RHW1pzgMVB7M/1euFLLi9+8FpA1QIbow6yNkc/wV9uwNfZxqdxBSC9wi2
	Gcx+CjbMGC83CafRdjouEMjJn6otqqwyvwQ1Triyv6UWCIKIt3YDCfpDPnMVxmjMa7JCWPRXzC9
	BGf7ZSxFoB9U22St1848Ee2vOh+eibpk08J3/7ADEaDDZwIQ7R2Qv5WC2sOP4TVRW761Z2umcMo
	+S2IggsO5vIwgSIeq1FSK7URr2bQkGzHPtaiKc8OgLhmE/yPc8goZoQ/
X-Received: by 2002:a05:6a00:c86:b0:725:df1a:288 with SMTP id d2e1a72fcca58-734ac428a45mr13606119b3a.24.1740838138477;
        Sat, 01 Mar 2025 06:08:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYumHkD7YokQkCOpWC+/EmLaWCz+qkXWwOW0aCsMYgaRIvgFH2/5/lKejQXrA23BBGVCRVw==
X-Received: by 2002:a05:6a00:c86:b0:725:df1a:288 with SMTP id d2e1a72fcca58-734ac428a45mr13606082b3a.24.1740838138042;
        Sat, 01 Mar 2025 06:08:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7356173aedfsm3212662b3a.95.2025.03.01.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:08:57 -0800 (PST)
Date: Sat, 1 Mar 2025 22:08:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228123354.GE5777@twin.jikos.cz>

On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2025.02.23 release.
> > 
> > Release Notes:
> > 1) There's not new test cases in this release, this's a release for bug fixes
> >    particularly.
> > 2) Reiserfs part is removed from fstests.
> > 3) ltp/growfiles is removed too, I think no one needs it.
> > 
> > I can't list all updates at here, more details please refer to below.
> > Thanks for all these contributions!
> > 
> > Thanks,
> > Zorro
> > 
> > The new head of the for-next branch is commit:
> > 
> > 5b56a2d88819 fstests: remove reiserfs support
> > 
> > New commits:
> > 
> > Christoph Hellwig (1):
> >       [04d0cf3f8909] generic/370: don't exclude XFS
> > 
> > Darrick J. Wong (35):
> >       [cc379f50f3bd] generic/476: fix fsstress process management
> >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> >       [777732b27e62] common/dump: don't replace pids arbitrarily
> >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> >       [77548e6066fd] common/rc: create a wrapper for the su command
> >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> >       [c71349150d34] common/rc: hoist pkill to a helper function
> >       [91d2880aa029] tools: add a Makefile
> >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> >       [247ab01fa227] check: run tests in a private pid/mount namespace
> >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> 
> I'm using a setup with a minimal VM system without systemd and such and
> dedicate the whole machine to one instance. I'm not interested in the
> check-parallel updates and test case separation. All fine if it is
> supported and lets me continue using single instance.
> 
> But as I read it and the deprecation it's not going to be the supported
> use case. After last week update of fstests 100% of cases failed in the
> test setup (_seq_run). My workaround is to simply disable it by
> 
> check:
> HAVE_PRIVATENS=
> HAVE_SYSTEMD_SCOPES=
> 
> so I don't have to debug changes to the detection of the scope and
> namespaces and after each for-next update. I understand that with a
> custom system setup I'm on my own but until recently things have been
> fine but now after each update either test cases fail or the whole test
> infrastructure does not work.
> 
> It's not just me who observes that. It seems that BTRFS is not tested
> before release as thoroughly as other filesystems (probably just XFS).

I test btrfs (only default), ext4 (+-fsverity, +-dax), ext3, exfat, xfs(1k, 4k,
64k blocksize, +-dax), tmpfs, nfs(base on xfs), cifs(on xfs), exfat, overlay
(on xfs) on aarch64, x86_64, s390x and ppc64le. But I'm not an expert of all
filesystems, so I just can check there's not big issue from my side for most of
fs. But different persons have different test ways, I can't try all different
test configs/ways on all filesystems by myself, I already take each weekend
to do these things, even I'm fever or on holiday. Even though I'm still asked
to release more fast...

Darrick's patchset has been in the list more than one month (since 2025-01-16)
to get reviewing. And I've tested Darrick's patchset several weeks, and talked
with Darrick several times about some issues I found. Darrick has done his best
to do that, please don't give him more pressure. But still sorry about I didn't
find the "100% fail" big issue in my test env. Feel free to share the config
you use, I'll refer to it to change my test.

I've gotten lots of pressure recently, I thought this release would be the end,
but looks like it's not. If you all (xfs, btrfs, ext4 and others) agree, I can
think about reverting the whole check-parallel and its related things, or there's
a switch to isolate the effect of check-parallel things. I thought there'll be a
painful period, but won't be too much if you don't use check-parallel directly.
I thought we will fix some bugs, then return to stable status. But I never thought
it's such painful. That's my fault...

Thanks,
Zorro

> 

