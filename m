Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B377211708
	for <fstests@vger.kernel.org>; Thu,  5 Dec 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393235; cv=none; b=jIKblWUxO/k+BKR0xjiICYh80l6UlnLzPhhnmGrbISTkFt50aH+KoHmUG0L48vbDhoBWLww10Sa3rMhSqMnvgUgxH9TX5EH21YOHcZWzlC+3uDc/78bX46h3TR6KIo+6LHb0QrQcuAatgueHQovw+9MN8tI+pI9l2d4C++NrtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393235; c=relaxed/simple;
	bh=Yyo3lOkF/kpwYvuob4SigKJQ6shSgKqB9DLAEPM4iVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU6Yl0hXpTZ7vquX0/DhLgVgMr9PPMztUeDOQFjTe/c0n3jNN9nLhn5S3M3xZS6YS7ZMSzQXVc4uQCwtCBXRupNjuUGkSuI4Or3kCD2c6P10RqUyplFl7cK0dRJ58YzlY8Kv2hT4JaHoUTrh98+KcfiRP0OuzkgAz2hgQj1cyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0VU/MPv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0VU/MPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733393228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yHaiiVl/OTuXzlqn0/h+QxIlzVoHEaq5mS8Hw/tBnU=;
	b=Q0VU/MPvYkLaa5uRsGEM+S7VWD5Hxp9ufAdVIzWxjToKbXDW0ZPvZGssf8JcS7gItLKqu7
	BaS7kyF10AvQHmFs4d24/QdNLouO2Q5donSwsaNQr7meiQTfIRNXJFAj6vnPudi9IB72e4
	m9lEePxVXncGizvbfYJ5hFSxfpobf4g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Ik4ZAafLNeGroD415FH8wQ-1; Thu, 05 Dec 2024 05:07:06 -0500
X-MC-Unique: Ik4ZAafLNeGroD415FH8wQ-1
X-Mimecast-MFC-AGG-ID: Ik4ZAafLNeGroD415FH8wQ
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so1219453a12.2
        for <fstests@vger.kernel.org>; Thu, 05 Dec 2024 02:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393164; x=1733997964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yHaiiVl/OTuXzlqn0/h+QxIlzVoHEaq5mS8Hw/tBnU=;
        b=r6xEyZ2FCWUeaU+6Nn5RSgLmRJ6eB6GP3DAghHQvayUumm2VvZk8ORMBVknoJ4gGvm
         0qhTCTZayTPsrVg+Nc2YqedqpIZP9sadRNRrcmkGNzKsKQZ85AEx25x7WpGsvo9yRq3Z
         yqL8wdL1fZX6X1KvPW6DXDPKs0DvjKQGOEXeu2eTNKFWZFFsvhIs7nl9AhaRs8MzvfYh
         lc6pQcpYfsqhNjVVytteni6TRuQeOeEzjQ8zjxKfaoNyKl13a8ERzc8Ye7RkbQoxhIXa
         KZmYfDxLLd1lr298zJFbgoRs8q5V+gwxAhng5944zWKyjPDXpJqJAdtSNaS9GUFF4jqY
         WuEQ==
X-Gm-Message-State: AOJu0YyNjt8RyrG3GWRIuolmJ9dNuVQsXW77qRs7u2FywDAnaKFNOyzS
	KtgMhoUCY3YulmHvkk5bMBIwu57ofpZK/oTTdUC5h/gSPKJ16DE0T2LhXbH7Os9Rv9akd7jV0tX
	Lsk0zbmyMlff3Z3o/NV676EvvLv9TrV+d+oSXxwznKMUbCnDTRxnxfts3s9rKWQImNg==
X-Gm-Gg: ASbGncsoklqrjh5f4udH4Sl5Hi/ExTghKq0zSljv92Z3HnSZdnTeaLxQSvua3krrvuN
	QuQS8/kbWxPUbQSmJB7AIBNebzJ5fvtYVh0Ys9Ei8ID77UHz60e2xFYSX+0ceoloPEXTd/nOoRD
	VFJwXZmksLR6gpstrn6WXsY01vUzB5NWRVN4NWrv/CL2NABUC7aat/ye4qOXEF6Cwv0Pvn0oc6n
	z2e/7RK/OdfEm3SgLUHtgzcSrgJcBo+EjMPJva0G6jRF50JBQUeRIlRgSEkL9StBqfWyvWuk5G3
	xndPWtqJ8+d+FG0=
