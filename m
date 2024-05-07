Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4733FBA2
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054440; cv=none; b=RClbmdcAuegsaTAr1vaqa0aTQaryaP2E8B2+wqVKem74sbdwzHmBqqxfGyNIoUylA9VywuOgIu62BZxnV6VYctVuL5+C0TqyZSZ4F83hfZZAkGY1kA6GFxaYBzLFN+ww7zifoG/wphD7PmPno/MhzhvpW0s6nzt5fNn2kABcwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054440; c=relaxed/simple;
	bh=guSDgRvIz5THolBRVoCsRSS7c3u5tGU9us9dwNqnjKY=;
	h=Date:Message-Id:From:To:Cc:Subject; b=aBbWgcXaZyQhrSP8lSj2M4u/SThUpDLZMioFd0lB+0Be8PlrOu9AF4kPTaIZREaLcL5udssEyH428klwVn07PWv3LmOGu9vIBuAqoXDj5eqVCFkjorm5p7zDt37VPkc/n6ncXpibQB1nzyn3FdQV1IWvtBA+1zXjVdy8spwYhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyY3aK0F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyY3aK0F"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1edf506b216so11637835ad.2
        for <fstests@vger.kernel.org>; Mon, 06 May 2024 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715054439; x=1715659239; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEtlCf+yOKu3a4/WEarpwXqu9I3FSSQ5S4myO7He2K8=;
        b=XyY3aK0F+ljAiz1biWU7PTZiDWA7Dqr37XbUlps1Q/lHprNKdRq7b1hyOf9P3kSbcE
         EVpjdMRBkGS/l81cIOgPL9HOioXkPlta7FbQH1RTf3znTcChiUxHWRwHnnlBxvcvd12h
         tzDsYA1cpDRWF0N8Ncec9uqxtEVfbdyBPuYAnbMPjHPb/6wtH6WAg6lbokuiLQgunsbR
         e007rmLWli2MjHa/Q2wXHEXhA6erIf5fBcAjLtWaXp4lL99t5Ur48pIa79yFllZVjPeI
         R7k6/incuL8Qg6yAcZpTFp9ABhtA4sfnSlXqwduazmoBn9eRyYvB5SK2Jx92QBZueThS
         bLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715054439; x=1715659239;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEtlCf+yOKu3a4/WEarpwXqu9I3FSSQ5S4myO7He2K8=;
        b=OQAJjin09j3i3+sSmpiDK8mZ/uSdDzohpXHJYiad/Fi02wcr100dsXKFvQVqjsRXWT
         f3FqGTYYIvdEEqSZuVgjE/h9d8vK8jeYdielaetks0iopyIy77N5zVqzh+FiqHctpQTR
         saRVXykIdI2Uy48JecN3yOICd7D4KYQFQAAT+BUWF42vfzM7Z1pIPERSyqxLcJ3MD3li
         Eg5FI45gNIAcEuOQYc6LtxNT6H3Vshva8V1PvSV2eNCtLEEO96iX2WjWafjoEiWK/Vwo
         26SHSj2T1TNSMLsY/39XM89GHSwn+b1aaCjRbfFAJ3V6NYhrzTnCpkQl8NE+Ka2j48o1
         K/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmb6U1oTJ+KMMVEnN68qa6aOwLLyOQ/z9LLGR2jzpat8iT2Qi8oRpqX3tsjyaVToCbvqGfY7JEjZrvYmMAuquWtZH37+D5kw==
X-Gm-Message-State: AOJu0YyKV2r5Ph7h0QAnkqhxsz5umCQDxX1lDKxbJAVOGTZpPKM+vvM/
	7E9k1URaAqwBGuCTNo+ma13fwala/pb6hAfCAb+JYgbrPdGVEfbr
X-Google-Smtp-Source: AGHT+IEjIZTiq3CPsOasjTy+CEKVJ44PIaiGuwhV0rsqStVW/X5xTIJ89PCDzqPQ+CFjeU34yO4sBg==
X-Received: by 2002:a17:902:ef81:b0:1e0:119e:f935 with SMTP id iz1-20020a170902ef8100b001e0119ef935mr8854954plb.15.1715054438778;
        Mon, 06 May 2024 21:00:38 -0700 (PDT)
Received: from dw-tp ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001e088a9e2bcsm9032294plc.292.2024.05.06.21.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 21:00:38 -0700 (PDT)
Date: Tue, 07 May 2024 09:30:24 +0530
Message-Id: <87jzk6nuef.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, gost.dev@samsung.com, mcgrof@kernel.org, kernel@pankajraghav.com, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> This test fails when xfs is formatted with 64k filesystem block size*.
> It fails because the soft quota is not exceeded with the hardcoded 64k
> pwrite, thereby, the grace time is not set. Even though soft quota is
> set to 12k for uid1, it is rounded up to the nearest blocksize.
>
> *** Report for user quotas on device /dev/sdb3
> Block grace time: 7days; Inode grace time: 7days
>                         Block limits                File limits
> User            used    soft    hard  grace    used  soft  hard  grace
> ----------------------------------------------------------------------
> 0        --       0       0       0      0       3     0     0      0
> 1        --      64      64    1024      0       1     0     0      0
> 2        --      64       0       0      0       1     0     0      0
>
> Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
>
> Cap the blksz to be at least 64k to retain the same behaviour as before
> for smaller filesystem blocksizes.
>
> * This happens even on a 64k pagesize system and it is not related to
>   LBS effort.

Indeed! Thanks for fixing this for 64k bs. Please feel free to add -

Reviewed-and-tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
