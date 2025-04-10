Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD622036E6
	for <fstests@vger.kernel.org>; Thu, 10 Apr 2025 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269182; cv=none; b=JHTE5m1ThHR8cAaw1xnpU3HD8rqRY8l7sV2kf3L+XySpIc8fVPTQ9fZHLfYtEck2jvnS5VWRzkKZCldaOX8QGzW/kn+j9+LZEjs52kVZ5YxgblogTLY4+BCXudHi1mvhhp2MiZVl4V6zC4GHSf4Qr81DO9fMB3IoB5P+pv7kzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269182; c=relaxed/simple;
	bh=dgp/2rKKxxNSIsXyMQ1kK4w/FMv4WGX637EAMMmYllU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q42EmnbBUkmWNNrsWrykrGsFpTbgb/QPidXBzHKCTgqKC03MnzwTNuSDAyRmjLW4STOqKiOeFx3fvVOL8EC9wOkzij3yvSs/tMgu2P1Ie1C9xhgYh4vWhOvGOHhtQ3y4bPL8DL7QUGu1yldH7qdBBG1hNkjqwFE5OmJFR4uRcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcjHUw9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcjHUw9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744269180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0Ufsk8sEM9LLx8Qh6h7FxkCqp6rSVr/lNG7nBCQ78s=;
	b=QcjHUw9nP2ukOjJlRQFDXZo553ekjgTpD2ckrZEfwvT2segenPSx+7I+XLFUjR195vM2wK
	AfXB4F0bTyyukqifBzd4e3UbvxwKJtdNTNX4L2m1h84mL3IetZcAUYAYG+NkvWbwPOB58N
	Um2jUmP0U8j96BKcFWVLw/u+cmfY6to=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314--OZ6J9fBMpuT8n8CxBta_w-1; Thu, 10 Apr 2025 03:12:58 -0400
X-MC-Unique: -OZ6J9fBMpuT8n8CxBta_w-1
X-Mimecast-MFC-AGG-ID: -OZ6J9fBMpuT8n8CxBta_w_1744269177
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so614814a12.3
        for <fstests@vger.kernel.org>; Thu, 10 Apr 2025 00:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744269177; x=1744873977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0Ufsk8sEM9LLx8Qh6h7FxkCqp6rSVr/lNG7nBCQ78s=;
        b=qsHpLJI2dqC3Djub0D8AFmjwHT9uJaoMw7dsnlYdPOW8cuLfoShmI5g6KveuR6nCin
         +GrjDSt87rrmUbZC5iEmGFA/TwZvapO1SoAWJBmfLSiPEDqdm+WiHUb0C3lygO6fqHdB
         zeQhxUZhC7dD/86MW6/1oByPfDqbcUm9IJ9Q8BR+5SQ36+qTNZkPvEHo8yVcuw7Bvb1E
         vfhNaL9ee1ZHIjObd69FlyiyyQbU1Yi+xAh7p6DQSJCuOXp1/UvzPQwDkuYnCnZgxLdx
         t1xOXUZKEO0IzShvy99xMSbxlF6FylVDiC8MV8ESsdeDi3d6da4KusFBqxj7+6jB22Mn
         TFSA==
X-Gm-Message-State: AOJu0YzecMrZN6mSiM8iVLwvVs34Bm5fMoXCaQtqP82bZM7Uf1W58TCR
	JlEIrrkfmabnTdsbNGRXH4QBpWrZ2FdrAwdhyLJFBqoNZO9cySvBZlIODzRzJk/whd+YFuB1eSd
	0SY0PdV1uvSQ5bYvpj2T8Ih4OcqO+tiPZS9hnmGdxV6hmAUkMOE37awVIvmJytH7HyQ==
X-Gm-Gg: ASbGncsTVwyFOcEEvxsQFl82+eAXUOjgUiS7nlAllqcPeaNsak/Qj3qr3XOdXUZ6zZx
	TtceKJe9HUioYdLesN19Fpds1rlrMp7xgD6QTLqVUYr+35rUmWZPgFUBL6b9WWznqfqAuuKqGyC
	x6CiGahxEyEEVzNQGVn3FSAaRL4t8mo6FslS61pkO0eCFjNJQ/kb25qyxA6s1IbNuYRjl5cU0x7
	EyqekPi7ZFgR5v1rZBNGVffGqvD53adBM4sKhdSYQGhmip3qHH4G1M16f4SWw5ppSZ4zp7v6KQd
	gqs417es43nLyVubcwY8uY8TqruRb+BLy26+p/2v92wMhWP7uO4a
X-Received: by 2002:a05:6a21:6d81:b0:1fe:61a4:71d8 with SMTP id adf61e73a8af0-201694d1378mr3510419637.22.1744269177184;
        Thu, 10 Apr 2025 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEW7oyWmu75wGcNwOzudVcP9hJ/wierR/YQ/cxHk2ZTupQ2jVWFm+f7300goqsTX4Fbaa/w==
X-Received: by 2002:a05:6a21:6d81:b0:1fe:61a4:71d8 with SMTP id adf61e73a8af0-201694d1378mr3510392637.22.1744269176884;
        Thu, 10 Apr 2025 00:12:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d3b43sm2335971a12.39.2025.04.10.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:12:56 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:12:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
Message-ID: <20250410071253.ykwnm7vvsqw7myqb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
 <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>

On Thu, Apr 10, 2025 at 05:31:39AM +0800, Anand Jain wrote:
> 
> 
> On 9/4/25 17:57, Zorro Lang wrote:
> > On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
> > > Ensure seqres is set early in run_section().
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   check | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/check b/check
> > > index 32890470a020..16f695e9d75c 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -804,6 +804,7 @@ function run_section()
> > >   	seq="check.$$"
> > >   	check="$RESULT_BASE/check"
> > > +	seqres="$check"
> > 
> > The "seqres" even might be used earlier than that. If your rootfs is readonly,
> > you'll see that.
> > 
> 
> Zorro,
> 
> Thanks a lot for the review and RVB!
> 
> I’ll take care of this patch 2/6 in a separate patchset.
> Meanwhile, could you help merge the rest of the sysfs patches,
> except for patch 2/6? I don't want the seqres issue to block
> the rest of the sysfs patches.

OK, let's have the test coverage at first. You can merge this patchset without
the 2/6 in your branch, (or use the way you did in
https://lore.kernel.org/fstests/5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com/
temporarily). Then send PR to me, I'll try to push this patchset in this week :)

Thanks,
Zorro

> 
> Thanks, Anand
> 
> > Thanks,
> > Zorro
> > 
> > >   	# don't leave old full output behind on a clean run
> > >   	rm -f $check.full
> > > @@ -849,7 +850,6 @@ function run_section()
> > >   	  fi
> > >   	fi
> > > -	seqres="$check"
> > >   	_check_test_fs
> > >   	loop_status=()	# track rerun-on-failure state
> > > -- 
> > > 2.47.0
> > > 
> > 
> 

