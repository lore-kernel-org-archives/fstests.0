Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0B3C76A0
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979290; cv=none; b=sqh0mGt5XX3sJfaIMpWIz4SOx+YLMsmcKCYF3VB77dvgBi8df96q4sg9+0l4HZ4iIA6IwzdcA6MKQdQuk0lv7161nrQrN6+SJGpI2saTpZNnSDzU8fUduC6eulViXHTlQnubEHg5CtdhWKxqPvC2VaE0GPmHhhUkRpDSei/BtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979290; c=relaxed/simple;
	bh=Wj08O4JO4Hg2Tbif9bc1WAlogFFZe0JqE2xOmjvgTAU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6FHCtKNsXSNJnkqZb74D3SqN8ZXI39KUrzPK5RuD222jDZppaxmwDsqzvR8aM42xloQpAlya/mC1uw3Ax7C8EBri1Owl1uXzMW5OQUt00C45NFZbiGEznNHCQ8LP3OfiFcIyhmEbQLkgkynKdbDVq5R+9Bfb4Bf5BB0fniUFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DGwjyBlQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DGwjyBlQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCVkCI1348186;
	Mon, 17 Aug 2026 15:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6QS7Za/us9QMXRBJglNI3fta9TS7Cu
	rmtj9yQeVGPtU=; b=DGwjyBlQj2sxTf9s4w6BHDYiNxyMccyvy6igTquiv55Ux7
	K3NWnuuZROxgDaeLIJyxRlXYxBA9pS9WbS5u2v4chf4pI8RDEphn7C7EL9a4+ZGt
	GWAXS7F3YX7sTpyNIzutjsC78aEtlzhaYTPT8FvvHa0NV97gz8ChDFaUyOF9xpLy
	0BqwiiYLTUbb6O49+SV+OfXQos5H1gLIzV31zMRRVQYrS0WimgL5y2LAXwP+WBcq
	ErEPXvanPRVJpIUFXPncaYg/DAZoNuNryx/sDyHX7SAL5lPKglu3+yWc6a/roQGG
	T5HtPI+QViYTvnwu7D+MB0CK+fDZyiNLjKT/no4Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3jwvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 15:08:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HEuPOr023810;
	Mon, 17 Aug 2026 15:08:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng6a8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 15:08:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HF83pr49414604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 15:08:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF4B20040;
	Mon, 17 Aug 2026 15:08:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F39420043;
	Mon, 17 Aug 2026 15:08:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.111])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Aug 2026 15:08:02 +0000 (GMT)
Date: Mon, 17 Aug 2026 20:37:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/4] check: refactor argument parsing with getopt
Message-ID: <aoMjxU1UGZvaxl6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-2-zlang@kernel.org>
 <an7P2CWzNnz6avGh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aoK5G5mT9Yc5sjPy@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoK5G5mT9Yc5sjPy@zlang-mailbox>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dFfr6WciNj7hifqZeGlaTr5v1iCf7Vnp
X-Proofpoint-ORIG-GUID: dFfr6WciNj7hifqZeGlaTr5v1iCf7Vnp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX5taFENBsUKqo
 E1jj/+dAQLpOeLtuOeUo0/75nlxLOLLnPOm13fKvu5V1POyQYVO3RaPZT9tNh2VNMaSZJmsaH/c
 nmgBZnNFNU/VumnEZDR48lYiggUz42I=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a8323d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PDlA8aCpJbfI0f951SMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX29+Ncdco77OY
 ZMceROaZImSLIrPI5dYpPwZ+S53R+5F6r3jVFGc8BGiIyVHqhd9kvg9PTMTqMO+Y1imry40jEi1
 c8M/Kp/XrIIivtw0rt9NP26LzmmVJXuhwPqKbWoQ1a0iKlffhS09JgYRVEY2h12f5lSFwK+5H0S
 36KlnZMKfJxb7DNtHgZdnt3GeMiOOZIVzTQfYnmxgzukYx07DlfmgVHyUenT26iNBPP/go0MH8V
 Do6avj2aw33v6bP5VoCnm47g+jsvkCw23FmTuklbnLkm1bUjgyEgEfcZO9Cw/P3a2neJ5hzybyj
 nAhgdEI3aeLcxg3HUEN8ZbcoBzfRls+snaevk4QTNApBoYZqxnzan2nEJx8ZDrggKmyXznGKUpu
 jBGELqVySLDc9XQZHMhVrLHvK98YErCLYSmQRf2s2BpkqoyAL1Xw1gzcetm/BZvcHMeu3iFF0Zg
 swDkre4QKF9rwaa6+Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170115

