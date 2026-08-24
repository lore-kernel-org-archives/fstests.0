Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081C38B7CD
	for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606609; cv=none; b=Vg2Smwl2e7xnf//opFmIxIWbZL8rB7oJCDwuXmcngc5ZXWdDo/WExocwp5h2a6KKeGVWYim+2SBY+48Iy/4qtFwDht+dkPT7RCbcM5eFuD9mg3bxrZA/+CQ96oEAH6yiyQt3QBn5vHdZBVJ1U+l68eTMuQH7Z8R7Tr6N/AQM8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606609; c=relaxed/simple;
	bh=AMNncJNty1MVmtAdB0JoYikNJcq7aBYHwvPdaL1iLR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2WFSbcttJMlOXPUCivz+Lfnh67h0u2u+XF7xnH2HzCIHz5Rw4dKK0QhtlKKiMiYHxCvSzlEa0xbSJSJWDWLBg7sB6CKszkEefAbVlvu4biU5+jbDIf7aNR3egzXvfqLur05DuJFEayB7mYLChfmGAlHLrmvKxvM/H4jUEV9RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaWnblix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaWnblix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F28C1F000E9;
	Mon, 24 Aug 2026 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787606607;
	bh=q1SH+r6hw26iqDEtmR/cvy40SDz3x+rRd8jycDoQQIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AaWnblixZqq/WbK/VlRJbRC26+oqTonMXgRynxRvy4GvkJE3xvd1Nhl/VscXOWmdz
	 +Iqdj18ikDzBwcTuf/sdpNCQiWjpYwYF5R4WFRR6we1mU3mxgSXMfthP+1iK+qFDcV
	 z6VHDnqgfd/gLoE4HZnJP4zjZZDshDEsZ0qEJDrydspc4aWVEBdwZRBgKjKa6mV2Vr
	 6/xqPYeaS4yQXsam1VCh1OnvYFq9kgP/OlNK8L+bGH5g3RCNOc39vw6uABocPGJJF+
	 aIRR2saWsS9BREtXwEtnG78o93fbG4+5O+y8DUT5S4K3xVLEy424KiQ1ZmA23DaKvO
	 S8hNIWXGQCm8w==
Date: Tue, 25 Aug 2026 05:23:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/4] check: refactor argument parsing with getopt
Message-ID: <aoy0s6eT-hsOFFw0@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-2-zlang@kernel.org>
 <an7P2CWzNnz6avGh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aoK5G5mT9Yc5sjPy@zlang-mailbox>
 <aoMjxU1UGZvaxl6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMjxU1UGZvaxl6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Mon, Aug 17, 2026 at 08:37:49PM +0530, Ojaswin Mujoo wrote:
