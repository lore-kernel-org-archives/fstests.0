Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20062DC328
	for <fstests@vger.kernel.org>; Thu,  4 Dec 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868829; cv=none; b=gHD7PyEE5Fp1ZQ69cYZbKd6iKP7Wsi+YkOaJ+fbgrlzjpWjHnD8caZRGy6yYaiKsPgMly5rCpPeTBnmrI0BtqHswwtBiiBb3a+q5j7JLA32+GpDTS3wJV6j1p9QnhUGeCHV23glpPUekvdMS59p7Dp70vrCAdZ34dGj6oY24Ftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868829; c=relaxed/simple;
	bh=tK+eY6Vb4Ife1n+uhuaMnmqsWLcoPqv6F/KpnpZ34cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo4yWNv//WqB1d75hz/aUMfHCiJhTCllHynDbe11+P+vKSq4lASWuW5GIv03o1qaohPeNZBJdHdPMaUCxWUKvLnpEhx7tUejrKwsCbLEVQZr0Sh3bp9eY6i1gN81kV4wligWKtBNPfZhiCZc84e8Of2p/UzuU7kHibEt+mippAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlva8Roe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlva8Roe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D75C4CEFB;
	Thu,  4 Dec 2025 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764868829;
	bh=tK+eY6Vb4Ife1n+uhuaMnmqsWLcoPqv6F/KpnpZ34cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tlva8RoewqIBhqyRHgIqO1o8YoXo24jG0VpiNy3ittTIuxLVuZhWPj9bKrLrueSef
	 xPUdBfMNu6ynsBbxfr9nSEecOvp6gUT06b5MfLx13dF0L6/KzwbewTKra5Gv4gTzVw
	 0WY8KMpTHvO4it5MsAiG2GavflG6j/mDCeAKvBcDIkCkVvPqynV2j1/NC22YpVbdDM
	 CqPN5OeQeVRCGkwQtM+f9aykZAjvn6kMMRieN/aVTLRMbF4rXN/zpJnejTBGtqoWLb
	 yGrnswSMi+yBwJbVfXxtOlyneSUSWI3BNLlisLpL2K7vgOiUdusLeeGlSZNC2vTZjB
	 gv35q14cwfUjQ==
Date: Thu, 4 Dec 2025 17:20:27 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk.kim@gmail.com>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org
Subject: Re: generic/204 is crashing on linux-next when testing f2fs
Message-ID: <aTHC2wtlC5d00xYL@google.com>
References: <20251202043952.GA70808@macsyma.lan>
 <CAOtxgyeik6kgF6SktvFj=anntmJZ_aWneqq1XzLpqpHK1XMb+Q@mail.gmail.com>
 <20251203021709.GA71988@macsyma.lan>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203021709.GA71988@macsyma.lan>

On 12/02, Theodore Tso wrote:
> On Tue, Dec 02, 2025 at 09:30:44AM -0800, Jaegeuk Kim wrote:
> > > For now, I'll exclude generic/204 from the f2fs configs in my test
> > > appliance; if you have a chance to take a look at this and let me know
> > > when it might be safe to re-neable generic/204 for f2fs, that would be
> > > great.  Thanks!
> > 
> > Thank you for sharing the report. I didn't hit this in my setup tho, let
> > us try to reproduce it first.
> 
> I'm not able to reproduce it by running generic/204 by itself; only
> when running the full auto group.  (See below).  The generic/204 test
> reformats the scratch partition at the beginning of the test, and
> doesn't depend on the test partition.  Presumably, a previous test
> when running the auto group is somehow setting up generic/204 to fail.
> 
> I'll try doing a run with KASAN enabled, in case that gives us some
> insight.

Thank you. fyi; I found some other xfstests failures, hence dropped some
suspicious patches and pushed today. Currently, my setup passed all the
test-cases with it, so if possible, could you please check probably tomorrow
linux-next?

Thanks,

> 
> 						- Ted
> 							
> TESTRUNID: ltm-20251202161646
> KERNEL:    kernel	6.18.0-rc4-xfstests-kasan-00072-g6fb67ac89690 #314 SMP PREEMPT_DYNAMIC Tue Dec  2 16:05:26 EST 2025 x86_64
> CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c f2fs/all -a -C 30 generic/204
> CPUS:      2
> MEM:       7680
> 
> f2fs/default: 30 tests, 6043 seconds
> f2fs/encrypt: 30 tests, 6209 seconds
> f2fs/compress: 30 tests, 6140 seconds
> Totals: 90 tests, 0 skipped, 0 failures, 0 errors, 18392s
> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202512020012
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests	4badb27 (Fri, 31 Oct 2025 19:53:27 +0900)
> FSTESTVER: fio		fio-3.41 (Fri, 5 Sep 2025 14:21:17 -0600)
> FSTESTVER: fsverity	v1.7 (Tue, 4 Nov 2025 17:28:17 -0800)
> FSTESTVER: ima-evm-utils	v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio  	libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
> FSTESTVER: ltp		20250930 (Tue, 30 Sep 2025 13:53:45 +0200)
> FSTESTVER: quota		v4.05-77-g22ff3d9 (Tue, 2 Sep 2025 08:12:02 -0400)
> FSTESTVER: util-linux	v2.41.2 (Mon, 22 Sep 2025 12:56:34 +0200)
> FSTESTVER: xfsprogs	v6.17.0 (Mon, 20 Oct 2025 16:49:00 +0200)
> FSTESTVER: xfstests-bld	gce-xfstests-202504292206-34-g84a091b7 (Tue, 2 Dec 2025 00:09:25 -0500)
> FSTESTVER: xfstests	v2025.11.04-12-g64e3dbda7 (Thu, 13 Nov 2025 19:58:03 -0500)
> FSTESTVER: zz_build-distro	trixie
> FSTESTSET: generic/204
> FSTESTOPT: count 30 fail_loop_count 0
