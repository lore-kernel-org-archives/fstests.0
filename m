Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20511DDC18
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294596; cv=none; b=uLINMaORefp2sMATVhAAFo1XAPqWaUOb3pLGCOipYbSefAqxQub37iqLbtPT5DKBsmYI4lIIu4MnG6Zf3AvcQgWX8dBpao6t7U7R4p/oixi81HU66F8PEAMmcKEqvkaTc69Shq23kwuEDgbhriORt/Ui6LwIbF/GB7PJOOSiN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294596; c=relaxed/simple;
	bh=ptYdHyXO3N9/ihNHLuoELVhKoWDcOiZzxs1ii/lBkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsMCmsWOHjv8SLy7QNvdPD1AUSbW+qDXm00wJSSQ1ySiRTAFQJBkVp0FRtD2QpN3eQsQRLmWZ3u9mCFGUQSgrQR/aG7itT3MpGsbSYqF+Tq/Uyo9Q4RisQw17ki4C5cnvaVIvvYFOlWeYepCTgpUmA9useH07C9vU6HA72JRFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EulTkPe+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EulTkPe+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so22542405ad.0
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741294594; x=1741899394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWkuK59BmG6tUseO2dcBFkVYSyEAR5JFieinStVjkqo=;
        b=EulTkPe+FsRO9lZYRKfx4GFo9V0s3VX1+lDj7pq/cmyaydrDzUxYS8JxJ+Dlw4K9pv
         L/nEBbkfg8mVuV8AtxBrh1bLMKozdPMeM3Mo7RaIdHakfTi5Zc/pFphdBVnqXZ9qqACV
         y/52o6gLvxqVwbDdOJ8NF42GA3Bi91JiDhaSCPEone07p7j0gHZjAjm7yE6Ow8fNt1H5
         RocSxMUP2ZsVpElY8syrk+F8gROvCP043IrMt6TPSvjbR1UkHWIageHbyVQtP0ozFlMp
         6V3qtemyGeT+e7Ey+Kv9mrGslqYF3DEG0ACA7TzpkWzRS4kUh3axLwmDC3xkgi/tVPjA
         +zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294594; x=1741899394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWkuK59BmG6tUseO2dcBFkVYSyEAR5JFieinStVjkqo=;
        b=KFg5DodG4LXvfxoOPWAhFB41p1va7+385vSVoqp/850l5AWug/c1MZoTa2SWwRJUZV
         E/mGsPYAAbAWC0ToH2a6cKpXc02OyvuJkO9nVygZ3SK/DbXGdsDSqzP2k9b5X/Xucncr
         8V580/DLWgyahYjTPt0C43BEhF4BfcrYJShwENVT2dKEt/PJNeQ9q5TfKm3rugReWtln
         JtK9pwbYfSjXT5L0moMB0sxFiPEqDIS+tST7lEDkENzwKp/u5jG2Ld8omvqM5UgxP0BU
         ZKQoblKG9rwEKw+gnrE9dc0NDaUDbaPNng3lILxs/xp80WTGn39PJAMyYFt6ghDeCLg6
         gfGA==
X-Forwarded-Encrypted: i=1; AJvYcCXLpKzt4ja0JSedd1Z0TczJcquOaZ6/7mwTp3qeDAZpdMpqx0x2/RJP3v3l2XNHlmWCtUpZ6rAk@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0U42O+Err9Wt/DBlGHXaCxbmvCevZCRg1Cz4yDH2trNzOJnO
	8LN1M7ILKzMgjAw1zUwxnhPhSYYiMn7CgYJg5UrZYbGJJtCaK7pzcctzUbRLSko=
X-Gm-Gg: ASbGncs67oBEoXapxktnrYA0eHvUTnrrVO0OuheskdrtPUGy+0aySRvSUXgNFnHwMgN
	c20aTTT1FqJDiyCbRCeV5lYy2HZnNaDXdVq/4C+LMw4H1IRo54DD3Bbj7PgbVgIkgj7hhvwu/Ep
	+fqya5p+Q4vfE06/mJVQE1A+Hb2o/CBY74dc093vBmRp/fnHthoj06iRxahQkgfvPEv7gVWgiiZ
	LcNP06PWVOAcle7n8DHGGWc8jwZF6tpwAaMuMZ6EEt2sG+gH9UHX1a1rwX3LkV9CwKzGLAbThOK
	A7Ngu/miZQfHZ3WCZY8+ZbYDU78Gt2KdrRJcWASVHjJxEIhWJ1reUg==
X-Google-Smtp-Source: AGHT+IFGPaHwyTHDYtih2rmrwO3xU0589/pntjcgAvCfvYwuTrGIeV8fb8J5anrk6rC9M/rC+fbAfQ==
X-Received: by 2002:a17:902:e750:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-224283ffb11mr14529315ad.0.1741294594051;
        Thu, 06 Mar 2025 12:56:34 -0800 (PST)
