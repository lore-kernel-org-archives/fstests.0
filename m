Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BD111B
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpcTPmtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9273EC433CC;
	Fri, 10 Nov 2023 04:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699591734;
	bh=l6vYhHxtTopAmg7TzRG+pm8oCaPwz+RGGXZ+7KxSYVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpcTPmtALoiyUJikEEzVNdskb2igng0l3HbaSW4+lX/J7Fy3HNchDInJPg3H3G/9m
	 0stU4hjigqk0EahrUkg7rMX49jFes8IQiwddNa9tkRU5ilPeaTN6wAhpYbeUEgSq79
	 BXLwlix25XwAE2PwzDAWaVSGIxewdmaqb0ZdDGuVq5KkDHKglVc1my1yB1jMkETUtN
	 or8q5d/MvU60ZkyMrmMFYq97axsiih3DwQKaznpdQmTKQQRGToKaVAGfvc342uBNDI
	 mIBVLfkkLp9SVl+hDW07N/6TJa3YsBs3aY5qu12LNN1euLxRqGvVtSVmIp2IVLsWdL
	 XpJ6C7u2yfj9A==
Date: Thu, 9 Nov 2023 20:48:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	guan@eryu.me
Subject: Re: [PATCHSET v27.0 0/2] fstests: FIEXCHANGE is now an XFS ioctl
Message-ID: <20231110044854.GF1203404@frogsfrogsfrogs>
References: <169947992096.220003.8427995158013553083.stgit@frogsfrogsfrogs>
 <20231109052106.GA29241@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109052106.GA29241@lst.de>

On Thu, Nov 09, 2023 at 06:21:06AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 01:45:20PM -0800, Darrick J. Wong wrote:
> > This has been running on the djcloud for months with no problems.  Enjoy!
> > Comments and questions are, as always, welcome.
> 
> Isn't the branch all new?
> 
> Anyway, this fixes skipping the tests when not supported, and runs them
> fine when supported:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Christoph Hellwig <hch@lst.de>

Thanks!

> although I wonder a bit if keeping functionality not actually supported
> upstream in upstream xfstests is such a good idea.  Keeping it in
> a development branch for the feature seems more flexible to me.  I guess
> there is no point doing a forth and back for this one now, but maybe
> should be more careful in the future.

At the time Zorro proposed merging all the remaining online fsck tests I
didn't think review of the kernel patches was going to continue on for
years.

--D
