Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA3DF6C;
	Sun, 19 Jul 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784488554; cv=none; b=BDQ0bTqeTiJ/bG5b975ObsGQeoc1PuUSe+g8DNt0KimOp3BwKRvv0Vq7JzvIysxs/SGHzWzpzXt/PvAhGDfrlK/7yFaQ111EdFKRgx6UrJNfk0/mseRSDqLB9Ig9xbBl6qutd7CQ+34vRgWLhRup9NLXSAV9rJrE1+nyke7ytKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784488554; c=relaxed/simple;
	bh=CoeblyX7URmqo2OgT2fyxEf0BplPJTbaw+9JtRpn3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAAXfshiip6IS8J/abs7uCXRDjQ+DYV/2XGQn4VFasOEqRoUbVSI3+ThdKS2S9BuVPr4EDDfrNySKySA38FI+VAIgGjiMHcRmVB3cnctDOWAhGiNeAuUjr++/5HqQ6XjByTWs1xsQoMbT7An6HKN+FabIQjThYeYEAhvn0ep2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHqmOTZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHqmOTZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65421F000E9;
	Sun, 19 Jul 2026 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784488553;
	bh=y5GE3u+pzknKTvUUnbMKdfnhSgkeSIQwUggIhUAsMLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHqmOTZKzKUEYbFbV/qQSi6u57Ruek0qbzy7mqFSqiBGzcFw+1xOxx6tvEYWxprNI
	 HBWWca+kk2vxG6LcTj5fn6LIqRrCkjJ98EjOZZOjrMWWOxXuEO1L2jH//njbKOpj8h
	 d7fAexu30aaXdgegQaAz/yX7OuNXDuiryFdbUILPIl8xgTLZGLAkf2stkyeMcWb4ym
	 uN6iOoyy7sDOrmuSyG6R4my5Xvb0vlqV9VE9yI7ADK/ycdphOvwBTI0JpoMf5YhTi+
	 ahGjUbsvlFszmc8f8eKewwdPU5XRyzCDMiNQJMGP/whnFfkG0rf/KmwFqFhZROWBfU
	 EcXDbWl5oKcHA==
Date: Mon, 20 Jul 2026 03:15:47 +0800
From: Zorro Lang <zlang@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <al0d2btWzQaFmcI5@zlang-mailbox>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
 <alpUADtQccA2zmWh@zlang-mailbox>
 <alzYSGVz86d7wDXn@mit.edu>
 <alzzQA9SR55FynDu@zlang-mailbox>
 <alz_HixXWhKTIfRV@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alz_HixXWhKTIfRV@mit.edu>

On Sun, Jul 19, 2026 at 12:52:50PM -0400, Theodore Tso wrote:
> On Sun, Jul 19, 2026 at 11:57:04PM -0500, Zorro Lang wrote:
> > Thank you for your reply. You are right. I was just listing some
> > possible options, and I did not mean we must change the kernel for
> > testing. Changing the kernel just for a _notrun is indeed not worth
> > it. If there is no simple way to implement the _require_* function,
> > we can `_exclude_fs hfs` directly :)
> 
> I wouldn't necessarily rule out changing the kernel so that file
> systems can declare whether they can support cgroupv2.  The advantage
> is that we wouldn't need to keep adding "_exclude_fs xxx" each time we
> try to make fstets work on the simpler file systems.  It also means
> that if a file system adds support for cgroupv2, we wouldn't need to
> change fstests --- also, if the patch gets backported to an older
> kernel (either an LTS or an enterprise distro kernel) we don't need to
> try to modulate the _exclude_fs using kernel version numbers (which
> isn't guaranteed to work given the backporting possibility).

Sure, hardcoding a _notrun based on FSTYP is a last resort, and it would
definitely be better if we had a more elegant way to trigger the _notrun.
As a test suite, I cannot enforce or dictate what features a specific
filesystem must export just for the convenience of testing :)

> 
> This is a philosophical issue, and reasonable people could disagree on
> this approach.  For my part, I created /sys/fs/ext4/features/*
> precisely so that userspace (and fstests) so we can test if a
> particular feature is available on a particular kernel.  Otherwise, a
> test to see whether a particular feature "works" might have a false
> positive if the feature is broken, and the way we test whether the
> feature is present is basically what was accidentally broken with by a
> regression.

/sys/fs/$FSTYP/features/ is indeed incredibly helpful! Just a couple of
days ago, I was actually discussing expanding _require_fs_sysfs to support
features/ checks there, since our current checks are limited to the
/sys/fs/$FSTYP/$device/ directory:

https://lore.kernel.org/fstests/aloCfjjqesxpzL9z@zlang-mailbox/T/#mc5a0492cc00550467256951042828bef5d7fa38d

Thanks,
Zorro

> 
> Cheers,
> 
> 					- Ted
> 
