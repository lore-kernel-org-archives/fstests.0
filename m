Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11C2FE053
	for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291875; cv=none; b=OgdiVo5OagCPVR84v72bNPpFVUf3sUKDO8hL3axUWQ4NwLuvMTdJz3l9SXUhiW6QBWLoHEJt3r4k8DMCMRyn32LmhQYrVfeVZORGPxnHDkf0327taocfm6ZWf3l/J1bmaAaIGA8Dw4P7aWvuzqL02q6mmQkQ8vmJA1+vSedYok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291875; c=relaxed/simple;
	bh=ArZYbRNMdA6N4gxDdcBF9wkRYxv5mM3zDGm0GProB9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=IRGd2Ff/naUoCQ6QE/SToFI2qaFqgZ8K91l3So2FxCf9LhxWuaUHZhDjNQhxFeuSAz+58e/LeKaeZtKUa2YRmXJnxNeq65WCR2S/j3AKQQnGUY6p4/IUHUvv6iKYCuiwb5BauvX7JevYvg6SBRPFs+vsac8T4bXFd4OoRy0cs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMXWtk8X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMXWtk8X"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781997d195aso1278644b3a.3
        for <fstests@vger.kernel.org>; Fri, 24 Oct 2025 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761291873; x=1761896673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YK5Cv2mHUZf0+sS6ZBkjl83GDLbEDehObxxO+NhiJw=;
        b=JMXWtk8X5j6syd33yn+4vwYWYkH98W5IdJme7pzVgtElqhKon+8qobp9XJ8dLk88NE
         KbPyoqJyv6SWjQeNl3vw0i1g6wkJJer2ysjOi9i9B9FdIgSKJ0nL7NRwM79Y+RS7DCRd
         Etf4EDO7s3rm4m6pu+JbFb1sVhb7PqcV3Q+jlUIfveYobr08oHDfC7fbJ75covf8RQnW
         TlkWzBwSpb3305XEiFUKqcAwkAoq3jogWqbYJT2TdicfSGTdMmIGIcDJPnk4PjP7ixo8
         XLSdYIm4+SnGC2dOKaOubYTtHqohuiI6JAc3//bevdZYcjJbWuY8FI5QcYnd1Ct9u5em
         ngbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291873; x=1761896673;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YK5Cv2mHUZf0+sS6ZBkjl83GDLbEDehObxxO+NhiJw=;
        b=RRK7ERs+XglccPkDlKv7268NC3jlKhaOE+/5v+fKzlGm7ylHHM2iaUyVBZv0n985vd
         Ql95Tlzc1WDAAVhKWqifsh4FeF8bwi6cldBecbBA5V8AesZiRD9tGOBlbViYrQwebtBp
         Xbj4qRmmn4CGRU36uwWltXUL4Q0TDcl2HxxB7UCLsmMRBhllXLCvUJFLMhAmr+aGKlR3
         Ybzy12SEOj+QjJi4wkEslU+s/YN9k3ruXsXoriKLKH8f777PmaW+5f+ieITV/e+kYQEG
         ieqUanxjsmR8SrJf41bel/q9H1dWG1xkhQxpcA88vZ3rnmeYI2nCLLvyeZaJkezrjqHM
         C9Bw==
X-Gm-Message-State: AOJu0YyWtR60a3klt6X9LIrennTpvD9CJzXWZnhz4o5lgpYQgVf/y8k1
	ZWoA8K0TiRULLHVGj4tLWyPGAqCwQuJHXyhZegh36/eJBYfeUW2QxY1V
