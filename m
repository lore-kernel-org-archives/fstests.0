Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9593D6479
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424539; cv=none; b=uLBp3zC/hEcNZaAz8Xvsx+AretMwH/e+szCH41N6+d7mU5emVbOGPzdXE+2XRFCbvMiL1rX9Fyb7IR9dgxWwbjb5WmSHSXczhg0dfG1LaAMvKyqVJ1MBCCBfGKgb4SgPyg+no+XHLbCNsysLByjp/DKro7LPalrShjEtme8oJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424539; c=relaxed/simple;
	bh=zFTpUqNxfwHZYoFVLLsWS3yA02zzXxNAGAap+93fzLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7BJSGvjW3BG8tLYb94hcCAFlrRV3/veVE1ncdRKZPP/mR+OE9eDU7DbPrDJpG+CMEvJhkeKWprB/W69NOi6hHwTkFvJc9FU3TXacyWI4ue6C2rssp8bsjVRfuhIr7ZU3r7mMeTvL9Z2yoAyp/Njh4GRMS2ws/NaWgLl6NTZy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmzHD0zh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVLHV5K4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmzHD0zh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVLHV5K4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773424537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLH+zzk82XmVGuSsd5GeuCRRscX7AappD0ztCcZg5hQ=;
	b=JmzHD0zhb1VPk15LAV26Nol5HTuSBdrMyrhbCF7sdFxkLZZhNSNfWtAP/oYM/ricP59Wu1
	rJJ8QUv7/2lnAAw+4bgbGUrkis8fesqTTEvhfIHriOfn629cDf2axe+GtLlLx6H5/vd2mh
	92nia8jN3ADspkpbrqZJ4++Y9Fy5N+A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-prn7h8ZtNy-c6oGH3aCC7Q-1; Fri, 13 Mar 2026 13:55:36 -0400
X-MC-Unique: prn7h8ZtNy-c6oGH3aCC7Q-1
X-Mimecast-MFC-AGG-ID: prn7h8ZtNy-c6oGH3aCC7Q_1773424535
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3598c05c806so2636958a91.0
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773424534; x=1774029334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLH+zzk82XmVGuSsd5GeuCRRscX7AappD0ztCcZg5hQ=;
        b=iVLHV5K4N7lIwjyHGaaYHvc9yhWJV33CPazXGtajm+aJnF4i31OpbOP8xZVcf2weKt
         kiXWnmwMNUB/ly1K9ZizX6BqNhYB71xZ/eufbV+GJPHvFD5gPIZqw9guoNXns5MFwoJk
         BwxE+3B+Tq9JIFUHMlR+U6k9phhQpiff/USKyFMV0Xbw+lxaIJrUuOg+r1O/lHlmH6Kj
         vn3nr5ynyEzl+ukwKFVa11Zqr5XRlg8h7U5sTRAlX/jOOYucymvM/dZI7H1mH1r3+zmz
         /uoLog4qtRKsrlEGyEnXUoSXktBkg/RTXuo2XTh7lQtP4ixjctEsanWetfK6rxdB0j3M
         3D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424534; x=1774029334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLH+zzk82XmVGuSsd5GeuCRRscX7AappD0ztCcZg5hQ=;
        b=Z9As91dDMpxcKHFUQOmoaifcLzR7yUUy56a2kwGC6/4POd1ro+HVcQ7MIvH1drEFRj
         wL2ZneWlbwBqyIdgVs2kdnIs6+6EMZsPoZ77Pi8uY2iKNy4ZAK/jekXvD+q3hZM/NGAj
         mqQ9XEYsX8h4g2qjJKNG9K8qaOJbNXfgFUcu7a3lyvTYVwD74J8bToN+w1v/F7qDpyo3
         owV8zQv+gQiTBU+Tf7qWbC1JqUsJCdFKkjB7nytq2yCmwKT6SV/R6CY69ljMlDPy9W0T
         I2iRPCG9lMoDQT3c3mzpwHcQwNsZOlVLzUvhBCrI01ySGeP4O5Io/PbJUgmZIBQRa0pJ
         fsKg==
X-Gm-Message-State: AOJu0YzeFr7opUXBWKNjt+/8s9jd56HW1179PKmKXqxSt1wFz8sV/i5o
	2+DoYHIw0eIgmesGJK5D2Tz9IE3FipW8UfPNrhTKntZnSUW0GS7dInLtzuL5DNsuWHlTf/urs+9
	WQXkR7eFeH2vFbs+R3VnG31qIE2hJ0Lfq3LQBxTGJdXNqHY7FxmbyIaKGyFE=
X-Gm-Gg: ATEYQzzsRNvmG1yWnzC9wnVFQFr3gTj3mQOL9F5ejVDkcOQ2nehitJyDr9trqjh3t4Q
	TXtUozBwxsCvRu9zY/FRCsIXuBt01TY/w947X8LCWp+lucCQxK2hhmH5WlHJRSXzcwd8sbzRYJf
	B/GBUUG0PL8RSYlOueE27FbLl32x8FLaB9/3OoBP5goOj6fkXk5TxHd7gA9EoRLFVcIWaxaKQkZ
	vncevz681MzEPIxVx1KgnGUqS1IvhaGR7duaVj7DKkfHqyUSQBemSvvKTZslxARA7xC1fHMHxYS
	Kn3+vLQZLhljqvP85584c57CgApz7djkmH8czp7tC5FVQTC6M1B1PEDx+6ByytWU0siAOoOLnLp
	2kvTJVYO6vUiVm0Z7gYIzNxjBTPEMcJIAPpOawfR0sXrpSzPVVhOFAhbCwCblJA==
