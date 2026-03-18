Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909173DCD9B
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845018; cv=none; b=Mt41I/UPdacQ1WXW3NUC8v3pDCcJ2QaZCsNoEEsdnkhRwP1dZJT2chwC0tn1FzKSLGMUPLImczfZO+JKtyTnMQGPpDEPew1X4RX9w8YpimKdZ0c5frFRbeefpPeP5m1AnKuqB6PtYyIaZul+aXCQc/bKHuzPzcrYAv+Gq2dCens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845018; c=relaxed/simple;
	bh=dG9vq7oddD2bvNMebFtSbZtYdvojnAgBogYqYR3B88Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7ohIOXf8u5w3AxVbke3N0Baclgu5PDbdXBaotkubfau+TAVHgeWn9VXncmAw9w5V68yQdUB9SBi1AirTZasaTJZSO2mMNx4g5S8Q4CVLM+NqC6xTkwtDNb1UkbHJHAaGAdILVzZVuimqKlD9Xk6vuopb0ZKcYvnjpBfX4wIPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJBItg1d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJBItg1d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae4816912so45607815ad.2
        for <fstests@vger.kernel.org>; Wed, 18 Mar 2026 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845016; x=1774449816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFHoJF7IdM8JdCtHdsURCE/J8sW/qd9UjP/TVMBMarM=;
        b=nJBItg1dxmS6SahWoUogomFqsTW9cjN/3FZzs4GSuFcZJZxXliuVuLkYmmIV4Zrwnf
         XS3eGjEg2o5AN7ICnrA7mDcvC/TcO3Pp2rpamDuNGD+DDI2hP0bhMve4wnEAToA6nNjE
         vHXbUTwqScNs7wB5YgvG3RpyE4UEjTfNZ0ZB+kPmtnOicyz6+YR5RnlXHtlQbLDVaCJR
         7OCYBrYWKjhxso5GiRIJHaLTiC1Qox7TP0JvsxX0VIjZR1tFL2/oZtbMu1txdSVQhXSv
         xwz+BtN038wmtoAxZDpBwGg3WS/EYuIOnYMbHz2HjSWrPgqV4KGwQ+sXVPAtp/NLnWzB
         DT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845016; x=1774449816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFHoJF7IdM8JdCtHdsURCE/J8sW/qd9UjP/TVMBMarM=;
        b=b/8BUNNskxKYCeM4Wu3+P4jKp3QFqZo1nS7LBQrTA/dJyv7uT3EOp2teQjUXxqQYsa
         TWDIZ3LKV5veiGTQ8BzXztmmqufK6vdXklqIKJ8mSGfBfWP0VJXX20f2x8cwL8He9Ri0
         5x8yLd9ZLgd5O/wNwedkNcVEPe1muqxTflaNf28HBTQfTxmUN/xJWhFFs8Vt6mjuvjrd
         pcQlGdi49BFrro3yzWhDdKbWkeG+2YNuAx2/t2CEjbZlRAeKkHlmOXSmee2OILQ1VfzG
         2Tgg4BUWZDBdPHdz9GqLyYfRzjVCpU+hsLT/cjgK5L/z7wrbccJfwPW4Eoc2/dg98NUj
         gWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK1JB0Af2iMxQjeG/iIEZAngXOeAuUECIenSqaAXUy4DuxeF8cW3N+msZAvgwoSHOgM+LlxpJf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw223dXuxZtMVDioe5eQPDk1JHJ73vff7qJEyO5VqOJtvA1lmvH
	ydqww2Nyd5UfaY9EcPXk7DHer543oA5owJ+tcSq9DqJjEtrUt4KepGZ4y7x0nA==
X-Gm-Gg: ATEYQzyITzDgILfoPM+no6aOwq8aqotMQaX4LTymIfvh7+8YZgrEs2Iqi+Ac5P0uU37
	6IfjasdnS0D7O3F+LF7hFm3rBp4++NlGLDqxF8vOQuRtv/kagdlhG5Sqv1KU0ferwtLy/c4aFq0
	aKDwuJveFxnQ1eusL/TGjworOqwhZHuJmNmrr6vaBVLMrRyHjQU52OWF6KUUJftKRluSS/znbO8
	zRbS1AKiFCu4Yce8mqRZej4TFfqjJKf/PpmrKcNLCkEI/fowcSEXt8M6L7QbjyYyFkhw9gQhAZf
	NJ5QK1mnWPzHBn9Xp5b5uU4axFcJKPe9mzBvfwmRKDV6CWGxAT5rjxfq7vZKDL0MBGR3fl6xjMS
	EyJK6BECMlaUhWG7Fq143ZJWM/CRvRFRpoIvw1KtCSlsnsA7329PuVm0195joFgmZ9x1wpvHQPk
	HYMOoynK441P7BZiUVNu9pibrK3UE1aUV8
