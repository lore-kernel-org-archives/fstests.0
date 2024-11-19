Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0D19AA68
	for <fstests@vger.kernel.org>; Tue, 19 Nov 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050290; cv=none; b=prYKiXvfqSiHK5bhFruQPzTmEKzZQqoQ1KBZyrQNYs2BB+qUbBBb4xVW4rnoyYG6jjokReQwAzpyvOW48q6jbvwYtREnCIe04uMW5UrknhPmvcFcSZTYdjbRd+3jxJ07ERIiPdo8Tq4MU1eSj9RvuXPqzHtWw1B9tQgu9751y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050290; c=relaxed/simple;
	bh=6p033Wqy2+MMQ492UJe2TAi2AzpDI0QVepV/PHfoDpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB1zn8RJQ85YqhsKrlwc3D1ZjuBsXvyFYmVD2pp1qRcDmHoVHgXGNtLDM5KTT0KIg+9oXwj/3gB5rUgoeKix5l4PE+TfMeGTNjua2oB8YNVGP5OAjcl0HCFPzeUl8msaoAzZprxvGCoEdoV3e/WLiO6pEv6mr5VUH+4QQMy2tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZtP6c3DG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZtP6c3DG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso2761750a91.3
        for <fstests@vger.kernel.org>; Tue, 19 Nov 2024 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732050287; x=1732655087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4kXnVQ6PQnuhpsawv0efgwkcLpWdx7p01Sunyybep0=;
        b=ZtP6c3DGttylnZpICAOeWaXQp2i+Kx6U87RdDoN82wwNh8Hf5Wdx8qBYktTWTAJSuu
         lBe4LqRT7YLq3hcxHO85CG3iH/Gdb/ltfr+XfG51VTTRiFcMAldhyPvNsVpy2YTnqKkr
         uoeRRp0xaJEF1zaDsY58mPMn8Xj+kgs4KSSzFxgmnluX5rDbBo+O51WZ96XZBF/dwxqI
         TV3u+dwOODicT/ESnRvNBlM8lsD1yWTZzPPZGksnYzqsSjz3PAU2JmdZrhNBtYj7jfHG
         /TvENsaSjLsM8CAXfZSNNjW/4z9NxSDxDedGymmIcOiGfiUrEWYqODlhplVH/tCjkfaR
         05rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732050287; x=1732655087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4kXnVQ6PQnuhpsawv0efgwkcLpWdx7p01Sunyybep0=;
        b=A42dZ2JIgAkpaK/jcx8XmYqN6vX2Q9Q5NLHsqxAfH4Oe2rYSUm0ZP0i5c1YrH5smBj
         thlNE/VEW1foeX4/9REpYee2PYaR22jQVVc8ttMvHB3LmdU0jtaTbBimkUqmgvaPeVH3
         GO+Yl9o+bo27vzFip9wn1bdzPcBKtcRrXFaVIWbw52j4FYplXR2GvyGTc0O3XzG2I/no
         4kZOyT7N97Fw7UX23JVkpg0MakoVv4b2nv5brgjWkHQX3M+IeHHb/c55m0oLVAa4Ej1M
         hzy4gMa11514R1Ztdu/wBaBM4j+emSmWWp8G077wQePeuzlHT/njTWz13I9jdiwoaqtj
         iCZg==
X-Forwarded-Encrypted: i=1; AJvYcCWHscRe0Y41Pll0ya/fmKa90bf0xikCwu02WhkegF601tc9Tq/9qBm+fg7SG6RDjAtMuMkSkmIm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkge9vraQMGg/y1YcrOUyaOHlzJaHvvHEJpDLychS4IWSne4qC
	PBzclErmy467EEZBgDWTEsGqkoLnSBJ0kdHVMhP1h72/u4Y4p26GKr1ITqdE6wY=
X-Google-Smtp-Source: AGHT+IFfK90Q1xZpvIwn6M+grSqV29lZECXKeNme8CfUwJYGBP3DxRkUqJ9a9nezPeqalIxEqK3R7w==
X-Received: by 2002:a17:90b:3908:b0:2ea:2906:a6e8 with SMTP id 98e67ed59e1d1-2eaca7da844mr264958a91.37.1732050286883;
        Tue, 19 Nov 2024 13:04:46 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b25eabsm3893344a91.31.2024.11.19.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:04:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tDVOt-00000000c1b-1MLw;
	Wed, 20 Nov 2024 08:04:43 +1100
Date: Wed, 20 Nov 2024 08:04:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 09/12] generic/251: constrain runtime via time/load/soak
 factors
Message-ID: <Zzz9a9RhImWP4F02@dread.disaster.area>
References: <173197064408.904310.6784273927814845381.stgit@frogsfrogsfrogs>
 <173197064562.904310.6083759089693476713.stgit@frogsfrogsfrogs>
 <ZzvtoVID2ASv4IM2@dread.disaster.area>
 <Zzwsgzu81kiv5JPB@infradead.org>
 <20241119154520.GM9425@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154520.GM9425@frogsfrogsfrogs>

On Tue, Nov 19, 2024 at 07:45:20AM -0800, Darrick J. Wong wrote:
> On Mon, Nov 18, 2024 at 10:13:23PM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 19, 2024 at 12:45:05PM +1100, Dave Chinner wrote:
> > > Question for you: Does your $here directory contain a .git subdir?
> > > 
> > > One of the causes of long runtime for me has been that $here might
> > > only contain 30MB of files, but the .git subdir balloons to several
> > > hundred MB over time, resulting is really long runtimes because it's
> > > copying GBs of data from the .git subdir.
> > 
> > Or the results/ directory when run in a persistent test VM like the
> > one for quick runs on my laptop.  I currently need to persistently
> > purge that for just this test.

Yeah, I use persistent VMs and that's why the .git dir grows...

> > > --- a/tests/generic/251
> > > +++ b/tests/generic/251
> > > @@ -175,9 +175,12 @@ nproc=20
> > >  # Copy $here to the scratch fs and make coipes of the replica.  The fstests
> > >  # output (and hence $seqres.full) could be in $here, so we need to snapshot
> > >  # $here before computing file checksums.
> > > +#
> > > +# $here/* as the files to copy so we avoid any .git directory that might be
> > > +# much, much larger than the rest of the fstests source tree we are copying.
> > >  content=$SCRATCH_MNT/orig
> > >  mkdir -p $content
> > > -cp -axT $here/ $content/
> > > +cp -ax $here/* $content/
> > 
> > Maybe we just need a way to generate more predictable file system
> > content?
> 
> How about running fsstress for ~50000ops or so, to generate some test
> files and directory tree?

Do we even need to do that? It's a set of small files distributed
over a few directories. There are few large files in the mix, so we
could just create a heap of 1-4 block files across a dozen or so
directories and get the same sort of data set to copy.

And given this observation, if we are generating the data set in the
first place, why use cp to copy it every time? Why not just have
each thread generate the data set on the fly?

# create a directory structure with numdirs directories and numfiles
# files per directory. Files are 0-3 blocks in length, space is
# allocated by fallocate to avoid needing to write data. Files are
# created concurrently across directories to create the data set as
# fast as possible.
create_files()
{
	local numdirs=$1
	local numfiles=$2
	local basedir=$3

	for ((i=0; i<$numdirs; i++)); do
		mkdir -p $basedir/$i
		for ((j=0; j<$numfiles; j++); do
			local len=$((RANDOM % 4))
			$XFS_IO_PROG -fc "falloc 0 ${len}b" $basedir/$i/$j
		done &
	done
	wait
}

-Dave

-- 
Dave Chinner
david@fromorbit.com