Received: from dread.disaster.area ([49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109eab91sm16999515ad.95.2025.03.06.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:56:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tqIGa-00000009ki3-45pz;
	Fri, 07 Mar 2025 07:56:28 +1100
Date: Fri, 7 Mar 2025 07:56:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Message-ID: <Z8oL_LAc9XQsKwd-@dread.disaster.area>
References: <20250306094924.1353269-1-zlang@kernel.org>
 <20250306094924.1353269-2-zlang@kernel.org>
 <Z8mBacJNAj6gVd7N@dread.disaster.area>
 <20250306134723.x5fovpzmzemleyi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306134723.x5fovpzmzemleyi3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Mar 06, 2025 at 09:47:23PM +0800, Zorro Lang wrote:
> On Thu, Mar 06, 2025 at 10:05:13PM +1100, Dave Chinner wrote:
> > On Thu, Mar 06, 2025 at 05:49:23PM +0800, Zorro Lang wrote:
> > > Currently we have 3 ways to run a test case in _run_seq():
> > > 
> > >   if [ -n "${HAVE_PRIVATENS}" ]; then
> > >       ./tools/run_privatens "./$seq"
> > >       ...
> > >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> > >       systemd-run --quiet --unit "${unit}" --scope \
> > >              ./tools/run_setsid "./$seq" &
> > >       ...
> > >   else
> > >       ./tools/run_setsid "./$seq" &
> > >       ...
> > >   fi
> > > 
> > > The "privatens" way brings in some regressions. We need more time
> > > to develop and test this way, it's not time let it to be the
> > > first default choice, so isolate the HAVE_PRIVATENS initialization
> > > by a TRY_PRIVATENS parameter, and disable it by default.
> > > 
> > > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > > old ways. This patch can be removed after "privatens" way is stable.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  check | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index ea92b0d62..cb2f19d08 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -674,10 +674,13 @@ _stash_test_status() {
> > >  	esac
> > >  }
> > >  
> > > -# Can we run in a private pid/mount namespace?
> > > -HAVE_PRIVATENS=
> > > -./tools/run_privatens bash -c "exit 77"
> > > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > > +# Don't try "privatens" by default, it's experimental for now.
> > > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > > +	# Can we run in a private pid/mount namespace?
> > > +	HAVE_PRIVATENS=
> > > +	./tools/run_privatens bash -c "exit 77"
> > > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > > +fi
> > 
> > Works for me - I have basically the same patch in my check-parallel
> > stack because this breaks check-parallel mount namespacing for
> > reasons I don't yet understand.
> > 
> > Creating a new mount namespace for each test that is run appears
> > to turn the private mount namespace that each check instance is
> > executed in back into a globally shared mount namespace inside
> > each individual test mount namespace.
> > 
> > i.e. when check uses private namespaces I can see all the mounts
> > from inside each test namespace from the init namespace and every
> > test can see every mount that every other test runs again.
> > 
> > That is the problem I originally used mount namespaces in
> > check-parallel to avoid.
> > 
> > I have no idea if this is how mount namespace nesting is actually
> > supposed to work (seems completely broken to me!), but the only
> > solution I've found that works so far is to turn off HAVE_PRIVATENS
> > in check as it is redundant when it is run from check-parallel.
> > 
> > FWIW, given that check-parallel now runs in it's own private PID
> > namespace with it's own /proc and /tmp, the original problem of
> > needing to "confine pkill to only the child processes of this test
> > instance" has gone away entirely. i.e. check-parallel does not need check to
> > to restrict pkill to children of the current test being run anymore.
> > 
> > Hence I think we can probably remove the new process isolation
> > shenanigans and revert the _pkill wrappers to plain pkill calls
> > again as the private PID namespacing the check-parallel does means
> > pkill does the right thing for both check and check-parallel now.
> 
> Hi Dave,
> 
> Thanks for your reviewing. Do you mean revert below commit directly?
> 
>   commit 247ab01fa227647c290cf82696f1b0bbf87a0177
>   Author: Darrick J. Wong <djwong@kernel.org>
>   Date:   Mon Feb 3 14:00:28 2025 -0800
> 
>       check: run tests in a private pid/mount namespace
> 
> I isolate the HAVE_PRIVATENS rather than reverting it, due to I'm not
> sure if you or Darrick still would like to improve that test way.

I'm talking about removing all the setsid and namspace bits that we
added to try to solve the need for pkill --parent. i.e. this series
of patches:

949bdf8ea check: deprecate using process sessions to isolate test instances
247ab01fa check: run tests in a private pid/mount namespace
88d60f434 common: fix pkill by running test program in a separate session
c71349150 common/rc: hoist pkill to a helper function
77548e606 common/rc: create a wrapper for the su command

Using private PID namespaces in check-parallel has solved the
original problem that required the pkill --parent usage and the
fsstress binary rename/copy workaround by wrapping process isolation
outside of each check instance. Hence check and the internal
check infrastructure doesn't need to ever care about process
isolation to solve this check-parallel problem anymore.

i.e. the isolation fix should have been made to check-parallel,
not to check.

It is not ideal to have to walk all this stuff back, but this is
what happens when an RFC-scope feature prototype is merged without
allowing adequate time for review or give the author a chance to
address at least one round of review comments and bug fixes before
it gets merged....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