On Mon, Aug 17, 2026 at 03:56:40PM +0800, Zorro Lang wrote:
> On Fri, Aug 14, 2026 at 01:50:40PM +0530, Ojaswin Mujoo wrote:
> > On Tue, May 12, 2026 at 09:25:36PM +0800, Zorro Lang wrote:
> > > Replace the legacy, hand-written argument parsing loop with getopt.
> > > Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
> > > -cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
> > > -udiff), pre-process them into long options before giving to getopt.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > >  check | 179 +++++++++++++++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 126 insertions(+), 53 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index ad685edc..11bdf81b 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -272,48 +272,97 @@ _prepare_test_list()
> > >  	rm -f $tmp.list
> > >  }
> > >  
> > > -# Process command arguments first.
> > > +# Backward compatible with the old options mode. Translate word-style options
> > > +# that getopt would misinterpret into long options.
> > > +compat_old_option()
> > > +{
> > > +	check_args=()
> > > +	while [ $# -gt 0 ]; do
> > > +		case "$1" in
> > > +		-nfs)		check_args+=("--fs" "nfs") ;;
> > > +		-afs)		check_args+=("--fs" "afs") ;;
> > > +		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
> > > +		-cifs)		check_args+=("--fs" "cifs") ;;
> > > +		-9p)		check_args+=("--fs" "9p") ;;
> > > +		-fuse)		check_args+=("--fs" "fuse") ;;
> > > +		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
> > > +		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
> > > +		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
> > > +		-ubifs)		check_args+=("--fs" "ubifs") ;;
> > > +		-overlay)	check_args+=("--fs" "overlay") ;;
> > > +		-udiff)		check_args+=("--udiff") ;;
> > > +		*)		check_args+=("$1") ;;
> > > +		esac
> > > +		shift
> > > +	done
> > > +}
> > > +
> > > +short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
> > > +long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
> > > +
> > > +compat_old_option "$@"
> > > +
> > > +# Note: The '+' prefix in getopt's option string preserves the existing
> > > +# behavior that option parsing stops at the first non-option test argument.
> > > +parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
> > > +test $? -ne 0 && usage
> > > +
> > > +eval set -- "$parsed_opts"
> > > +
> > >  while [ $# -gt 0 ]; do
> > >  	case "$1" in
> > > -	-\? | -h | --help) usage ;;
> > 
> > Hi Zorro, mostly looks good but I think we slightly change the behavior
> > here. Earlier ./check -\? would print help but not:
> > 
> >    ./check -\?
> >   check: invalid option -- '?'
> >   Warning: need to define parameters for host <host>
> >          or set variables:
> >           TEST_DIR TEST_DEV
> > 
> > Maybe we should add this to compat_old_option ( although i really doubt
> > anyone would care about -\? :) )
> 
> Thanks for the review! Turns out `-\?` is indeed an option

Hi Zorro,

Yeah haha, i doubt anyone uses it tho.
> 
>   while [ $# -gt 0 ]; do
>         case "$1" in
>         -\? | -h | --help) usage ;;
> 
> I've never used it before and wasn't sure if anyone actually does. But given
> that it's the existing behavior, let's keep it consistent. I'll update and
> remove the "RFC" flag in next version.

Yep sounds good.

Thanks,
ojaswin

