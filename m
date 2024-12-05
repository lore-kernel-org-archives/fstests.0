Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2E18C33C
	for <fstests@vger.kernel.org>; Thu,  5 Dec 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380134; cv=none; b=HtW5Gihi/ANXBnpSSG55Fa4FSGTdHQ5pFm1FIa+Pi/zMuPXbZNBHkAmeqtovRviAGpLcU3xgciSldLII/XNfz11HIGm8gPst9P5JlrQiD5lzBV+Fdn+Af6JHsV9KTLJJPQE6PpBni82aijSKaSiDVpGzYds4ww6I3RdP/Vks1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380134; c=relaxed/simple;
	bh=o8XByuQAS5FcAZktY+3dH6OwEUUaqmNP1xpavhJVbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNNNcEdXiQZQjWptJug374PH5jSHm/bRHwPrrZDgFRYyrB7eNWJvR+iFvMwST0CWd48lxzSDQF6uKb9NBdKqsUCMrN7Uuwf2X9lVwC59n5+to7wYdrz6EjmxtoGpNstEt41nPOz0mKW1mGWi5QxJ9yNWVy91zpchFcZ0irE4qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M992lGpp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M992lGpp"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so536251a91.1
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2024 22:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733380131; x=1733984931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EewBQDS2gNnk5fv1NbWQryL9fcSFnblgCK+PkAurpvo=;
        b=M992lGppy4cYsl03GOWBC6FfSTLW6iTeGyvPl2FfEumIIWrSC3MiVRmAJoIvL3ZL/w
         CWFm2RSp1+/2tGxv8iPSNKGtPYOXlXwvoZ0yv4AZwkdzLnJuJ/oMk0YdIT5hgtQGGYlR
         sR6wR1BfKpdFVJavpJVUpZL5dvQR/pRQFF5SmLRNIvCt7yLcw2S5TfjHuStKaT2AIhlL
         CI1P5C6Kv1bLhOl8b+qfYSx3j1fhpQvPT4H8H9V+e0sMYeeJMtUboq7IKyS/iWdKhOJg
         atr862BaObCVOblv7fmpljEkZ9gIzcPE3EXBoY7r3KwfeHB+eazWpoZFGRkk8qV8Z2Qo
         eHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733380131; x=1733984931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EewBQDS2gNnk5fv1NbWQryL9fcSFnblgCK+PkAurpvo=;
        b=U7V1vCBG9xQ8945vbcCxXTyQ7QuBpjFpL+xCRH8YB8kcnpBXZVWpImhbJAoRPT545I
         23bS+rXt4s2MaTvYQUz17O5OMIbY74U+5B/6lIUuyc/cysMxeqFUG4nHtL0BZxXGnbxc
         +nIIBkYy2jIzcI98Gj75NHG723OUjYuc3YHuey8skfo/cOC+skOH+CBXiUalv0UEjRKv
         eaMBqITWdYQgtF9vNsTVoJ/FR9IDO2Nz3W2xVdOx2AAWI9f+oqBbk8jLtntoM5PCckOi
         Ts9UUi3hFHBwUIU639wIkQbaq+GjNf6jufvgvC1dGwHZTnVSe87CmvDonDeJDxUJKlcd
         0O6A==
X-Gm-Message-State: AOJu0YzfINRpH+HLydB+cxLaymHvCS+0ppmE48uv7qDzbzsU4EXhXyNe
	VcZxtXGIQU9zwzgsJKroSnjCitErr+5Lk1ke+cPFGm+/oJZZEVQSNRknZkB9c4d04pbLs3F5bTL
	V
