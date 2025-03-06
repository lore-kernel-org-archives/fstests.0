Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BB33FD
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268863; cv=none; b=K1/27N2Re60nj6hR18PaZtetidmxCIJ3Y2vOlb+hrb5cDkRl/GRHSbRkWIBI/W95Uc7xqOqhyOzXNS+TacfwcwYGX+xNLUGOUJ8B6mmmkJTYHyuBgiNQSFwxFY2H2rdz5ts/TQwC+ZF985nPzJCVbsKXIL+ILK4ziMT58TeqLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268863; c=relaxed/simple;
	bh=aeTxOhekU0TsvLjs1tGH7Rt7tFztqZlpWPZ5htDT12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2jVo8MJgL/n6SGl75VEF6FOzZGnmI1oyQ+RYPPjufAnKo6MxWFHavNXgZRAqPWFUxqfg7KTSl8gCfm20luHl/gJvwyipvl8ZvRajRzNh7YK6fyyxSIljmo4RkHwFhqMonAnQ6jukpSijg/sJ92r5ODsNBs5eYqeBgwfipYM88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2IwOP5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2IwOP5r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741268859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WG4oCsBUCyn7PT0di78atmnNB+eU30z15aB5vuM31g=;
	b=J2IwOP5r2Ymso+SpKKgqay8y8YbjKx1YtaJyBbZPDBYvOHm5XNpyrB2tHr88dEY+p4WAK1
	vDVn04SwtbxHdgBXAKblf0ubJAHQZriyUXl9bjDYWYF4nu+F/xsaREyeV76Me0NLuS65YY
	8QZYQF16mbybIdXj2pkqOO881cR+UH8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-9F030Vm5ND6WZAJAzF4g-g-1; Thu, 06 Mar 2025 08:47:28 -0500
X-MC-Unique: 9F030Vm5ND6WZAJAzF4g-g-1
X-Mimecast-MFC-AGG-ID: 9F030Vm5ND6WZAJAzF4g-g_1741268847
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2236b6fb4a6so20832995ad.2
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 05:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741268847; x=1741873647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WG4oCsBUCyn7PT0di78atmnNB+eU30z15aB5vuM31g=;
        b=vM+ozXOj/s94wWja2BbIiINhaNJV0CgPcnnjqVX+/XwjOrUor4TFmd0iQKmbypKtaM
         njGiC18QGlmNusH1FoObk7A+xkhMwu02LaJLQPR1ybdJiUWtTeRhcWZ6vVk9jzj7Iro8
         Ypb0v2k0LNYL2YNeq6OYy8TySWX6iAWdO8betwspfyCugGUQKbyLik5/Ye+X66bAxZjH
         ncT+IVUS16wshTL80o8lGDa/rCCAhJLG1kZ9BqM8AMdUZOzAu/jFO/fDmqoJwJJXHmfk
         1Qm6rbmgIWNERn+F6y4u6LWB8zj42vLKOcltkTkVcuu8f398WdAmlnzI/mGOPTp2SByw
         O1sg==
X-Forwarded-Encrypted: i=1; AJvYcCVX8hSISQSbZLsZhpiziTK7W9ftqaAqmA3RkwFq4x15Vvz5sjDZTFRo7FLBt2db2LNvskdBX0cG@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTTpJr0QkFVTBxi3wQulmgoyVK6GHF6SxtAx7mdwq838dihMd
	Lbf7n4qOz9AjrZUkIOi6p29IrLRO7uO4DxHq2UEDigXEj3sBHMnIcbODRfQkxeN7y+Mie/ul171
	UVdakpxDY8CIp1a8coujhJaMclBRN9+XHk5AApKGg/suCnuA1l5uG3LQ=
X-Gm-Gg: ASbGnctMmDweLOnOwAzNAPy9JuOZUpVL8jWE5pSY83s/Xg8QeK6R9tCcyRCl60A85Em
	BC4JJwlPrOuhtTCnaADDklTmJNm/PC69erNu8hfvJgvkyy/XfEeIXH4M2FJEBTnC8v0yy21KNcH
	JaN+a52cNcoacNqOontjkv6G/JtvmqAu7lTBBPiD+SQ2naPvBqk0I+bsbm0u/MJA5wu3mvofR8L
	xBtamRamR79a/E8yARMaZw0nOgS98F/kHbFqWK97+kzqsb0kVqsajx/oWCF4puz9GDb150IqXno
	rmwKVHafKdytMaPrjtf61MHkVAmi3ZV3CMwPqHLznNQ3JlJBqU3sX+Y4
