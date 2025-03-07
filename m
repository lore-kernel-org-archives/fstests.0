Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB40DF71
	for <fstests@vger.kernel.org>; Fri,  7 Mar 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362457; cv=none; b=fJJUH1ghfO6jDjZUMWbANfsDVZLvsIOW65pSPSzZXGdzQ85wTFrjAS5sTo0QhTyUBlyrYDoetXG5uv0YW9TEXJRGWlQaTWgz8k9ONihUmAoTR3sGCOqx3PrXQLQF2UtECPWsawrduN8N8SElgqTA6PcHeILhkOLLQtn5Bb6RoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362457; c=relaxed/simple;
	bh=Mk2UaEka+WdAhxKWWqVAfpSVCa8racwnlijTLE0H9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ40XdKLkk/i7zwlxaDJY8wBjPxJvjQ4mRF+PFfEPLo6VhjVhcRrroH1EAkhAMiQKX0hvt1je3uyiHqrbi7LMCxfFjFVHjhbtctDISQIW8q9OOnMJpfG+zy09zntXqygNlpZQmiJ+fiosdc1jJ9fqCkbzcFv/yE4iUMrk5MLmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyPTbV1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyPTbV1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741362453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUOHyNehYUC0/Y/aqolCS7r50W1zQSZBmzY0RfQ11Mc=;
	b=MyPTbV1CrQf2GsIfHI+6pNWBRD6ku35qOrm9iHv2ampbkYHCvPAf7LfVoTj/KZFeTlXY8r
	QL7UIJs+bPB1xibA7F+Q9MIjAjo+UmeCxRniAh45oazweyMO+qIeoQoOrOMYf+1wnuhwa2
	YoiQl3Ltg8Xw0kJbL+sV3Z+E2t0HCJE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-VHJyYLMxN4C7iZhO64xzHg-1; Fri, 07 Mar 2025 10:47:29 -0500
X-MC-Unique: VHJyYLMxN4C7iZhO64xzHg-1
X-Mimecast-MFC-AGG-ID: VHJyYLMxN4C7iZhO64xzHg_1741362448
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso2280118a91.2
        for <fstests@vger.kernel.org>; Fri, 07 Mar 2025 07:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362448; x=1741967248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUOHyNehYUC0/Y/aqolCS7r50W1zQSZBmzY0RfQ11Mc=;
        b=UeVXYHzrYG3CRUm09M7XYgXR8n4iDjLWwWLIV96jodu0YE74P81hW31svuOsh6z5RA
         l8bm14WTkDD5liBoCSawpSUSTgYLB32dABwY6ERMwQ0b27B5BxGAZyqZIv2S8BQvYkMX
         8djJ3Sasjv06iB6yeEQHKh6NmX68zZcDoFd8ghPHcbtbkiL69dSFm+x8tqUG+VaC5Px+
         Z3sVDyFlU+1Vs6Pqt6BuRbpT1tGPmVX2PXP62aSv8ox+xAeJjzSgGEHdREvDDLY5Rd8G
         NLV7vXFwo4V6ncUmkK2T41DnuWThUY3EzGqClmHlkO6XDi4cJDr0lw+0BHpK1jrk5nLn
         wrZg==
X-Forwarded-Encrypted: i=1; AJvYcCUuAilTagLE7v4BqozQl8Z/iuDdGPkOkXIqmUXqIzvgKd56gDILtkWYs3gxFtx+ReaQWJZUNI2R@vger.kernel.org
X-Gm-Message-State: AOJu0YxAC7GeXYOfJ3b6gRvHYqMs1J9jSdEQqJ/83bXJhaBkPDsmHtSY
	owEF1W0UZUXh9q4JiV687Ylk355zlMvtTb9PiL6oJzL633sQeDFw5bpMoxKI61OmuFHkoEnkE9v
	fcOBtTLl2h1O488uIeMK5n5mF7XGdhQ/og9PL3Si1J3cP3w3vU4wZBVg=
