Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503F1E7C12
	for <fstests@vger.kernel.org>; Fri,  1 Aug 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029174; cv=none; b=uio0RQsGMM78agNBpD2suyabaqJXNGuPD3WZBmrVY+DEqn2BBoFZf1u0SlwsPkPDyKPJXRxU4S05syfN0j2NwZIhDQVSVo7NCqEtNfpE2jFuI5nRTJaMnNaAJ8hfUBG8hxQMANL4I0t92xfIqViYtMHra/ylCMt/ZCqPSKJq368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029174; c=relaxed/simple;
	bh=EPHYRAPG3KozJvbw/i4FF6IGHiR0rWYCf+bjKUPbMGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVe4GLHcaOXbNPrDba5iek8eCR3YMKMAyGBJCduwusjsFY3TM2ZxGFdO6mA4E8ObbWTawc0XvfZeyWTzsXzBTbcGFrGIBoZygx0M6w10nP76dU+cmQU+6FOP5DtmDcVxMViXUjVEm+dRrnV+eF6rmAbUxVAIF6+/I/qwDY479XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArHyS9Lp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArHyS9Lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754029172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMYiehdGIQOorTyXunkhNyOrR1xtlljPmOkSUA9k3Uk=;
	b=ArHyS9Lpnzv2G8SRR5SDMcwibaXUBkU8b1LcHeAid+d0dQ7q6ZNJmLv9N7dT82kgV16ypd
	yCth8UJEM8jCKP9T++B7uZy+7WnyBj8l5njuxihgGPBY3wbmKpUqUxZ5ZKuuD/oKNNdb5T
	W7bkZiUG/gJfjwp4jLQzXR7sp1yau2U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9sH7MISqN92JYDH0e7azMw-1; Fri, 01 Aug 2025 02:19:30 -0400
X-MC-Unique: 9sH7MISqN92JYDH0e7azMw-1
X-Mimecast-MFC-AGG-ID: 9sH7MISqN92JYDH0e7azMw_1754029170
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24086faa5bcso15231675ad.0
        for <fstests@vger.kernel.org>; Thu, 31 Jul 2025 23:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754029169; x=1754633969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMYiehdGIQOorTyXunkhNyOrR1xtlljPmOkSUA9k3Uk=;
        b=w1jwHS6pMniXr9L5Gl8wX1tKB90a4HGbg2sP0S3K3YdZzBAGBGB4bWU/BIsr0LOWS9
         XuUsIV4/ylAQSHarM4A2RY1nusJJaDHumanXrbUa6IRkFnke8IK/d5o9R1awpAFX1zpR
         BA5j3gMWaFiVPrTIrr++bs7HUYDO116b+dMj/hYZtOWCsjCgS8eqrRM731IdlL0KRx7R
         Up0ogBR29EqlFG1nvK/tR/fRCzFF57UKrqTZnq2iSStgHLve99R1jh7dTmEw5hfb6qT8
         5niXrTsehksyUWCwWeB0x+IcR1RwVntO9rzQiHfKMyGtTooHoQWvO1OfdJt8SrkB8fUB
         vVlw==
X-Gm-Message-State: AOJu0YxzF/5AhLsmC6Vpsy1qalEVL1ogGS8d+j8RoWjZ36y4MMAmSejC
	dNv233GnCEIiHzJBx1teUrOZiZnC/hoQKXLxEejZzEBleOUCveZFEn6pPJzXI0hGzhfaASFLLC5
	t/27iu1uEzog5/2Z8vYcDWZFpa9pv8rdqGsL2VJyrFmu+dvEI991wMIw2pnA=
X-Gm-Gg: ASbGncupm1ygPwRg/oQ7t9CPij4uHhlNlqb/Vash3/kT6YsqVGNRc/YngLruTbYrHtd
	Mm65S/gscH+iuFgXBF16EXNhJmrrUL5R8+RxSRgGGLHeJvoELYqTFtFkMxBpaktvwnI7QEfKeur
	X+Gou2Qz6dNUepIrJXt6u77uIYKs7SOGWE+5oEYXC6908R5zM88vWRrQ9Jkxnh5aNHSK/7eExYJ
	U4gWiLgqcaMlPyivWJPT/VJ+jI7c2jn5bqpnYyKbByAjOuOJERvQAmy5lttnmYO6XFihxNw3MBl
	I04y2K8eZblqiz38hct83LiNyNwohB+oAQpAtOs48Bnp9ZBGoKxwE6zltrMFYlPEHNk07L21J0E
	oG/ru
X-Received: by 2002:a17:902:f2c6:b0:240:981d:a4f5 with SMTP id d9443c01a7336-240981da701mr103511405ad.42.1754029169637;
        Thu, 31 Jul 2025 23:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0+kBDdQxrptzUfQkX7oUxk29yF9CB1ceaWnQH3LJBA2mUBpKv/zMXQ5n4S8JBC+lAkH6dqg==
X-Received: by 2002:a17:902:f2c6:b0:240:981d:a4f5 with SMTP id d9443c01a7336-240981da701mr103511075ad.42.1754029169269;
        Thu, 31 Jul 2025 23:19:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a6ec2sm33954845ad.145.2025.07.31.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 23:19:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:19:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCHSET 1/3] fstests: fixes for atomic writes tests
Message-ID: <20250801061925.43z675yfcq7lb3o5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <175381957865.3020742.6707679007956321815.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175381957865.3020742.6707679007956321815.stgit@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 01:08:28PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> Here's a pile of bug fixes for the atomic writes tests.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D
> 
> xfsprogs git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=atomic-writes
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=atomic-writes
> ---
> Commits in this patchset:
>  * generic/211: don't run on an xfs that can't do inplace writes
>  * generic/427: try to ensure there's some free space before we do the aio test
>  * generic/767: require fallocate support
>  * generic/767: only test the hardware atomic write unit
>  * generic/767: allow on any atomic writes filesystem
>  * xfs/838: actually force usage of the realtime device
>  * common: fix _require_xfs_io_command pwrite -A for various blocksizes
> ---

Do I miss something? I didn't find [PATCH 1/7] in this patch thread :)

>  common/atomicwrites |    6 ++++++
>  common/rc           |   14 +++++++++++---
>  tests/generic/211   |    6 ++++++
>  tests/generic/427   |    5 +++++
>  tests/generic/767   |   19 +++++++++++++++----
>  tests/xfs/838       |    1 +
>  6 files changed, 44 insertions(+), 7 deletions(-)
> 