X-Received: by 2002:a17:902:d489:b0:220:e5be:29c7 with SMTP id d9443c01a7336-223f1cf42e6mr109631935ad.39.1741268847153;
        Thu, 06 Mar 2025 05:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoF1DeIz/SGFVhCTFS6IVUbiVjLtHL51h6KAEIFC9HMulKuprn12tjyxMjeWKjFPwNrL6TRA==
X-Received: by 2002:a17:902:d489:b0:220:e5be:29c7 with SMTP id d9443c01a7336-223f1cf42e6mr109631575ad.39.1741268846750;
        Thu, 06 Mar 2025 05:47:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fa24sm12143055ad.108.2025.03.06.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:47:26 -0800 (PST)
Date: Thu, 6 Mar 2025 21:47:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Message-ID: <20250306134723.x5fovpzmzemleyi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306094924.1353269-1-zlang@kernel.org>
 <20250306094924.1353269-2-zlang@kernel.org>
 <Z8mBacJNAj6gVd7N@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mBacJNAj6gVd7N@dread.disaster.area>

On Thu, Mar 06, 2025 at 10:05:13PM +1100, Dave Chinner wrote:
> On Thu, Mar 06, 2025 at 05:49:23PM +0800, Zorro Lang wrote:
> > Currently we have 3 ways to run a test case in _run_seq():
> > 
> >   if [ -n "${HAVE_PRIVATENS}" ]; then
> >       ./tools/run_privatens "./$seq"
> >       ...
> >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> >       systemd-run --quiet --unit "${unit}" --scope \
> >              ./tools/run_setsid "./$seq" &
> >       ...
> >   else
> >       ./tools/run_setsid "./$seq" &
> >       ...
> >   fi
> > 
> > The "privatens" way brings in some regressions. We need more time
> > to develop and test this way, it's not time let it to be the
> > first default choice, so isolate the HAVE_PRIVATENS initialization
> > by a TRY_PRIVATENS parameter, and disable it by default.
> > 
> > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > old ways. This patch can be removed after "privatens" way is stable.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  check | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/check b/check
> > index ea92b0d62..cb2f19d08 100755
> > --- a/check
> > +++ b/check
> > @@ -674,10 +674,13 @@ _stash_test_status() {
> >  	esac
> >  }
> >  
> > -# Can we run in a private pid/mount namespace?
> > -HAVE_PRIVATENS=
> > -./tools/run_privatens bash -c "exit 77"
> > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > +# Don't try "privatens" by default, it's experimental for now.
> > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > +	# Can we run in a private pid/mount namespace?
> > +	HAVE_PRIVATENS=
> > +	./tools/run_privatens bash -c "exit 77"
> > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > +fi
> 
> Works for me - I have basically the same patch in my check-parallel
> stack because this breaks check-parallel mount namespacing for
> reasons I don't yet understand.
> 
> Creating a new mount namespace for each test that is run appears
> to turn the private mount namespace that each check instance is
> executed in back into a globally shared mount namespace inside
> each individual test mount namespace.
> 
> i.e. when check uses private namespaces I can see all the mounts
> from inside each test namespace from the init namespace and every
> test can see every mount that every other test runs again.
> 
> That is the problem I originally used mount namespaces in
> check-parallel to avoid.
> 
> I have no idea if this is how mount namespace nesting is actually
> supposed to work (seems completely broken to me!), but the only
> solution I've found that works so far is to turn off HAVE_PRIVATENS
> in check as it is redundant when it is run from check-parallel.
> 
> FWIW, given that check-parallel now runs in it's own private PID
> namespace with it's own /proc and /tmp, the original problem of
> needing to "confine pkill to only the child processes of this test
> instance" has gone away entirely. i.e. check-parallel does not need check to
> to restrict pkill to children of the current test being run anymore.
> 
> Hence I think we can probably remove the new process isolation
> shenanigans and revert the _pkill wrappers to plain pkill calls
> again as the private PID namespacing the check-parallel does means
> pkill does the right thing for both check and check-parallel now.

Hi Dave,

Thanks for your reviewing. Do you mean revert below commit directly?

  commit 247ab01fa227647c290cf82696f1b0bbf87a0177
  Author: Darrick J. Wong <djwong@kernel.org>
  Date:   Mon Feb 3 14:00:28 2025 -0800

      check: run tests in a private pid/mount namespace

I isolate the HAVE_PRIVATENS rather than reverting it, due to I'm not
sure if you or Darrick still would like to improve that test way.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

