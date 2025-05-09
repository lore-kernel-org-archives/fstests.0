Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92723A9AD
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806453; cv=none; b=ErFGPuz/Lve+CZ9C1q4rbmWmo2Zc+qKTxSAzueIPMWRT7hf5yrCQEhA3HVPjddobpqy0D6GNWeeTiYD0Eea2o2gsh9NjjhhvGhPHCADsJRUv0rb06tPn8lq6wn6ej4y1zil5/uHgztDxHtNZHlW8GGztwLYUHJfHat5vFmBX+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806453; c=relaxed/simple;
	bh=X4kdbWVftO5UjDyCISDrSuXzB2kZaHkgtO2Ahd6Q8UE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=u1X78XE3bz78PnSTIYB+1zNDGAd+T6x4ypoBOb7DKbufM9ezvtvPUU9Jsdb+Rwc5TUmuc1DK6HsvzIblYIDAZvfnRJwQyu5SANDc9mgTxJZa+ijLXCUq1Xxb1ahUdx+vPXiOqX1k49ANIOPtbhIS5jqmcBQPB1+6sQkY97cvGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iMloRmdb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iMloRmdb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549E4xRf031514;
	Fri, 9 May 2025 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QVL7PY
	m9OOJNI8jMeHzx+bUA4a4DmPmcXNzl0PHVKGQ=; b=iMloRmdbZrTRv3ccKR71ZH
	q4PVN2Najwx++Gu+FAv83bmbhkwcIsDWEZZZH62Jr3G20Uy2Ft1k3FkHLTKSPsU0
	x3gegp+a0+szsqHKuOpk0AsXXdzmA3BAObfGVY/WlGp/gKN9D3+N56FTeRcg38Xs
	oQP8wlB0BMy6YQttwTzxhGmcTIS4rFd6FRsvCOPf5F3BxpmQoMKZVuyRTutrhByv
	Ys92arl4Dn7bZz2hsZM0rf9ey1v4MUKvO63SS2baq3OfufbBhB4PPIPE9UQ8utBm
	1ziWCihjnbh+453NN4S9aleguvh3UknV2yiPXq7Bxt5Z8L+rwvxXbn8EWWXPTseQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwctve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:00:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549FBLEu001345;
	Fri, 9 May 2025 16:00:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftve58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:00:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549G0i6653412214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 16:00:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA26A200B8;
	Fri,  9 May 2025 16:00:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C198200B7;
	Fri,  9 May 2025 16:00:43 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.25.103])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 16:00:42 +0000 (GMT)
