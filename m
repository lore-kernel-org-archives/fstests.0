Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA50204583
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999798; cv=none; b=VE4fdJN7gY2MvGH8l8p9pNIllscir5nAfFxq+bglNJQmylypzoPssjEFqdHGejn40VfN/vvvqhor+4A1sZaSBhI/QMsNmX8TvzWlzwaom9DgU8kHjfE7nWdMnp4pHZX61jCbVESgybf4zUsXPGCX0uC+Bv710iNQUcbO6uMjoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999798; c=relaxed/simple;
	bh=40leZV1SFNFz80nLbUO3RwbpfOpJiPwhF7fgOyUaErc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=BIajkaveQYzSvt0ngjL8/LFhoViItgeHipkqRH+NF94RAW7+sEDVsSWWvFmMj3UAVS3c5a6ahR4XZXZyvQnQad9B4HNs+mhR5LVtZeQXckOi5cgKQW4KJcH+kuFziHVZzukr3FzKozJhWIAmt01Dth2kuXhWym/OAiVSnCSWhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP5QoE8k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP5QoE8k"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22da3b26532so59711595ad.0
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745999796; x=1746604596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQFOtSeT36W2Nk/NYqIjcvZK0VNp6fx5XTTYna3txPw=;
        b=jP5QoE8kxrTRxj82wx1xKyNfpiXabyQra43h6u4jTjCg78qXakGbJnxlsJU55eEm45
         aJBS5nxOQlJ9YR/hN6qsvKJN8LicdeSdu6Z+NtQ1wEHvtbrRxWimwtPG0CKoQFkUN084
         Uh8ufacicoCAgaVCu0lgIyZmJ0GK5p9jTy477gWfIWTpjH33D+R+n3bg5UQHRp/3cx8p
         XYYVpYv2KUy3xyavtvPjcCJbRbJt7GFSgn0kQP6cDugVRDzW0hDE0pGtfh6WkQKWGw2/
         Jvk60PfJrNeM3fb1nZutPxF36hgW16RxAyoSS8g8dn2/5v1FboyuadxAARGOmGltMnIo
         km8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999796; x=1746604596;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQFOtSeT36W2Nk/NYqIjcvZK0VNp6fx5XTTYna3txPw=;
        b=kO+/dpjE4MdFXkL8zRw+FynANK9U8YnAfhGOkQ70cO2C/XgAKU+vQUbqq4KNNfSblz
         j8btdZ5P1SdiH4tPgpb14BKnZve7EXpEmc0AHa7cgO356MSi+eHk+bRySv9+6KIsh8+8
         gSfmKNicHNUaee6iWbjqPuz+IZz2u0P2P9qUHebdS5vompslMF0VSxCSHIFfcTaewBgL
         6kfINDGAK2jaxYVaLdybSxh3+QCZM2qnYerr6gkhjwPPdDdE9H+jGThJYLimOfUZMpSy
         JibF8HrnB7HSyyaklIJcErTOmbSXjaI2He7Lg/WGx8NGB3ZWyj3p8cv52pRdOArxiDMo
         rjyw==
X-Forwarded-Encrypted: i=1; AJvYcCXTx6NnC0zVUJMGoIT0LE07hmdubC6B/9JT53oMoSYaUS5IgWv3Kq1zqg3O0QCrcx+lHZaw/ZOv@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVJuVsSjr9F87LnXVfrKiRIsdAOL2Xtg2yHpHE5hJ+1xpHMhA
	0BE7NY2dIrZYwMUBvec5hFPW5/iC+eXfPEmpaP1JTUiD3hLPr4Pp
X-Gm-Gg: ASbGncs08zHwFJ3NEhwsDBudZkSj1IquySJG750Uy8qxSZu7Xx4kwqYYMcmRWOqm83U
	WwB22go5/0oa86ZVnEf+x280wY6ybIguhzDlacrbs1FAuPHl9H+NYKzZJ06vVJqG7gSC+N5f9ro
	rbkBODIh4afPvkKS3UKgkFw67HK6rzYUdGm+ytU+E+eiq0agYAz2++ngjcczi8oi4jW+uWrmB6z
	jBIOvb1MhD5rvlbxTKLc76eFr9XMOFk6ihDcHpIIpyGvl0fe2GB9rhe6AHyxPML/RxTLrDhkvWB
	rRBUFQzXPkc6ycbgOG0ePkGHo5hHBIpIGU7+1jUMZec9V073pFJ6lGnk1FvSP0e9ilFDMYnQvFU
	GkCELZsf4i0d60Hsi6Q==
X-Google-Smtp-Source: AGHT+IFRXFLL/LGRWwiN38pJOMNkh+DLmt1/E9csHAROwzj6v4RclOpDHkvWelMAcPnKhlM55wU0ZQ==
X-Received: by 2002:a17:902:d486:b0:220:ce37:e31f with SMTP id d9443c01a7336-22df34d5f5fmr36988725ad.17.1745999796112;
        Wed, 30 Apr 2025 00:56:36 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51021a8sm115728375ad.172.2025.04.30.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:56:35 -0700 (PDT)
Message-ID: <9b3af52a17171a3e6e1be53ed92aa8b2fe08e968.camel@gmail.com>
Subject: Re: [PATCH 28/28] xfs/259: no need to call sync
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 13:26:32 +0530
In-Reply-To: <20250417031208.1852171-29-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-29-david@fromorbit.com>
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
> xfs/259 runs sync every time through it's loop.
> It takes a ridiculously long time to run under
> check-parallel:
> 
> xfs/259        461s
> 
> When running check-parallel, sync can take a -long- time to
> run as there can be dozens of filesystems that need to be synced,
> not to mention sync getting hung up behind all the mount and
> unmounts that are also being run.
> 
> sync is used at the end of the loop before destroying the loop
> device, but the contents of the loop device is completely discarded
> at the start of the next loop. i.e. the image file is unlinked and
> recreated. Hence the sync call does nothing useful and only slows
> down the test. Removing it runs the test much faster:
> 
> xfs/259        23s
Yes. The sync doesn't do anything useful since the loop device is
destroyed and the underlying loop device image file is also re-created
at the beginning of the loop using dd. 
This looks good to me.
Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/259 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/xfs/259 b/tests/xfs/259
> index c2d26381a..c40ba3a0e 100755
> --- a/tests/xfs/259
> +++ b/tests/xfs/259
> @@ -52,7 +52,6 @@ for del in $sizes_to_check; do
>  		$MKFS_XFS_PROG -l size=32m -b size=$bs $loop_dev
> |  _filter_mkfs \
>  			>/dev/null 2> $tmp.mkfs || echo "mkfs failed!"
>  		. $tmp.mkfs
> -		sync
>  		_destroy_loop_device $loop_dev
>  		unset loop_dev
>  	done

