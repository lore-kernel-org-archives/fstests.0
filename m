Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86135B65F
	for <fstests@vger.kernel.org>; Mon, 23 Feb 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846152; cv=none; b=XuM1ZvV2bT0p6Wp3s7jKA6uXd/gRz+RKEBoXwJKF1HDhXT2K9imCREDzB+pT74kAd45DqgfQ9IdKoOarqIRQxZEgVUTrGY1MH7m2CLvO/U1gXxeaNDyL3RwyquF16tZjyuDTh94D7nXJ/iCcdvkHQMETHn34d6uoph1cXisGNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846152; c=relaxed/simple;
	bh=minexp1hrWimMHLEY9FDZS0PwNii3WufiEwwoHxZl0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=lxihyGecHwbqsP+RmuxIMzyRoFY37EjGaWWvu7V4LLFXyHObN0wM+paMCKY3K98T2Hq1W6A3qxclD08nFoHNoClJ1zz77io/UavU6Pcrf8vHl+jTuWhXUkJoEeQ7sSucG5Bd/qLPnRNqYMjAyAeRCX6RchDFKZwcM9rI6o5uyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPYoNYtw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPYoNYtw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad4d639db3so20020395ad.0
        for <fstests@vger.kernel.org>; Mon, 23 Feb 2026 03:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771846151; x=1772450951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUPUqcruGdRF+QmccK0f6cTHJ0qRsoMn0qsfNlhX9BI=;
        b=KPYoNYtwZdI8YNy5lnMHe38FcFLLILW62gkr9aCW0YS3AiL9hdPvP3Y+ZYaUKL2Gzn
         6TfamjpqYQbHdDnwQwd8BghVcXqj/X5+WZulnxQUgGUyjlmpK9HcaaTTBSOGq2ybwIBn
         f2C41uczuw/Dr9BURTReDidNLrfntRP3gzSq4obrAuCrfbBKojfoKXOpS2CmS+ZQlgrQ
         mDT9qP2tMHJBjiFH+qT/Y3A0Lgb/aropcHMkD8W9JxznCnrpSmxd+Q3Ti55Y1GIFigyK
         5eqg459pca3n6H/jT8VLZlYjVhWOQLmE6C3Cw/1N/jjbPDrMzdFP6S9Ef03Iz6Oio0zr
         9qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846151; x=1772450951;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUPUqcruGdRF+QmccK0f6cTHJ0qRsoMn0qsfNlhX9BI=;
        b=W6z10qLJzPZ79JRIBKNQnSjvlQCjScLuh3rYSruVJAjfQTtWCV/b5QC35TsulLgxcp
         a5L33nMCz0QKS2pTzwQYDR+NFHXXrUHJYdj1WTWcmr4lG4fA+ZgEaxHBfbcSbpLJ78Ft
         HsrHWByNWr3ayAkiXv3VCMpnqKRem7vk3qnR+f+PJCc7Tf2W32p+sHyl1AQT5m05fDah
         kCeltzwSm1AEMOkyHcDRcxRtC4Mt1PzMjD0w/gaPmtCO1C20NEc2cG+AYOkscbxyJDGO
         TihCQNm+QNy89Sa415HXSNp831OkYxVv/BIs8/c7qyX8e6dbZPTR+xC4H9ktGSQJ/Jre
         mtTg==
X-Forwarded-Encrypted: i=1; AJvYcCVoPPxnn2erLESegIEhikQem1CxBf2iHWbs79Xmzv6ube3Rhf+Zq/pH/Tj5pf5uMx84ZEEV39B9@vger.kernel.org
X-Gm-Message-State: AOJu0YwRP9etAHF0Kao4PiHX1bbvJKc7pH41BOqtLuZsP9RybKKUWCoB
	bTUjXcrWcoFcBpreGjHqlGmdiyBDqrXqthUZkO/pV12jSMwAksMhPIyP
