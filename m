Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E232BE641
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996668; cv=none; b=cNaFqnaumyMJ95Wclywggy+V1LlizMYImuuVDDJsm2kBfJnB60E+RjeoqjmjlJXUw+t9uWQfTut77Gwbeg7JvJFG1ZPDlFd2Ul67J21TIvkuqJeHACjdYoP5UTQkNE5tXcQX9THnOOtU8OYT9gSf0Y12ypMYLuS6R5vJ8Jg3kwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996668; c=relaxed/simple;
	bh=Wgn5r/lPJPjsgA4MoDbSJYHnfAMkY8qlZA+J5phAEng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=bKBJS6IqsheBc5nj6zBZ6RMNZ4tvP+8FgZvRkVSsGxOpz9GLsBuF/YR8EwKtbMGPm+735h1P4hOUb81NRWYAOCQy1R40UyZf4MKusQBiHWoBG9onqTGVDC1JoZ8R5q4GuNiKmwYpAKfMARDWnOjrigqrXSdd0rQKuAibRSUy9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ShyyeS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ShyyeS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3545d66bb3aso3364778a91.0
        for <fstests@vger.kernel.org>; Tue, 24 Feb 2026 21:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771996667; x=1772601467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm/pFrokwWEbL0vu5bebZLYMxEX5AVIntN1lmNVMkbg=;
        b=g6ShyyeSv0aFRGY4MVQPnQrVDMhUZTZLreic1e9Mi1wkbRFaqQo73+AfPENcm16DGN
         QbFmjdbNtfyQymDjKZv8nxyy1JIZwmeTUVJUANzz55/xiYMEF4IMiyky8n8kTFkZ0yQL
         KxgjcgwSn6HenWC2eiWqm1rUWOvxQm9IXFzvl3vQeGiFsth6ti2s3TY81zuIubu6gI53
         tM7u82MscgAD/GNEFAVdyufZUGtKvQ4WQuFlugbTGKKXUw5XdmbFukdalRNRQWnvSyEX
         Nvp8Q1447Y/BzQp26sXRq+nvQczMi5xFVWDx8gKQ3pQ6Z2h6kw8ad1bQ0MDudjnkgagC
         36Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771996667; x=1772601467;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm/pFrokwWEbL0vu5bebZLYMxEX5AVIntN1lmNVMkbg=;
        b=hyq4zgQK3SHmOC19Tz45Jq4gNZ28dZFI8RQvQmOIoKlbCiUDCyAITOr3qAtXcntOX7
         0nUo4A3z/faY6wKkN2jIrIH52IfMkvKcf8qY18NZGGWdzmiJXZ3UohgGWrKAZwH0oUvt
         nvFd3ykzkA6vfbrmeHXY7PFwVvIguIduDa7JZqb6zC7QNtbIvjHaXnNULLvLYnv73OB7
         nw9dYZsHbepRMLLYlQbbKrpD55HuZcqmzAA1c3IcFkmXmBkO/exSF+VuaATo5tzVmfjO
         Gnq01nVjbjgXQWL9IzoyVkswrhYEuVYU+W5EEfF4Yv5CVAJun0X1H6oMxGs+sFn8MKet
         XIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXp1g0P6XWeH+Oo7BBC7cslqE9YHke3IF2SVQa7WQiW01EAxCwVFQDpHGjww395MFDVRmX8zHJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwObbiGZ6ds9a3yIT+gOFgKFUgZW5dSJ4OjnpCnf1ldDpqBtS4A
	435alsdXYl18MP8V7n2MCrQTzuekIbNX9dFMD2g2gzydpGcJzDUOOAQe
X-Gm-Gg: ATEYQzxHirKl5RJkDN8Y4odDcVAQZWwYu4x/tff8rX+Coi9RcgZdCDLEGkFHsRuaknZ
	iuNu4irP4Rkq+57dciN/lIdbt/dMmjEk5ft+nhLGhYmfiCaUpiHd6Pc9KEFIDomFKTUP1x7iGHW
	w1wZfUZAQlGVdNz6vVdBIzcbXrF6WpbvP4qIo7LIl0stYSAPXhyIhq6U70QRLH41ubWURAHc7KF
	cFsQGT7n5c4d7xYP+CKfwMs00HVwladMI8ndSV3ASdmbl+PC2SJWmewjGxoM0/9QLABAm97ADTt
	MGZdmsWYmsewwVb2Huw9xjLg8qw+siIJgdcNwOKdeh2NNMNds4BjlijxFBv3Yzj1SAbriamVt53
	WixOJNRVHJgwGEAE3SjFVnzzl/qrOAXsdMXPByW2Z/t5iyV4xuOOBEnU8g0WUI3ODT7/qK3Uioi
	r0n9JKpf0pE2pfqEgrLhj17QK+sBiud6t9aZuchldTQY4nrPd0OVCgs8F3W9yEgXgtfnenX8dbI
	dk6zk4bi1TbKw==
X-Received: by 2002:a17:90b:314a:b0:356:7917:23c with SMTP id 98e67ed59e1d1-3590f1afabdmr1140696a91.27.1771996666950;
        Tue, 24 Feb 2026 21:17:46 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.233.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359019780bfsm1434203a91.8.2026.02.24.21.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 21:17:46 -0800 (PST)
Message-ID: <d7853e26511631b9ca9a28bb691bbe82765640c0.camel@gmail.com>
Subject: Re: [RFC v1 4/4] xfs: Add support to shrink multiple empty realtime
 groups
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, cem@kernel.org, david@fromorbit.com, 
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org, ritesh.list@gmail.com, 
	ojaswin@linux.ibm.com, hsiangkao@linux.alibaba.com