Message-ID: <767f406ee57c688b9a2289d9b139351b54c9c323.camel@linux.ibm.com>
Subject: Re: [PATCH 17/28] check-parallel: rebuild test list when FSTYP
 changes
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Fri, 09 May 2025 21:30:42 +0530
In-Reply-To: <20250417031208.1852171-18-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-18-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e26ae cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=sRqHJ33k6CQalwnpJ8AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0KzJGF0lu_JOkElkoVIOmrkZwZ7F0qDO
X-Proofpoint-ORIG-GUID: 0KzJGF0lu_JOkElkoVIOmrkZwZ7F0qDO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1NCBTYWx0ZWRfX5eagDHuDvhe6 2fD/7lIgaAOjz/nP7bVYHV8CF1oynMLDQYf+FBQnT7IJFo025wAE7BN0vBJyK6gvULofAFlEPlM q4MJQ0I5cjiB5pLrDQ0LIAmpcFTQdzxaNIuouYq0+f4ZRWxXoYNHCFlr09FRao42dGJSssc5BtR
 UWoKlcEDtbB64Q9H0iYxbYyOeysftqo/EW2MMm1c4RpvK+TXb5xxpD9kvyiUBo9VCFqXXEi01+U vdb8kiR+2UbUS4vcmJxZkVH7UKIm5RBMxNyGie/wPRWz1WxMz/Y/FmCjVMY8SaO4em9g01s5sh3 ckx5Q8D6CpPOIE77RsTZLCpR7NV6NU5NMTnVAXFl9H3cN7grA/VVXReQJspsjqQzxF5Ro/B+dC2
 /eKD2Kx0JA56QtPKp8OPZEFi56wUSG8LYQ5UqrsMBrtBbDeCe2v11S699hiSlDo+iYLGCqqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090154

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When a config section changes FSTYP, we do not rebuild the test list
> that is to be run. This means that if we go from xfs to ext4, the
> ext4 section will still try to run all the XFS tests, and won't try
> to run the ext4 tests.
> 
> To fix this for check-parallel, check if the FSTYP has changed and
> if it has strip the old tests from the test list and add the new
> tests back to it.
> 
> This is effectively a zero-day bug in the check config section
> support code.
> 
> While there, remain the internal _tl_file variable and the filename
> used to hold command line tests. The check-parallel change uncovered
> that it was using the same filename ($tmp.test_list) as the test
> list code was using and they were stepping on each other.
Right.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel   | 81 +++++++++++++++++++++++++++++-------------------
>  common/test_list |  8 ++---
>  2 files changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 23d29c7a8..374ac8e96 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -175,7 +175,6 @@ time_order_test_list()
>  	local rx=0
>  	local ix
>  	local jx
> -	#set -x
>  	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
>  		echo $_tl_tests | grep -q ${_list[$ix]}
>  		if [ $? == 0 ]; then
> @@ -198,6 +197,26 @@ if ! $_tl_randomise -a ! $_tl_exact_order; then
>  	fi
>  fi
>  
> +# Build the test list from the test sepcification and FSTYP settings. This can
typo: specification
> +# be called at any time to regenerate the list as the include/exclude lists
> +# generated from the command line are retained separately to the test list
> +# itself.
> +setup_test_list()
> +{
> +	_tl_prepare_test_list
> +	_tl_strip_test_list
> +
> +	if ! $_tl_randomise -a ! $_tl_exact_order; then
> +		if [ -f $basedir/runner-0/$prev_results/check.time ]; then
> +			time_order_test_list
> +		fi
> +	fi
> +
> +	# reverse the order of tests so that the get_next_test() can pull from the file
> +	# tail rather than the head.
> +	echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
> +}
> +
>  # Grab the next test to be run from the tail of the file.
>  # Returns an empty string if there is no tests remaining to run.
>  # File operations are run under flock so concurrent gets are serialised against
> @@ -242,6 +261,7 @@ _destroy_loop_device()
>  run_tests()
>  {
>  	local section="$1"
> +	local logfile="$2"
>  
>  	exec 99<>$tmp.test_list_lock
>  
> @@ -257,7 +277,7 @@ run_tests()
>  		echo -n " $test_to_run "
>  		unset FSTESTS_ISOL
>  		if ! _tl_expunge_test $test_to_run; then
> -			tools/run_privatens ./check -s $section $test_to_run >> $me/log 2>&1
> +			tools/run_privatens ./check -s $section $test_to_run >> $logfile 2>&1
>  		fi
>  
>  		test_to_run=$(get_next_test $section)
> @@ -308,12 +328,12 @@ runner_go()
>  	rm -f $RESULT_BASE/check.*
>  
>  	# Only supports default mkfs parameters right now
> -	wipefs -a $TEST_DEV > $me/log 2>&1
> -	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
> +	wipefs -a $TEST_DEV >> $_results/log 2>&1
> +	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $_results/log 2>&1
>  
>  #	export DUMP_CORRUPT_FS=1
>  
> -	run_tests $section
> +	run_tests $section $_results/log
>  
>  	wait
>  	sleep 1
> @@ -327,10 +347,10 @@ runner_go()
>  	_destroy_loop_device $SCRATCH_LOGDEV
>  	_destroy_loop_device $LOGWRITES_DEV
>  
> -	grep -q Failures: $me/log
> +	grep -q Failures: $_results/log
>  	if [ $? -eq 0 ]; then
>  		echo -n "Runner $id Failures: "
> -		grep Failures: $me/log | uniq | sed -e "s/^.*Failures://"
> +		grep Failures: $_results/log | uniq | sed -e "s/^.*Failures://"
>  	fi
>  
>  }
> @@ -339,19 +359,33 @@ run_section()
>  {
>  	local section="$1"
>  	local now="$2"
> +	local results="$basedir/*/results-$now"
This results points to all the individual _results for result-"$now" and _results is for each runner
id and an associated timestamp. 

So if we have 2 invocations at 2 different timestamps(t1 and t2) with 2 test runners, we will have 
$basedir/runner-0/result-t1
$basedir/runner-1/result-t1
$basedir/runner-0/result-t2
$basedir/runner-1/result-t2

I feel grouping the results for each invocation, i.e for each timestamp together looks more
convenient, doesn't it. What I am saying is the following:
Instead of the above if we can have

$basedir/r-t1/runner-0/result
$basedir/r-t1/runner-1/result
$basedir/r-t2/runner-0/result
$basedir/r-t2/runner-1/result

So all the files/results under one invocation are under one direction i.e, $basedir/r-t<n>/* where
t<n> is the timestamp we are looking for.

Please let me know what do you think of the above and if it has any pitfalls?
>  	local i
>  
>  	echo $run_section |grep -qw $section || return
>  	echo $exclude_section |grep -qw $section && return
>  
>  	echo
> -	echo Running section: $section
> +	echo Running section: $section $now
>  	echo
>  
>  	parse_config_section $section
>  
> -	# set up consumable test list first
> +	# update the test list if necessary, then set up
> +	# the consumable test list for this section to use.
> +	if [ "$last_fstyp" != "$FSTYP" ]; then
> +		setup_test_list
> +		last_fstyp=$FSTYP
> +	fi
> +	echo FS Type: $FSTYP
> +
> +	if [ -n "$show_test_list" ]; then
> +		echo Test list to run:
> +		cat $test_list
> +		return
> +	fi
>  	cp $test_list $test_list.$section
> +
>  	for ((i = 0; i < $runners; i++)); do
>  		runner_go $i $now $section &
>  	done
> @@ -360,17 +394,18 @@ run_section()
>  	echo
>  	echo Section: $section
>  	echo -n "Tests run: "
> -	grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> +	grep Ran $results/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
>  
>  	echo -n "Tests _notrun: "
> -	grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
> +	grep "^Not run" $results/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
>  
>  	echo -n "Failure count: "
> -	grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
> +	grep Failures: $results/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
>  	echo
>  
>  	echo Ten slowest tests - runtime in seconds:
> -	cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
> +	cat $results/check.time | sort -k 2 -nr | head -10
> +
>  }
>  
>  cleanup()
> @@ -386,27 +421,8 @@ cleanup()
>  trap "cleanup; exit" HUP INT QUIT TERM
>  
>  _config_setup_parallel
> -
>  run_section=${run_section:="$HOST_OPTIONS_SECTIONS"}
> -
>  _tl_setup_exclude_group "unreliable_in_parallel"
> -_tl_prepare_test_list
> -_tl_strip_test_list
> -
> -if ! $_tl_randomise -a ! $_tl_exact_order; then
> -	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
> -		time_order_test_list
> -	fi
> -fi
> -
> -# reverse the order of tests so that the get_next_test() can pull from the file
> -# tail rather than the head.
> -echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
> -if [ -n "$show_test_list" ]; then
> -	echo Time ordered test list:
> -	cat $test_list
> -	exit 0
> -fi
>  
>  # Each parallel test runner needs to only see it's own mount points. If we
>  # leave the basedir as shared, then all tests see all mounts and then we get
> @@ -422,6 +438,7 @@ fi
>  mount --make-private $basedir
>  
>  now=`date +%Y-%m-%d-%H:%M:%S`
> +last_fstyp=
Minor: Can we make last_fstyp somehow local to this file? The reason why I am asking is that, we
have some similar logic in run_section() of check ("$OLD_FSTYP" != "$FSTYP" -> recreate TEST_DEV)
and maybe in an unlikely event if somebody tends to re-use this variable name unknowingly - haven't thought about how would this script behave though, but just in case.
--NR
>  for section in $HOST_OPTIONS_SECTIONS; do
>  	run_section $section $now
>  	if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
> diff --git a/common/test_list b/common/test_list
> index 2b3ae9fbf..092b3ed17 100644
> --- a/common/test_list
> +++ b/common/test_list
> @@ -20,7 +20,7 @@ _XGROUP_LIST=
>  _tl_exact_order=false
>  _tl_randomise=false
>  _tl_have_test_args=false
> -_tl_file="$tmp.test_list"
> +_tl_cli_tests="$tmp._tl_cli_tests"
>  _tl_exclude_tests=()
>  _tl_tests=
>  
> @@ -122,8 +122,8 @@ _tl_prepare_test_list()
>  {
>  	unset _tl_tests
>  	# Tests specified on the command line
> -	if [ -s $_tl_file ]; then
> -		cat $_tl_file > $tmp.list
> +	if [ -s $_tl_cli_tests ]; then
> +		cat $_tl_cli_tests > $tmp.list
>  	else
>  		touch $tmp.list
>  	fi
> @@ -281,7 +281,7 @@ _tl_setup_cli()
>  				if grep -Eq "^$test_name" $group_file; then
>  					# in group file ... OK
>  					echo $_tl_src_dir/$test_dir/$test_name \
> -						>> $_tl_file
> +						>> $_tl_cli_tests
>  					_tl_have_test_args=true
>  				else
>  					# oops

