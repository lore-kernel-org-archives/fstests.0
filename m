Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1421ABC9
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004143; cv=none; b=uHefcCkfoj8H8L1vh1y7+w0nC7m3g85+rZzapBEpfeMXWCXMcoFydQu3ttpJY/p8AEM8NOo1+AqWVvPgzmNT7iokzZGPwwoKXYl42L8/jcfHzIszsUkMzqpM+bI6llSmvZ+iPPG736LkUlVoJzMVBCT17aE9zFsjuaeATb2J2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004143; c=relaxed/simple;
	bh=EkJucvsjI/fUPZOYbASge8ItAKTuM4rQfeoGZul+wAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=bNl2Vvjv8+gWwANdeCvXLYoAWc4lWzxl9UAVroh/bD05+QQ1duWBHQ5GiBFF5Sw56L7PcJl/DhFZ1qSQ8SKIR5ZsTgwI+NKqZ0yqsLY5Z/mtmyi2orgN0Ns6HLMWt+pAxBpYrwwb4ENpobFTFqjLrGWeRDUSNStqLQdq6IEJL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UumOb2HM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UumOb2HM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c277331eso689907b3a.1
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746004142; x=1746608942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wlua+SQQv1mavH2Yh4qlNrYi93Jbis7D2G6f9wVldI=;
        b=UumOb2HMQHPsUxooMINwHd9TyyZ0DFakcNxqLk8B48qzsfbVVOk/MFQ5VtjqDENCXa
         CFaF0FaBEmm6khSqpN6vzRh9EMuWRYCs76n9pOfrxO8nVlEwhpaggEcps/BrE22b65wF
         QuAt/Zc0EUtC9YNDsaMjJOMn/onlZYa+8RAhQoOazeKrlL7UaQV+hVCzXKAVWHqUSqGr
         zVEQ6VgTaYcwZz432N19HbiXyCJnoFKhlMv/m42OaRPml9huvROE98XtV9KgL2raCsH7
         rJFo46V8Xb4B6usdnLXdo4zOg0FDJRQP/w1/2lkOgbxaxEZRQbgnY004WO8QanXfhAPC
         q+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004142; x=1746608942;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9wlua+SQQv1mavH2Yh4qlNrYi93Jbis7D2G6f9wVldI=;
        b=gZLVHXa3yiyIH+KEDjlFkrlnnovPmPpMqfTrs3jB/YFp7gk5ODyqb8F/gBJeBn1qK+
         KLRz2YnthXc2XLSBBLqGptZR2il/HOTaQT7ErtvDLXh5eVBU5XSrGjRR8OSU6QAhPLIG
         BbMScONYOhdDTYhbnolwFEruZ5zgyr8s83wVyG0r1iu7XvgL8P3DLU4O/FOq302kvLsl
         /zieCxWrq8/ihOhv6ILrSb1M+1kcD4MepaargIc3E/GQNPqTiQRKKRy4azDfnUBHu8gR
         y8760dKuHPXu+qtB4HWFvl76RswRIIOlBZzIUQ7x/F7BcfhW24RE0fJ9DJnWrSnu4XIg
         ylDg==
X-Forwarded-Encrypted: i=1; AJvYcCXOhCWf+hmxO/jOORarkt65MiLmXZa+iGzNLZvDEhes0TjOw5sc3sbOissa9EtQQrn1UFktSkeE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyng60p3pHMhHoO/sGs1PfPv3qtGRfkXhkpwbRyQwYCCBjL0UAR
	GATiB6nPj1dEMXoBFDutGvZz0mdjcS44KgmPAnrKrZc0OKW/WG+E
X-Gm-Gg: ASbGncsGIBzKXnZ2MJchPqA7CsrWk+VuQd7R9POFN098vBvGpHd6BEx8+Ai9xSDxbtG
	4XHWJnXuarftrhvFLIwjSL+l1kiab7PP4rciFLJcGkN2mvEKyfWRbuhgkrwhA+gtkVkWvkARdxZ
	OF8POfAp8ihAreSMsnmNXE1a1EQ9lFs7s+lJJZwAfp4qCQ+rOtLevdUdwY9s+bl+A0v99cxTdiO
	FJkptRRXoN2Hmr/jzXauPCtk0mIvbDefr7D95cLYTfdJ7J1F7hWBxhgvBvraddX0HJm4J2VUT0X
	T4UfnUQzP9huIJ9wu8naZj162Gd70t/P1aIWqkxgDq1XJx1YEIv7E1XzRnp5qNXgoO2bQw33pRC
	mAfLKka6KTWAXOw5EQg==
X-Google-Smtp-Source: AGHT+IENZsyhfHf7amKwbA56ZqhD3FwGDM6SJTgNuiuK0DPnTBKXN193zYYWEEdpQPCFv/89Kod+Ng==
X-Received: by 2002:a05:6a21:920e:b0:1fe:61a4:7210 with SMTP id adf61e73a8af0-20a8e17220amr3010937637.2.1746004141645;
        Wed, 30 Apr 2025 02:09:01 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f4680sm10205669a12.14.2025.04.30.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:09:01 -0700 (PDT)
Message-ID: <53f79f8f27a0d99de336fca50d9028b92769e6d2.camel@gmail.com>
Subject: Re: [PATCH 22/28] fsync-tester.c: use syncfs() rather than sync()
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:38:58 +0530
In-Reply-To: <20250417031208.1852171-23-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-23-david@fromorbit.com>
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
> generic/311 runs each fsync-tester unit test 4 times, and there are
> 20 separate tests. At least 9 of those unit tests run sync() to
> flush dirty data periodically.
> 
> When running check-parallel, sync() can take a -long- time to
> run as there can be dozens of filesystems that need to be synced,
> not to mention sync getting hung up behind all the mount and
> unmounts that are also being run. This results in:
> 
> Ten slowest tests - runtime in seconds:
> generic/311 419
> 
> This test running for a really long time.
> 
> Convert the sync() calls to syncfs() so that they only try to sync
> the filesystem under test and not the entire system. This avoids
> interactions and delays with other tests and mount/unmount
> operations, hence allowing both the test and the overall
> check-parallel operation to run faster:
> 
> generic/311        166s
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/fsync-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/fsync-tester.c b/src/fsync-tester.c
> index 417187491..048cb4853 100644
> --- a/src/fsync-tester.c
> +++ b/src/fsync-tester.c
> @@ -131,7 +131,7 @@ static int test_three(int *max_blocks, int
> prealloc, int rand_fsync,
>  		/* Force a transaction commit in between just for fun
> */
>  		if (blocks == sync_block && (do_sync || drop_caches)) {
>  			if (do_sync)
> -				sync();
> +				syncfs(test_fd);
Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>  			else
>  				sync_file_range(test_fd, 0, 0,
>  						SYNC_FILE_RANGE_WRITE|