X-Gm-Gg: ASbGncuCb0swwcHOrDJ82gAcAJeX2W9Ykyq0jk/wMysesAMVI4QxzMuZNnZzyokxUA+
	9hqN7u8R2kmecLAwBX06UV/NPnJ083D7ZQ/ZY+TYQCP0V75OoN32r8oTretJ7mcsDVf8Wa2k3Ut
	ZCb95kt+et7d3ZKCpR9vDzfZmUPRjyomEq1trnrKxypSTZRbASeOJnhhsuAIuJmKVo+hkzPRRdb
	MK5DYuGj56zEjUNVj9WhI3RsU6PmUoEv61AOD1cpLTWDyCieMr8ZRsQBPskOIUFY02kPs1CWHI0
	OBhMqud3Nd5VMRF/5TmVCBoyrF7k8DjS6WitLcg8iXxATtELMYukl2YG
X-Received: by 2002:a05:6a21:32a7:b0:1f3:4667:7288 with SMTP id adf61e73a8af0-1f544c8bdd4mr6802780637.10.1741362448067;
        Fri, 07 Mar 2025 07:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGodKvguIVTazqbr/K52LVu1yCZWLSnednc6fs3fmFDXnOYyKIbLMmzvzqifO4wlN458cPNsw==
X-Received: by 2002:a05:6a21:32a7:b0:1f3:4667:7288 with SMTP id adf61e73a8af0-1f544c8bdd4mr6802619637.10.1741362446164;
        Fri, 07 Mar 2025 07:47:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369d4b978asm3038413b3a.28.2025.03.07.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:47:25 -0800 (PST)
Date: Fri, 7 Mar 2025 23:47:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Message-ID: <20250307154722.iafm7hm7qo6x54c3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306094924.1353269-1-zlang@kernel.org>
 <20250306094924.1353269-2-zlang@kernel.org>
 <Z8mBacJNAj6gVd7N@dread.disaster.area>
 <20250306134723.x5fovpzmzemleyi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Z8oL_LAc9XQsKwd-@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8oL_LAc9XQsKwd-@dread.disaster.area>

