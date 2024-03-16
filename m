Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC59168BE
	for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710599965; cv=none; b=N+SpkZEqG7xW8FQQ7Webj4Prty0CHA8s94Ftq6DBEHCrqlG5L8BQ5QTAR2/U1atl0dHQXc6SMBepUEjEBijqggmvthRfonewzPDwkK4PT0ciTImw6ZUCTbdaffiedGKQcfsz9OWiVXGL4EIPUo5+oOqgxMY2LjUGIDWMAWnufL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710599965; c=relaxed/simple;
	bh=JZ/pBhMElJdtzSDvSu1x5nwBYDer+jabEYwfG69ZKnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+0dWCewttbCuLWrBQI69J/CX62qmsyDFiTj9hFu6qS2JvdkLiVQID+kMTU+UZsAH5NwXQJ1I+2yginOEdOafrww4X54V5IUNAqgxwGP/SXuOhLnGsl57w0ApH0ZIz53lg9uX6/iGmJjY2y7nYudeYVVazF2GRm/MupbvZ59QWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NGW0ip+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkAWZorW; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NGW0ip+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkAWZorW"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id EDF995C01A5;
	Sat, 16 Mar 2024 10:39:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 16 Mar 2024 10:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710599961;
	 x=1710686361; bh=zJsf3heQwFJf/b5guB19V0dCKN2yHbpvjn9rPNiM2ok=; b=
	NGW0ip+S8l5MqJgeDsr1mT+LirQppLh1zf4ZO0LX1ah1d+5AXYC6DJxW+MJQhPFN
	Y4hvnwAHGZalx0dbCE0y+BSmGcgcVCoWyQ1lDO8w9B0nNOAjUHb7c6Y0cBKUlSkP
	v1zw8AXQyM3qjELf4/fZLrfwnOj8wNCWtOHaJ0zon8FXuV8sbk8A8iUTN2UjQBIh
	8rVWAiMZaiCdqhFP6GrOVXplAac4wmR26KKzIs+CdiGPtpHzAUsX6S8k5qGiHEk3
	Z4hoaiY8uyB3zo+FrQf1afdMcB1L5moZv/nvnczE25sXYlwHb5E9eE5hURgH3sE5
	rTAoeXvtRX/he66IaTH27w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710599961; x=
	1710686361; bh=zJsf3heQwFJf/b5guB19V0dCKN2yHbpvjn9rPNiM2ok=; b=W
	kAWZorW7s6Tyl7Z0lZMqBB03AY9yfhBwP4N0tOhxRo7OOwtVf4MlqnYqVAzqJVry
	xmniLTjzEHZ7rtcnEvAlFWYu7gdpCHHkLVLFniT/eWgJlNn0+mteOOnZ2XW9o3DN
	5bCX6kk+jMuxN7fWHGcinNOyAxfEqPhBze0Ujli7SdOILR4HfY55KcFRKw1pYY0d
	FhQXhdlT8F29QSvVg6dIgvpwDa8ZGNcI9H41SBLIP6pNy+P2sJg4b7wTzwpXPrqK
	Bu3Ml3w3bEH21v8E21es5TjyIj+Vk43Avep8ZFfq66sQMDVfEMdwI8s+hzFTX9kk
	YD7ONpJr10OTD/t2j+KsQ==
X-ME-Sender: <xms:Ga_1ZUOkUd3X7bk7-JXPcLhhcGotvN_oJuB2dk1_CslvTziZZwpiew>
    <xme:Ga_1Za8-EWUE4Xj_ea6j6zNK3TQbJl6g4McsCbBe4A5vkRFAZ-vWP4WsbIORhYvBZ
    CyhqWFQWB7a6SwWQHs>
X-ME-Received: <xmr:Ga_1ZbRCXQlV9_ZercHpanle8w6AZ8Qdxk4eieEbn5n1eVlAkQSeYJNxQp8oWDajX1Z-1YJQnYgWm8KzJMeJMZgVgjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkedvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehhfduhefgkeehudefvdetgfetleeuiefgfefhfeegjeekfeehhffgkeejhfdvheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Ga_1ZcuKdqH51EUcLK_9FtuK7Y_MbmAb5gXzmhnz5K2KgGzI0XNkRg>
    <xmx:Ga_1Zcc-k3nYweidH6gStCQWus8WmN5bTliF9QDHpNY2R54R3XYdDw>
    <xmx:Ga_1ZQ0hcwDFIw7cX3xzWUxDGMJEo-KqJQ_aWQbwrFx5qKxpI_PRgA>
    <xmx:Ga_1ZQ9SUNGpxCVcrmt44dbhF4jIurULwLjV1xIiYdvTW4E6qvET2Q>
    <xmx:Ga_1Zb5zbmCAdMlRMam9vkiida9t7sIBo4V_a_GtR8U_Nu--3pHBgA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Mar 2024 10:39:20 -0400 (EDT)
