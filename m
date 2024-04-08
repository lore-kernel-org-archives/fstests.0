Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C48475
	for <fstests@vger.kernel.org>; Mon,  8 Apr 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557096; cv=none; b=avnvo040wYMuO6HKz3nCu1fSnkJ5MbN7X1aPHBM7FGg78SLWV75OBl1qvlyAiIjVL0mMDTcWnzOCQHZAb7/mmWLDenP0aADZLp7LqifiO6rOlLcn42R4e15Ix1ECpCiyHh5HSOWq/DFy1qzjPGbxcMM0G27PMSTf8bNPhExkG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557096; c=relaxed/simple;
	bh=Rd958awGrANA1EHPy6/wHw0PNz2UYIOEt8a6P+iPoB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqYtOk5mm9dNS6I4uP85AJ3Iz0cPsSjrn4ed3qB0UnCQWYTiriIqA2ACscyYlNanaViCp5lGabo1JcgNN/LOf5eKqAYTmkTeX2NvN5tzCrfC3LjV246BGzuMoG2hcHBKAm+GHJD79QtrvlelqBQ4PWFfZv4c0sXTCzDdDtV/yeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhjKyOyW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhjKyOyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712557093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3mvohd+c+W8wOT5hGF6GGH/GGKJrfOZvGwzqsfjMyg=;
	b=FhjKyOyWsAFrPnMoTcGcL387gIgF7X+EnBx8DKnLe+NxtHMtt1KZI6/alj/Fks0pi2neav
	9zzOw4Jir6efinzQ9p/DPQzEUYaiVF7P8jP5OXE9kXqcCWDip9Kp6C7lPPJ6HJVdta94qt
	W6J2JQCut4QFlAtlQHiFmiB51Nj7vJw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-NtdLon7-M6CmUfGqoHUkeg-1; Mon, 08 Apr 2024 02:18:11 -0400
X-MC-Unique: NtdLon7-M6CmUfGqoHUkeg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e2bbb6049eso17605905ad.0
        for <fstests@vger.kernel.org>; Sun, 07 Apr 2024 23:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557091; x=1713161891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3mvohd+c+W8wOT5hGF6GGH/GGKJrfOZvGwzqsfjMyg=;
        b=CGnjE9aNIJCiNy9GuiEXS14B4idsyVWdma24VPj4f3m6+Ok5+fJo8hiAQjr6694Axk
         EK/XL6H40TVAYc7FLIwaKfrmShgfpGcC/9n8+uam1mPtvcotg54DQSb52lHm7Prrisa8
         nqdmDwmn6oOUOKmEN7WigS7LiLKQTrqFhi01ehd7yPaacbOHGd3ZrLNZEWWxoJrSmK8E
         tXuIj8Voa2EpttwmGMDCEjv0lDFzoB/zggzcukSac1146nsoEZtvD2LWvS4tBiOhWXfU
         Ovy9TXnM6fbqVN0GNiGxf6B592GtSYsrT+ffUfxoa2fgmADBy1eMFW787okebV+Aov/p
         5X9A==
X-Gm-Message-State: AOJu0YyL7Y/9/zNB81PvXcLct/XlnrIQtzecnwe7Vx17U2E+NRV1QIIY
	2ENHeiGUw3qnTud3T53Tp/5jj8T1fCRfFlPS9oIx9oF6Loz1FJ26qdqavCxNinbh3KAOE5yDT5C
	o26JANf87TIG5V1/wgkI7b7aqgKDcHhrlFHjhMN6t50gEE8xZhyO3zNw=
X-Received: by 2002:a17:902:7484:b0:1e2:8eee:ca5a with SMTP id h4-20020a170902748400b001e28eeeca5amr6116743pll.52.1712557090519;
        Sun, 07 Apr 2024 23:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmOKGcEYqAlUOFNhnCM98goUhl89ppPcEURjLnJc6Qss8CsxWjY4/z95dzQzbLHO2LitWrg==
X-Received: by 2002:a17:902:7484:b0:1e2:8eee:ca5a with SMTP id h4-20020a170902748400b001e28eeeca5amr6116728pll.52.1712557089943;
        Sun, 07 Apr 2024 23:18:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903120d00b001e0937a77e8sm6068250plh.200.2024.04.07.23.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 23:18:09 -0700 (PDT)
Date: Mon, 8 Apr 2024 14:18:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: tjackson9431@gmail.com
Cc: fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/2] vfs/idmapped_mounts.c: Change mount_setattr expected
 output
Message-ID: <20240408061805.3buvgr7kh24nhryo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
 <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>

On Tue, Mar 26, 2024 at 08:33:52PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <tjackson9431@gmail.com>
> 
> In kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return -EINVAL
> when no map is written”), the behavior of mount_setattr changed to
> return EINVAL when attempting to create an idmapped mount when using
> a user namespace with no mappings. The following commit updates the test
> to expect no mount to be created in that case. And since no mount is created,
> this commit also removes the check for overflow IDs because it does not make
> sense to check for overflow IDs for a mount that was not created.
> 
> Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
> ---
>  src/vfs/idmapped-mounts.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 34052ca3..f4dfc3f3 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -6667,7 +6667,7 @@ static int nested_userns(const struct vfstest_info *info)
>  	}
>  
>  	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
> -			      &attr_level4, sizeof(attr_level4))) {
> +			      &attr_level4, sizeof(attr_level4)) != -1 || errno != EINVAL) {

Hi Taylor,

This patch has been merged, but I found it causes g/645 fail on old kernel[1].
Is it expected?

If it's an expected failure on kernel without dacfd001eaf2 (“fs/mnt_idmapping.c:
Return -EINVAL when no map is written”), we'd better to add this commit to
generic/645 as a hint, to avoid others feel they hit a regression.

Thanks,
Zorro

[1]
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 sheep-3 5.14.0-xxx.el9 #1 SMP PREEMPT_DYNAMIC Fri Apr 5 12:21:04 EDT 2024
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 /dev/vda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vda3 /mnt/xfstests/scratch

generic/645       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/645.out.bad)
    --- tests/generic/645.out	2024-04-08 07:27:51.432955372 +0200
    +++ /var/lib/xfstests/results//generic/645.out.bad	2024-04-08 07:31:49.811581285 +0200
    @@ -1,2 +1,4 @@
     QA output created by 645
     Silence is golden
    +idmapped-mounts.c: 6671: nested_userns - Success - failure: sys_mount_setattr
    +vfstest.c: 2418: run_test - Success - failure: test that nested user namespaces behave correctly when attached to idmapped mounts
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/645.out /var/lib/xfstests/results//generic/645.out.bad'  to see the entire diff)
Ran: generic/645
Failures: generic/645
Failed 1 of 1 tests

>  		log_stderr("failure: sys_mount_setattr");
>  		goto out;
>  	}
> @@ -6706,11 +6706,6 @@ static int nested_userns(const struct vfstest_info *info)
>  			log_stderr("failure: check ownership %s", file);
>  			goto out;
>  		}
> -
> -		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
> -			log_stderr("failure: check ownership %s", file);
> -			goto out;
> -		}
>  	}
>  
>  	/* Verify that ownership looks correct for callers in the first userns. */
> 
> -- 
> 2.34.1
> 
> 
> 

