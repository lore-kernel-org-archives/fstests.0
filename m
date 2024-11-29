Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C71C01
	for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732850336; cv=none; b=GXtukVzejlY2kPHxEDfNzCAGDlLROR5bBf4UPWCjmXVbpRrKKTVcbE5iuXA4uG4spc09E2Zpimtmxf6GHtgTylGk5VBsROBxwIut/c+r5S8fgJsMLvvRI7mjfg2JV0Yd70c11gSD69nEHWsTYJMoSQTCFl7W5cXCmZ1VrbXz/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732850336; c=relaxed/simple;
	bh=zL/6Sd1osdLheJGHK+wrDAypWQxRCFqtmjPSIRpw9eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWv9dY3tfN9G2B1BLQyokPOibXxyCuZocCjpT969raIx0MLt9N3PScw6hryATdWSWAF9k7PQSiprKd7y8KWjn/3oV1SBInIfymvN5CZJf31OjS5Hb32CTvMX0JbsDHH8WHGGHFej9hwkjscaBbqNA2k3sZq0dYWCrSUwRU4Nlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/YRbubx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/YRbubx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732850332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LviedvwYudBbORCtgsSsmxxk70SLfPdrlJEw1bF4X0g=;
	b=H/YRbubxlyFXGj+8+68EeibbjDBa4qRDfZ4Z0zYafza9iT8D9gc4bEdDqBGpcIrI5DbG0O
	NUBQl7wS7lAJ4pNeLk/R+X3XFqVKHhOsV0YA1nmCOmkw/jpwVhRICEZs8XeD0QY2mLl4co
	wASjFb1KcvPBBwEpBRFkD5S5eLSYDw8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-1rx1QiMoPSeukUVnJQLE5g-1; Thu, 28 Nov 2024 22:18:51 -0500
X-MC-Unique: 1rx1QiMoPSeukUVnJQLE5g-1
X-Mimecast-MFC-AGG-ID: 1rx1QiMoPSeukUVnJQLE5g
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2152b7d22caso8029675ad.2
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 19:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732850330; x=1733455130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LviedvwYudBbORCtgsSsmxxk70SLfPdrlJEw1bF4X0g=;
        b=MDlamXmXDVBjm/E0UQiWmRKXUzVczaJ5tkkXWtO23YpYW2kTnsugEXqPstUQMs1j/w
         yXWKTh57ogo2ITxg/jqvITq19Hktyqwn2I2VmvCN8a+VJRSX76MddLYsiajf8BdPGv1b
         ewJGRlrMOKkRJALU9PcnVIKXKwbPO0O8A2wx4N1WvSVJ5gpNEXByVhkTQObv+47+/A4v
         /Hf9SE5kR26mhvct4s6El18W43OP9DZatKHWJ5xi5v4jxGshf1V2LN2vuYsPk/EYKOE4
         tkkgQIy/Jq3eL4uPM/0exlF2sjr0nnP04AElBTmz3ShUZinkA9qL9/K1LbVZRQaGWbR6
         t0JA==
X-Gm-Message-State: AOJu0YyGE/iAVP/CQT2q0swUZit1iX7CYMeLVUSrNqnzh+7tfQoE25fd
	L+pmrObtS8wNP8MBTXwSHZ5oEIpSTP6KzU4MGQ+o6zn/ku4ok+jrPlkPhoLNow+ff4y8YVjLed9
	shq+SQoOBKv7QaeDvRNgvGk39Csl4oWX4NqD7bnT3sIAEnXpu0739NH6dGFlKQZiX2Q==
X-Gm-Gg: ASbGncss6DV4v5vBOQk/OXJ97aHuLImEEMZJlrkuDjhmPwsl136lfD9k+yVmkAziEGQ
	sL+jYRYIu+PbPkjlRRiRaGvnxvQ02Ezybv1IWdci+UToRcf6exFPPfUAYWqCuBSdEVvlX16OrMj
	mC4C9Gy+zDf757TR8/7+F6SS2hJuo7ljtGr2NUZC3qjcssJzQBIh1oNcg4QO/r97x7jvIhwAzrr
	ZRLz5kyAkIzgIWzlxekbuFzRN04SnOiLytoe68qDRGK12Q5DIKrfZ4WWaTT6hLZhLPIoNLYxlo5
	mRCst3qt0/SB6Es=
X-Received: by 2002:a17:902:7241:b0:212:4aec:f646 with SMTP id d9443c01a7336-21501855dc9mr90407485ad.33.1732850329934;
        Thu, 28 Nov 2024 19:18:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG+wj9E1o4g3w8edcMZ3PVrhBpmeW7F8MD4RjCNQSxi5AWCmxdkObP4CHWeQrpFfjcoxST6A==
X-Received: by 2002:a17:902:7241:b0:212:4aec:f646 with SMTP id d9443c01a7336-21501855dc9mr90407245ad.33.1732850329565;
        Thu, 28 Nov 2024 19:18:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f2bsm21126145ad.93.2024.11.28.19.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 19:18:49 -0800 (PST)
Date: Fri, 29 Nov 2024 11:18:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <20241129031846.rije5u7o5o64v6gv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
 <Z0jS5zmObJTEWYTY@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0jS5zmObJTEWYTY@dread.disaster.area>

On Fri, Nov 29, 2024 at 07:30:31AM +1100, Dave Chinner wrote:
> On Thu, Nov 28, 2024 at 12:14:56PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > If we interrupt the test after it spawned the fsstress and balance
> > processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
> > kill them and they stay around for a long time, making it impossible to
> > unmount the scratch filesystem (failing with -EBUSY).
> > 
> > Fix this by adding a _cleanup function that kills the processes and
> > waits for them to exit.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/028 | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> IIRC there are several btrfs tests that run fsstress that need
> similar fixes. I fixed this problem for fsstress across the entire
> fstests code base in this patch I recently sent:
> 
> https://lore.kernel.org/fstests/20241127045403.3665299-3-david@fromorbit.com/
> 
> Avoiding needing to repeated rebase that work by having people
> randomly fixing one-off instances like this is why I'd like those
> large "fix everything" patches reviewed and merged sooner rather
> than later...

Sure Dave, I'll make an individual fstests release just for your big patchset next
week. This week I already prepared to have other patches. Your patchset will
be reviewed, tested (it changes many things) and merged soon, if there's not big
issue from it. Hope that makes sense to you :)

Thanks,
Zorro

> 
> Regardless,
> 
> > diff --git a/tests/btrfs/028 b/tests/btrfs/028
> > index f64fc831..4ef83423 100755
> > --- a/tests/btrfs/028
> > +++ b/tests/btrfs/028
> > @@ -13,6 +13,19 @@
> >  . ./common/preamble
> >  _begin_fstest auto qgroup balance
> >  
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.*
> > +	if [ ! -z "$balance_pid" ]; then
> 
> "! -z <var>" is the same as "-n <var>"
> 
> > +		_btrfs_kill_stress_balance_pid $balance_pid
> > +	fi
> > +	if [ ! -z "$fsstress_pid" ]; then
> > +		kill $fsstress_pid &> /dev/null
> > +		wait $fsstress_pid &> /dev/null
> > +	fi
> > +}
> 
> This really wants the balance_pid and fsstress_pid variables to be
> unset after they are killed in normal execution so we don't try to
> kill and wait for them a second time on exit.
> 
> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

