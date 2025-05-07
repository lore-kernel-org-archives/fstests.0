Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2620298C
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612347; cv=none; b=e9/ZR83ioEsUdFs1yQV3jEBK7eBXfekkDVHBIo+tDxymgBOvffLwD941gRvFn/pJ9kYWKT6gKfisRl+8s1uP/3lv2ChXtScWo547n/qFO67VQcJn03ngbemSO6Pax9EVLrdfPh8x/8hexiAOFxTmUTz9Z5CKD56h8y3AAi9DLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612347; c=relaxed/simple;
	bh=Yn+a745qix5ZX0/lig1QZbbfxgXBV8FhrUUK8xpzeE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Qar87Xybzzn6NLI+U1sY1P7C4FiPbPH2gWGYFoawjekchj5j6T88jxLIWcMyi4zlX1y14KXf5jT667fPPxavRimvV2dpkFDtU3nSMgL/Pd2T5WB87pdWfATzw3IjT6zy/XFy+kGg4ZRzhWzgIvz7z6SzIwY94igSMUTPL07RWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKTL15R7; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKTL15R7"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2ada8264aso5392811fac.2
        for <fstests@vger.kernel.org>; Wed, 07 May 2025 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746612345; x=1747217145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWhSdsdv6LHreCrYWhWckHRtwnAsxoHVouii6z2EgYU=;
        b=gKTL15R7PNvoQlwrtK2DEtZwOJcETm8zKwASMJXP8xxzVFjTUdRNlg1M1tBxq8neMh
         d/gGMQgMv12iCnYcj5ulh47/uXq1u+rLd4MzJTM1jGah5NhFj1zz1OpxRQHYCLzOD99p
         XV0Yorj3QNbIEk8EENu5qbu8Y6iq8zspsA+zXHa7Tyxc7M64UzjJCB4F2YO21mAJjCP7
         LPbZxzL5zFtHcwcPyd/Dh8K64AlFDbuO4xw8zGe9c4ZzQkOTILIYYYWo9ZDmbkSw10tl
         RpPuicLATAd4uU57yqkN+EaFDCpftEKmViyi1zXQ9RMQ6MQU8k6k1/uME3qbCMnCquUV
         I0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746612345; x=1747217145;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWhSdsdv6LHreCrYWhWckHRtwnAsxoHVouii6z2EgYU=;
        b=GdOXsUqx/8foqn4cutWV7G70YmgsR1Iwm2zTPxxDk+aqflfA/5SNWvx54jjtiX2eEg
         hfnYVDifd6kWbikZVY9EvHQuFTs5GjiFp1oYXKS+CU55h/mrh91BdsVyBMGgQMPpmNN5
         zHe3x723AXGpeMWvX1rWJB2n74P8YzYEa0xDZGb5FmcrqfpBjAqavjTjJE4YOOgFgCg9
         f9wd5v1pnWbkuY/v8i29dyaaCl7FhG0UVDJ6NI0xGDV2m/N5CSx5ctx5AaxEu4aCd8tE
         P+2mtss5bwsOiWd8BJvd1TKCKxY1/2EekrIGHkL/Hgzx9tZCc/agUyFm2cBOFJPvWTkI
         jurA==
X-Forwarded-Encrypted: i=1; AJvYcCXMmzSnuCA94M88ZDny38KjGwNM+gKtpsg6k9NDtfAuyRZHt1YGmm0xqqt0AG8Ov4Bv2U9Wr6vx@vger.kernel.org
X-Gm-Message-State: AOJu0YzeygkS02TRm8+JGIpZKzl2tuFh1plGcfT/omA9Wz7Dj40ewfFp
	BqqiRBqfGdstgER8nKZ+AqgJ6pTH8hEii0jmsqM6IC9dV6CInZBoWF9Aig==
