Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF112765ED
	for <fstests@vger.kernel.org>; Mon,  9 Feb 2026 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770602007; cv=none; b=bkZP/+RO7N9rxGTRhfJUR0UU1G+rZp/XhUIEOYJy1Lk+zZ+AMtzHL/fovjEgtIfJQqH35FzS9C4P0oxp3n3nb8YXAk1hvnkEI3UNy7rlY9b4i2MFbcpF4XTw/qgny7uEhKjHAfpdEZnXC5/5xhoAqaVZrTdYZzGjm2xihyaDiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770602007; c=relaxed/simple;
	bh=96QqglFg43zvYNEv2/Zj9UYa/qEYFwhtncmwSzkvNW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7z5gW7HD4wTblJtwnnuVxWC59yMvWkdYeYIkJvdgH2Q9eHrMaV2EPR46gNc6m/6qohKy9+1iF0VAu8Me7GL4G8gLu90sm6lAKuadeNl59ZmOV9+RRLgeGUtw6kRbyTh9cVgpH2j4u6DuqtuPuQkEei2ZGGhJmx+mXQlBivoH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y26EkbjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y26EkbjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E9C4CEF7;
	Mon,  9 Feb 2026 01:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770602007;
	bh=96QqglFg43zvYNEv2/Zj9UYa/qEYFwhtncmwSzkvNW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y26EkbjAuRsIi08x/AdidBiODMibitINvDUsXhZ5FC8oLzLBmqmstv7PTNm8q9RQ5
	 YMZgTxGMQpO/1JCGB0yQ5jj2HVol8JUAKFolJXiJy3cA0WAFgtWhR8FL+XrqZJ6y1C
	 zQIrNtDYu91nrgr7nRtI3T6jSKWUKA6az1J5hfJtepwMwZdDI7FyKK4PTeRBx4B6Gs
	 d9QJByeU1iyfBqQiZFhoF09UNQ/HNRkfp9Q8jtQtU5G0N1S5diLrG6ePgCztpW3wjP
	 pR/5Cwx4Yyc0qonmpGsj+ghImKvuCkgmiGhhgPv87Y8eAKN4qRz1OvwPt5n9WE4Ho+
	 fZx6stRpU4oMw==
Date: Sun, 8 Feb 2026 17:53:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Joanne Chang <joannechien@google.com>, fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
Message-ID: <20260209015326.GK1535390@frogsfrogsfrogs>
References: <20260108022501.754320-1-joannechien@google.com>
 <20260110013802.GB15541@frogsfrogsfrogs>
 <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
 <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 09, 2026 at 03:50:43AM +0800, Zorro Lang wrote:
> On Mon, Jan 12, 2026 at 11:20:36AM +0800, Joanne Chang wrote:
> > On Sat, Jan 10, 2026 at 9:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > On Thu, Jan 08, 2026 at 02:25:01AM +0000, Joanne Chang wrote:
> > > > generic/735 attempts to create a file with nearly 2^32 blocks. However,
> > > > some filesystems have a maximum file block limit below this threshold.
> > > > For instance, F2FS is limited to approximately 2^30 blocks due to the
> > > > capacity of the inode. So add _require_blocks_in_file helper to skip the
> > > > test in such cases.
> > > >
> > > > The helper uses a hardcoded constant instead of a programmatic method,
> > > > so that bugs which affect the maximum file size are not masked.
> > >
> > > Not to mention trying to create a file with 1,057,053,439 blocks
> > > allocated to it would probably take forever.
> > >
> > > Hang on, we're talking about iblocks (aka the number of blocks allocated
> > > to this inode), not the maximum file size in blocks, right?
> > >
> > > If so, then maybe this function and its comments should
> > > s/blocks/iblocks/?  Or am I confused? ;)
> > >
> > > --D
> > 
> > If I understand correctly, generic/735 creates a large logical file, but
> > the actual physical block allocation is much smaller. Also, the F2FS
> > limitation is about how many blocks the inode can address, no matter if
> > the blocks are actually allocated.
> > 
> > So I believe the requirement is about the maximum file size in blocks,
> > not the number of blocks actually allocated. Does it make sense to keep
> > the name, or do you think another term would be clearer? I appreciate
> > your thoughts on this.
> 
> Hi Darrick,
> 
> I think Joanne's explanation makes sense, if you don't have more review points
> on it, I'll merge this patch.

Agpgth, I didn't notice this reply!  My apologies! :(

Ok, since this is a limit on the maximum logical file block number,
_require_max_file_range_blocks, perhaps?

--D

> 
> Thanks,
> Zorro
> 
> > 
> > Best regards,
> > Joanne
> > 
> 
