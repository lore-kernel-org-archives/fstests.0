Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974D2139A2
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003395; cv=none; b=hZJ+s99Xd1k2eYFH+rczgB+HSzM63En7jtLZt4OY+WtPzdvbSDx3TVBDNoB5SsNuXpi1SyPMlKxJF44ZwBE4gb/+iceRsZDJn3upK49C7yneENYxZFY6xeGb+et3ayX/bRAXOC/ZeIry6F1Q/uiaQHKvMcdvCckWvH5Vl2ubMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003395; c=relaxed/simple;
	bh=XPNILCXsVTR96c9YaVYsg/nHNN0mUg1fncpsuUjviDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=MZrSDbH5Q0jGgzE3Dagmm6+BEx71+9n4GNfM7wd/Kq8UF/fUb7NMU5CEqjqLY4H8RjM5SSCh0jVT942zPGPDs/YoJkhVOv9Qs2QFtN/gRVZfcgQEpqhBN/CdYBpcpKhREmEmEQb5zevh/mFBxt/R2+sTdp53vGunxl+YK/aF5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjnvBMKh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjnvBMKh"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ae727e87c26so4663922a12.0
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746003393; x=1746608193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WS2fLw5YCz5oAvugRMmrmPS0GfpDqkFHtedmCnBdL5Y=;
        b=AjnvBMKhFSIi+un+IY1eeuSGef9xj68GTt5qXXQ9m78lLANJJGyeS2Z6dvJzd4AqkI
         4PYNNUMaOTWNeqB2o7Nnn1unum3bA+xfMAMoCdiKJPen17+oCUlBtLGA/i28vLXyH7oT
         cFY5/W4uisYz/sH8gaXr2y9PdnvaED3extxZSw2DR6EUIuKu5Cl2G3SbCuwPxEFce9Fv
         ENomnkgHvEyCHg1HseQU/Z6aU4+L5zscVvvjiF8390a3KsChpCgzgvRXsD4lDUydgw6F
         g109YQb+LLYlBcr8pjmyzu0iqt96Py8INWBr53RXRyc5uH202epU5k8xDCkc/pfGMJqt
         RycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003393; x=1746608193;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WS2fLw5YCz5oAvugRMmrmPS0GfpDqkFHtedmCnBdL5Y=;
        b=NR9pCRBf9lnYG53v6CxV3kx9Uj9Fyu6LwtBo9T+YiKuG7yuawosKXorSBeOk88yWU4
         Iwt8p2zA7Gg32H7f00X2/G/+sTdkEJzSDaMEhRCQa6OaAH2aHRnGnW5CHAL/u7pZmaqu
         LYLgJtuMgNHsNkGUTaij7UZIs5UVYQq0a9/kPwXOsaG28hFvHenf5YP4ETqESP9lZ3yL
         Qq5NfOkVB+QNQndN2B3d6VtWAG1tJ/zEL9VSQ5SYSNIGVb+U+oG67hDKk8li0bfaMPlX
         aChhW2ItIJhi+BFoBSidr/YtR8GaSLAlhvfpAt40pk+v4W6whzmBlHtQWjzvPk3aBoO6
         HIPg==
X-Forwarded-Encrypted: i=1; AJvYcCXzyNQY6eEc4h3jnVnoCPs0J1O4/aQz9nyJlxuBo2f6ie7oVE0skL8Tmf8/4odgGeHocYv3MzA8@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRLpXSP9NCcRzah2i0neT+0SFPrdr3BV34IoQMM4lBgQjQIOM
	dkHya9vfQyM7y9URYISF0RJOAl8AT2exTk45D3PPcFze242otsy1HZg4TQ==
X-Gm-Gg: ASbGncv8eFqUBKALRpBeCgsSBUXrQ7OgSbr6PiPcBBmlW4LSiGlG1U3p/NKTK7gZK9Y
	1fCIWDmdwVXdFVMXOnKByuh37RUCODtjPJbqR9GV75LjLg2NYWLo0RuiyOmvIR6D3BxjgAHelXJ
	pAIvoSlslHfVcWR4yZ9CSondnwzkLt3yq1Wip2cnrI+k9ieTZrt9Bm31Lo6ZSJbpfS3X2AOwo8C
	ENQ1ox/9NA6lVSo4LHpQ4UizbbsfVGLwjPucQaSk6lSaLKWh7zJdh39a/bIJkVGHtS6hOmAPUOK
	OXtqasgMeI4JqIevfSGp3kuruEduWgvshhzyV4FIv/7Km/XZ4JhbEh8J25XOYA+f/MXK2XqE0x6
	qEzbL5tgsMoXCANxP9Q==