On Fri, Mar 07, 2025 at 07:56:28AM +1100, Dave Chinner wrote:
> On Thu, Mar 06, 2025 at 09:47:23PM +0800, Zorro Lang wrote:
> > On Thu, Mar 06, 2025 at 10:05:13PM +1100, Dave Chinner wrote:
> > > On Thu, Mar 06, 2025 at 05:49:23PM +0800, Zorro Lang wrote:
> > > > Currently we have 3 ways to run a test case in _run_seq():
> > > > 
> > > >   if [ -n "${HAVE_PRIVATENS}" ]; then
> > > >       ./tools/run_privatens "./$seq"
> > > >       ...
> > > >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> > > >       systemd-run --quiet --unit "${unit}" --scope \
> > > >              ./tools/run_setsid "./$seq" &
> > > >       ...
> > > >   else
> > > >       ./tools/run_setsid "./$seq" &
> > > >       ...
> > > >   fi
> > > > 
> > > > The "privatens" way brings in some regressions. We need more time
> > > > to develop and test this way, it's not time let it to be the
> > > > first default choice, so isolate the HAVE_PRIVATENS initialization
> > > > by a TRY_PRIVATENS parameter, and disable it by default.
> > > > 
> > > > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > > > old ways. This patch can be removed after "privatens" way is stable.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  check | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/check b/check
> > > > index ea92b0d62..cb2f19d08 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -674,10 +674,13 @@ _stash_test_status() {
> > > >  	esac
> > > >  }
> > > >  
> > > > -# Can we run in a private pid/mount namespace?
> > > > -HAVE_PRIVATENS=
> > > > -./tools/run_privatens bash -c "exit 77"
> > > > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > > > +# Don't try "privatens" by default, it's experimental for now.
> > > > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > > > +	# Can we run in a private pid/mount namespace?
> > > > +	HAVE_PRIVATENS=
> > > > +	./tools/run_privatens bash -c "exit 77"
> > > > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > > > +fi
> > > 
> > > Works for me - I have basically the same patch in my check-parallel
> > > stack because this breaks check-parallel mount namespacing for
> > > reasons I don't yet understand.
> > > 
> > > Creating a new mount namespace for each test that is run appears
> > > to turn the private mount namespace that each check instance is
> > > executed in back into a globally shared mount namespace inside
> > > each individual test mount namespace.
> > > 
> > > i.e. when check uses private namespaces I can see all the mounts
> > > from inside each test namespace from the init namespace and every
> > > test can see every mount that every other test runs again.
> > > 
> > > That is the problem I originally used mount namespaces in
> > > check-parallel to avoid.
> > > 
> > > I have no idea if this is how mount namespace nesting is actually
> > > supposed to work (seems completely broken to me!), but the only
> > > solution I've found that works so far is to turn off HAVE_PRIVATENS
> > > in check as it is redundant when it is run from check-parallel.
> > > 
> > > FWIW, given that check-parallel now runs in it's own private PID
> > > namespace with it's own /proc and /tmp, the original problem of
> > > needing to "confine pkill to only the child processes of this test
> > > instance" has gone away entirely. i.e. check-parallel does not need check to
> > > to restrict pkill to children of the current test being run anymore.
> > > 
> > > Hence I think we can probably remove the new process isolation
> > > shenanigans and revert the _pkill wrappers to plain pkill calls
> > > again as the private PID namespacing the check-parallel does means
> > > pkill does the right thing for both check and check-parallel now.
> > 
> > Hi Dave,
> > 
> > Thanks for your reviewing. Do you mean revert below commit directly?
> > 
> >   commit 247ab01fa227647c290cf82696f1b0bbf87a0177
> >   Author: Darrick J. Wong <djwong@kernel.org>
> >   Date:   Mon Feb 3 14:00:28 2025 -0800
> > 
> >       check: run tests in a private pid/mount namespace
> > 
> > I isolate the HAVE_PRIVATENS rather than reverting it, due to I'm not
> > sure if you or Darrick still would like to improve that test way.
> 
> I'm talking about removing all the setsid and namspace bits that we
> added to try to solve the need for pkill --parent. i.e. this series
> of patches:
> 
> 949bdf8ea check: deprecate using process sessions to isolate test instances
> 247ab01fa check: run tests in a private pid/mount namespace
> 88d60f434 common: fix pkill by running test program in a separate session
> c71349150 common/rc: hoist pkill to a helper function
> 77548e606 common/rc: create a wrapper for the su command
> 
> Using private PID namespaces in check-parallel has solved the
> original problem that required the pkill --parent usage and the
> fsstress binary rename/copy workaround by wrapping process isolation
> outside of each check instance. Hence check and the internal
> check infrastructure doesn't need to ever care about process
> isolation to solve this check-parallel problem anymore.

If "check" doesn't need these namespace isolation things, that will be good
to me. That'll help to isolate the issues on check or on check-parallel.
And we won't bring in regressions to check when try to fix check-parallel.

Now let me merge this patch at first, to avoid the regressions on btrfs.
Then please feel free to send patches to remove/reduce the coupling of
two testing ways (check and check-parallel:)

> 
> i.e. the isolation fix should have been made to check-parallel,
> not to check.
> 
> It is not ideal to have to walk all this stuff back, but this is
> what happens when an RFC-scope feature prototype is merged without
> allowing adequate time for review or give the author a chance to
> address at least one round of review comments and bug fixes before
> it gets merged....

Sorry, I've learned from this. I thought I've given it lots of test,
and fixed all bug reports at that time. And I asked several times
if there's any objection about merging it in next release. As there's
not objection from anyone in 2 weeks, so I decided to give it a chance,
to save the super complicated rebasing workload... Anyway, next time,
for each complex patchset on infrastructure, I'll always give it 3+
release cycles time. And never merge it if without 3 acks from xfs,
ext4 and btrfs, as there're too many different test ways I can't test
cover. Sorry again for the mess this time, hope we can back to track
soon.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