> On Mon, Aug 17, 2026 at 03:56:40PM +0800, Zorro Lang wrote:
> > On Fri, Aug 14, 2026 at 01:50:40PM +0530, Ojaswin Mujoo wrote:
> > > On Tue, May 12, 2026 at 09:25:36PM +0800, Zorro Lang wrote:
> > > > Replace the legacy, hand-written argument parsing loop with getopt.
> > > > Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
> > > > -cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
> > > > -udiff), pre-process them into long options before giving to getopt.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > ---
> > > >  check | 179 +++++++++++++++++++++++++++++++++++++++++-----------------
> > > >  1 file changed, 126 insertions(+), 53 deletions(-)
> > > > 
> > > > diff --git a/check b/check
> > > > index ad685edc..11bdf81b 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -272,48 +272,97 @@ _prepare_test_list()
> > > >  	rm -f $tmp.list
> > > >  }
> > > >  
> > > > -# Process command arguments first.
> > > > +# Backward compatible with the old options mode. Translate word-style options
> > > > +# that getopt would misinterpret into long options.
> > > > +compat_old_option()
> > > > +{
> > > > +	check_args=()
> > > > +	while [ $# -gt 0 ]; do
> > > > +		case "$1" in
> > > > +		-nfs)		check_args+=("--fs" "nfs") ;;
> > > > +		-afs)		check_args+=("--fs" "afs") ;;
> > > > +		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
> > > > +		-cifs)		check_args+=("--fs" "cifs") ;;
> > > > +		-9p)		check_args+=("--fs" "9p") ;;
> > > > +		-fuse)		check_args+=("--fs" "fuse") ;;
> > > > +		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
> > > > +		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
> > > > +		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
> > > > +		-ubifs)		check_args+=("--fs" "ubifs") ;;
> > > > +		-overlay)	check_args+=("--fs" "overlay") ;;
> > > > +		-udiff)		check_args+=("--udiff") ;;
> > > > +		*)		check_args+=("$1") ;;
> > > > +		esac
> > > > +		shift
> > > > +	done
> > > > +}
> > > > +
> > > > +short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
> > > > +long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
> > > > +
> > > > +compat_old_option "$@"
> > > > +
> > > > +# Note: The '+' prefix in getopt's option string preserves the existing
> > > > +# behavior that option parsing stops at the first non-option test argument.
> > > > +parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
> > > > +test $? -ne 0 && usage
> > > > +
> > > > +eval set -- "$parsed_opts"
> > > > +
> > > >  while [ $# -gt 0 ]; do
> > > >  	case "$1" in
> > > > -	-\? | -h | --help) usage ;;
> > > 
> > > Hi Zorro, mostly looks good but I think we slightly change the behavior
> > > here. Earlier ./check -\? would print help but not:
> > > 
> > >    ./check -\?
> > >   check: invalid option -- '?'
> > >   Warning: need to define parameters for host <host>
> > >          or set variables:
> > >           TEST_DIR TEST_DEV
> > > 
> > > Maybe we should add this to compat_old_option ( although i really doubt
> > > anyone would care about -\? :) )
> > 
> > Thanks for the review! Turns out `-\?` is indeed an option
> 
> Hi Zorro,
> 
> Yeah haha, i doubt anyone uses it tho.
> > 
> >   while [ $# -gt 0 ]; do
> >         case "$1" in
> >         -\? | -h | --help) usage ;;
> > 
> > I've never used it before and wasn't sure if anyone actually does. But given
> > that it's the existing behavior, let's keep it consistent. I'll update and
> > remove the "RFC" flag in next version.

Hi,

I just found out that "?" is not supported as a valid option character by getopt,
and "-?" doesn't seem to be standard usage anyway. Because of this, we can't really
support "-?" natively via getopt.

However, I can handle "-?" inside compat_old_option() by mapping "-\?)" to
check_args+=("-h") and treating it as a deprecated option. Is that good to you and
others?

Thanks,
Zorro