X-Gm-Gg: ASbGncsQuEkcc3NaGrP+Fmvh1SBTdzEb+VX5I3TlJDbVbQ6agug3aClJqT7XHPv2nEA
	+mRYomqGeEvLspjjnNaHJAnmGQcZm5tPAuzhLijGEw4j5u6UEBHvcKMK+x9cA83TXWEWvlCP1Vq
	iAHixwz25snntBktvtNm5W28FUbTSETMYDH9W/OGKwBdr9PHtk/6vyl+fEHZPO7kJ0Hf4wttvMT
	eJ2juJz5/l0VRl3kY0nuCfaL1z4qxzRcwQM74OFsCR/EHj/krCRAHYOoimC5/iKJ4hnlU+nNnqV
	loUrkWM/lTUld8WTgqk8SZowvI2tpA4dEf79us4/QNNiM3Ugi2FJAYP8uAG4CgsTzjYTIsUThlB
	bvsuZpJoa5NU4npYzU6DxvalsuptECykLXOHVSRNjdCPhHWjmedEl/SAp97yDKmMVUhf97AoQdV
	dXIB1dVGXi8MG77PvXd05D/Ra6oJ6QfS3VeutKqFmttkPsXrmTuKQn
X-Google-Smtp-Source: AGHT+IFjb5mZJgyR6bGIzS0AMBegu+BQn8DvDFMRLJFSSMUddJwgyi8DVtG32VC9u1C+4NcA8h2O6g==
X-Received: by 2002:a05:6a20:3d20:b0:2fb:62bb:dec with SMTP id adf61e73a8af0-33dead55a43mr1920840637.39.1761291872700;
        Fri, 24 Oct 2025 00:44:32 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274aaec46sm4906323b3a.31.2025.10.24.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:44:32 -0700 (PDT)
Message-ID: <68e2839c0a7848a95fa5b2b8f6107b1e941636a4.camel@gmail.com>
Subject: Re: [PATCH 5/8] generic/772: actually check for file_getattr
 special file support
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Fri, 24 Oct 2025 13:14:29 +0530
In-Reply-To: <176054617988.2391029.18130416327249525205.stgit@frogsfrogsfrogs>
References: 
	<176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
	 <176054617988.2391029.18130416327249525205.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-15 at 09:38 -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> On XFS in 6.17, this test fails with:
> 
>  --- /run/fstests/bin/tests/generic/772.out	2025-10-06 08:27:10.834318149 -0700
>  +++ /var/tmp/fstests/generic/772.out.bad	2025-10-08 18:00:34.713388178 -0700
>  @@ -9,29 +9,34 @@ Can not get fsxattr on ./foo: Invalid ar
>   Can not set fsxattr on ./foo: Invalid argument
>   Initial attributes state
>   ----------------- SCRATCH_MNT/prj
>  ------------------ ./fifo
>  ------------------ ./chardev
>  ------------------ ./blockdev
>  ------------------ ./socket
>  ------------------ ./foo
>  ------------------ ./symlink
>  +Can not get fsxattr on ./fifo: Inappropriate ioctl for device
>  +Can not get fsxattr on ./chardev: Inappropriate ioctl for device
>  +Can not get fsxattr on ./blockdev: Inappropriate ioctl for device
>  +Can not get fsxattr on ./socket: Inappropriate ioctl for device
> 
> This is a result of XFS' file_getattr implementation rejecting special
> files prior to 6.18.  Therefore, skip this new test on old kernels.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/772 |    3 +++
>  tests/xfs/648     |    3 +++
>  2 files changed, 6 insertions(+)
> 
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> index cc1a1bb5bf655c..e68a6724654450 100755
> --- a/tests/generic/772
> +++ b/tests/generic/772
> @@ -43,6 +43,9 @@ touch $projectdir/bar
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> +file_attr --get $projectdir ./fifo &>/dev/null || \
> +	_notrun "file_getattr not supported on $FSTYP"
> +
Shouldn't we use $here/src/file_attr like we have done later (maybe just for consistency)?
Also, I am wondering if we can have something like
_require_get_attr_for_special_files() helper kind of a thing?
--NR
>  echo "Error codes"
>  # wrong AT_ flags
>  file_attr --get --invalid-at $projectdir ./foo
> diff --git a/tests/xfs/648 b/tests/xfs/648
> index 215c809887b609..e3c2fbe00b666a 100755
> --- a/tests/xfs/648
> +++ b/tests/xfs/648
> @@ -47,6 +47,9 @@ touch $projectdir/bar
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> +$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> +	_notrun "file_getattr not supported on $FSTYP"
> +
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
>  	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> 

