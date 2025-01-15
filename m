Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF35223
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923627; cv=none; b=eEpAy0UL1A1lraJ4cNOsVJRAkiVXHoLDkaNfgmcxvSMgId8Er0tyYMWKONmRDeWF7LVq8Tmr9H9PFtJiw4tDfj1/teC7reyYzI50V1vSo08t9W7VpYMDefpWieDVScjI59RLj6EjkiQ8cvUnHOMvj0id0eqy4NARRuaDzWU3f3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923627; c=relaxed/simple;
	bh=akSzYS9lOeK/7mY/XcmbGtuEYG8Tj7SAn5wOhnYVGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onT6cga+gYzN1uIrQrkLRhwSSv33gdewsed36Hb5VQsg2w8x6TCJIhoMr/NHqVQdDwPcu4YNDIwfu1rJLXAhE6QfOi+ELLXb5WRAvEaRQ0zGj1MicIMUNFMGtKRUvTnsr6v9nkLrVSQYvDTXP3v/qfmF4Rrs21xFvUfK8oGhObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXNEyZFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXNEyZFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA134C4CEDF;
	Wed, 15 Jan 2025 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736923626;
	bh=akSzYS9lOeK/7mY/XcmbGtuEYG8Tj7SAn5wOhnYVGq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXNEyZFRsSnfAI6/zsiwzndDAXUG+uR0eX/M1IaGNRaa/Qjeml9/RIIjrGnSeDi+W
	 FSEApcq6zwULfESn+g7e+YvwruqNuaaZi3ioR5lIKtXDjhBoQ7AX3rSSDVMM3sJ34g
	 36NEy3lfxCxmnQ6OzATwWqhY356ES7KxXoaXfY8rZOLs9HvOWZCkMcJxkEPV3+ITNH
	 vzOk08t7KK2S9d9gtfItGzSySO/GY41McjMHJGrwImJjWdmKp+1yrOVwqkI8oKX/2n
	 dan+RNyXHj7rkm1SqGOQuUh1DPbg+XAua0KxKK6L95f7jkS2/Uf3fx6Ia9xI+WeXpU
	 2/qsUuaKJERoA==
Date: Tue, 14 Jan 2025 22:47:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/5]: CLI and feature improvements for check-parallel
Message-ID: <20250115064706.GD3557695@frogsfrogsfrogs>
References: <20250115060258.3951185-1-david@fromorbit.com>
 <20250115062916.GC3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115062916.GC3557695@frogsfrogsfrogs>

On Tue, Jan 14, 2025 at 10:29:16PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2025 at 04:51:11PM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > This patchset brings some new functionality to check-parallel to
> > make it easier to run across different machines and filesystems.
> > The patch seti adds these features:
> > 
> > - auto-adjusts concurrency for the machine it is running on.
> > - adds CLI support of selection of tests. These CLI parameters are
> >   identical to the check CLI parameters and the test lists are built
> >   using the same code.
> > - adds support for logwrites devices so that all the test that use
> >   dm-logwrites are now enabled
> > - adds support for specifying the initial filesystem type to test
> >   on the CLI. This makes it easy to select xfs, btrfs, ext4, etc as
> >   the target filesystem type that is to be tested.
> > - Only block device based filesystems can be used with
> >   check-parallel, and this is now enforced at FSTYP selection time.
> 
> Can you please add a --help so that curious users don't have to go find
> the calling conventions by reading the bash? :)

Oh, there is one in patch 3, please disregard this message.

--D

> --D
> 
> > For example, testing the rw group on ext4 is now a simple matter of
> > adding the "-f ext4" parameter to the command line like so:
> > 
> > $ time sudo ./check-parallel -D /mnt/xfs -f ext4 -g rw -x dump
> > Runner 12 Failures:  ext4/308
> > Runner 1 Failures:  generic/095
> > Runner 21 Failures:  generic/042
> > Runner 51 Failures:  generic/627
> > Runner 8 Failures:  generic/032
> > Runner 13 Failures:  generic/019
> > Runner 34 Failures:  generic/347
> > .....
> > 
> > Options like exclude files, groups and lists also work natively in
> > check-parallel now, same as they do in check...
> > 
> > -Dave.
> > 
> 
