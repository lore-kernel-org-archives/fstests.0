Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA06221FB7
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608555; cv=none; b=tEun1z6qyeqa5uLBbm/ZcSpfNzcDLm7jaQjBn4lBgWIndGVYJxpXYJcmf2hUdFHf5mTjKtS+cwPkbXefncaW+d9UPn3+ikDsdPTCDX0OVvZLsHsTkfG+VfYmZXfzEwIsI9tw6Bx6sXMniJ8fcp+nnBuN0UONkOe+1ddMevq7BLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608555; c=relaxed/simple;
	bh=syaMzory2SDhUrgHQRNJS/hh65z+M9jgSk1gcBF3cDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=cGcLqhQ6geFbvmz8SRhvJlpBWr0/M2/VJ9JRNR1xuzg3jXo+A/8tH5D+7C9XiYkGOPm4PgW3Q8b2owwXMxuuqTtyCNjB021Q5T2k0ZTS3LclgYB9yrhDf1waGPU8It3wHJKZH0jfP5+tpvqY227rTk4RDnKoXb9xQU7NrvtDiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOx0x+pV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOx0x+pV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73c17c770a7so9173113b3a.2
        for <fstests@vger.kernel.org>; Wed, 07 May 2025 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746608553; x=1747213353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0ZDy1NxfXAG8NZJMJqXrQW/sHCQP8ewWRYdMWB3AGo=;
        b=lOx0x+pVuqACcnKysOhkMtzAsky6KMWbHK5rIA0OyBlPmSmgA7K1YZayrySbFQ8aoj
         prJ6s4BL691CZQUTorMUY947lAA45h9yXRkzJn8kB0Ai3eoybk1eX8oCa0QmFXu32B61
         ENHgBAFocGc5fP0yOuXjDqvbat8kzLrvAUhXweU10aL+dSe2sS7mCpG+Mc4NgdXQncV7
         SfytytgHBzIITD0kI5rgeUHEy3cF/wQUxwMkpYLpdXCBKtEqK4IFj2zNix3c52l8cvxK
         vl2gBJhxIhO74U0uOEHkNXXzem6urAuVzmhqCbJirGUk7WZCdvVXPbOHEL+rMoAuL7OP
         euAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746608553; x=1747213353;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0ZDy1NxfXAG8NZJMJqXrQW/sHCQP8ewWRYdMWB3AGo=;
        b=rc7XksYGgrubDFljgHE7fHp92gKqFkNencLXP0Q3nAzf+8iDBZ/H8wTYE7AQtRYR1J
         bGhss6PwUQriJVu+aDilTbFF+/K6nAnkjmXGLFdSgosW2kD7ESSBd23OympRqdM7JKVF
         xKdFj/5MLDNnprAtXPGPTzry640XnyGpbzm0yHPWoPYGPc2qJ3u3NmKZkvizKy4OqKig
         JJcE7fRWC6q7NUB0yh5QSPBTAVt9YiN+26fTtpzw1QyApFVv04/XOPeDwX/7suHXd3lq
         MHkUaEEncD6kiou+DelK792PFXV+jsHaqpvuErrnAaw4BcXelUjPqwzBrTTez3o2P9s9
         Qp6A==
X-Forwarded-Encrypted: i=1; AJvYcCWuBAIFb2Rm8RTrd3HQhbekUUJLugxKvYm2z6sq20yCOCwSQz2ROJFr+2kuO61PXYzG6L5P5wSR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd67zj9e/wWpCGmjQRVgCINVVHgCJ+tJae+msAJhcqCT1WjB1U
	taElca4Ej2kkqSeEvRkt+x5nxjjevBO7dIjO+eYySJTbiba1Sl9sE9UxJA==
X-Gm-Gg: ASbGncsQeJVH5OmXngPpJe8tIuJ3uWC9QN3r1AyVT7xrLVBYvqiyFKNakpXCJqhc+1j
	ADFnBXAqca5cpU7s5YnCgDwmWgTlqB4o80/Fnfqn8+qca2Zg3/XNSr8dHjtFWscumlQsKfy3wdE
	y2s6sGIqZufmiDQ3FBoM8NLGk74LgQKlDlrYC2HyQTzZn1zTeDxQ+NFbAoBKb5bMhUPJ5UoKe4k
	DVSu+tqziE4zmW09oRcOqpC95FByUNO1IbnLZhx+ymdGtviA7tctlugrkCjgnOCBJpy+Z+CrMlI
	DJHoRhbjVbUyfpPKr3BC1IdBR5gM52TrHRAPIABbf21NqXSY97tc6nO3Z9UMCB0TFNK8weeYIxc
	mXuJBCrTv5jVX2tYn4w==
X-Google-Smtp-Source: AGHT+IEBlFi/7+MOo3NolKqWdHC1IOYCPVpvLkKMpgSeUG89l1SSm3fMGeU3BeP8hduYOzH48TMOJw==
X-Received: by 2002:a05:6a00:4404:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-7409d01504cmr3826288b3a.21.1746608552847;
        Wed, 07 May 2025 02:02:32 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db8befsm10495432b3a.40.2025.05.07.02.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:02:32 -0700 (PDT)
Message-ID: <0c40accd275f3fcdb9d00309159ecb9eb55335b9.camel@gmail.com>
Subject: Re: [PATCH 10/28] check-parallel: use PID namespaces for runner
 process isolation
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 07 May 2025 14:32:29 +0530
In-Reply-To: <20250417031208.1852171-11-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-11-david@fromorbit.com>
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
> This provides isolation between individual runners so that they
> cannot see the processes that other test runners have created.
> This means tools like pkill will only find processes run by the test
> that is calling it, hence there is no danger that it might kill
> processes owned by a different test in a different runner context.
> 
> This means we need to turn of private pid/mount namespaces inside
> check itself - nesting private namespaces causes all sorts of weird
> TEST_DIR mount issues with SELinux disallowing TEST_DIR mounts.
> 
> Note that this also regresses generic/504 for check-parallel,
> because it triggers looking at the init namespace from
> FSTESTS_ISOL=privatens and this variable is not exported to test
> subprocesses anymore.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 19f2d2b0c..aa88c681e 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -267,14 +267,18 @@ runner_go()
>  	rm -f $RESULT_BASE/check.*
>  
>  	# Only supports default mkfs parameters right now
> -	wipefs -a $TEST_DEV > /dev/null 2>&1
> -	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
> +	wipefs -a $TEST_DEV > $me/log 2>&1
> +	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
>  
>  #	export DUMP_CORRUPT_FS=1
>  
>  	# Run the tests in it's own mount namespace, as per the comment below
>  	# that precedes making the basedir a private mount.
> -	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
> +	#
> +	# Similarly, we need to run check in it's own PID namespace so that
> +	# operations like pkill only affect the runner instance, not globally
> +	# kill processes from other check instances.
> +	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
Why aren't we using -s $section and only using $section with check?
--NR
>  
>  	wait
>  	sleep 1

