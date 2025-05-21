Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A54430
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747795156; cv=none; b=DdMfINjrhBSP2QA59vjg0fwU7ADTpebXKbF2sUyIDaPWgog4WkHXez7Giw0hxxd8KJEuCzw0N+wqfTkMmIazwhioAxcWVhs8beKQJRipTXuAMchuA4ryu8YZTcMjK1KbEqVAVzMdfaEv/GgzNZmyRztGOuEPeCck4pmmXntmvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747795156; c=relaxed/simple;
	bh=V1d8sNLClp1rmHacXcaGlR2hpXAK0xZdeDuAJ6jh8G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um1zv7h7OurKnuiBAIMEwELLS8Ulo/Yqs4qHySNKzCd6Oh20gOAKynYC6psEWwhyIV7CoqzqGm17L3aR9sD6jOZgt2QtCwyOPGtAjgbnlV6ZH82i6syBORjNr0I+e0tivtpH2kUpsCsoGJGyRJc3/pVGG2eZQYo3XKwmwi1hiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BOH35Gto; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BOH35Gto"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742af848148so3500534b3a.1
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747795154; x=1748399954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooxHGB5bHF4mLC0pX6DL7d5+TBk0P+eg/sLzH3GsxW0=;
        b=BOH35GtosgCpZZuUNFFVhcVk3u42BmI7/eCiVRHPch5zRlifFomzi+5ue9ou8KZ+Va
         DLQOQsGpvXesRO2bPqLbOvgYtippLcg71h5i2vj0jjq+LitY9xk4/dhJVD8Rl7PFgUv7
         AYp3B1qBhnQudWbAkcr+dVZVm8WON5s9DN/8j+cgv/GY8crCCkQ0a4nRInAaDYzBOIcg
         iK7C7+qsrQoMmuvqMjw1r46wolE3e/CBqpOk2kozw03ASNFIPgiaplrvf7ngTszSdVfT
         1Pni58/67L4xxbywn20cxhLNlN9DDc/NxwPnYX6OiBTtwj+641iPOi+n/mVyk3FyLTvk
         qBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747795154; x=1748399954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooxHGB5bHF4mLC0pX6DL7d5+TBk0P+eg/sLzH3GsxW0=;
        b=TVY/6/XJcAAwAlHJ8Y2CH1PQpwlv4euZQK/b9wvHD4WU0tU5K8YZaavIpjYjPG14Pz
         Dhh16Efjk4yk/f8F6HCIhVT2MTc7WPJB+hN+chZPxH6fpWPfdFdvt1etqgIqo1mYNHhK
         8mg2EGrG4AB9Sb8cpZBNrFxBblC9J2GD9HgUDjvgVGPdpyjbTM9tm/LpQ3C2eH2ZWfHh
         fGa98B+cTnyGV+TSwHwTxOdyQvCXJISwGtncbJ4U69HbLmR+uAUN+mCoyBM1Msp5sZYN
         M9WECZjjfgcFDJDNjUfyIXFSjTZaUiDllP873AbpAqBuQ8lIil1ZCLbhG4A+4vOAmuDb
         0UdA==
X-Gm-Message-State: AOJu0YyoYnMFMX/+Llq44g8DokZTJewUlZQuHHOawpwCjkx8jiz27KEb
	22HoJVCFYR6BNDHHB4e6UoueQbMc/BUgGLSM7yEEVuj+qtgsFZoBJHnbUt+umqq1fI4=
X-Gm-Gg: ASbGncsDP0s+GGPRfxxNbB+T12uOG5rsM2yiEvfYc0B32Az2r614W+bFc8V5Cg/XWJY
	NK87Knro10XjvnANW+EWiACpkfdYleCY4Alq+2Gm49Dj+uqsh075CmS75UjhpmydcWlmyEKY9CW
	I8z60IFfVyps0qOUO5dkkGA7HSzlnoZw50e10MkamOtpoEHtKQP7effJ37xbrJzhe5NTFGpqJqo
	tz4hfCvys66Ly+PpPc4fF0rGmhFi4ZO1pGGZ1JZhehJI7zzeld3m2+HkuwKNfmXJj2QdXYgemN0
	aMQRKUpCZNapmzpthpLG6rcfo/ukSQBY95QH2pzfGcV+Ulagf+sHI7DadQms+ayo7TCkoR55NLt
	G3sfg8OwupN1Fq6ZyxebAoBYUohw=
X-Google-Smtp-Source: AGHT+IFbD/u1ujCrT8heMf6zLUXStZvh9IRqreydfMBvyLtrS5VZsrd3okWFg50BVzA1WGvlHkeG9g==
X-Received: by 2002:a05:6a00:1414:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-742a979528bmr24894485b3a.6.1747795153712;
        Tue, 20 May 2025 19:39:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm8599932b3a.88.2025.05.20.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:39:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHZMM-000000068b8-0oQO;
	Wed, 21 May 2025 12:39:10 +1000
Date: Wed, 21 May 2025 12:39:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 01/28] fstests: remove support for non-numeric test names
Message-ID: <aC08zjbjWxcAlQZd@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-2-david@fromorbit.com>
 <0b040e1d9f7157614067850ca662ee47f68872ca.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b040e1d9f7157614067850ca662ee47f68872ca.camel@gmail.com>

On Wed, Apr 30, 2025 at 02:47:00PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We haven't had any tests using the "999-the-mark-of-fstests" name
> > format for a long time. Th eonly test that used this format was
> > xfs/191-input-validation, and that got removed in 2022 by commit
> > c1941d6f5 ("xfs/191: remove broken test").
> > 
> > However, the infrastructure for this naming convention still exists,
> > so lets get rid of that dead code so we don't have to carry it
> > anymore.
> Any other reason why we are planning to remove this convention apart
> from the fact that it is not being used for a long time?

It hasn't been used because nobody has ever really seen much value in trying
to describe the test in the test filename. It would be used if
people valued it, right? Mostly, though, people complained about
that one test with a weird name....

> But yes,I
> agree that only numeric names are easier to refer and we can also use
> some one liner shell script tricks to run several tests - something
> like 
> ./check xfs/{1...100} to run all the tests from xfs/1 xfs/2 ... xfs/100
> (ofcourse assuming all these tests with these numbers exist).

Right, that becomes more complex as soon as names have free-form
components.

If you want to know what all the tests do, use the lsqa.pl to
extract the initial comment in the test that describes what the test
is exercising.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
