Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9BEEAC7
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799420; cv=none; b=UA/t1OLMJlAggJYcI5Aj/hMpoXy+VVnhNQZTRVi+UY756fgqVCyp2SZ/YKd667HdudKwGef5xD6NbdlzoBJOE4uHVjlD8d2aMWYb7B+hICu34dX2joEu8XW/bDiq5cXQnRNa0Osqn9xnLo5ielCUcD0dAgA9RG41n3cod7CmMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799420; c=relaxed/simple;
	bh=WVKOHxTWlb9glGJSuVnm1yqXBph+FDBil/JGNrxZZKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=FiL4z5U/F8376uc+bx4+aXnrm0hI7LT8s7amMwejoq2OMboZ2YIPV9p9whvGP/SDnXZV1DEQOVSKC4yoww18pbxq0NJIp77h+V+VG6JMGyDSRzO8yKa1y6FxigMVyityzHp/5Fr0zbN4vIc23q+K0DpL1m8JMzIB+Ebh4/vmM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b4ZvMq29; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b4ZvMq29"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549DOdkq031577;
	Fri, 9 May 2025 14:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/gH1qo
	pWX8F8dK8tyC8uMJDIoh7aq2CH2Rz52mEUG/M=; b=b4ZvMq29LWKClcMvQwHjvT
	7CXvq6w+CuCaEqVxAievrh7X9qoFRqDhDSYM+jvh/awe6RwAvIScpne1Dkl5tjM1
	VZ02qnhfAOx54kIGgc5pLVqVKZiGk28QjcjNpFMwOsZIHaEdBXOFr4qkNXHnf8lK
	qz9xhsCWTqgRo90igni/AGP17I5EXlfoQBDG02VrijbVbIiBqWgqxPbdiAzkj6UQ
	RkDWHsgtSXXs2+N+B43eHmh8vV4HZvFVgaNhGq9RD1xuTi5Isaw1MpMIox/IvDXh
	VxKOGv0HGwDn1/tq7IOATiM8RIakwVbr8Jz8/5SmXUbkxM30DtiZUJ5VHofiGeGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwc2cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 14:03:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549Cqfmx002729;
	Fri, 9 May 2025 14:03:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfpbksh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 14:03:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549E3Tdq22217110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 14:03:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CC69200BA;
	Fri,  9 May 2025 14:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4BF8200BD;
	Fri,  9 May 2025 14:03:28 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.25.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 14:03:28 +0000 (GMT)
