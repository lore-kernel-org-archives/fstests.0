Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486212C3245;
	Sun, 19 Jul 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476632; cv=none; b=VYoU5ApeNsQSpMBEeYqAHc2TRq99REJXx3W+JvTh1sGRMAxRsrMkpUUdhQZuYmJbPF7nbCSpYFmIozMdnqjlDU4ANb1SJQ2hJocgrL+obbwxQcjddP5GcNHP38gM3Lz3a0yx2UX59VEIWiDQEcScCnXurW939KSJ6qqPAlzFBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476632; c=relaxed/simple;
	bh=KfCinnlrdCWPlf03D00+fC9wNIqXXrnk1zB5uv2L0zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNgyq5ff4bu/lUh120sGAztyVm0Jy1xoYjP7M1FoGstsoQoQgFPbt8rKce7D0MGBJzZylGLmmotqOCyJxAM+xXuDakyj+Y/VoSpP8dvvDKx+Mx4hpg6kA+Kl8QhmcHwu7bV3of84pEVnho/A22b3FGBnAE3rI99Eujm5sKLVQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apXTj4gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apXTj4gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D1C1F000E9;
	Sun, 19 Jul 2026 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784476630;
	bh=jMN3LPNkhWo8HhkBYCl/0vtiBzQdc6t0rRMOnTS9YwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=apXTj4gvZjfosneHSr5HRNYPRVRPzFM8NDFvHPHe5ZPdmPsaEbo+rvJ7doxj1p+HC
	 7LPhX94ccWzzzh7Rwe/SWLwvwK5dSFBoBaJbcVKWFpg+dQiwpeYwh5Cqj0unkPtlSo
	 9QuXxClgRH3fEs1rCuP2mK0OkesPvjhydJafv6skgeMnXawruIz/TWUP0frCCjSd8j
	 mJHVxkHwReQ1N/pW3X6TH2wtpkuM85g2eUT04HyTLgk0OTnCMqTLxFHGjJEXT1ECbX
	 Fre/oLi2yHzBeoXcsc9hC1MGy5uVY/g7JVd+LopeZklVO+Lxgc52ZylHeC5wP0FnbS
	 ZE2Od9YA/T92w==
Date: Sun, 19 Jul 2026 23:57:04 +0800
From: Zorro Lang <zlang@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <alzzQA9SR55FynDu@zlang-mailbox>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
 <alpUADtQccA2zmWh@zlang-mailbox>
 <alzYSGVz86d7wDXn@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alzYSGVz86d7wDXn@mit.edu>

On Sun, Jul 19, 2026 at 10:02:47AM -0400, Theodore Tso wrote:
> On Sat, Jul 18, 2026 at 12:19:52AM -0500, Zorro Lang wrote:
> > 
> > 3. You can use or implement a _require_ function to check if a specific feature
> >    is supported, which will gracefully _notrun the test if it's missing. While
> >    _require_cgroup2() already exists, its granularity is currently too coarse to
> >    _notrun for HFS. You might want to consider refining it or introducing a new
> >    helper to help file systems like HFS+ _notrun properly.
> 
> It may be rather challenging to determine whether the file system is
> supposed to support cgroupv2, unless we want to define a VFS specific
> flag and a way to query it via sysfs.  If we want to encourage the use
> of the simpler file systems to use xfstests, we may want to consider
> that approach.

Hi Ted,

Thank you for your reply. You are right. I was just listing some possible
options, and I did not mean we must change the kernel for testing. Changing
the kernel just for a _notrun is indeed not worth it. If there is no simple
way to implement the _require_* function, we can `_exclude_fs hfs` directly :)

Thanks,
Zorro

> 
> 						- Ted
> 
