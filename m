Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4448663E
	for <fstests@vger.kernel.org>; Wed,  8 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184388; cv=none; b=ouXTlps/+99+/CX2IHuOIeuRTP4l6FB6vJWAiHwwtCLPW7pn3oVf0VSe0dbFjiQt2K6AEKQqZwK53MdB/Z0Qa+CkbH2gs+kI30TjsVgQ61QzNufzY0JHvXqlKDjqotksOGcfBzQ/nd9asJYjsMGgfvksuoOezyGjM4ujTBRNcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184388; c=relaxed/simple;
	bh=7QIWJ6il5KR7wDJnPqFFgMP8rnG3+fLQWhdaJEnoxoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNsg3c/ZRpfXa7ddCmfeYIJn4GOjhmmxVDRumpyi9gjC9/d56ByiTq+lRo5JkN8b5Yfz5e04kMa7NPnPfFPAJtlXpQB3EksaNRiM9X12KXMlttvnhI3799GD4fz0NbUo2NTDmBOieTv6MipOiYR1GSaeUfdvwP9tb0hMMOYbMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGHqJt1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGHqJt1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094DAC2BD10;
	Wed,  8 May 2024 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715184388;
	bh=7QIWJ6il5KR7wDJnPqFFgMP8rnG3+fLQWhdaJEnoxoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGHqJt1TU6/dbhQtOmqhyXE6Jl3YOQ8rGoDQqUm5k9NGHXgYYnjw9xvnmpQX9tBlE
	 O2k+AgxPwrFPT4MRoUKVhCsXh2jNiXUx7sUYkznBc/zFi7OAw6F66v7AbMk3hgvXW4
	 8531zlu9tfrJs8jhoSreWyFCDgeahBBxslbjSl8oB14Qq8t8g9gmKvvo2mynMhzJxG
	 Ie/E7s2HZBL7eZ/aFlXwMuexycz5Y5zllRttbnLYOsrpQmbxTFP5jNleWZOOP1XBkf
	 ZcUR1ejowsrrGhGyKhLbqUSFEbzQliZFgI8mrcFTmOuEybNTNeHbIGzX9uyMjhL2zr
	 1yZMcAQrVdpkA==
Date: Wed, 8 May 2024 09:06:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Message-ID: <20240508160627.GG360908@frogsfrogsfrogs>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com>
 <20240507222323.GC2049409@frogsfrogsfrogs>
 <CALk7dXqCD2MDPavit0mkD061bEHTswFxuwbfPZuAuCtNcFAPFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALk7dXqCD2MDPavit0mkD061bEHTswFxuwbfPZuAuCtNcFAPFA@mail.gmail.com>

On Wed, May 08, 2024 at 08:20:01AM +0530, Ritesh Harjani wrote:
> On Wed, May 8, 2024 at 3:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > >
> > > This test fails when xfs is formatted with 64k filesystem block size*.
> > > It fails because the soft quota is not exceeded with the hardcoded 64k
> > > pwrite, thereby, the grace time is not set. Even though soft quota is
> > > set to 12k for uid1, it is rounded up to the nearest blocksize.
> > >
> > > *** Report for user quotas on device /dev/sdb3
> > > Block grace time: 7days; Inode grace time: 7days
> > >                         Block limits                File limits
> > > User            used    soft    hard  grace    used  soft  hard  grace
> > > ----------------------------------------------------------------------
> > > 0        --       0       0       0      0       3     0     0      0
> > > 1        --      64      64    1024      0       1     0     0      0
> > > 2        --      64       0       0      0       1     0     0      0
> > >
> > > Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
> > >
> > > Cap the blksz to be at least 64k to retain the same behaviour as before
> > > for smaller filesystem blocksizes.
> > >
> > > * This happens even on a 64k pagesize system and it is not related to
> > >   LBS effort.
> > >
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > ---
> > >  tests/xfs/161 | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tests/xfs/161 b/tests/xfs/161
> > > index 486fa6ca..94290f18 100755
> > > --- a/tests/xfs/161
> > > +++ b/tests/xfs/161
> > > @@ -38,9 +38,15 @@ _qmount_option "usrquota"
> > >  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
> > >  _scratch_mount >> $seqres.full
> > >
> > > +min_blksz=65536
> > > +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> > > +# Write more than one block to exceed the soft block quota limit.
> 
> Maybe we should improve this comment to -
> 
> # Write more than the soft block quota limit of 12k which is set later
> via xfs_quota
> # On 64k bs this will get rounded to the nearest blocksize which is 64k
> 
> > > +blksz=$(( 2 * $file_blksz))
> > > +
> > > +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
> >
> > If we don't set $min_blksize and always write (2 * $file_blksz) does the
> > test still work?
> 
> I guess it won't (even for bs=4k), because we set the bsoft=12k via xfs_quota.
> So we have to write more than 12k to trigger the grace timer.

Ah, ok.  Yes, that makes sense with the improved comment. :)

--D

> -ritesh
> 