> 
> Yep sounds good.
> 
> Thanks,
> ojaswin
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Other than that, feel free to add:
> > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > -
> > > > -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> > > > -		FSTYP="${1:1}"
> > > > +	--fs)
> > > > +		if [ "$2" == "overlay" ];then
> > > > +			[ "$FSTYP" == overlay ] || \
> > > > +				export OVL_BASE_FSTYP="$FSTYP"
> > > > +			FSTYP=overlay
> > > > +			export OVERLAY=true
> > > > +		else
> > > > +			FSTYP="$2"
> > > > +		fi
> > > > +		shift
> > > >  		;;
> > > > -	-overlay)
> > > > -		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> > > > -		FSTYP=overlay
> > > > -		export OVERLAY=true
> > > > +	--udiff)
> > > > +		diff="$diff -u"
> > > >  		;;
> > > > -
> > > > -	-g)	group=$2 ; shift ;
> > > > -		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> > > > +	-g)
> > > > +		GROUP_LIST="$GROUP_LIST ${2//,/ }"
> > > > +		shift
> > > >  		;;
> > > > -
> > > > -	-x)	xgroup=$2 ; shift ;
> > > > -		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
> > > > +	-x)
> > > > +		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
> > > > +		shift
> > > >  		;;
> > > > -
> > > > -	-X)	subdir_xfile=$2; shift ;
> > > > +	-X)
> > > > +		subdir_xfile="$2"
> > > > +		shift
> > > >  		;;
> > > >  	-e)
> > > > -		xfile=$2; shift ;
> > > >  		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> > > > -			<(echo "$xfile" | tr ', ' '\n\n')
> > > > +			<(echo "$2" | tr ', ' '\n\n')
> > > > +		shift
> > > >  		;;
> > > > -
> > > > -	-E)	xfile=$2; shift ;
> > > > -		if [ -f $xfile ]; then
> > > > +	-E)
> > > > +		if [ -f "$2" ]; then
> > > >  			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> > > > -				<(sed "s/#.*$//" $xfile)
> > > > +				<(sed "s/#.*$//" "$2")
> > > >  		fi
> > > > +		shift
> > > > +		;;
> > > > +	-s)
> > > > +		RUN_SECTION="$RUN_SECTION $2"
> > > > +		shift
> > > > +		;;
> > > > +	-S)
> > > > +		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
> > > > +		shift
> > > > +		;;
> > > > +	-l)
> > > > +		diff="diff"
> > > > +		;;
> > > > +	-n)
> > > > +		showme=true
> > > >  		;;
> > > > -	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> > > > -	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> > > > -	-l)	diff="diff" ;;
> > > > -	-udiff)	diff="$diff -u" ;;
> > > > -
> > > > -	-n)	showme=true ;;
> > > >  	-r)
> > > >  		if $exact_order; then
> > > >  			_fatal "Cannot specify -r and --exact-order."
> > > > @@ -322,40 +371,64 @@ while [ $# -gt 0 ]; do
> > > >  		;;
> > > >  	--exact-order)
> > > >  		if $randomize; then
> > > > -			_fatal "Cannnot specify --exact-order and -r."
> > > > +			_fatal "Cannot specify --exact-order and -r."
> > > >  		fi
> > > >  		exact_order=true
> > > >  		;;
> > > > -	-i)	iterations=$2; shift ;;
> > > > -	-I) 	iterations=$2; istop=true; shift ;;
> > > > -	-T)	timestamp=true ;;
> > > > -	-d)	DUMP_OUTPUT=true ;;
> > > > -	-b)	brief_test_summary=true;;
> > > > -	-R)	report_fmt=$2 ; shift ;
> > > > -		REPORT_LIST="$REPORT_LIST ${report_fmt//,/ }"
> > > > +	-i)
> > > > +		iterations=$2
> > > > +		shift
> > > > +		;;
> > > > +	-I)
> > > > +		iterations=$2
> > > > +		istop=true
> > > > +		shift
> > > > +		;;
> > > > +	-T)
> > > > +		timestamp=true
> > > > +		;;
> > > > +	-d)
> > > > +		DUMP_OUTPUT=true
> > > > +		;;
> > > > +	-b)
> > > > +		brief_test_summary=true
> > > > +		;;
> > > > +	-R)
> > > > +		REPORT_LIST="$REPORT_LIST ${2//,/ }"
> > > >  		do_report=true
> > > > +		shift
> > > >  		;;
> > > > -	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
> > > > -	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> > > > -	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> > > > -		loop_on_fail=$2; shift
> > > > +	--large-fs)
> > > > +		export LARGE_SCRATCH_DEV=yes
> > > > +		;;
> > > > +	--extra-space)
> > > > +		export SCRATCH_DEV_EMPTY_SPACE="$2"
> > > > +		shift
> > > > +		;;
> > > > +	-L)
> > > > +		[[ $2 =~ ^[0-9]+$ ]] || usage
> > > > +		loop_on_fail=$2
> > > > +		shift
> > > > +		;;
> > > > +	-h|--help)
> > > > +		usage
> > > > +		;;
> > > > +	--)
> > > > +		shift
> > > > +		break
> > > > +		;;
> > > > +	*)
> > > > +		usage
> > > >  		;;
> > > > -
> > > > -	-*)	usage ;;
> > > > -	*)	# not an argument, we've got tests now.
> > > > -		have_test_arg=true ;;
> > > >  	esac
> > > > -
> > > > -	# if we've found a test specification, the break out of the processing
> > > > -	# loop before we shift the arguments so that this is the first argument
> > > > -	# that we process in the test arg loop below.
> > > > -	if $have_test_arg; then
> > > > -		break;
> > > > -	fi
> > > > -
> > > >  	shift
> > > >  done
> > > >  
> > > > +# Remaining arguments
> > > > +if [ $# -gt 0 ]; then
> > > > +	have_test_arg=true
> > > > +fi
> > > > +
> > > >  # we need common/rc, that also sources common/config. We need to source it
> > > >  # after processing args, overlay needs FSTYP set before sourcing common/config
> > > >  if ! . ./common/rc; then
> > > > -- 
> > > > 2.54.0
> > > > 
> 
