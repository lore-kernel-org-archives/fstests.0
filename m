Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7618C33C
	for <fstests@vger.kernel.org>; Thu,  5 Dec 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380138; cv=none; b=OdZePbUFPM6Dr02/+mYtlbNp+ZBW8/aCsb08Rzd98MDlW5/7eW8k72X/o71+S7t8b1Wb+geTNz9nueKNAOdxfgx1gHDNO9zrtl9vKq2wW/vHfXqZJCACZ+CSuqrRh4jwTs85akN/QlebXpb9YBasSdt9zbsih5FNuzfbpLNWiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380138; c=relaxed/simple;
	bh=LZjdNvU9/p8qu5kRMtYGvH0v47pIZ6J32LMK9QWYd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkZvg7zecXlSjwW1h/nST23wOaQzZd18xHqvCcW6ebgESbajFVJ+7iz7em8+b7dhIHMVaVHmW4esPNclHboChazJoXKbJ0F/4yhDxlyb9yk58kp2l6ehgsdw1j/8XvdzBMCfmrqysZ0RWrZwpe/UN03apTeERsUMslhkybjCWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2NjKhOuP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2NjKhOuP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee6abf124aso495605a91.3
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2024 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733380135; x=1733984935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT+9EgmIds4i8p5l/KzQganmAYbtEN8qNhJpVn1sy8Y=;
        b=2NjKhOuPUc7INUlc5/bK3J7v7fbnbEL3pi0oDJ/cTW3dmUTbfe2jfIfpSCJP3GOxF+
         3DRORmbSC2IbQVjCOeTS8TRCAQVxzcMccrS6VULmkQkF/Gnde1+Chag2TzxhMXX4O2PF
         KvWv2QCHqmzzLG2bZvPI2gWJisScrfMZjVfaxYaNj6/MGnVJAQOcL11+Kjori1E7HCeb
         gcLxtP0e5JTa1ZxnYyci9ox65evNAcCe/GvEUPLvwUq7SpOETyLKZym1hliyrRHRr4il
         0dVyd48jEc6Bj6//h/C22sQDngVZ/wZ/g2xu4+VCXQwHQxzk9Zo5EcWz1htKqNUrBUwI
         9DZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733380135; x=1733984935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+9EgmIds4i8p5l/KzQganmAYbtEN8qNhJpVn1sy8Y=;
        b=CWMm5N8N2EzNwCFPuYF7bz6+3xPrgzhOlW/IYi2bTdwJznkzU/53mdg4NbuorJuDQy
         SbH3qRcfTxgzehBsCRs3DY0BUF2QvBjYTsbHdofuMaD3gPhkyyH4Ijc1Nkfvt1OSm50a
         Jcb5DgoHPh8+64FWAw03KBpnS0OXacHkj5vil5QNjmrGGA0SzLV4VOeaQRX0YXxxCUGb
         x+BTGkr9YZfMfniD5z40rXalXMJhlDU+QMdlIkm+KBH0g2UJQneQt3sQUgXiEeTwCS7l
         PsliGQkW4QxXWPhGIWwFDRyOlNOV3Rf1ANjM7xZGQVGi2ZCzouikN4lg92KDwFKyzb4c
         0OFQ==
X-Gm-Message-State: AOJu0YzvCt1zPKbakgdodIwz6N1G5tnrBk/gFcP/so4dCcgzW8ljDG7N
	3kdi/WKDGkSlb4iBhSWQrNuxWPtkX1hzciRpkSFUxlJ9xF+9fdrBNBHrhcXpBbrCi+Pzyx94zJr
	x
X-Gm-Gg: ASbGncvn8v2CAkz0Axn9nXvgKdmGkAPLp5g1qtjU2rOFzuPATWzoltjYysax04Odl1H
	QLmT5KQP1mVBc/EnxIhGlZDxtZ/4L/t51M++iXziDwXOKLuF+s/pcjy8JmzAY/nNdF2ndSBOsDb
	gn1GwE5YixTw4grZe+OV7BK9JCnD80DSuq0QgR2XTXuXykLqGpYHL7zfurW9NKkotG0n/vvqOcr
	7IwV7zz4z4+ozUIVB3Dktw5xJDLLrXtxi77WBVs6YIRnppMVR3ZqnUy0l5ZqH1dKztBt+vsIWpv
	OSauOPmi4ZzRDXa4sA==
X-Google-Smtp-Source: AGHT+IHTxLw1bvDWsjZZGzxQzy9qr+k3wID7JZalJY3JVhvikv2CMTOxmT9YpeBAFeFgjxmDu9xhOQ==
X-Received: by 2002:a17:90b:3e83:b0:2ee:b8ac:73c1 with SMTP id 98e67ed59e1d1-2ef011db5f7mr11720116a91.2.1733380135359;
        Wed, 04 Dec 2024 22:28:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-218-149.pa.nsw.optusnet.com.au. [49.180.218.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm597511a91.36.2024.12.04.22.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:28:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tJ3ge-00000006ocD-45nN;
	Thu, 05 Dec 2024 15:42:00 +1100
Date: Thu, 5 Dec 2024 15:42:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 02/40] fstests: cleanup fsstress process management
Message-ID: <Z1EvGBRTcBa4yEEc@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-3-david@fromorbit.com>
 <20241204175715.56pvxgzeb243yodz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204175715.56pvxgzeb243yodz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Dec 05, 2024 at 01:57:15AM +0800, Zorro Lang wrote:
> On Wed, Nov 27, 2024 at 03:51:32PM +1100, Dave Chinner wrote:
> > +# Common execution handling for fsstress invocation.
> > +#
> > +# We need per-test fsstress binaries because of the way fsstress forks and
> > +# tests run it in the background and/or nest it. Trying to kill fsstress
> > +# tasks is unreliable because killing parent fsstress task does not guarantee
> > +# that the children get killed. Hence the historic use of killall for stopping
> > +# execution.
> > +#
> > +# However, we can't just kill all fsstress binaries as multiple tests might be
> > +# running fsstress at the same time. Hence copy the fsstress binary to a test
> > +# specific binary on the test device and use pkill to select that only that
> > +# task name to kill.
> > +#
> > +# If tasks want to start fsstress themselves (e.g. under a different uid) then
> > +# they can set up _FSSTRESS_BIN and record _FSSTRESS_PID themselves. Then if the
> > +# test is killed then it will get cleaned up automatically.
> > +
> > +_FSSTRESS_BIN="$seq.fsstress"
> > +_FSSTRESS_PROG="$TEST_DIR/$seq.fsstress"
> 
> Hi Dave,
> 
> I'm wondering if the "$seq.fsstress" can be unique name? For example, if generic/561,
> xfs/561, btrfs/561, ext4/561 run fsstress in parallel, won't they have same
> "561.fsstress", then "pkill -PIPE $_FSSTRESS_BIN" kills all these cases' fsstress
> processes?

Yeah, it's not entirely unique, but it was "good enough" to solve
the problem and move on to the next one. It should be easy enough to
change; the reason I used $seq was because it is short, and the
pkill man page says:

NOTES
       The  process  name  used  for  matching is limited to the 15
       characters present in the output of /proc/<pid>/stat.

It turns out that this 15 character limit doesn't appear to exist
anymore.  I just checked that file on a 6.10.7 kernel, and it
appears that there are full process names in there. pgrep (at least)
matches on process names longer than 15 character, so I suspect that
the man page is simply out of date here.

Hence we might be able to use something longer and more unique along
with 'pkill -x' to match the full name. i.e. this is a solvable
problem, but not critical to the effective working of concurrent
test running.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
