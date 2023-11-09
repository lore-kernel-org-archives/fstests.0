Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE86D38
	for <fstests@vger.kernel.org>; Thu,  9 Nov 2023 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731252683;
	Wed,  8 Nov 2023 21:21:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07AAF67373; Thu,  9 Nov 2023 06:21:07 +0100 (CET)
Date: Thu, 9 Nov 2023 06:21:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCHSET v27.0 0/2] fstests: FIEXCHANGE is now an XFS ioctl
Message-ID: <20231109052106.GA29241@lst.de>
References: <169947992096.220003.8427995158013553083.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169947992096.220003.8427995158013553083.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 08, 2023 at 01:45:20PM -0800, Darrick J. Wong wrote:
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.

Isn't the branch all new?

Anyway, this fixes skipping the tests when not supported, and runs them
fine when supported:

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christoph Hellwig <hch@lst.de>

although I wonder a bit if keeping functionality not actually supported
upstream in upstream xfstests is such a good idea.  Keeping it in
a development branch for the feature seems more flexible to me.  I guess
there is no point doing a forth and back for this one now, but maybe
should be more careful in the future.