X-Gm-Gg: ATEYQzxwNcuTkFSZrJ3YW9SQFSSOXLyRb3rCwnuiKY2Zqffea6fuWgNAp1AqZRUFtjx
	4Q15nOyV8biookDo/B+YnjAjb3TDJpMFuPF9mikWNV0L1lAn692PIs4upVEwaZN7flpc2CHEAvk
	iv88Fc4266NXNW9nQ/5UHaJt9c1hezdkVv/li++alWz9ULR8aHJA9i04yZ+8fCC5ZrWAVNIW7EE
	LDBty/HyqZ1XCNwHho/bWYajqkiyyADSzeEI/E2bc8UlPmE5Ftf+yguN42yCM8U0jYbP0feJ2N7
	eFfiOaQoR9mpLNKUEbGrcWVU5mA221/y/iPidKbjMbSaA6Vohwn0P3c3AoHP8/lDEf9mimCdOjo
	m/bPqA/8ITa3OPHOhbFCNk/o3On37uFabrnnTdjKiQ2clq+2ZqE5rLNfoE5v2QDYnKcizOGA6VX
	d/mVAabelNJdF7E3YUKGK0VGWijWh4Dg41pdwe+sA2JTwNcKDg7WcLP2Hull4GHQWLNkrhq3o8z
	9lr
X-Received: by 2002:a17:903:2283:b0:295:560a:e499 with SMTP id d9443c01a7336-2ad74419fb9mr68131985ad.5.1771846150791;
        Mon, 23 Feb 2026 03:29:10 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.233.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75321543sm73424095ad.72.2026.02.23.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:29:10 -0800 (PST)
Message-ID: <de1ac9aa2e6f9f1701f9d9efd6ef443466fd5c47.camel@gmail.com>
Subject: Re: [RFC v1 0/4] xfs: Add support to shrink multiple empty rtgroups
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: djwong@kernel.org, hch@infradead.org, cem@kernel.org, david@fromorbit.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
 ritesh.list@gmail.com,  ojaswin@linux.ibm.com, hsiangkao@linux.alibaba.com
Date: Mon, 23 Feb 2026 16:59:04 +0530
In-Reply-To: <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
References: <20260219055737.769860-1-nirjhar@linux.ibm.com>
	 <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2026-02-19 at 11:33 +0530, Nirjhar Roy (IBM) wrote:
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

Hi Darrick,

Please find the github branches for the changes in the patchsets:
kernel changes - https://github.com/Nirjhar-Roy-0211/linux/commits/xfs-shrink-rt-v1/
userpace changes - https://github.com/Nirjhar-Roy-0211/xfsprogs-dev/commits/xfs-shrink-rt-v1/
fstests - https://github.com/Nirjhar-Roy-0211/xfstests-dev/commits/xfs-shrink-rt-v1/

--NR

> 
> Nirjhar Roy (IBM) (4):
>   xfs: Re-introduce xg_active_wq field in struct xfs_group
>   xfs: Introduce xfs_rtginodes_ensure_all()
>   xfs: Add a new state for shrinking
>   xfs: Add support to shrink multiple empty realtime groups
> 
>  fs/xfs/libxfs/xfs_group.c     |  18 +-
>  fs/xfs/libxfs/xfs_group.h     |   4 +
>  fs/xfs/libxfs/xfs_rtgroup.c   | 105 ++++-
>  fs/xfs/libxfs/xfs_rtgroup.h   |  31 ++
>  fs/xfs/xfs_buf_item_recover.c |  25 +-
>  fs/xfs/xfs_extent_busy.c      |  30 ++
>  fs/xfs/xfs_extent_busy.h      |   2 +
>  fs/xfs/xfs_inode.c            |   8 +-
>  fs/xfs/xfs_mount.h            |   3 +
>  fs/xfs/xfs_rtalloc.c          | 824 +++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_trans.c            |   1 -
>  11 files changed, 1023 insertions(+), 28 deletions(-)
> 
> --
> 2.43.5
> 

