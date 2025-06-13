Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95A1ADC90
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827088; cv=none; b=mD25QzYhpQhiMrUFisgse8x36AUGysPmn0XZEAGqF1iTApQcamlpMZ9TWuCV1Qax6l83zx4ahdrbMIYZALPRxKzPM7o4HK2F/cjLX8lOk7oBNstRWd6sTbswNqDIp5a41bwzn52ELwemOxhKSEtJVgeTxQm16Yzewf7bWpA5NGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827088; c=relaxed/simple;
	bh=Sg6AZoc4duhbzdb6WkS6sWJEvT7WzOVpDce+BQUsVbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmdSY3a5IZI3+5OTh34a+GCl/OL/fL5pfoGSYThffRBi7QJBH5e0PntskxJQ+PddlC+ZjCHkwGRUDbED712sYBdg4JdWX0XlPqcvvivBezoUl5SgVDafa7+oINbjHc25k5ClYy/RbMp9mygzGWuQgPg9fW1LDH4orgXHcp7QuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3+XguQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3+XguQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8A4C4CEE3;
	Fri, 13 Jun 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749827087;
	bh=Sg6AZoc4duhbzdb6WkS6sWJEvT7WzOVpDce+BQUsVbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3+XguQ4aScXD8wW9I/WKAaRb1lc2M9ld98+pku539UFk0ZAONvD4Y+WrkDMYWjgj
	 aYp/GH8mvY1GozYPsMexFHAhbp/KgJKd73U2NkVBayDlgyi4mplVpI6COFLuTOfQJR
	 nHDvlzmwDqt6FH7aaHDDiuSBbxz/YFttU4SN66K1iUw6Q8Fgywo8KY1S4zikhZVhqu
	 +UlVNiDBLflE3jcdiQKZmPs7bCqVqGXvINwW3R3mKirtwvSni6ht/UvMUr8h94CsEn
	 XjfJhlIAWw8bIQ9XUf27fxk9D3DEnjCZNNHj8B6UN8ckLI5W384PevCdF9qzzH/M+G
	 D3yGD7wj516Xw==
Date: Fri, 13 Jun 2025 08:04:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250613150446.GX6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
 <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250612143614.GR6143@frogsfrogsfrogs>
 <aEu3rfhMPrE7414B@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEu3rfhMPrE7414B@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Jun 13, 2025 at 11:01:25AM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 12, 2025 at 07:36:14AM -0700, Darrick J. Wong wrote:
> > On Thu, Jun 12, 2025 at 11:41:16AM +0530, Ojaswin Mujoo wrote:
> > > On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > > 
> > > > > Insert range and collapse range only works with bigalloc in case
> > > > > the range is cluster size aligned, which fsx doesnt take care. To
> > > > > work past this, disable insert range and collapse range on ext4, if
> > > > > bigalloc is enabled.
> > > > 
> > > > Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> > > > maybe we should amend test() in fsx to round to the allocation unit
> > > > size?
> > > Hey Darrick,
> > > 
> > > Yes makes sense but as you mentioned, I'm not sure if there
> > > is a way to programatically detect the bigalloc cluster size (or
> > > allocation unit in general) like we do for xfs. 
> > 
> > I don't either, but maybe we should have a way reveal the allocation
> > unit size for a given file?  Yet another statx field? :P
> > 
> > (It /would/ be useful for programs that use collapse/insert range)
> 
> Yes it would, at the very least, help with defining clear semantics for
> collapse/insert range with bigalloc/rtvol because right now those
> operations just EINVAL if the range is not aligned correctly, which is
> confusing since it is not documented how to do it properly.
> 
> xfs does have an ioctl to get the geometry for rtvol. I think you are
> suggesting a more generic statx field which can be used by other FSes as
> well, right?

Right, since other filesystems (fat, ntfs, etc) also have allocation
units larger than the fsblock size.  Most of the time the allocunit
amplification simply doesn't matter to applications, but once in a while
it does (collapse/insert range, cow) affect performance.

--D

> 
> Regards,
> ojaswin
> > 
> > --D
> > 
> 
