Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAD2FD1D4
	for <fstests@vger.kernel.org>; Mon, 25 Aug 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136656; cv=none; b=FmhhHag/fgQ7nCGLWnh0MgSfUuiYx9czcWYvebLMQs4aQNH343TuEvyTQt9gIn8CgDboq9to+AduEZA7GouTW4DiFRe9aPHEE+GriFaWYkrS1E/Husjrtfk13lcNVLNT8PtgLczsTTzH9JxbWMApPHLipGxMcjjXoE1oEPSyNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136656; c=relaxed/simple;
	bh=f6UTTV3HQ3d6jbPvPhW3byClTFkJH7JWH0y1fcalmfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYHmzJgRiDRa+3iiuLVEHyw8CJzhkfjCkuQbd6+qrOlzWMFPhPPc2J0D8SDZ54rINZxoprM613lgKazvOdmQIAO1ERXvdc5aiTVkc3IJqqzom4y913zlz6kZBntT5yLq9EwlTF7l/ZJDAjuv3Ev9f9fI7uUSKZDxqipFzwfO7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9vnquFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9vnquFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7641DC4CEED;
	Mon, 25 Aug 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756136654;
	bh=f6UTTV3HQ3d6jbPvPhW3byClTFkJH7JWH0y1fcalmfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9vnquFK/xuSr2qwYNljAaSPxqgAY4XUYxTGsbBnl8BntUJ39701ZnGT+kxwdBpkv
	 OXDCr9/V/aFmHEuxI7bwzJQk1XH5tVI1aREbMadf4O7YjBIFZ/bITfXJO5Tsh+nb8o
	 oOYoYzGMF8wKGhvGACfHmD1ynXXOigu+Ur2PuwKk3KyZW7eTLP9Tjp+ZulQppesPW1
	 ov5ueALxmEBryzGtWAvB50EsZwgHsrvf6U9b57amF3kVfnUJpIeaCx2hvY1oGyR1X0
	 IndqVrE7PVVybWUCUWku/d46P0H60AzBmzAmzgmUmHKVAIyXSaS4BG/sEWlXyssALe
	 1koTFL3/imwxA==
Date: Mon, 25 Aug 2025 23:44:10 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] dmthin: _notrun when dm-thin setup fails
Message-ID: <20250825154410.dt5avycrauhtd2te@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250818072724.1559133-1-hch@lst.de>
 <20250818072724.1559133-2-hch@lst.de>
 <20250818205131.GD7952@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818205131.GD7952@frogsfrogsfrogs>

On Mon, Aug 18, 2025 at 01:51:31PM -0700, Darrick J. Wong wrote:
> On Mon, Aug 18, 2025 at 09:27:16AM +0200, Christoph Hellwig wrote:
> > dm-think does not work on device with protection information.  Instead
> > of failing the tests using it in obscure ways, _norun them.
> 
> Heh, I wish we had a thinking device mapper target. :)

Me too :) anyway I'll help to change this typo.

> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Anyhow, failure to set up a dm-thinp volume sounds like failing to meet
> a test precondition, sooo

I'm wondering, if we choose _notrun when _dmthin_init/dmsetup_create fails,
but others _dmxxxx_init/dmsetup_create [1]  fails, we still call _fatal. Isn't
that an inconsistent behavior :)

Thanks,
Zorro

[1]
zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ ls common/dm*
common/dmdelay  common/dmdust  common/dmerror  common/dmflakey  common/dmhugedisk  common/dmlogwrites  common/dmthin

> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  common/dmthin | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/common/dmthin b/common/dmthin
> > index 453e43a0499e..a1e1fb8763c0 100644
> > --- a/common/dmthin
> > +++ b/common/dmthin
> > @@ -105,13 +105,13 @@ _dmthin_init()
> >  	# Metadata device
> >  	DMTHIN_META_TABLE="0 $meta_dev_size linear $dm_backing_dev $meta_dev_offset"
> >  	_dmsetup_create $DMTHIN_META_NAME --table "$DMTHIN_META_TABLE" || \
> > -		_fatal "failed to create dm thin meta device"
> > +		_notrun "failed to create dm thin meta device"
> >  
> >  	# Data device
> >  	local data_dev_offset=$((meta_dev_offset + $meta_dev_size))
> >  	DMTHIN_DATA_TABLE="0 $data_dev_size linear $dm_backing_dev $data_dev_offset"
> >  	_dmsetup_create $DMTHIN_DATA_NAME --table "$DMTHIN_DATA_TABLE" || \
> > -		_fatal "failed to create dm thin data device"
> > +		_notrun "failed to create dm thin data device"
> >  
> >  	# Zap the pool metadata dev.  Explicitly fsync the zeroes to disk
> >  	# because a slow-running udev running concurrently with dd can maintain
> > @@ -124,16 +124,16 @@ _dmthin_init()
> >  	# "start length thin-pool metadata_dev data_dev data_block_size low_water_mark"
> >  	DMTHIN_POOL_TABLE="0 $data_dev_size thin-pool $DMTHIN_META_DEV $DMTHIN_DATA_DEV $cluster_size $low_water"
> >  	_dmsetup_create $DMTHIN_POOL_NAME --table "$DMTHIN_POOL_TABLE" || \
> > -		_fatal "failed to create dm thin pool device"
> > +		_notun "failed to create dm thin pool device"
> >  
> >  	# Thin volume
> >  	$DMSETUP_PROG message $DMTHIN_POOL_DEV 0 "create_thin $pool_id" || \
> > -		_fatal "failed to message pool device"
> > +		_notrun "failed to message pool device"
> >  
> >  	# start length thin pool_dev dev_id [external_origin_dev]
> >  	DMTHIN_VOL_TABLE="0 $virtual_size thin $DMTHIN_POOL_DEV $pool_id"
> >  	_dmsetup_create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
> > -		_fatal "failed to create dm thin volume device"
> > +		_notrun "failed to create dm thin volume device"
> >  
> >  }
> >  
> > -- 
> > 2.47.2
> > 
> > 
> 