X-Received: by 2002:a17:902:d541:b0:2b0:5903:13fe with SMTP id d9443c01a7336-2b06e325bb6mr37485355ad.12.1773845015850;
        Wed, 18 Mar 2026 07:43:35 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.193.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5f0e8dsm27157915ad.51.2026.03.18.07.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 07:43:35 -0700 (PDT)
Message-ID: <0e20766d-5855-4514-a6bd-49e32261c162@gmail.com>
Date: Wed, 18 Mar 2026 20:13:28 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/4] xfs: Add support to shrink multiple empty rtgroups
To: "Nirjhar Roy (IBM)" <nirjhar@linux.ibm.com>, djwong@kernel.org,
 hch@infradead.org, cem@kernel.org, david@fromorbit.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, hsiangkao@linux.alibaba.com
References: <20260219055737.769860-1-nirjhar@linux.ibm.com>
 <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/19/26 11:33, Nirjhar Roy (IBM) wrote:
> From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
>
> This work is based on a previous RFC[1] by Gao Xiang and various ideas
> proposed by Dave Chinner in the RFC[1].
>
> The patch begins with the re-introduction of some of the data
> structures that were removed, some code refactoring and
> finally the patch that implements the multi rtgroup shrink design.
> We can remove only those rtgroups which are empty.
> For non-empty rtgroups the rtextents can migrated to other rtgroups
> (assuming the required amount of space is available).
> I am working on the patch series [2](by Darrick and
> Dave) for completion of the data block migration from the end of the
> filesystem for emptying an realtime group. That will be a future work
> after this.
> The final patch has all the details including the definition of the
> terminologies and the overall design.
>
> The design is quite similar to the design of data AG removal implemented
> in the patch series[3] that I have posted earlier.
> The reason for keeping [3] on hold and posting this patch series is
> that (based on the discussion in [5], [6]), realtime devices won't have any
> metadata/inodes and migrating data from the end of realtime devices will
> be simpler. On the other hand there are challenges in moving metadata
> from regular AGs especially inodes.
>
> Please note that I have added RBs from Darrick in patch 1 which was
> given in [4].
>
> Instructions to test this patch:
> $ Apply the patch for xfsprogs sent with this series and install it.
> $ mkfs.xfs -f -m metadir=1  -r rtdev=/dev/loop2,extsize=4096,rgcount=4,size=1G \
> 	-d size=1G /dev/loop1
> $ mount -o rtdev=/dev/loop2 /dev/loop1 /mnt/scratch
> $ # shrink by 1.5 rtgroups
> $ xfs_growfs -R $(( 65536 * 2 + 32768 ))  /mnt1/scratch
>
> I have also sent the tests.
>
> [1] https://lore.kernel.org/all/20210414195240.1802221-1-hsiangkao@redhat.com/
> [2] https://lore.kernel.org/linux-xfs/173568777852.2709794.6356870909327619205.stgit@frogsfrogsfrogs/
> [3] https://lore.kernel.org/linux-xfs/cover.1760640936.git.nirjhar.roy.lists@gmail.com/
> [4] https://lore.kernel.org/all/20250729202632.GF2672049@frogsfrogsfrogs/
> [5] https://lore.kernel.org/linux-xfs/aPnMk_2YNHLJU5wm@infradead.org/
> [6] https://lore.kernel.org/linux-xfs/aPiFBxhc34RNgu5h@infradead.org/

Hi Christoph and Darrick,
I am preparing a v2 incorporating all the initial review feedback 
received so far. In parallel, I am looking into adding shrinkfs support 
for zoned XFS  -  however, it would be great if we can discuss the 
current design and get a full review of the changes so far to get this 
work (shrinkfs for non-zoned realtime groups) into proper shape for the 
upcoming merge window first and submit zoned XFS shrinkfs support 
separately afterward. Do you think that make sense?

--NR

>
> Nirjhar Roy (IBM) (4):
>    xfs: Re-introduce xg_active_wq field in struct xfs_group
>    xfs: Introduce xfs_rtginodes_ensure_all()
>    xfs: Add a new state for shrinking
>    xfs: Add support to shrink multiple empty realtime groups
>
>   fs/xfs/libxfs/xfs_group.c     |  18 +-
>   fs/xfs/libxfs/xfs_group.h     |   4 +
>   fs/xfs/libxfs/xfs_rtgroup.c   | 105 ++++-
>   fs/xfs/libxfs/xfs_rtgroup.h   |  31 ++
>   fs/xfs/xfs_buf_item_recover.c |  25 +-
>   fs/xfs/xfs_extent_busy.c      |  30 ++
>   fs/xfs/xfs_extent_busy.h      |   2 +
>   fs/xfs/xfs_inode.c            |   8 +-
>   fs/xfs/xfs_mount.h            |   3 +
>   fs/xfs/xfs_rtalloc.c          | 824 +++++++++++++++++++++++++++++++++-
>   fs/xfs/xfs_trans.c            |   1 -
>   11 files changed, 1023 insertions(+), 28 deletions(-)
>
> --
> 2.43.5
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