X-Gm-Gg: ASbGncuypbbX2H5sTmzDZKaLZmc1av7cJMdj+te5OYexay0rhToAcS5PitFFOXzypWD
	OCFwNICB7Q2ntbt6FLzMx2DI8krYl7dkA2ytKrWZmpLo5oXfDDKWcU4eQPJhO0fkiQda4OzUJgi
	RDOmSSdLRixo2Tg1b8VSITblA2+u9FtAJWv09gPKgvQ+s2o96gIhG09C5Yx0mv0S+l32IYzNGbM
	mw0FEnkBf1qi26FG7TmCGKMI6cnxZzmvq/038+DcWd1vjefTc7qzey8EqW56EgBBQ02iaeKoh0g
	GFMmndsEyXzpn2sJOGoqudiRlZ+uz2Ee
X-Google-Smtp-Source: AGHT+IGL/2AH4W0FdjNiMTko1UnHR0EXxEBAok+KuektEbPU4j4oIhrPQhrP6rohlerOVKJVgrs3TQ==
X-Received: by 2002:a17:90b:1a8c:b0:2ee:f46f:4d5f with SMTP id 98e67ed59e1d1-2ef011e378bmr12059256a91.6.1733380131595;
        Wed, 04 Dec 2024 22:28:51 -0800 (PST)
Received: from dread.disaster.area (pa49-180-218-149.pa.nsw.optusnet.com.au. [49.180.218.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffb3796esm2344868a91.0.2024.12.04.22.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:28:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tJ3u1-00000006ovV-352D;
	Thu, 05 Dec 2024 15:55:49 +1100
Date: Thu, 5 Dec 2024 15:55:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <Z1EyVTXPczqg2u0s@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-3-david@fromorbit.com>
 <20241204180435.qequx4dbnhz3a2bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180435.qequx4dbnhz3a2bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Dec 05, 2024 at 02:04:35AM +0800, Zorro Lang wrote:
> On Wed, Nov 27, 2024 at 03:51:32PM +1100, Dave Chinner wrote:
> > diff --git a/tests/generic/561 b/tests/generic/561
> > index 39e5977a3..3e931b1a7 100755
> > --- a/tests/generic/561
> > +++ b/tests/generic/561
> > @@ -13,9 +13,9 @@ _begin_fstest auto stress dedupe
> >  # Override the default cleanup function.
> >  _cleanup()
> >  {
> > +	end_test
> >  	cd /
> >  	rm -f $tmp.*
> > -	end_test
> >  }
> >  
> >  # Import common functions.
> > @@ -23,28 +23,20 @@ _cleanup()
> >  . ./common/reflink
> >  
> >  _require_scratch_duperemove
> > -_require_command "$KILLALL_PROG" killall
> >  
> >  _scratch_mkfs > $seqres.full 2>&1
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  function end_test()
> >  {
> > -	local f=1
> > +	_kill_fsstress
> >  
> >  	# stop duperemove running
> >  	if [ -e $dupe_run ]; then
> >  		rm -f $dupe_run
> > -		$KILLALL_PROG -q $DUPEREMOVE_PROG > /dev/null 2>&1
> > +		kill $dedup_pids
> 
> Hi Dave,
> 
> The $dedup_pids is a "while loop" bash process, it isn't the $DUPEREMOVE_PROG
> process itself. From my testing, this change might cause g/561 keep waiting
> $DUPEREMOVE_PROG processes forever, as $DUPEREMOVE_PROG not always be killed
> properly.

I have another patch that I didn't send that reworks duperemove
killing. I didn't sent it because I ended up simply turning the test
off via adding it to the unreliable_in_parallel group because it had
a 75% failure rate due to duperemove bugs (e.g. getting stuck in
fiemap loops that never terminate)...

> I'm wondering if you hope to do "pkill $DUPEREMOVE_PROG" directly? Or you'd
> like to copy $DUPEREMOVE_PROG to $TEST_DIR/${othername}_duperemove, then
> pkill ${othername}_duperemove ?

I came up with the "copy to $seq.binary then pkill $seq.binary" idea
after I gave up on this test as fundamentally broken. I'll revisit
it now that we have a reliable way of killing only the processes
belonging to the specific test. That might make this test
reliable enough to run concurrently, but I have my doubts...

I'll have another look at it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