Message-ID: <a569622c6609a3f154f259f0ae12a3751eab7a3d.camel@linux.ibm.com>
Subject: Re: [PATCH 16/28] check-parallel: run sections directly
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Fri, 09 May 2025 19:33:17 +0530
In-Reply-To: <20250417031208.1852171-17-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-17-david@fromorbit.com>
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
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e0b34 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=sQHciJR6UTdDH_00TMEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2IJV855iPxpwfgRhvrTjD7x1w0edgpNt
X-Proofpoint-ORIG-GUID: 2IJV855iPxpwfgRhvrTjD7x1w0edgpNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEyOCBTYWx0ZWRfXx2at/c811ZQ+ YrvRoerd2mOH5stUwugqzahQK8cAwrPMYz2qmcigSLO2Y6siWQO37MM6XlL1muGfFsXkgzsq415 C5eUy3bMJ3Lm5hhEeebhczR8qxaUQNNf4Q0xBS22wVmbqjxOe8ES4Bodk7MK5ORaDMI9qH0zIXB
 7VKcBjvQr5jvcZ6cOeR9s9H7X+ItRibRXpWPYN1jS5qpe3B2lGO2iALNuBpM/W3SOYia86pJIcX x+HInWeF+hCxL0QgCses7C/xaf+//1UM1NBIfJNEttpr3M7+ukx/JNGHvzHLuAIkECh+7etMbqG J0KpKRLaY00fvffk1lD2upiNYuHTFfYzArmIXS/yJRD5yxgguDbBkOuQG2bunLfKzdgkjGbvWQ8
 ZPuuoSaDGmLUbSJ5jnT7DWcbf8EwqwnyDpyJUFjSQbmOxkXiM7LzdmKEEQBVKo3mbsYV8QBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090128

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently we pass the section through to check for it to apply and
> run. However, we do not reconfigure the test or external devices in
If we are passing ./check -s <s1> -s <s2>, the devices will be reconfigured, right?
I was able to understand the implementation in this patch but I am not able to figure out the
reason. Could please explain "results in devices that may be incorrectly configured for the given
section config we want to run." 
Basically instead of check issuing multiple ./check -s <s1> -s <s2> ..., what we are doing is we are
issuing ./check -s <s1> # one section to ./check and each such ./check invocation is being made in
parallel - but what is wrong with multiple ./check -s <s1> -s <s2> in parallel?
> check-parallel after the initial setup, so thie results in devices
> that may be incorrectly configured for the given section config we
> want to run.
> 
> To fix this, we need to iterate the sections directly in
> check-parallel and reconfigure the runner device setup between each
> section that is run. This allows the test device and external
> devices to be set up correctly for each section config.
> 
> As the test list is consumed as we walk it, we need to reset the
> test list for each section that we run.
> 
> We still pass the config section through to check so that it can
> also source the correct config from the section we are running.
> 
> We also add section exclusion support so that we skip sections the
> same way that check currently does.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel         | 118 ++++++++++++++++++++++++++++-------------
>  common/config-sections |   3 ++
>  2 files changed, 84 insertions(+), 37 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index e2cf2c8d0..23d29c7a8 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -15,6 +15,7 @@ runner_list=()
>  runtimes=()
>  show_test_list=
>  run_section=""
> +exclude_section=""
>  iam="check-parallel"
>  
>  tmp=/tmp/check-parallel.$$
> @@ -119,7 +120,8 @@ while [ $# -gt 0 ]; do
>  
>  	-f)	is_supported_fstype $2 ; export FSTYP=$2; shift ;;
>  
> -	-s)	run_section="$run_section -s $2"; shift ;;
> +	-s)	run_section="$run_section $2"; shift ;;
> +	-S)	exclude_section="$exclude_section $2"; shift ;;
>  
>  	-*)	usage ;;
>  	*)	# not an argument, we've got tests now.
> @@ -202,11 +204,12 @@ fi
>  # each other.
>  get_next_test()
>  {
> +	local test_file="$test_list.$1"
>  	local test=
>  
>  	flock 99
> -	test=$(tail -1 $test_list)
> -	sed -i "\,$test,d" $test_list
> +	test=$(tail -1 $test_file)
> +	sed -i "\,$test,d" $test_file
>  	flock -u 99
>  	echo $test
>  }
> @@ -236,10 +239,34 @@ _destroy_loop_device()
>          losetup -d $dev || _fail "Cannot destroy loop device $dev"
>  }
>  
> -runner_go()
> +run_tests()
>  {
> +	local section="$1"
> +
>  	exec 99<>$tmp.test_list_lock
>  
> +	local test_to_run=$(get_next_test $section)
> +
> +	# Run the tests in it's own mount namespace, as per the comment below
> +	# that precedes making the basedir a private mount.
> +	#
> +	# Similarly, we need to run check in it's own PID namespace so that
> +	# operations like pkill only affect the runner instance, not globally
> +	# kill processes from other check instances.
> +	while [ -n "$test_to_run" ]; do
> +		echo -n " $test_to_run "
> +		unset FSTESTS_ISOL
> +		if ! _tl_expunge_test $test_to_run; then
> +			tools/run_privatens ./check -s $section $test_to_run >> $me/log 2>&1
> +		fi
> +
> +		test_to_run=$(get_next_test $section)
> +	done
> +}
> +
> +runner_go()
> +{
> +
>  	local id=$1
>  	local me=$basedir/runner-$id
>  	local _test=$me/test.img
> @@ -250,7 +277,7 @@ runner_go()
>  	local _scratch_log=$me/scratch-log.img
>  	local _logwrites=$me/logwrites.img
>  	local _results=$me/results-$2
> -	local test_to_run=$(get_next_test)
> +	local section=$3
>  
>  	mkdir -p $me
>  
> @@ -286,21 +313,7 @@ runner_go()
>  
>  #	export DUMP_CORRUPT_FS=1
>  
> -	# Run the tests in it's own mount namespace, as per the comment below
> -	# that precedes making the basedir a private mount.
> -	#
> -	# Similarly, we need to run check in it's own PID namespace so that
> -	# operations like pkill only affect the runner instance, not globally
> -	# kill processes from other check instances.
> -	while [ -n "$test_to_run" ]; do
> -		echo "Runner $id: running test $test_to_run"
> -		unset FSTESTS_ISOL
> -		if ! _tl_expunge_test $test_to_run; then
> -			tools/run_privatens ./check $run_section $test_to_run >> $me/log 2>&1
> -		fi
> -
> -		test_to_run=$(get_next_test)
> -	done
> +	run_tests $section
>  
>  	wait
>  	sleep 1
> @@ -322,6 +335,44 @@ runner_go()
>  
>  }
>  
> +run_section()
> +{
> +	local section="$1"
> +	local now="$2"
> +	local i
> +
> +	echo $run_section |grep -qw $section || return
> +	echo $exclude_section |grep -qw $section && return
> +
> +	echo
> +	echo Running section: $section
> +	echo
> +
> +	parse_config_section $section
> +
> +	# set up consumable test list first
> +	cp $test_list $test_list.$section
> +	for ((i = 0; i < $runners; i++)); do
> +		runner_go $i $now $section &
> +	done
> +	wait
> +
> +	echo
> +	echo Section: $section
> +	echo -n "Tests run: "
> +	grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> +
> +	echo -n "Tests _notrun: "
> +	grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
> +
> +	echo -n "Failure count: "
> +	grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
> +	echo
> +
> +	echo Ten slowest tests - runtime in seconds:
> +	cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
> +}
> +
>  cleanup()
>  {
>  	killall -INT -q check
> @@ -336,6 +387,8 @@ trap "cleanup; exit" HUP INT QUIT TERM
>  
>  _config_setup_parallel
>  
> +run_section=${run_section:="$HOST_OPTIONS_SECTIONS"}
> +
>  _tl_setup_exclude_group "unreliable_in_parallel"
>  _tl_prepare_test_list
>  _tl_strip_test_list
> @@ -369,23 +422,14 @@ fi
>  mount --make-private $basedir
>  
>  now=`date +%Y-%m-%d-%H:%M:%S`
> -for ((i = 0; i < $runners; i++)); do
> -	runner_go $i $now &
> -done;
> -wait
> -
> -echo -n "Tests run: "
> -grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> -
> -echo -n "Tests _notrun: "
> -grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -l
> -
> -echo -n "Failure count: "
> -grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l
> -echo
> -
> -echo Ten slowest tests - runtime in seconds:
> -cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
> +for section in $HOST_OPTIONS_SECTIONS; do
> +	run_section $section $now
> +	if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
> +		interrupt=false
> +		status=`expr $sum_bad != 0`
> +		exit
> +	fi
> +done
>  
>  echo
>  echo Cleanup on Aisle 5?
> diff --git a/common/config-sections b/common/config-sections
> index 28bd11bab..c0ea097e8 100644
> --- a/common/config-sections
> +++ b/common/config-sections
> @@ -436,6 +436,9 @@ _config_setup_parallel()
>  		exit 1
>  	fi
>  
> +	# strip check-parallel from the sections to run
> +	export HOST_OPTIONS_SECTIONS=`echo $HOST_OPTIONS_SECTIONS | sed -e "s/$iam//"`
> +
>  	grep DEV $HOST_OPTIONS |grep -qv SIZE
>  	if [ $? -ne 1 ]; then
>  		echo "$iam config file has devices defined"