Date: Sat, 16 Mar 2024 07:40:08 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, kernel-team@fb.com,
	fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
Message-ID: <20240316144008.GA3615790@zen.localdomain>
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
 <20240315025628.GH6188@frogsfrogsfrogs>
 <20240315233054.GA3597569@zen.localdomain>
 <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com>

On Sat, Mar 16, 2024 at 01:08:57PM +0000, Filipe Manana wrote:
> On Fri, Mar 15, 2024 at 11:30 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Mar 14, 2024 at 07:56:28PM -0700, Darrick J. Wong wrote:
> > > On Wed, Mar 13, 2024 at 04:47:47PM -0700, Boris Burkov wrote:
> > > > This test removes a SCSI debug device out from under a mounted
> > > > filesystem with a (probably) dirty file. This assumes that page cache
> > > > cannot save us from EIO, for a reason that I can't quite explain. In
> > > > fact, this test fails for exactly that reason, at least on btrfs.
> > > >
> > > > The original patches:
> > > >
> > > >       https://lore.kernel.org/fstests/20230807112100.GB15405@lst.de/
> > > >
> > > > refer to this passing on xfs and not btrfs, so I suspect I am missing
> > > > something. With that said, on my machine this actually fails on xfs with
> > > > and without my patch, so this is clearly not enough.
> > > >
> > > > High level, I am trying to understand what is really the expected
> > > > behavior from a filesystem under this condition and what this test is
> > > > getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while btrfs
> > > > does pass with this additional syncing/cache dropping to nudge it to an
> > > > error.
> > >
> > > Does btrfs prefetch pagecache data as soon as a file opens?  Or I guess
> > > it could be that xfs trips an IO error and shuts down, and
> > > xfs_file_read_iter will return EIO after that happens.
> > >
> > > --D
> > >
> >
> > I might be wildly misunderstanding, since I'm very far from an expert on
> > the page cache, but didn't we just do a buffered write to the file? So it
> > would make sense for it to be in cache?
> >
> > At any rate, what I observed on my system was that xfs does not pass
> > this test. Curious if that is only on my system or just the current
> > state of the test.
> 
> Instead of xfs, do you mean btrfs?
> 
> For me xfs and ext4 always pass this test, i.e. the cat command fails
> with -EIO, both with and without your patch.
> 
> On the other hand, btrfs and f2fs always fail without your patch, and
> pass with your patch applied.

$ sudo ./check generic/730
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 v0 6.8.0-rc7+ #205 SMP PREEMPT_DYNAMIC Thu Mar 14 16:44:32 PDT 2024
MKFS_OPTIONS  -- -f /dev/mapper/tst-scr0
MOUNT_OPTIONS -- /dev/mapper/tst-scr0 /mnt/scratch

generic/730 1s ... [failed, exit status 1]- output mismatch (see /home/vmuser/fstests/results//generic/730.out.bad)
    --- tests/generic/730.out   2023-11-01 22:14:50.011000000 +0000
    +++ /home/vmuser/fstests/results//generic/730.out.bad       2024-03-16 14:38:02.431000000 +0000
    @@ -1,2 +1 @@
     QA output created by 730
    -cat: -: Input/output error
    ...
    (Run 'diff -u /home/vmuser/fstests/tests/generic/730.out /home/vmuser/fstests/results//generic/730.out.bad'  to see the entire diff)
Ran: generic/730
Failures: generic/730
Failed 1 of 1 tests

I suspect it has something to do with my Kconfig. Perhaps "xfs (non-debug)" is a clue?

> 
> From a btrfs point of view, it makes sense for the cat command to
> succeed, since all the file data is in the page cache.

That was my intuition as well, as I mentioned above.

> 
> I don't know why the cat command fails (-EIO) with xfs and ext4, and I
> haven't looked at any of their source code (my knowledge of those
> filesystem's internals is too little anyway).
> 
> An alternative to your patch is just to make the write with direct IO
> by passing -d to $XFS_IO_PROG. It makes the test succeed on these 4
> filesystems.
> 
> 

I like this idea a lot more than my patch!

> >
> > Summary of my test matrix:
> > ext4: passes with and without this patch
> > btrfs: fails without this patch, passes with it
> > xfs: fails with and without this patch
> >
> > For that reason, I don't think this a good patch, I just mostly want to
> > figure out where to go with this test!
> >
> > Thanks,
> > Boris
> >
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  tests/generic/730 | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/tests/generic/730 b/tests/generic/730
> > > > index 11308cdaa..ca5037c57 100755
> > > > --- a/tests/generic/730
> > > > +++ b/tests/generic/730
> > > > @@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
> > > >  # delete the scsi debug device while it still has dirty data
> > > >  echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > > >
> > > > +sync
> > > > +echo 3 > /proc/sys/vm/drop_caches
> > > > +
> > > >  # try to read from the file, which should give us -EIO
> > > >  cat <&3 > /dev/null
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > >
> >
