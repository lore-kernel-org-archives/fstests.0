Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A5376F1
	for <fstests@vger.kernel.org>; Sun,  1 Dec 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733089045; cv=none; b=aLw+bCUEif1gfhPjrmzYrqWMk+GvUEQJpWmeMtZbzvrRWG2BVy/oL30oEZ3PGbVGp8pXu7Wc6LYALWTeScJiC638yk9k58L57p3xN1K+udmGNSNwn99yRu93EeFMgkxnE6zgOWDfDiUxSSz9cYfazi63LVuf8Vg4/x1mXFLMVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733089045; c=relaxed/simple;
	bh=c8HHEtjAfP+Y35A/FJFGCckUUCfDZDjNeHr0YilCGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyX0GEdGGTTCyyyFocW8EdD9d0eLFgUfqGz14Oddank2uTByaGWd86tUcGy8HAD3VXKT2Q6nia/LaKmTyaAFy/4y6xq9P3YvQA1QwtMGLCZucjlbiYkSInBFW/tr0SdsOPGkKUAuOCIQs23UgV7ko6KKKFYjI4jQPHk09a5vxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fgZU2d6n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fgZU2d6n"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2155157c58cso11032565ad.0
        for <fstests@vger.kernel.org>; Sun, 01 Dec 2024 13:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733089042; x=1733693842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejmOEQhfWwi07g2KAyv6Em+v/JV5XPr6MBMAglRSOzI=;
        b=fgZU2d6n2tzaayr67obm4myA8NVxOS4pPtJb0e2QTrN1RgMyLhYgplafd+xWUboztt
         CXYazZkKJn+iYOw3zadcspD3T7b1mYCiDwjXYED5BE1aMSSKXclKux8UcAPG+91a30gW
         lQ3J8A8+LSls1mxxka4Xk4Azn9IAGJdNtH1LUobBVaRTlura2N20KMQ2QByUvceBWza0
         mGbtL3icMl4jYmYPGxrSpOhdwPXw0NBnNd2wv09UG6EjNwbdBzjHyHd+wdZ0xNqPe9yk
         fBt2DMK2hY8ovA4u6wd6ZCkay9A8nStBPqlXtOIh/mOjbqYDpYl74zYX+wqg5IfzrUm6
         toqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733089042; x=1733693842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejmOEQhfWwi07g2KAyv6Em+v/JV5XPr6MBMAglRSOzI=;
        b=NhFhbLk+g95TcPiXEfF648zCl57B8SGiD9Lwy3PJy/a0A7sGnwtFJcYiXF3DrnpF9y
         ZDnSMpiFDxJQIrq37en5P03zEtycxdQrww8I9VpFks8M7BMwmKYvmcmgI4xdM51vr72L
         4PvnU/i3LhSk/hhLKUrKBj/2tB79gaktIWWaIY3TvqVewwKvUwp2wMYtFnAcuBSpf4YU
         nzVCUNY8SOpzuZnaIZKczwv83u272DdX+pX8OL1R4OFgCgp4NbI6TLBmTe8PzPhQOr3v
         LVSU+Mt4diUmHPQRc1hG3P9SBcOaV17nR8yot/7isT4oTDL2WfkaiadGTKklDlYRO3tW
         54sg==
X-Gm-Message-State: AOJu0YzStBrxXFRFOat3AzwKBrkTp9jStc5KLAEXD/wPogtb/B4Ijg3G
	lYko+UaJSrW0tlabSY+qdASiZ4vXdN7bQ+xOQPl6uTu/i15cbjoeEbXPUrUJyZI=
X-Gm-Gg: ASbGncuHdLZ8X/2yvVDuPHY2LG0u6zeh6FFmkUzehmv89WUNY6wwy71GaoLCvXHAEf5
	IDFzGn2Wly65fnTzWC9sssreJwGzU0PVu6xlZB52KASVX5FEcraXz9ppVwwi79Ixy00YX2wzKi0
	VpuQtgI2rnZbAjuYaMp9rdzX4yPs76nh8TEoyPysMZ3Du3U3ZGaVYg+GFOFPOVWyHeip3cWB59h
	PqRNB4GeiBqgITmak1MdcN/7eKFyKfEizC3oF4W5v6QPhoNalKTIi92uvRh3hMfFDr7QNPlqszG
	fhUkU1CR5NygkeNWEMI1ZOO1Vg==