X-Received: by 2002:a17:90b:3d4b:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35a21f666cbmr3506536a91.11.1773424534297;
        Fri, 13 Mar 2026 10:55:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4b:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35a21f666cbmr3506522a91.11.1773424533785;
        Fri, 13 Mar 2026 10:55:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb6335fsm2485840a12.19.2026.03.13.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:55:33 -0700 (PDT)
Date: Sat, 14 Mar 2026 01:55:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs/62[3-8]: require XFS_SCRUB_PROG
Message-ID: <20260313175529.kdwqkjtpn2fwigrz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260311041443.GC6023@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311041443.GC6023@frogsfrogsfrogs>

On Tue, Mar 10, 2026 at 09:14:43PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> QA reports that xfs/62[3-8] fail because they didn't install
> xfsprogs-xfs_scrub package and this test requires xfs_scrub(8).
> Add the missing _require call, and update the README so that anyone
> running fstests on RHEL/Fedora actually get all the necessary
> components to do a full test of XFS.
> 
> Cc: <fstests@vger.kernel.org> # v2024.06.27
> Fixes: 4de8fd7860a2bb ("scrub: test correction of directory tree corruptions")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  README        |    2 +-
>  tests/xfs/623 |    3 +--
>  tests/xfs/624 |    3 +--
>  tests/xfs/625 |    3 +--
>  tests/xfs/626 |    3 +--
>  tests/xfs/627 |    3 +--
>  tests/xfs/628 |    1 +
>  7 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/README b/README
> index 211e273115f08f..36684cc6572d4b 100644
> --- a/README
> +++ b/README
> @@ -126,7 +126,7 @@ Fedora
>     $ sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
>          gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
>          libcap-devel libtool liburing-devel libuuid-devel lvm2 make psmisc \
> -        python3 quota sed sqlite udftools  xfsprogs
> +        python3 quota sed sqlite udftools xfsprogs xfsprogs-xfs_scrub

Sure,

Reviewed-by: Zorro Lang <zlang@redhat.com>

I’m thinking we could split this package list into "necessary" dependencies and "optional"
ones. The "necessary" dependencies would include all packages required for building and
basic execution of xfstests, while missing "optional" dependencies would simply result in
certain cases being notrun. Any thoughts on this :)

Thanks,
Zorro

>  
>  2. Install packages for the filesystem(s) being tested:
>  
> diff --git a/tests/xfs/623 b/tests/xfs/623
> index aff3f903660fa7..7f79ccbcbf7f14 100755
> --- a/tests/xfs/623
> +++ b/tests/xfs/623
> @@ -16,8 +16,7 @@ _begin_fstest auto online_repair
>  . ./common/fuzzy
>  . ./common/populate
>  
> -
> -# Modify as appropriate.
> +_require_scrub
>  _require_xfs_db_command "link"
>  _require_xfs_db_command "unlink"
>  _require_scratch
> diff --git a/tests/xfs/624 b/tests/xfs/624
> index e63cfcc6e7ba82..09a922c8d18c8a 100755
> --- a/tests/xfs/624
> +++ b/tests/xfs/624
> @@ -16,8 +16,7 @@ _begin_fstest auto online_repair
>  . ./common/fuzzy
>  . ./common/populate
>  
> -
> -# Modify as appropriate.
> +_require_scrub
>  _require_xfs_db_command "link"
>  _require_xfs_db_command "unlink"
>  _require_scratch
> diff --git a/tests/xfs/625 b/tests/xfs/625
> index 23013f195c9e7f..2654216b67aa11 100755
> --- a/tests/xfs/625
> +++ b/tests/xfs/625
> @@ -16,8 +16,7 @@ _begin_fstest auto online_repair
>  . ./common/fuzzy
>  . ./common/populate
>  
> -
> -# Modify as appropriate.
> +_require_scrub
>  _require_xfs_db_command "link"
>  _require_xfs_db_command "unlink"
>  _require_scratch
> diff --git a/tests/xfs/626 b/tests/xfs/626
> index c424819cede6e1..3b4cdca4fe4e24 100755
> --- a/tests/xfs/626
> +++ b/tests/xfs/626
> @@ -16,8 +16,7 @@ _begin_fstest auto online_repair
>  . ./common/fuzzy
>  . ./common/populate
>  
> -
> -# Modify as appropriate.
> +_require_scrub
>  _require_xfs_db_command "link"
>  _require_xfs_db_command "unlink"
>  _require_scratch
> diff --git a/tests/xfs/627 b/tests/xfs/627
> index 411a7603317058..fc54199b4a95de 100755
> --- a/tests/xfs/627
> +++ b/tests/xfs/627
> @@ -16,8 +16,7 @@ _begin_fstest auto online_repair
>  . ./common/fuzzy
>  . ./common/populate
>  
> -
> -# Modify as appropriate.
> +_require_scrub
>  _require_xfs_db_command "link"
>  _require_xfs_db_command "unlink"
>  _require_scratch
> diff --git a/tests/xfs/628 b/tests/xfs/628
> index c77d67db358983..e003f41999f401 100755
> --- a/tests/xfs/628
> +++ b/tests/xfs/628
> @@ -17,6 +17,7 @@ _begin_fstest scrub fsstress_scrub
>  . ./common/inject
>  . ./common/xfs
>  
> +_require_scrub
>  _require_scratch
>  _require_xfs_stress_scrub
>  
> 

