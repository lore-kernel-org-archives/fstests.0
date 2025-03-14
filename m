Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3978F2E
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973120; cv=none; b=OFIqT9t/b+Ol/4Tmvy0hAesbL9TZpviB4G9HHCK2Rb1K7MRJPlheZe4JUSW14qYvlWcDMDr3GwMEbozCDFV0tK6Qc3G50t8jl0qYlosffqswDawhMZBaSccdXrPMwz6ieMzF4TVC5KovKV3z0k9Z41hgo6NrGmIjGI7DmjwBSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973120; c=relaxed/simple;
	bh=BzkVaXCAHwuCqTd275Hx1v1pO1+8YmCCOAg4wRmSVNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx5+xa1fqSVZJGI+YEsSDwsvjjE7UzMJNgmKgPSaGwTJg3lvxyS8n1a5v8HBQiXoGX0Zg1zirdDTmu3A0QBVkFji8L+GspkuaockYTBGVYpvQywPxZ10rcPoIiCuoOPFTzg9ot2o66FnHDk8glupLqh6rI3C0lMlIyQYMu1J028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4XRr1Ed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4XRr1Ed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C98C4CEE3;
	Fri, 14 Mar 2025 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741973120;
	bh=BzkVaXCAHwuCqTd275Hx1v1pO1+8YmCCOAg4wRmSVNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4XRr1EdDkUOM/pYnLdGujPCegIQhGXOo0UoMs9ShwcNlgRuc6dbIQ2yiuJTCBnZE
	 L6Km3lneDA/mOx6MJGDtqbe8QaCkhXU36ZEVuWUgZ1xdi56xp1lcOBNmmjFCxQzqa+
	 rnTSM2rUdA5fgb9CAD0gBlwPcfrh7A4OHtn1nS/geJnnDwT49xMdPAQmiJPuYAjP9F
	 dqB0IybuKmj3xvdCDsCM8dPzcPee2d+tFYD3rqg8ipyofWbiCqivyvmN3FXPTERiVL
	 BMFWecbGfdd4P0KoCsmlCH53d5Km9OSOZzJYj4Kt0BIX+8pUUdefHbKk8HK3ydsq1s
	 oW060ghQOszsg==
Date: Fri, 14 Mar 2025 10:25:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH V2] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250314172519.GK89034@frogsfrogsfrogs>
References: <7ca733f5-f33a-4b2e-a70d-4a48a4904391@redhat.com>
 <20250314164812.GK2803740@frogsfrogsfrogs>
 <6a486dcf-7a62-4094-a5f7-d3fbb6437874@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a486dcf-7a62-4094-a5f7-d3fbb6437874@redhat.com>

On Fri, Mar 14, 2025 at 12:16:18PM -0500, Eric Sandeen wrote:
> On 3/14/25 11:48 AM, Darrick J. Wong wrote:
> > On Fri, Mar 14, 2025 at 09:56:20AM -0500, Eric Sandeen wrote:
> >> The current test in _require_fio (--warnings-fatal --showcmd) does not
> >> fail if an invalid/unavailable io engine is specified.
> >>
> >> Add an explicit test that every requested io engine in the job file
> >> is actually available.
> >>
> >> Remove the "ioe_e4defrag" entries in ext4 tests - an engine with this
> >> name has seemingly never existed, but in each case later stanzas
> >> overrode the io engine, so it did not cause problems without this
> >> explicit parsing and checking.
> > 
> > Well, they override it with the correct name "e4defrag":
> 
> and/or with libaio - it doesn't matter what it's overridden with, just
> that the incorrect name in the global stanza is never used due to
> re-specification in each subsequent stanza.
> 
> I guess I don't really understand how it helps to explicitly describe
> the contents of each ioengine= line that clearly still exist in each stanza,
> or why that's critical to the commit log...
> 
> Not saying your suggested text is bad. Just saying I don't think it warrants
> a V3, unless that's a showstopper to get your RVB, in which case I will go
> back again and take the time to do so.

Oh, the reason I wanted the commit message to mention that the fio
config files in ext4/30[1-4] eventually picks the correct engine name is
that I looked at the patch, saw the removal of "ioengine=ioe_e4defrag"
and wondered "Doesn't that break the test?"  The patch doesn't break
anything, but that's not immediately obvious from the diff context.

At least it wasn't to me :P

--D

> Thanks,
> -Eric
> 
> > $ fio --enghelp
> > Available IO engines:
> >         cpuio
> >         mmap
> >         sync
> > <snip>
> >         falloc
> >         e4defrag
> > 
> > I think the commit message should call that out specifically "...but in
> > each case later stanzas provide the correct ioengine name 'e4defrag',
> > so...").
> > 
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > With that amended, this all looks good to me so
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > --D
> > 
> >> ---
> >>
> >> V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
> >>     we only test each requested engine once.
> >>
> >> diff --git a/common/rc b/common/rc
> >> index ca755055..ac443ec2 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
> >>  _require_fio()
> >>  {
> >>  	local job=$1
> >> +	local eng
> >>  
> >>  	_require_command "$FIO_PROG" fio
> >>  	if [ -z "$1" ]; then
> >>  		return 1;
> >>  	fi
> >>  
> >> +	# Explicitly check for every ioengine listed in the job
> >> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
> >> +		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
> >> +			_notrun "fio engine $eng not available"
> >> +	done
> >> +
> >>  	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
> >>  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
> >>  }
> >> diff --git a/tests/ext4/301 b/tests/ext4/301
> >> index abf47d4b..a05b8e8a 100755
> >> --- a/tests/ext4/301
> >> +++ b/tests/ext4/301
> >> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
> >>  cat >$fio_config <<EOF
> >>  # Common e4defrag regression tests
> >>  [global]
> >> -ioengine=ioe_e4defrag
> >>  iodepth=1
> >>  directory=${SCRATCH_MNT}
> >>  filesize=${FILE_SIZE}
> >> diff --git a/tests/ext4/302 b/tests/ext4/302
> >> index 87820184..e0f5f2f9 100755
> >> --- a/tests/ext4/302
> >> +++ b/tests/ext4/302
> >> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
> >>  cat >$fio_config <<EOF
> >>  # Common e4defrag regression tests
> >>  [global]
> >> -ioengine=ioe_e4defrag
> >>  iodepth=1
> >>  directory=${SCRATCH_MNT}
> >>  filesize=${FILE_SIZE}
> >> diff --git a/tests/ext4/303 b/tests/ext4/303
> >> index 2381f047..0a83e86c 100755
> >> --- a/tests/ext4/303
> >> +++ b/tests/ext4/303
> >> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
> >>  cat >$fio_config <<EOF
> >>  # Common e4defrag regression tests
> >>  [global]
> >> -ioengine=ioe_e4defrag
> >>  iodepth=1
> >>  directory=${SCRATCH_MNT}
> >>  filesize=${FILE_SIZE}
> >> diff --git a/tests/ext4/304 b/tests/ext4/304
> >> index 53b522ee..5f2ae4bd 100755
> >> --- a/tests/ext4/304
> >> +++ b/tests/ext4/304
> >> @@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
> >>  cat >$fio_config <<EOF
> >>  # Common e4defrag regression tests
> >>  [global]
> >> -ioengine=ioe_e4defrag
> >>  iodepth=1
> >>  directory=${SCRATCH_MNT}
> >>  filesize=${FILE_SIZE}
> >>
> >>
> > 
> 