Date: Wed, 25 Feb 2026 10:47:40 +0530
In-Reply-To: <aZasXfB-GUiGT4yc@infradead.org>
References: <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <1a3d14a03083b031ec831a3e748d9002fab23504.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <aZasXfB-GUiGT4yc@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2026-02-18 at 22:23 -0800, Christoph Hellwig wrote:
> Just q quick glance, no real review:
> 
> > +int
> > +xfs_group_get_active_refcount(struct xfs_group *xg)
> > +{
> > +	ASSERT(xg);
> > +	return atomic_read(&xg->xg_active_ref);
> > +}
> > +
> > +int
> > +xfs_group_get_passive_refcount(struct xfs_group *xg)
> > +{
> > +	ASSERT(xg);
> > +	return atomic_read(&xg->xg_ref);
> 
> Using "get" to read a refcount value is very confusing.  Looking
> at the users I'm tempted to say just open code these and the
> ag/rtg wrappers.

Noted.
> 
> > -	rtg = xfs_rtgroup_grab(mp, prev_rgcount - 1);
> > +	if (prev_rgcount >= mp->m_sb.sb_rgcount)
> > +		rgno = mp->m_sb.sb_rgcount - 1;
> > +	else
> > +		rgno = prev_rgcount - 1;
> > +	rtg = xfs_rtgroup_grab(mp, rgno);
> 
> Throw in a comment that this is about grow/shrink?

Noted.
> 
> > +void
> 
> Stick to the unique XFS style here and in other places, please.

Sure.
> 
> > +xfs_rtgroup_activate(struct xfs_rtgroup	*rtg)
> > +{
> > +	ASSERT(!xfs_rtgroup_is_active(rtg));
> > +	init_waitqueue_head(&rtg_group(rtg)->xg_active_wq);
> > +	atomic_set(&rtg_group(rtg)->xg_active_ref, 1);
> > +	xfs_add_frextents(rtg_mount(rtg),
> > +			xfs_rtgroup_extents(rtg_mount(rtg), rtg_rgno(rtg)));
> > +}
> > +
> > +int
> > +xfs_rtgroup_deactivate(struct xfs_rtgroup	*rtg)
> 
> It might also make sense to explain what activate/deactive means here.

Okay, will update in the upcoming revisions.
> 
> > +{
> > +	ASSERT(rtg);
> > +
> > +	int			error = 0;
> 
> No need for the assert, and code goes after declarations.

Noted.
> 
> > +	xfs_rgnumber_t		rgno = rtg_rgno(rtg);
> > +	struct	xfs_mount	*mp = rtg_mount(rtg);
> > +	xfs_rtxnum_t		rtextents =
> > +			xfs_rtgroup_extents(mp, rgno);
> 
> This assignment fits onto a single line easily.

Okay - will fix this in the next revision.
> 
> > +	ASSERT(xfs_rtgroup_is_active(rtg));
> > +	ASSERT(rtg_rgno(rtg) < mp->m_sb.sb_rgcount);
> > +
> > +	if (!xfs_rtgroup_is_empty(rtg))
> > +		return -ENOTEMPTY;
> > +	/*
> > +	 * Manually reduce/reserve 1 realtime group worth of
> > +	 * free realtime extents from the global counters. This is necessary
> > +	 * in order to prevent a race where, some rtgs have been temporarily
> > +	 * offlined but the delayed allocator has already promised some bytes
> > +	 * and later the real extent/block allocation is failing due to
> > +	 * the rtgs(s) being offline.
> > +	 * If the overall shrink fails, we will restore the values.
> 
> Formatting: use up all 80 characters.

Okay.
> 
> > +	xfs_rgnumber_t          rgno = rtg_rgno(rtg);
> > +
> > +	struct xfs_rtalloc_args args = {
> 
> Weird empty line between the declarations.

Will fix this.
> 
> > +bool xfs_rtgroup_is_empty(struct xfs_rtgroup *rtg);
> > +
> > +#define for_each_rgno_range_reverse(agno, old_rgcount, new_rgcount) \
> > +	for ((agno) = ((old_rgcount) - 1); (typeof(old_rgcount))(agno) >= \
> > +		((typeof(old_rgcount))(new_rgcount) - 1); (agno)--)
> 
> I don't think this is helpful vs just open coding the loop.  The mix
> of ag and rg naming is also a bit odd.
> 
> > +	for_each_rgno_range_reverse(rgno, old_rgcount, new_rgcount + 1) {
> > +		rtg = xfs_rtgroup_get(mp, rgno);
> 
> Given that we have this pattern a bit, maybe add a reverse version
> of xfs_group_next_range to encapsulate it?

Okay - I will try to come up with something. Thank you for the suggestion.
> 
> 
> Highlevel note:  this seems to only cover classic bitmap based RTGs,
> and not zoned ones.  You might want to look into the latter because

Okay. So are you suggesting to add the shrink support only for the zoned devices or extend this
patch set to cover shrink for the zoned devices too?
> they're actually much simpler, and with the zoned GC code we actually
> have a super nice way to move data out of the RTG.  I'd be happy to
> supple you a code sniplet for the latter.

Sure, that would be super useful. Also, since I don't have much experience in zoned devices, can you
please point to some relevant resources and recent zoned device related patchsets that can help me
get started with?
--NR