> 
> Thanks,
> Zorro
> 
> > 
> > Other than that, feel free to add:
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > -
> > > -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> > > -		FSTYP="${1:1}"
> > > +	--fs)
> > > +		if [ "$2" == "overlay" ];then
> > > +			[ "$FSTYP" == overlay ] || \
> > > +				export OVL_BASE_FSTYP="$FSTYP"
> > > +			FSTYP=overlay
> > > +			export OVERLAY=true
> > > +		else
> > > +			FSTYP="$2"
> > > +		fi
> > > +		shift
> > >  		;;
> > > -	-overlay)
> > > -		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> > > -		FSTYP=overlay
> > > -		export OVERLAY=true
> > > +	--udiff)
> > > +		diff="$diff -u"
> > >  		;;
> > > -
> > > -	-g)	group=$2 ; shift ;
> > > -		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> > > +	-g)
> > > +		GROUP_LIST="$GROUP_LIST ${2//,/ }"
> > > +		shift
> > >  		;;
> > > -
> > > -	-x)	xgroup=$2 ; shift ;
> > > -		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
> > > +	-x)
> > > +		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
> > > +		shift
> > >  		;;
> > > -
> > > -	-X)	subdir_xfile=$2; shift ;
> > > +	-X)
> > > +		subdir_xfile="$2"
> > > +		shift
> > >  		;;
> > >  	-e)
> > > -		xfile=$2; shift ;
> > >  		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> > > -			<(echo "$xfile" | tr ', ' '\n\n')
> > > +			<(echo "$2" | tr ', ' '\n\n')
> > > +		shift
> > >  		;;
> > > -
> > > -	-E)	xfile=$2; shift ;
> > > -		if [ -f $xfile ]; then
> > > +	-E)
> > > +		if [ -f "$2" ]; then
> > >  			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> > > -				<(sed "s/#.*$//" $xfile)
> > > +				<(sed "s/#.*$//" "$2")
> > >  		fi
> > > +		shift
> > > +		;;
> > > +	-s)
> > > +		RUN_SECTION="$RUN_SECTION $2"
> > > +		shift
> > > +		;;
> > > +	-S)
> > > +		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
> > > +		shift
> > > +		;;
> > > +	-l)
> > > +		diff="diff"
> > > +		;;
> > > +	-n)
> > > +		showme=true
> > >  		;;
> > > -	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> > > -	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> > > -	-l)	diff="diff" ;;
> > > -	-udiff)	diff="$diff -u" ;;
> > > -
> > > -	-n)	showme=true ;;
> > >  	-r)
> > >  		if $exact_order; then
> > >  			_fatal "Cannot specify -r and --exact-order."
> > > @@ -322,40 +371,64 @@ while [ $# -gt 0 ]; do
> > >  		;;
> > >  	--exact-order)
> > >  		if $randomize; then
> > > -			_fatal "Cannnot specify --exact-order and -r."
> > > +			_fatal "Cannot specify --exact-order and -r."
> > >  		fi
> > >  		exact_order=true
> > >  		;;
> > > -	-i)	iterations=$2; shift ;;
> > > -	-I) 	iterations=$2; istop=true; shift ;;
> > > -	-T)	timestamp=true ;;
> > > -	-d)	DUMP_OUTPUT=true ;;
> > > -	-b)	brief_test_summary=true;;
> > > -	-R)	report_fmt=$2 ; shift ;
> > > -		REPORT_LIST="$REPORT_LIST ${report_fmt//,/ }"
> > > +	-i)
> > > +		iterations=$2
> > > +		shift
> > > +		;;
> > > +	-I)
> > > +		iterations=$2
> > > +		istop=true
> > > +		shift
> > > +		;;
> > > +	-T)
> > > +		timestamp=true
> > > +		;;
> > > +	-d)
> > > +		DUMP_OUTPUT=true
> > > +		;;
> > > +	-b)
> > > +		brief_test_summary=true
> > > +		;;
> > > +	-R)
> > > +		REPORT_LIST="$REPORT_LIST ${2//,/ }"
> > >  		do_report=true
> > > +		shift
> > >  		;;
> > > -	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
> > > -	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> > > -	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> > > -		loop_on_fail=$2; shift
> > > +	--large-fs)
> > > +		export LARGE_SCRATCH_DEV=yes
> > > +		;;
> > > +	--extra-space)
> > > +		export SCRATCH_DEV_EMPTY_SPACE="$2"
> > > +		shift
> > > +		;;
> > > +	-L)
> > > +		[[ $2 =~ ^[0-9]+$ ]] || usage
> > > +		loop_on_fail=$2
> > > +		shift
> > > +		;;
> > > +	-h|--help)
> > > +		usage
> > > +		;;
> > > +	--)
> > > +		shift
> > > +		break
> > > +		;;
> > > +	*)
> > > +		usage
> > >  		;;
> > > -
> > > -	-*)	usage ;;
> > > -	*)	# not an argument, we've got tests now.
> > > -		have_test_arg=true ;;
> > >  	esac
> > > -
> > > -	# if we've found a test specification, the break out of the processing
> > > -	# loop before we shift the arguments so that this is the first argument
> > > -	# that we process in the test arg loop below.
> > > -	if $have_test_arg; then
> > > -		break;
> > > -	fi
> > > -
> > >  	shift
> > >  done
> > >  
> > > +# Remaining arguments
> > > +if [ $# -gt 0 ]; then
> > > +	have_test_arg=true
> > > +fi
> > > +
> > >  # we need common/rc, that also sources common/config. We need to source it
> > >  # after processing args, overlay needs FSTYP set before sourcing common/config
> > >  if ! . ./common/rc; then
> > > -- 
> > > 2.54.0
> > > 
