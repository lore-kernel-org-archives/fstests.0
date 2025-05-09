Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C128F524
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792121; cv=none; b=LT5m24xrgoLKET75wWVh0qsMCgbTM7IoNcJ40ZL8eDR1k85Hq2rtSymzeot6Ixnq8IMyEnGAojc7r99t8yivkWiBHjDolmCHqE+RrMtMNvZqMfsGvpURnrGtwpLFScDCkUVTygmYNgiuSxHMZxf95H1qIDl8O80NjKbaNiC0ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792121; c=relaxed/simple;
	bh=qZs7cuQgmKmFARc09XvByjgKcNfZ83pWJj/FlEf0iZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=GxDiOE4l7kwU1EXfXXM5jAmoms0ZJBpaukGFasu4KOYXSbSGld7tf/z5SccL1qFi0x2z/t0f6m1oCAny4lx5xfk4tupYuanqQtqGY+zw5W0hEjCG2sYFoyUZcsMFrxGePSUDxUw0pYSJObG1Dpx3rCXHCJv+AX7oW1UHhFy+qMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NuGaYP4y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NuGaYP4y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AegZL003892;
	Fri, 9 May 2025 12:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WRXotF
	ANv9HBeLfe6F6eW9rsQveMA8Y9xjjj1RVBHJA=; b=NuGaYP4yFjkwHxz6GlUZ5D
	vHhxS0NPKsl3Pj0ISKsi8HLLytN+yZJH+jWI9+TVLzI78X2eoGuVIl5PvBCmxX4A
	feasjH9kZMWO8xuxn3SlmfbJsvLMX7NxNS9MsNd9gqAUBVBB/tHjTkkPi5XRD/SA
	QLNCJbmh85XcWCTqGHerEKAq7ATlL5Vn9qBydnNoFcBY4CdzN4EqFLJtGE6Me6EH
	7pN1ITXCig1q2R5nucFdHJdVfAp9DoL8LygXq2ZXbpmdpEV2Fv4syPWP0daEQkKC
	mAOKZ+ktuCkrKZh/LSR9JnFAIUSIX4ozA2PyjSzBnFj4ks4+g8BDhPjf3xThA6Jw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46hg5sga9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:01:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549Aa6cO014087;
	Fri, 9 May 2025 12:01:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm2xv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:01:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549C1qmN30409306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:01:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D7D2011E;
	Fri,  9 May 2025 12:01:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7712011B;
	Fri,  9 May 2025 12:01:50 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.25.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 12:01:50 +0000 (GMT)
Message-ID: <077e031f6b6b179c9b5dabf284e3015c37dc3367.camel@linux.ibm.com>
Subject: Re: [PATCH 13/28] check-parallel: introduce config file support
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Fri, 09 May 2025 17:31:49 +0530
In-Reply-To: <20250417031208.1852171-14-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-14-david@fromorbit.com>
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
X-Proofpoint-GUID: n9UjgqzKI-ow--p3Di2NRmpLb2lL5AcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExMiBTYWx0ZWRfX7tiVSJenwwZb gITlk/kvOpqhWAWZ4P6+zrr0VLETtudQVg9GPaB+nSVTweU2Gkmyu8zAB+UKTj5+jj/+4ltcNun Uwg17dUjGv1CM293jOtWN/ShZsQU93d1GTIFKcg6puhMtVHtlY3Fq6XowolxhZXpeZIS7fAqTtC
 VTAoPAOTMtmfjtr3IhgZ2z5bRPVk9kOS4P71yb9DvW5RzpILf/671/oN5+syQ/fkCeXkWBO4zfm LKPFPdNUlUWWUa3meeeBdRf7h/f7bIhJNEm9xGWW3KnbYLFGs4anfjzsSV3tMYUAA6ocdIyaKE0 gLm2VYXlKOiLJYl0rZv848pmo5XWGRj7+22TK9cWnXyyuaHmTlKYNUJslh2t7JPL6X5HsbxhZ9L
 9OeGQwmqRsHkTMUEY1tX91Aiogq2C7koN16hajuNfaF7jUSkuNfjyOlVFipnbNlGzuaL7GQD