X-Received: by 2002:a05:6a20:2590:b0:1d7:ca7:bfce with SMTP id adf61e73a8af0-1e165410fafmr12349651637.42.1733393164662;
        Thu, 05 Dec 2024 02:06:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuMfsu6x0UDs6K2276qwty8l6HpkQEkWyPPUyr7KloEUUffSKSN4jA5swBNxU8IvdTfBA3dg==
X-Received: by 2002:a05:6a20:2590:b0:1d7:ca7:bfce with SMTP id adf61e73a8af0-1e165410fafmr12349324637.42.1733393159347;
        Thu, 05 Dec 2024 02:05:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1a52sm835454a12.33.2024.12.05.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:05:59 -0800 (PST)
Date: Thu, 5 Dec 2024 18:05:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <20241205100556.ecj2d7mx7jn3bdl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-3-david@fromorbit.com>
 <20241204180435.qequx4dbnhz3a2bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Z1EyVTXPczqg2u0s@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1EyVTXPczqg2u0s@dread.disaster.area>

On Thu, Dec 05, 2024 at 03:55:49PM +1100, Dave Chinner wrote:
> On Thu, Dec 05, 2024 at 02:04:35AM +0800, Zorro Lang wrote:
> > On Wed, Nov 27, 2024 at 03:51:32PM +1100, Dave Chinner wrote:
> > > diff --git a/tests/generic/561 b/tests/generic/561
> > > index 39e5977a3..3e931b1a7 100755
> > > --- a/tests/generic/561
> > > +++ b/tests/generic/561
> > > @@ -13,9 +13,9 @@ _begin_fstest auto stress dedupe
> > >  # Override the default cleanup function.
> > >  _cleanup()
> > >  {
> > > +	end_test
> > >  	cd /
> > >  	rm -f $tmp.*
> > > -	end_test
> > >  }
> > >  
> > >  # Import common functions.
> > > @@ -23,28 +23,20 @@ _cleanup()
> > >  . ./common/reflink
> > >  
> > >  _require_scratch_duperemove
> > > -_require_command "$KILLALL_PROG" killall
> > >  
> > >  _scratch_mkfs > $seqres.full 2>&1
> > >  _scratch_mount >> $seqres.full 2>&1
> > >  
> > >  function end_test()
> > >  {
> > > -	local f=1
> > > +	_kill_fsstress
> > >  
> > >  	# stop duperemove running
> > >  	if [ -e $dupe_run ]; then
> > >  		rm -f $dupe_run
> > > -		$KILLALL_PROG -q $DUPEREMOVE_PROG > /dev/null 2>&1
> > > +		kill $dedup_pids
> > 
> > Hi Dave,
> > 
> > The $dedup_pids is a "while loop" bash process, it isn't the $DUPEREMOVE_PROG
> > process itself. From my testing, this change might cause g/561 keep waiting
> > $DUPEREMOVE_PROG processes forever, as $DUPEREMOVE_PROG not always be killed
> > properly.
> 
> I have another patch that I didn't send that reworks duperemove
> killing. I didn't sent it because I ended up simply turning the test
> off via adding it to the unreliable_in_parallel group because it had
> a 75% failure rate due to duperemove bugs (e.g. getting stuck in
> fiemap loops that never terminate)...

Great to know you've noticed that :)

> 
> > I'm wondering if you hope to do "pkill $DUPEREMOVE_PROG" directly? Or you'd
> > like to copy $DUPEREMOVE_PROG to $TEST_DIR/${othername}_duperemove, then
> > pkill ${othername}_duperemove ?
> 
> I came up with the "copy to $seq.binary then pkill $seq.binary" idea
> after I gave up on this test as fundamentally broken. I'll revisit
> it now that we have a reliable way of killing only the processes
> belonging to the specific test. That might make this test
> reliable enough to run concurrently, but I have my doubts...
> 
> I'll have another look at it.

Currently only generic/561 runs duperemove in background bash, if you don't have
time to change it this week, I can help to change it to use the "copy to
$seq.binary then pkill $seq.binary" way temporarily, to avoid a test blocker.
Due to I want to merge your patchset ASAP in this week. Then we can move on.
I don't want to let you or others do much rebase jobs :)

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

