Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7CE23771C
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297237; cv=none; b=VgWh3/f/vZ7VUQe4k/H2ty1Blo7ggyTGo6iYhvPoofH0pGvMq1YqjyVlNJ7c2/p8SfOyR3Un85c3gZ08bppvF0Nhw3ClLtTn0KROG1YwCm5ITWmzNO8a8lB/erx5kOIeNUDEGqGqbz6GqdM+GeF++il39PrTFftERrL5TYEG8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297237; c=relaxed/simple;
	bh=87jHQC5i99VbHSDvSXG94V+xLBy6se95k6GSEOkLNzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0e5tWIkrgCkoUVPv84X1iZ/x44cKfg++VMU2uv6X1Xa99kTJ1LuTmtA+uZN4oidNRaPHc0QkbpK3bCEzbWkYoTne701ZV0omHJjoXPoSJIRerO/PrGkm38fF6pKgQldSoTvxwLSMSsFMfMcRUbgGIeLs6LVhEVS3vaxWFTnTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGwdSnGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGwdSnGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1592FC4CEE3;
	Mon, 30 Jun 2025 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751297234;
	bh=87jHQC5i99VbHSDvSXG94V+xLBy6se95k6GSEOkLNzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGwdSnGEWKif590FSoMqOTTg/Ute/Z5bj+0t9l0rw04rFcmyqJBoL1nn4/fsarmyB
	 5Hc9TZH61Eviu/esW2VzLIXFGsCOPuH/Ahkv9ft5Uxv9HYyKEVo1zSQCCvHOxHIv62
	 5TrS77SNWo7nZOSY99yynxcccX+7VaHMxe+3zmvt5PHVnmDf6YqMP18QALukkOEpZA
	 tJa6TqM8Ji2bPWlNH4TahBx4E0Z4/oYi1AmKzFHLgPun86OLGtPgY4dNHDbUIGcKGf
	 gkIRp1mk9wqJ9eMxKQd/qtJtHTvQeTQdJrtZ1GWOKK34m+C7iDGAYstjxC3eSA+Y0O
	 DZqc/nA1D6e8g==
Date: Mon, 30 Jun 2025 08:27:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250630152713.GB9995@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
 <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250612143614.GR6143@frogsfrogsfrogs>
 <aEu3rfhMPrE7414B@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250613150446.GX6143@frogsfrogsfrogs>
 <aFEJijH70NW-GAm_@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFEJijH70NW-GAm_@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Jun 17, 2025 at 11:52:02AM +0530, Ojaswin Mujoo wrote:
> On Fri, Jun 13, 2025 at 08:04:46AM -0700, Darrick J. Wong wrote:
> > On Fri, Jun 13, 2025 at 11:01:25AM +0530, Ojaswin Mujoo wrote:
> > > On Thu, Jun 12, 2025 at 07:36:14AM -0700, Darrick J. Wong wrote:
> > > > On Thu, Jun 12, 2025 at 11:41:16AM +0530, Ojaswin Mujoo wrote:
> > > > > On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> > > > > > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > > > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > > > > 
> > > > > > > Insert range and collapse range only works with bigalloc in case
> > > > > > > the range is cluster size aligned, which fsx doesnt take care. To
> > > > > > > work past this, disable insert range and collapse range on ext4, if
> > > > > > > bigalloc is enabled.
> > > > > > 
> > > > > > Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> > > > > > maybe we should amend test() in fsx to round to the allocation unit
> > > > > > size?
> > > > > Hey Darrick,
> > > > > 
> > > > > Yes makes sense but as you mentioned, I'm not sure if there
> > > > > is a way to programatically detect the bigalloc cluster size (or
> > > > > allocation unit in general) like we do for xfs. 
> > > > 
> > > > I don't either, but maybe we should have a way reveal the allocation
> > > > unit size for a given file?  Yet another statx field? :P
> > > > 
> > > > (It /would/ be useful for programs that use collapse/insert range)
> > > 
> > > Yes it would, at the very least, help with defining clear semantics for
> > > collapse/insert range with bigalloc/rtvol because right now those
> > > operations just EINVAL if the range is not aligned correctly, which is
> > > confusing since it is not documented how to do it properly.
> > > 
> > > xfs does have an ioctl to get the geometry for rtvol. I think you are
> > > suggesting a more generic statx field which can be used by other FSes as
> > > well, right?
> > 
> > Right, since other filesystems (fat, ntfs, etc) also have allocation
> > units larger than the fsblock size.  Most of the time the allocunit
> > amplification simply doesn't matter to applications, but once in a while
> > it does (collapse/insert range, cow) affect performance.
> > 
> > --D
> 
> Makes sense Darrick. I can look into it. 
> 
> For this patch, is it okay to keep the approach of disabling
> collapse/insert range for bigalloc for now and we can change fsx later
> if we add support for exposing alloc units.

Yeah, particularly since there's no easy way for userspace to find out
the collapse/insert unit size.

--D

> Regards,
> Ojaswin
> 