X-Proofpoint-ORIG-GUID: n9UjgqzKI-ow--p3Di2NRmpLb2lL5AcO
X-Authority-Analysis: v=2.4 cv=NrjRc9dJ c=1 sm=1 tr=0 ts=681deeb2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=byUmkVefNbIXhXqmJEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090112

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> check-parallel will use the same config file format check does,
> and use the same code to auto-discover the config file.
> 
> The biggest difference is that check-parallel -requires- the use
> of config sections, and the first section *must* be named
> "[check-parallel]". This first section is used for defining
> setup parameters for check parallel - loop device image file sizes,
> etc.
> 
> The second biggest difference is that check-parallel does not allow
> the config file to define devices. Any section found to contain a
> device definition such as TEST_DEV or SCRATCH_DEV will result
> check-parallel terminating with an error.
> 
> This config file format works for check-parallel invoking check,
> too, because once a section is specified on the check command line,
> it effectively ignores unknown values set in sections that it
> doesn't run.  Hence it effectively skips over the [check-parallel]
> setup section.
> 
> For check-parallel, each config section now defines just the
> filesystem configuration to be tested; all the usual mount and mkfs
> options apply, and USE_EXTERNAL must be set for testing external
> devices.
> 
> This commit implements the initial [check-parallel] section support
> and moves the build in default values for these parameters to the
> config file setup. This means if the config file does not contain
> all the necessary parameter values, a default value will be used for
> it.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel         | 14 +++-----
>  common/config-sections | 78 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 77 insertions(+), 15 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 5bb44b6a5..6fc86fb92 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -15,22 +15,14 @@ runner_list=()
>  runtimes=()
>  show_test_list=
>  run_section=""
> +iam="check-parallel"
>  
>  tmp=/tmp/check-parallel.$$
>  
> -TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
> -TEST_RTDEV_SIZE=${TEST_RTDEV_SIZE:=10G}
> -TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
> -SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
> -SCRATCH_RTDEV_SIZE=${SCRATCH_RTDEV_SIZE:=20G}
> -SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SIZE:=512M}
> -LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
> -
> -FSTYP=
> -
>  . ./common/exit
>  . ./common/test_names
>  . ./common/test_list
> +. ./common/config-sections
>  
>  usage()
>  {
> @@ -332,6 +324,8 @@ cleanup()
>  
>  trap "cleanup; exit" HUP INT QUIT TERM
>  
> +_config_setup_parallel
> +
>  split_runner_list
>  if [ -n "$show_test_list" ]; then
>  	echo Time ordered test list:
> diff --git a/common/config-sections b/common/config-sections
> index 69a03375a..28bd11bab 100644
> --- a/common/config-sections
> +++ b/common/config-sections
> @@ -329,6 +329,7 @@ get_next_config() {
>  
>  known_hosts()
>  {
> +	[ -z "$HOST" ] && export HOST=`hostname -s`
>  	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
>  
>  	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
> @@ -336,7 +337,7 @@ known_hosts()
>  	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
>  }
>  
> -_config_section_setup()
> +_config_file_setup()
>  {
>  	if [ ! -f "$HOST_OPTIONS" ]; then
>  		known_hosts
> @@ -346,13 +347,32 @@ _config_section_setup()
>  	export OPTIONS_HAVE_SECTIONS=false
>  	if [ -f "$HOST_OPTIONS" ]; then
>  		export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
> -		if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
> -			. $HOST_OPTIONS
> -			export HOST_OPTIONS_SECTIONS="-no-sections-"
> -		else
> +		if [ -n "$HOST_OPTIONS_SECTIONS" ]; then
>  			export OPTIONS_HAVE_SECTIONS=true
>  		fi
>  	fi
> +}
> +
> +_config_section_setup()
> +{
> +	if [ "$iam" == "check-parallel" ]; then
> +		echo "$iam: incorrect config file format chosen!"
> +		exit 1;
> +	fi
> +
> +	_config_file_setup
> +
> +	# If we don't have sections, source the options from the config file.
> +	# Otherwise, strip sections that should not be run by check that may be
> +	# present in the config file
> +	if [ "$OPTIONS_HAVE_SECTIONS" != "true" ]; then
> +		. $HOST_OPTIONS
> +		export HOST_OPTIONS_SECTIONS="-no-sections-"
> +	else
> +		export HOST_OPTIONS_SECTIONS=$(echo $HOST_OPTIONS_SECTIONS | \
> +				sed -e 's/check-parallel//')
> +	fi
> +
>  
>  	if [ -z "$CONFIG_INCLUDED" ]; then
>  		get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
> @@ -388,3 +408,51 @@ _config_section_setup()
>  		fi
>  	fi
>  }
> +
> +# check-parallel config files must:
> +# 1. have config sections defined
> +# 2. use the first config section for check-parallel setup
> +# 3. not define any physical device parameter in any section
Nit: Maybe some documentation of the above restrictions and some new
variables introduced (like SCRATCH_DEV_SIZE, ..)in the README?
> +# If all these are true, then we read the first section that defines
> +# the check-parallel config parameters and continue onwards.
> +_config_setup_parallel()
> +{
> +	if [ "$iam" != "check-parallel" ]; then
> +		echo "$iam: incorrect config file format chosen!"
> +		exit 1;
> +	fi
> +
> +	_config_file_setup
> +
> +	if [ "$OPTIONS_HAVE_SECTIONS" != "true" ]; then
Most of the places the way OPTIONS_HAVE_SECTIONS is being used is as 
if $OPTIONS_HAVE_SECTIONS; then 
    ...
fi

so, when OPTIONS_HAVE_SECTIONS=true, /bin/true is executed and the exit
code of /bin/true is always a success and it is not a string comparison
with "true" or "false". /bin/true always succeeds and hence if
OPTIONS_HAVE_SECTIONS=true, then 
if $OPTIONS_HAVE_SECTIONS is always executed. In the same way
/bin/false always has a failure code upon exit.
So maybe we should change this to 
if $OPTIONS_HAVE_SECTIONS; then - just to have consistency with the
rest of the code?
> +		echo "$iam config file has no sections!"
> +		exit 1;
> +	fi
> +
> +	local first_section=`echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
> +	if [ "$first_section" != "$iam" ]; then
> +		echo "$iam config file has no [$iam] section"
> +		exit 1
> +	fi
> +
> +	grep DEV $HOST_OPTIONS |grep -qv SIZE
This will incorrectly fail the check-parallel invocation even if we
have the devices defined in the comment section - so something like the
following is causing a failure

local.config >>
[check-parallel]
TEST_DEV_SIZE=2G
#TEST_DEV=/dev/loop0

Maybe we should try to ignore the lines that begin with '#'
something like - grep -v '^[[:space:]]*#' $HOST_OPTIONS | grep DEV |
grep -qv SIZE ? 

Another case:

Let us consider another local.config file:

[check-parallel]
TEST_DEV_SIZE=2G

[xfs_4k]
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/test
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

The above file runs fine ./check -s xfs_4k selftest/001

However, with check-parallel, it will fail and it is expected according
to the design. But is there any specific reason to fail when the above
configuration is perfectly suitable to run check-parallel (we have
check-parallel, section defined)? So 

./check-parallel -s check-parralel -D /mnt1 -x stress -t 1 selftest/001
check-parallel config file has devices defined

Instead of grepping on the entire $HOST_OPTIONS, how about we only grep
on the check-parallel section? In this way we parse/export the
environment variables only in check-parallel section and ignore the
sections that have devices defined and/or check-parallel incompatible.
./check -s xfs_4k works anyway with [check-parallel] section defined.
./check -s check-parallel will fail with *DEVs not defined which is
self explanatory.

Some something like:
get_env_section $first_section | grep -v '^[[:space:]]*#' | grep DEV | 
grep -qv SIZE

get_env_section()
{
   # code taken from parse_config_section
   SECTION=$1
   echo `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
   -e 's/#.*$//' \
   -e 's/[[:space:]]*$//' \
   -e 's/^[[:space:]]*//' \
   -e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
   < $HOST_OPTIONS \
   | sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
}

The value that we are getting out of the the above suggestion
modification is that we can re-use local.config file between check and
check-parallel. 
Please let me know what do you think of the above?
> +	if [ $? -ne 1 ]; then
+		echo "$iam config file has
> devices defined"
+		exit 1
+	fi
+
+	# we only need to
> pull in the config parameters here and set defaults
+	# if they are
> not set after pulling in the config values.
> +	parse_config_section $1
What value is $1 holding? _config_setup_parallel is being called only
from check-parallel without any parameters passed, right? Did you mean
_config_setup_parallel $first_section ?
--NR
> +
+	TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
+	TEST_RTDEV_SIZE=${TES
> T_RTDEV_SIZE:=10G}
+	TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
+	
> SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
+	SCRATCH_RTDEV_SIZE=${SC
> RATCH_RTDEV_SIZE:=20G}
+	SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SI
> ZE:=512M}
+	LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
+
+	FSTYP
> =${FSTYP:=xfs}
+}

