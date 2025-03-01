Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414C23DE
	for <fstests@vger.kernel.org>; Sat,  1 Mar 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790934; cv=none; b=HbymLv5X4ase2X+bJHtoLTuIS8wOKj0B3xjjdllZVDlagyPulgp0W9gkjeSPOxyHz0qvquFgQS3i8GxeuKVC09nVwZmQ9EOPDyeZpJlwu1gIo+PUGFyNOWP/efL2dwIRgL0Ne7TXA6KOI8Pw9xzkiohIiOEgUq1wt3TdfmO7doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790934; c=relaxed/simple;
	bh=7HCwmsqmBxfKDdLQkoqvAX2lPTWn6ADEecwyOZs6vLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5ySZnp7p42hfaQnSucqdCd47/2DLLsmjZj7cJYON6lV4HLQquqPuSJXYJJfPtxrgGIWh8Ir5YDwD/nOAHe5owYT9GXNbqYZLTgfRud1GC3ZCgCMMJEzWXLWaRqizRTSRJkASdDS5NvOLzAeMpWyq06/ecJxrxiLkgS3HnpY2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52111tcO012179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:01:55 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0844B2E010B; Fri, 28 Feb 2025 20:01:55 -0500 (EST)
Date: Fri, 28 Feb 2025 20:01:55 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250301010155.GA71970@mit.edu>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250228173319.GG1124788@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228173319.GG1124788@frogsfrogsfrogs>

On Fri, Feb 28, 2025 at 09:33:19AM -0800, Darrick J. Wong wrote:
> 
> Agreed.  I would very much have liked to continue single-instance
> testing in peace the same way I always have.  There are things that
> excite me that I would like to move onto; refactoring a large pile of
> bash is NOT one of them.

I'm also not particularly interested in check-parallel; the reason for
this is that using a 64-CPU system is *expensive*.  It's actually
cheaper to kick off multiple VM's and then shard the tests across
multiple VM's.  It's cheaper to use a multiple small, cheaper VM's
compared to a single large VM.

Sure, having a fast wall clock time is kinda cool.  But not everyone
has access to -- or can afford -- a 64-CPU behemonth.  (Either the
cost of the server, or the cost of electricity / air conditioning ---
I recently upgrading to an AMD Threadripper, although not a 64-CPU
server, since I'm not that wealthy, and was shocked to find that it
consumes 100W at *idle*.)

> Before anyone gets any ideas -- there is no grand plan or collaboration
> here.  Chinner posted an RFC[1] and wrote:
> 
> "This will probably take a bit of time, so I'd like to get the bug
> fixes, improvements and infrastructure changes underway so I'm not
> left carrying a huge patchset for months...."

Yeah, I'll say that I'm a bit annoyed myself, since I've been carrying
patches out of trees for *years* because Dave has objected that the
patches didn't reach his high standards, and then the cr*p that was
check-parallel got merged?  Because he's an XFS architect?  I can't
help but think that there is a massive double standard....

> > It's not just me who observes that. It seems that BTRFS is not tested
> > before release as thoroughly as other filesystems (probably just XFS).
> 
> Admittedly, I only run ext4/btrfs in the default configurations.  I only
> learned yesterday about SCRATCH_DEV_POOL because Felipe called that out.

I'm actually running ext4, xfs, btrfs, and f2fs on fs-next every day.
I used to update to xfstests's for-next quite regularly.  But given
how destablized for-next got, I reduced the regularity of updating to
the latest for-next, because I got busy and I didn't always have time
to debug for-next breakages....

						- Ted