X-Gm-Gg: ASbGncusZUVb1CqP8vNIR2JA5z5mOrf57c4DhMfX+aa4orRMM0eB8UXDBIgYNnp8BVP
	BzGn7A+8VTo3LBtGa1xVRxBWCZ34Uhv2HasmFIKI/hWQ7/j3R5G5rENYFAmRvCMq59gC2CxNP+3
	zHvjG0x9rygqD+jLr2pDy4rnZFu7UZEWbmvTg5HxP7rHgTvBLnpxiDYloLpm14D1PvSf7m+0/1T
	zgn3T+KP7XgvIaXqYBdTqrBUwxjPvuCtLaRg9hvtRf/by2ezq2Lne1OJJZ2T8j417CrWarSYS4F
	I884jePR4Ad9QOxKSJbpTbVwOyw+oxm2PeMtcBiuplrkOrBstAHQQWT4uCwONwJuK6OVnxGMtJT
	kg6IeiBIiRIfQsEJtNg==
X-Google-Smtp-Source: AGHT+IFGGKDuwgD3usBpPmonpihADCI133cIPRIcoz5JcGG9fojcnIFCzFceoAKJMIt9ZRMn16A61w==
X-Received: by 2002:a17:90b:3a85:b0:30a:4c44:cc05 with SMTP id 98e67ed59e1d1-30aac183aefmr4811514a91.10.1746612334362;
        Wed, 07 May 2025 03:05:34 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaec170eesm1569734a91.31.2025.05.07.03.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 03:05:33 -0700 (PDT)
Message-ID: <c63cadb8922f591e6bc3a528db35e96ebc6e9949.camel@gmail.com>
Subject: Re: [PATCH 11/28] check-parallel: initial support for specifying
 device sizes
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 07 May 2025 15:35:29 +0530
In-Reply-To: <20250417031208.1852171-12-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-12-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Rather than hard coding loop device sizes, abstract them out into
> environment variables with defined default values. This allows
> a check-parallel wrapper to specify sizes or, in future, for them
> to be read from a config file. Sizes are specified in human readable
> values using M/G/T suffixes to indicate the units being specified
> 
> Whilst doing this also add support for creating all the external
> devices that XFS uses during fstests execution. A typical setup
> will be something like:
> 
> TEST_DEV_SIZE=10G
> TEST_RTDEV_SIZE=10G
> TEST_LOGDEV_SIZE=128M
> SCRATCH_DEV_SIZE=20G
> SCRATCH_RTDEV_SIZE=20G
> SCRATCH_LOGDEV_SIZE=512M
> LOGWRITES_DEV_SIZE=2G
Should we document these new variables in README?

The functionality looks fine to me. I have some refactoring suggestions
below (nothing functional). 
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index aa88c681e..5bb44b6a5 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -18,6 +18,14 @@ run_section=""
>  
>  tmp=/tmp/check-parallel.$$
>  
> +TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
> +TEST_RTDEV_SIZE=${TEST_RTDEV_SIZE:=10G}
> +TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
> +SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
> +SCRATCH_RTDEV_SIZE=${SCRATCH_RTDEV_SIZE:=20G}
> +SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SIZE:=512M}
> +LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
> +
>  FSTYP=
>  
>  . ./common/exit
> @@ -116,7 +124,7 @@ while [ $# -gt 0 ]; do
>  	--exact-order) _tl_setup_ordered ;;
>  	-n)	show_test_list="yes" ;;
>  
> -	-f)	is_supported_fstype $2 ; FSTYP=$2; shift ;;
> +	-f)	is_supported_fstype $2 ; export FSTYP=$2; shift ;;
>  
>  	-s)	run_section="$run_section -s $2"; shift ;;
>  
> @@ -243,22 +251,35 @@ runner_go()
>  	local id=$1
>  	local me=$basedir/runner-$id
>  	local _test=$me/test.img
> +	local _test_rt=$me/test-rt.img
> +	local _test_log=$me/test-log.img
>  	local _scratch=$me/scratch.img
> +	local _scratch_rt=$me/scratch-rt.img
> +	local _scratch_log=$me/scratch-log.img
>  	local _logwrites=$me/logwrites.img
>  	local _results=$me/results-$2
>  
>  	mkdir -p $me
>  
> -	xfs_io -f -c 'truncate 2g' $_test
> -	xfs_io -f -c 'truncate 8g' $_scratch
> -	xfs_io -f -c 'truncate 1g' $_logwrites
> +	xfs_io -f -c "truncate $TEST_DEV_SIZE" $_test
> +	xfs_io -f -c "truncate $TEST_RTDEV_SIZE" $_test_rt
> +	xfs_io -f -c "truncate $TEST_LOGDEV_SIZE" $_test_log
> +	xfs_io -f -c "truncate $SCRATCH_DEV_SIZE" $_scratch
> +	xfs_io -f -c "truncate $SCRATCH_RTDEV_SIZE" $_scratch_rt
> +	xfs_io -f -c "truncate $SCRATCH_LOGDEV_SIZE" $_scratch_log
> +	xfs_io -f -c "truncate $LOGWRITES_DEV_SIZE" $_logwrites
Do you like the following refactoring:


declare -a devices_map=(
	"$TEST_DEV_SIZE:$_test:TEST_DEV"
	"$TEST_RTDEV_SIZE:$_test_rt:TEST_RTDEV"
	"$TEST_LOGDEV_SIZE:$_test_log:TEST_LOGDEV"
	"$SCRATCH_DEV_SIZE:$_scratch:SCRATCH_DEV"
	"$SCRATCH_RTDEV_SIZE:$_scratch_rt:SCRATCH_RTDEV"
	"$SCRATCH_LOGDEV_SIZE:$_scratch_log:SCRATCH_LOGDEV"
	"$LOGWRITES_DEV_SIZE:$_logwrites:LOGWRITES_DEV"
)
create_dev_images devices_map

create_dev_images() {
    # this executes commands like 
    # xfs_io -f -c "truncate 10G  <test-file.img>"
    # for all the devices
    local  -n dev_list="$1"  
    for entry in "${dev_list[@]}"; do
        IFS=':' read -r -a tuple <<< "$entry"
        xfs_io -f -c "truncate ${tuple[0]}  ${tuple[1]}"
    done
}

>  
>  	export TEST_DEV=$(_create_loop_device $_test)
> +	export TEST_RTDEV=$(_create_loop_device $_test_rt)
> +	export TEST_LOGDEV=$(_create_loop_device $_test_log)
>  	export TEST_DIR=$me/test
> +
>  	export SCRATCH_DEV=$(_create_loop_device $_scratch)
> +	export SCRATCH_RTDEV=$(_create_loop_device $_scratch_rt)
> +	export SCRATCH_LOGDEV=$(_create_loop_device $_scratch_log)
>  	export SCRATCH_MNT=$me/scratch
> +
>  	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
Something similar as above:

create_devices()
{
    # This exports all the device related environment variables
    # like TEST_DEV, SCRATCH_DEV etc.
 
    local -n dev_list="$1" 
    IFS=':' read -r -a tuple <<< "$entry"
    eval "export ${tuple[2]}=\$(_create_loop_device ${tuple[1]})"
	
}
and then simply call
create_devices devices_map
export TEST_DIR=$me/test
export SCRATCH_MNT=$me/scratch


> -	export FSTYP=xfs
>  	export RESULT_BASE=$_results
>  
>  	mkdir -p $TEST_DIR
> @@ -285,7 +306,11 @@ runner_go()
>  	umount -R $TEST_DIR 2> /dev/null
>  	umount -R $SCRATCH_MNT 2> /dev/null
>  	_destroy_loop_device $TEST_DEV
> +	_destroy_loop_device $TEST_RTDEV
> +	_destroy_loop_device $TEST_LOGDEV
>  	_destroy_loop_device $SCRATCH_DEV
> +	_destroy_loop_device $SCRATCH_RTDEV
> +	_destroy_loop_device $SCRATCH_LOGDEV
>  	_destroy_loop_device $LOGWRITES_DEV
destroy_devices()
{
    # This destroys all the loop devices that were created. 

    local -n dev_list="$1"
    IFS=':' read -r -a tuple <<< "$entry"
    eval "_destroy_loop_device \$${tuple[2]}"
}
and then call
destroy_devices devices_map. 
IMO, this reduces the number of lines of code and adding an entry to
devices_map automatically does the devices creation, removal and
setting of environment variables without having to manually add them.
This is just a suggestion - please let me know what do you think about
this.
--NR
>  
>  	grep -q Failures: $me/log