X-Google-Smtp-Source: AGHT+IG89LpUuPtqNybqxfI8wgkpfkp8+w168jl1N7y4zfDU2glg/zfZls8uuB3cQ96zsfcUZwqkPA==
X-Received: by 2002:a17:902:d483:b0:215:4662:db7a with SMTP id d9443c01a7336-2154662dd3dmr131618385ad.54.1733089042500;
        Sun, 01 Dec 2024 13:37:22 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f452csm63524435ad.48.2024.12.01.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:37:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tHrcz-00000005TRc-431p;
	Mon, 02 Dec 2024 08:37:17 +1100
Date: Mon, 2 Dec 2024 08:37:17 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 30/40] fstests: don't use directory stacks
Message-ID: <Z0zXDWD_Oa7qbB7u@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-31-david@fromorbit.com>
 <20241201121046.qdgyjhuaovupjadw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201121046.qdgyjhuaovupjadw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Dec 01, 2024 at 08:10:46PM +0800, Zorro Lang wrote:
> On Wed, Nov 27, 2024 at 03:52:00PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Using bash directory stacking (pushd, popd, etc) seems to be
> > somewhat unreliable. I've been seeing occasional random failures
> > from both pushd and popd commands that cause the test to fail, and
> > there does not appear to be any reason for the failures occurring.
> > 
> > Rather than wasting time chasing ghosts, just get rid of the
> > directory stacking altogether.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/generic/099 |  8 +++-----
> >  tests/generic/109 |  5 +----
> >  tests/generic/135 | 24 +++++++++++-------------
> >  tests/generic/707 |  7 ++++---
> >  4 files changed, 19 insertions(+), 25 deletions(-)
> > 
> > diff --git a/tests/generic/099 b/tests/generic/099
> > index c7d5932b6..980fd38f3 100755
> > --- a/tests/generic/099
> > +++ b/tests/generic/099
> > @@ -253,15 +253,13 @@ echo ""
> >  echo "=== Recursive change ACL ==="
> >  rm -fr root
> >  mkdir root
> > -pushd root >/dev/null
> >  # create an arbitrary little tree
> > -for i in 1 2 3 4 5 6 7 8 9 0
> > -do
> > +( cd root ; for i in 1 2 3 4 5 6 7 8 9 0; do
> >  	mkdir -p a/$i
> >  	mkdir -p b/c$i/$i
> >  	touch a/$i/mumble
> > -done
> > -popd >/dev/null
> > +done )
> > +
> >  chown -R 12345:54321 root
> >  echo "Change #1..."
> >  _runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
> > diff --git a/tests/generic/109 b/tests/generic/109
> > index 2b0b438cf..894e07167 100755
> > --- a/tests/generic/109
> > +++ b/tests/generic/109
> > @@ -54,10 +54,7 @@ _scratch_mount >> $seqres.full 2>&1
> >  # Test different directory sizes to test various directory formats
> >  for f in 1 2 3 4 5 8 12 18 27 40 60 90 135 202 303 454 681 1020 1530 2295; do
> >  	mkdir $SCRATCH_MNT/dir$f
> > -	pushd $SCRATCH_MNT/dir$f >/dev/null
> > -	filldir $f
> > -	renamedir
> > -	popd >/dev/null
> > +	( cd $SCRATCH_MNT/dir$f ; filldir $f ; renamedir )
> >  done
> >  
> >  status=0
> > diff --git a/tests/generic/135 b/tests/generic/135
> > index 30c52af72..cb9407fdf 100755
> > --- a/tests/generic/135
> > +++ b/tests/generic/135
> > @@ -21,30 +21,28 @@ _scratch_mount
> >  cd $SCRATCH_MNT
>    ^^^^^^^^^^^^^^^
> 
> Below "_scratch_cycle_mount" fails, due to above line. I'll remove it.

I've updated my local tree with this fix and the others that you've
noticed. Thanks!

-Dave.

-- 
Dave Chinner
david@fromorbit.com
