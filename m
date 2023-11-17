Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DF4500A
	for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0MFh2BE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29831C433C8;
	Fri, 17 Nov 2023 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700258986;
	bh=o1YSel63NJjceSYSoyhJnMK4hoF64DxXtLdCfsaK4dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0MFh2BEwZzgW7OzaybsVWBzvnbDeUm8bYh6fDBjjdbuon7H4ZxxvbEkyJO03qLIc
	 fro7Ew4pginzIsgxbu1HL+5icGbjTcPsmqb5DfJK9JDdNkxubI+Qcbjg3NJqa/tBtz
	 zHwccshy/qbhYJbYBfdQ00cpWGlkM2dYNFoPiZQZlHZ3NOyiWbi2tRpCmcJng7VKvH
	 Fibi70SfpJM1KQ6knRuuNiUBxZHws05V4wHrOK2QFUT4hiVvha+/pz+bD/z/W62Yn+
	 ssFWzJPi0/zKHNZ6bWC6RefM8eQMiE1vAn3whIEj6KOd8OvLt00xvo5GJ53+dfWc6y
	 OPd4XPfc0WSPA==
Date: Fri, 17 Nov 2023 14:09:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/726,727: add missing _require_scratch_reflink
Message-ID: <20231117220945.GH36175@frogsfrogsfrogs>
References: <20231108152428.432995-1-hch@lst.de>
 <20231117145155.t7vvq3ksdrhyo5ff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117145155.t7vvq3ksdrhyo5ff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Nov 17, 2023 at 10:51:55PM +0800, Zorro Lang wrote:
> On Wed, Nov 08, 2023 at 04:24:28PM +0100, Christoph Hellwig wrote:
> > These two tests require reflink functionality, add the correct
> > statement to ensure that.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/generic/726 | 2 ++
> >  tests/generic/727 | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/tests/generic/726 b/tests/generic/726
> > index f0d8df2e..77afe10c 100755
> > --- a/tests/generic/726
> > +++ b/tests/generic/726
> > @@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
> >  
> >  # Import common functions.
> >  . ./common/filter
> > +. ./common/reflink
> >  
> >  # real QA test starts here
> >  
> > @@ -28,6 +29,7 @@ _require_user
> >  _require_xfs_io_command swapext '-v vfs -a'
> >  _require_xfs_io_command startupdate
> >  _require_scratch
> > +_require_scratch_reflink
> 
> Does the "startupdate" actually need reflink feature?

It does, but the -a switch to the _require_xfs_io_command swapext line
above will fail _notrun the test.  Or at least it would had I not
changed the CLI options when I gave up on getting FIEXCHANGE merged and
reworked it as an xfs-only ioctl.

IOWs, the "privatize the FIEXCHANGE" series should fix all these
problems for Christoph.

--D

> >  
> >  _scratch_mkfs >> $seqres.full
> >  _scratch_mount
> > diff --git a/tests/generic/727 b/tests/generic/727
> > index 2cda49ea..1f9eebc5 100755
> > --- a/tests/generic/727
> > +++ b/tests/generic/727
> > @@ -20,6 +20,7 @@ _begin_fstest auto fiexchange swapext quick
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/attr
> > +. ./common/reflink
> >  
> >  # real QA test starts here
> >  
> > @@ -31,6 +32,7 @@ _require_command "$SETCAP_PROG" setcap
> >  _require_xfs_io_command swapext '-v vfs -a'
> >  _require_xfs_io_command startupdate
> >  _require_scratch
> > +_require_scratch_reflink
> >  _require_attrs security
> >  
> >  _scratch_mkfs >> $seqres.full
> > -- 
> > 2.39.2
> > 
> > 
> 
> 
