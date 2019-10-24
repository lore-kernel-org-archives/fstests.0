Return-Path: <SRS0=fGqU=YR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C2CA9EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7272166E
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF5yC8/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392650AbfJXQBt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:01:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36732 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXQBt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Oct 2019 12:01:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so12071096plk.3
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2019 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRuNTuryLkbd9vH/+iBWd0pYBdMdzakpvm5iVbzv3/A=;
        b=YF5yC8/cG8/PmNQAfd2x19AKkFAxTId1T2KDYaRCmVPJNVcvUkB6SQmzrQGgbdSIQJ
         3zfki5GJeX2j9OSuvCTHfVjRmSmo3RDttlqEWKCd5DX6wRFqzxlBknr1XnGQcD1JqzSB
         mU3va8BFeGeYWdYh3CzUgLrT+vZVnF+rECfNAbTGolsdMEU13qLqtWBKsrSj11Nxh93f
         j3HEzVsGytulQpqL+eVXZsN6HspKjGKkR4/HfrMETwNHMR0OX/rhwj4uYHEixcX4yI3p
         ZQRA0XshoMxoSctdVOvLuCuOexJi389oDQyycqtb7X+fpit7Itazh8Xt7DZwOM9bva84
         tAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRuNTuryLkbd9vH/+iBWd0pYBdMdzakpvm5iVbzv3/A=;
        b=WgLTSCR4Ty0D8am5bYqrOteGv2hUlJB4V1ZsJQtEa+LgPt6+JQgmwqnnAeOBiRNJ1Q
         7XGRf02vYwXZStO0Ccfws93ysNwnWI7CVeqxCkihmI2SieaH9gkx5EuZcDEWrW8wN3FI
         zhQEUCnW1R5R0HDl6yaMnQvutk3O+DcB7TLUsx+DFAxCJ8YlWul82dsyX4ldLyiMRp0G
         S+rbt+dSlV0vpstHzf6Zuyie8/mFaVpZR3tXieEu8rJiB5HeTmYftm2CwTM944NtaRrn
         yO5Vawe+ULDooJ0dT9ZIMPTPuoi+eyo2/08CCa9K5LGSQLlS0ugoZamSCQ3Fyuhj9KRR
         JLkA==
X-Gm-Message-State: APjAAAXG1x/TeO/WetQUNyVTKMk43QDAfffRjBWc7j7vE0dPylfvnN/Y
        y/F6O0DrTKIIwDKUCNkK1m4=
X-Google-Smtp-Source: APXvYqxcE5WsBXugBujAf6wv+bf+XvJSbHmmOFdSHXVWCLGwvj4gcqckiN0PRcQpYNBI92LTYyQ0eA==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr1713026plo.225.1571932908057;
        Thu, 24 Oct 2019 09:01:48 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id s5sm2586371pjn.24.2019.10.24.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:01:47 -0700 (PDT)
Date:   Fri, 25 Oct 2019 00:01:41 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     fstests@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: Re: [PATCH] generic/402: update test script style
Message-ID: <20191024160141.GF2543@desktop>
References: <20191023220401.12335-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023220401.12335-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 23, 2019 at 03:04:01PM -0700, Deepa Dinamani wrote:
> Removed test result checking, as test result already depends on
> output diff comparison with the golden output.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Thanks! I've folded this into original patch.

Thanks,
Eryu

> ---
>  tests/generic/402     | 33 +++++++--------------------------
>  tests/generic/402.out |  2 +-
>  2 files changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/generic/402 b/tests/generic/402
> index dd136ec2..0392c258 100755
> --- a/tests/generic/402
> +++ b/tests/generic/402
> @@ -44,14 +44,11 @@ check_stat()
>  	prev_timestamp="$timestamp;$timestamp"
>  	if [ $prev_timestamp != $stat_timestamp ]; then
>  		echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
> -		return 1
>  	fi
> -	return 0
>  }
>  
>  run_test_individual()
>  {
> -	fail=0
>  	file=$1
>  	timestamp=$2
>  	update_time=$3
> @@ -62,33 +59,24 @@ run_test_individual()
>  		$XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
>  		if [ $? -ne 0 ]; then
>  			echo "Failed to update times on $file" | tee -a $seqres.full
> -			fail=1
>  		fi
>  	fi
>  
>  	tsclamp=$((timestamp<tsmin?tsmin:timestamp>tsmax?tsmax:timestamp))
>  	echo "Checking file: $file Updated timestamp is $tsclamp"  >> $seqres.full
> -	if ! check_stat $file $tsclamp; then
> -		fail=1
> -	fi
> -	return $fail
> +	check_stat $file $tsclamp
>  }
>  
>  run_test()
>  {
> -	fail=0
>  	update_time=$1
>  
>  	n=1
>  
>  	for TIME in "${TIMESTAMPS[@]}"; do
> -		if ! run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time; then
> -			fail=1
> -		fi
> +		run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
>  		((n++))
>  	done
> -
> -	return $fail
>  }
>  
>  _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> @@ -108,8 +96,7 @@ declare -a TIMESTAMPS=(
>  	$((tsmax+1))
>  )
>  
> -_scratch_mount
> -result=$?
> +_scratch_mount || _fail "scratch mount failed"
>  
>  status=0
>  
> @@ -119,9 +106,7 @@ echo "In memory timestamps update test start" >> $seqres.full
>  # update time on the file
>  update_time=1
>  
> -if ! run_test $update_time; then
> -	status=1
> -fi
> +run_test $update_time
>  
>  echo "In memory timestamps update complete" >> $seqres.full
>  
> @@ -140,13 +125,9 @@ update_time=0
>  echo "On disk timestamps update test start" >> $seqres.full
>  
>  # Re-run test
> -if ! run_test $update_time; then
> -	status=1
> -fi
> +run_test $update_time
>  
>  echo "On disk timestamps update test complete" >> $seqres.full
>  
> -echo "inode timestamp tests completed status $status"
> -
> -# success, all done
> -exit $status
> +echo Silence is golden
> +exit
> diff --git a/tests/generic/402.out b/tests/generic/402.out
> index 4500e6c7..28e1501c 100644
> --- a/tests/generic/402.out
> +++ b/tests/generic/402.out
> @@ -1,2 +1,2 @@
>  QA output created by 402
> -inode timestamp tests completed status 0
> +Silence is golden
> -- 
> 2.17.1
> 