X-Google-Smtp-Source: AGHT+IHfN8y/OOJZm+EIQxrenSi4NPt0hgD5BeoJu+H8zoVH1WoQdxbmnYic/VCgd2tl5eOz+LWv2g==
X-Received: by 2002:a17:90a:d004:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-30a332f1deemr3513120a91.9.1746003392538;
        Wed, 30 Apr 2025 01:56:32 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3471f323sm1187500a91.7.2025.04.30.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:56:32 -0700 (PDT)
Message-ID: <31048aeecaf4cb1622fe3a2b18f6a7d921175fa8.camel@gmail.com>
Subject: Re: [PATCH 24/28] open-by-handle.c: use syncfs() rather than sync()
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:26:28 +0530
In-Reply-To: <20250417031208.1852171-25-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-25-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs/183 runs bulkstat_unlink_test to create 100 inodes, unlink on
> and bulkstat them. It takes a ridiculously long time to run under
> check-parallel because it runs sync() multiple times per iteration:
> 
> Ten slowest tests - runtime in seconds:
> .....
> xfs/183 328
> 
> When running check-parallel, sync() can take a -long- time to
> run as there can be dozens of filesystems that need to be synced,
> not to mention sync getting hung up behind all the mount and
> unmounts that are also being run.
> 
> Convert the sync() calls to syncfs() so that they only try to sync
> the filesystem under test and not the entire system. This avoids
> interactions and delays with other tests and mount/unmount
> operations, hence allowing both the test and the overall
> check-parallel operation to run faster:
> 
> xfs/183        4s
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/bulkstat_unlink_test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/bulkstat_unlink_test.c b/src/bulkstat_unlink_test.c
> index d78cc2ac2..62e5bb978 100644
> --- a/src/bulkstat_unlink_test.c
> +++ b/src/bulkstat_unlink_test.c
> @@ -88,7 +88,7 @@ main(int argc, char *argv[])
>  		}
>  
>  		if (chknb) { /* Get the original number of inodes
> (lazy) */
> -			sync();
> +			syncfs(fd[nfiles]);
This looks good to me. 
Minor: Is it safe to use int fd[nfiles + 1]; Isn't it better to use
malloc()?
Other than this:
Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>  			if (xfsctl(dirname, fd[nfiles],
> XFS_IOC_FSBULKSTAT, &a) != 0) {
>  				printf("Warning (%s:%d),
> xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
>  			}
> @@ -118,7 +118,7 @@ main(int argc, char *argv[])
>  			 *The files are still opened (but unlink()ed) ,
>  			 * we should have more inodes than before
>  			 */
> -			sync();
> +			syncfs(fd[nfiles]);
>  			last_inode = 0;
>  			if (xfsctl(dirname, fd[nfiles],
> XFS_IOC_FSBULKSTAT, &a) != 0) {
>  				printf("Warning (%s:%d),
> xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
> @@ -139,7 +139,7 @@ main(int argc, char *argv[])
>  			 * The files are now closed, we should be back
> to our,
>  			 * previous inode count
>  			 */
> -			sync();
> +			syncfs(fd[nfiles]);
>  			last_inode = 0;
>  			if (xfsctl(dirname, fd[nfiles],
> XFS_IOC_FSBULKSTAT, &a) != 0) {
>  				printf("Warning (%s:%d),
> xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
> @@ -150,7 +150,7 @@ main(int argc, char *argv[])
>  			}
>  		}
>  
> -		sync();
> +		syncfs(fd[nfiles]);
>  		last_inode = 0;
>  		for (;;) {
>  			if ((e = xfsctl(dirname, fd[nfiles],
> XFS_IOC_FSBULKSTAT, &a)) < 0) {
> @@ -173,11 +173,11 @@ main(int argc, char *argv[])
>  			}
>  		}
>  
> -		close(fd[nfiles]);
>  		sprintf(fname, "rm -rf %s\n", dirname);
>  		system(fname);
>  
> -		sync();
> +		syncfs(fd[nfiles]);
> +		close(fd[nfiles]);
>  		sleep(2);
>  		printf("passed\n");
>  	}

