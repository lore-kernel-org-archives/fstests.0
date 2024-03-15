Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C254745
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545413; cv=none; b=s6W6Q+lOII8w1AsfNSRGJE2NN0EgNYauj9V47+ltR2ylCYRqKg8gqNIeI8d2j83Ok3Uur+R8/spIqi4K6To0B5JijlAPCC/BxEhp6OjokXPb2d830v+3vPmnSC+M24MIow03FediK+Ka7dgGTRjrBRBTVMGpRlZHdVUO9X7JTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545413; c=relaxed/simple;
	bh=WLGJBzH47+HSJ6y+I3ez0dEQH9WvKGDi1lPjwIT5RwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8MZitR2U00CWHISyi/c8C48in1M8o0jG5kdHZCrpjDB3ZzyhD0b/htX5xvKeqvNcerU+QOdWg4NgmmOXcGchXWrFKzx5OYaHLVbsctri7pXvEIEhZsUpfHzzpxwD5oo5rfnQkCAHAjvw08kDuau9CfYAHDqWVcn0k5QUHADyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aKLBdQUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRksJJ7n; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aKLBdQUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRksJJ7n"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A8A2E3200922;
	Fri, 15 Mar 2024 19:30:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 19:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710545408; x=1710631808; bh=ksH40rANuj
	Jge2om5A5sFNqBWLqqKlbVr5vqIhkICoY=; b=aKLBdQUyXQNjh12HGXVF2/OKLn
	Soo0IZI0Ourr5zpNs+LpV4b5K9ENBf9OtiK/Ab0JDbHo860E01db1PITchS4GJ5w
	++fY94jlz6OvpWxZIMgRkM6TLxNRHpyaUdZsTvWp2nr5S1ScTYKufCkmYzjVNskZ
	XE34yHi1qPap+SawOntWIhC/USNmKjrnTn3ty1VRmJA5/aj84EU1ACx0iYWfqyIq
	wAHjvEIivAYyJggdYbTC/Jr5hcMp01ugnd6+SxzP/+kQYAYrZzcnDElRxQFx0Ee/
	UEuPbnPRLsYByfHWyzSyD0bRH2TPjZjz043ZUBEGxZ/X7RShcZNCSV/Y64jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710545408; x=1710631808; bh=ksH40rANujJge2om5A5sFNqBWLqq
	KlbVr5vqIhkICoY=; b=fRksJJ7nMRxK7zhyd/W6CXWoQCafQGoXrZs5M4TmU6UJ
	UeTbVUFQyYY85U34ZqF/fJHOPiNlLy9Gq93o5MFm9b6AGyFwQFwAc+DRwlCGJm/c
	iZ+uS8BM2Rv2srSTxa/CyYvGChrQR97ep0lrmF9qY7Cp5AsnFOsTjrtC1RXsNofi
	D6KtIN4yEknhmpJcv3cg3fLzStNP8M5MNx/hM+QUC8GOeVu0boi70e+fNMp5Sgng
	VL946fItrMBNsTA2fpj/Iz2yYOJTkyPE87GNUSIKAxDr4t+DogWO0IQSf8cW9ZMC
	g82Z1HQGIrRzp4PDTx0NKzge41bHDcqLP8DBlMWUKQ==
X-ME-Sender: <xms:_9n0ZZMV_mOJJ7XtCXcNAm6gwdOvwbdb6pS5mWbmM5R6Zk84twckeA>
    <xme:_9n0Zb9dC4BtdBm6Vosnprkw9zROr4zIKb60PB6juTKwFPn8jAtR3336uhKPGIYZ6
    89ljAxqeGBnnoY976I>
X-ME-Received: <xmr:_9n0ZYTchMBRgK1oFO9oajzmuHPm3vAVfclR-94-CYuK0uqC3RsH3G4NZ3_Zjc_HeUYZiTNIgjGgPSuGhKc4ry-PFyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    dthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:_9n0ZVvoQ12-okU26ZYcN-6PhBEjC5WMWfxoEFWWRpA7UhuEmYrzSw>
    <xmx:_9n0ZRd10xLK7P4EInd4s9sTZBOad5tvir8RS30l2m_uvbdL3oA4mQ>
    <xmx:_9n0ZR0hVmOhxjkJzBbP-de5AWY2yA5NI9OukHj7_FOasxb9ndvqIQ>
    <xmx:_9n0Zd-4xcy75f8ymse-sWo-VKMOjREsFZcbwpT3huYxziBORUY3vw>
    <xmx:ANr0ZV6thP6Nyv9jDdAefaSJ8b4d1ws-ymSbDl-4Geo_BOFt_nseFQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 19:30:06 -0400 (EDT)
Date: Fri, 15 Mar 2024 16:30:54 -0700
From: Boris Burkov <boris@bur.io>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: kernel-team@fb.com, fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
Message-ID: <20240315233054.GA3597569@zen.localdomain>
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
 <20240315025628.GH6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315025628.GH6188@frogsfrogsfrogs>

On Thu, Mar 14, 2024 at 07:56:28PM -0700, Darrick J. Wong wrote:
> On Wed, Mar 13, 2024 at 04:47:47PM -0700, Boris Burkov wrote:
> > This test removes a SCSI debug device out from under a mounted
> > filesystem with a (probably) dirty file. This assumes that page cache
> > cannot save us from EIO, for a reason that I can't quite explain. In
> > fact, this test fails for exactly that reason, at least on btrfs.
> > 
> > The original patches:
> > 
> >       https://lore.kernel.org/fstests/20230807112100.GB15405@lst.de/
> > 
> > refer to this passing on xfs and not btrfs, so I suspect I am missing
> > something. With that said, on my machine this actually fails on xfs with
> > and without my patch, so this is clearly not enough.
> > 
> > High level, I am trying to understand what is really the expected
> > behavior from a filesystem under this condition and what this test is
> > getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while btrfs
> > does pass with this additional syncing/cache dropping to nudge it to an
> > error.
> 
> Does btrfs prefetch pagecache data as soon as a file opens?  Or I guess
> it could be that xfs trips an IO error and shuts down, and
> xfs_file_read_iter will return EIO after that happens.
> 
> --D
> 

I might be wildly misunderstanding, since I'm very far from an expert on
the page cache, but didn't we just do a buffered write to the file? So it
would make sense for it to be in cache?

At any rate, what I observed on my system was that xfs does not pass
this test. Curious if that is only on my system or just the current
state of the test.

Summary of my test matrix:
ext4: passes with and without this patch
btrfs: fails without this patch, passes with it
xfs: fails with and without this patch

For that reason, I don't think this a good patch, I just mostly want to
figure out where to go with this test!

Thanks,
Boris

> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  tests/generic/730 | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/generic/730 b/tests/generic/730
> > index 11308cdaa..ca5037c57 100755
> > --- a/tests/generic/730
> > +++ b/tests/generic/730
> > @@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
> >  # delete the scsi debug device while it still has dirty data
> >  echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> >  
> > +sync
> > +echo 3 > /proc/sys/vm/drop_caches
> > +
> >  # try to read from the file, which should give us -EIO
> >  cat <&3 > /dev/null
> >  
> > -- 
> > 2.43.0
> > 
> > 
