Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2142048
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738901; cv=none; b=eeyquVLfQcjrvE9TTcJR27LIN/nrtH40qQmVuPfDpiGG9zcYXE63hea6fmcfs+l4C5V2hg+G03dH/jJAXGvGQFgdVThj2TDGkfC5vd6Ahwm1tTesrNMLrkWGkn10nkwJG8Zch2AhzBzaQ96Qhn/kwPeoaLhLLKT0KeQA2gAFllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738901; c=relaxed/simple;
	bh=dtRcv47nBWE9GN89I0Da7ttW/YLemwk/5qP87+dq/dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnoAIr8Op8Kgv6qW8/xvUtoJ6fv1Yngd5CaoLg1Z0NpMaUGPjcYg7WNgRJJbcoEktiGqrwhpxCcPOn6lcw+t5ArbybBGaXSzqe5O43GZFbEUBqNH/sh23A/52gJetny4IYgtfcu8zFV8hhG8HrPhyE6WT0C+TojeTmRiaGS5oZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWoRa4rd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWoRa4rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C09C4CEEB;
	Thu, 12 Jun 2025 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738901;
	bh=dtRcv47nBWE9GN89I0Da7ttW/YLemwk/5qP87+dq/dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWoRa4rdi48b29NKAivmlL9BPrHmUkCXQmfZqgwVVHO52CJduzHW9u07mSztRaJiw
	 CH7vWPDzOGhti4x4oAS52PzMsYS4XwlYAd0KhjsGbIS93OC+9/tU7pLn+TCKEnPQov
	 scpwlUx8eramlTQ0rxYdi7hpx3gdtdWKd3HhKqoF8CdWmMd6y3OWMJ7Q9t0kghtquT
	 7xT+bHXYGcUh6IBBqWQOVQvLfj7kYXWjfORgddWlkE92SlWXiBB/COJLjMw5GSal9e
	 yB70CXI74CFF8pSwcwAL2UqkJRbuOb0CQy2AbDpr+MDZBjbb42NRLVu+sU2jW2DgKw
	 8W2BR45387GRA==
Date: Thu, 12 Jun 2025 07:35:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 02/12] common/rc: Add a helper to run fsx on a given file
Message-ID: <20250612143500.GQ6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <0a0604215a992f0aaa4d8d6821b8c8051a0f8d80.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143138.GG6143@frogsfrogsfrogs>
 <aEpw_TTDNW8KnBLl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEpw_TTDNW8KnBLl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Jun 12, 2025 at 11:47:33AM +0530, Ojaswin Mujoo wrote:
> On Wed, Jun 11, 2025 at 07:31:38AM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 11, 2025 at 03:04:45PM +0530, Ojaswin Mujoo wrote:
> > > Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
> > > Add a helper _run_fsx_on_file so that we can run fsx on any
> > > given file including in $SCRATCH_MNT. Also, refactor _run_fsx
> > > to use this helper.
> > > 
> > > No functional change is intended in this patch.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/rc | 21 ++++++++++++++++++---
> > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index cfbe2a5f..a5d811a1 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5115,13 +5115,22 @@ _require_hugepage_fsx()
> > >  		_notrun "fsx binary does not support MADV_COLLAPSE"
> > >  }
> > >  
> > > -_run_fsx()
> > > +_run_fsx_on_file()
> > >  {
> > > +	local testfile=$1
> > > +	shift
> > > +
> > > +	if ! [ -f $testfile ]
> > > +	then
> > > +		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
> > > +		touch $testfile
> > > +	fi
> > > +
> > >  	echo "fsx $*"
> > >  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> > > -	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> > > +	set -- $FSX_PROG $args $FSX_AVOID $testfile
> > 
> > 	local testfile="${1:-$TEST_DIR/junk}"
> > 	...
> > 	set -- $FSX_PROG $args $FSX_AVOID $testfile
> > 
> > Then you don't need the extra helper.
> Hi Darrick,
> 
> I originally added the extra helper so that we won't need to change the
> existing run_fsx calls. For example, with the change you suggested,
> generic/263 would need to be changed from:
> 
> run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> 
> to 
> 
> run_fsx $TEST_DIR/junk -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> 
> because otherwise, the $1 would actually be "-N" and run_fsx would get
> confused. 
> 
> However, if you would prefer to drop the helper and rather modify
> run_fsx and the call sites to pass a filename, that should be doable as
> well. Please let me know your preference on this.

Ah, right.  I forgot that the function filters its arguments but then
passes them on to fsx.  Ignore this comment, then. :)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Regards,
> ojaswin
> 
> > 
> > --D
> > 
> > >  	echo "$@" >>$seqres.full
> > > -	rm -f $TEST_DIR/junk
> > > +	rm -f $testfile
> > >  	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
> > >  	local res=${PIPESTATUS[0]}
> > >  	if [ $res -ne 0 ]; then
> > > @@ -5133,6 +5142,12 @@ _run_fsx()
> > >  	return 0
> > >  }
> > >  
> > > +_run_fsx()
> > > +{
> > > +	_run_fsx_on_file $TEST_DIR/junk $@
> > > +	return $?
> > > +}
> > > +
> > >  # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
> > >  # the test, but if any other error occurs then exit the test.
> > >  _run_hugepage_fsx() {
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 
