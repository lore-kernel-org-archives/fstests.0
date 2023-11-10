Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957E111B
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1LgXS+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89307C433CB;
	Fri, 10 Nov 2023 04:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699591607;
	bh=fzEvcDCi184fWZaY5x5VLkkRZ1aAYGSc82ksbTAfnQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1LgXS+FMKnAlk+lJtac8ywK/+e5SgxtAHthRYe6uoUngwImNs+DpZ1NtWpE86IFr
	 eGDMYfN8JV+g71tAUK+DD6Thpn+ap7E1tD8FNQyXnv1xva0O0//OocGI5ME2hyh+YR
	 oSmBcYKQOGOzzabZOQIFWbBrjbVkvpwICnec0lzCsZeaWt6J3VTY9Coe4QJjFw7CMk
	 LAqQGRDChndMKdEKYhNMSY99dqmlUIeufjgaBRwtsgXjl7eJ4FU4kqqGLjAT5wDUCU
	 8sYov1lh1HpY14SuAfTw+VoiQ4j1AwZiKFy8wB8Rmi7qBnJIVOcohVRf4NEtZBgnzD
	 Iz0oBkB3bvBkw==
Date: Thu, 9 Nov 2023 20:46:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, guan@eryu.me, david@fromorbit.com,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: test unlinked inode list repair on demand
Message-ID: <20231110044646.GE1203404@frogsfrogsfrogs>
References: <169947894813.203694.3337426306300447087.stgit@frogsfrogsfrogs>
 <169947895967.203694.8763078075817732328.stgit@frogsfrogsfrogs>
 <ZUxwoLoy2D/CIUbE@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUxwoLoy2D/CIUbE@infradead.org>

On Wed, Nov 08, 2023 at 09:39:44PM -0800, Christoph Hellwig wrote:
> > +# Modify as appropriate.
> 
> Btw, why do we keep adding this pointless boilerplate everywhere?

Oops.  It comes from the ./new output, but I guess I am a bit lazy about
removing it. :(

> > +_supported_fs generic
> 
> I think this should be xfs only.

Changed.

> > +source ./common/filter
> > +source ./common/fuzzy
> > +source ./common/quota
> 
> When did we switch from using . to source other shell files
> to "source"?  Just curious.

Habit of mine.  vim colors and bolds "source" nicely, which it doesn't
do for dot.

> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> 
> xfs again.

Changed again.

--D
