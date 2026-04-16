Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DE23E320
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358454; cv=none; b=IK1/sReW+47g3y7AONscOIU2jCw5qDHrKRBdfZS9Dmu+Ls8Ohwk6i2pF+Cnp/XFKn+Q3zzjTmk3PJ2qLd0tOvJ2vp/6/hx9rQHhaBSGjm/nKYOP94II4falONrQ2/mNLq5gmE0Km9l6cidQ8syJVzUJBJ4bvUx5W8Pgz01ylgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358454; c=relaxed/simple;
	bh=0//tjg8rpXA25jkUeSQ63gVkKeuGlKd/OT7roZ/pau4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myiodQh/MTU+9rF/K4mRb9k8GeI+xZ2mQpAQvMrPmHvqyqiUSfyz5lu7cOozYRTO1TwULWf6fIUR+iwcUSzUFk2wEUOE4Y3Sq+A7MFkwyW4Ws7Kytd6NToG9lvoqUkuqULHrj9uDPYBE+gSPoYw6yv88izSmzHadLWZZEUuTEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnyG1Jgc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnyG1Jgc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f4c3619b0so2043934b3a.2
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776358453; x=1776963253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LJpmivbSlaORaKGrO6bdls+IzjUDvHIFx1V0s83E+8=;
        b=nnyG1Jgc1lA3alp7vwubKG/+SGky5Bsv5ZfsxN17vKdODvOK59Fumsb9XIAYOjJ/gS
         XAK0KycU1yY6C5l9CuhKQckgTMqXDuK4/8AkahDnTbVHfakIQ0LFCLnkliiOQcC0xa/B
         23JuRH9QyZGg4lf8Pex6KSFz4KJhnEWhSGq98C6UJqQ2SYgF3Fpl4GGGFsFMKXr90o05
         zQaqdPcwZWhymItwJRLGRS0ndS8j2vvz18ReI/2BWdjGgiJjgVVP7exgls7kw9irXJ+a
         cgnIUGwiCjJubG7zVHAkQ4RngHE+AtXBPulx0ddn1Gy8hx3jNPqPmXneLwz5tvV/RL+w
         +5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776358453; x=1776963253;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LJpmivbSlaORaKGrO6bdls+IzjUDvHIFx1V0s83E+8=;
        b=cg9C6IYG7d1DAC/A1vrGwAcrQqXw6mr5hb+6/1dIEQMzYI796hwC1v7NeaoFXu7Lm2
         /ttkxjA9X5dcHvrbVOM6/66msCWqV+Vmb3SQ7AU1Lr7dXMs07VChaUjvMpCBD3lyodC/
         P5I/S24SKyWMHMx5CE5hsBDcL/WIVfmQU8DhyeCrQ3VnUAX//9uKRiRPc4RBBz5eCaCW
         ztY85NmzCErFTd9rib3v1+UtdXnmLwvdI2qdFWgVzsQSRIoGZNeul9bizjN7uoFtCFxS
         oVIrOAS2GmrHMiygydFdgfZDxDs3Ex9MDpfj6nrwcCaDqalYI6coCxu2bOBUVIvxSGya
         cXyA==
X-Forwarded-Encrypted: i=1; AFNElJ+J7XkUKSaqnEo0W0DZA0oB5zG0c0EXuyC11WXRzL4Ay4f+klX43j8uD/297aAV0n6qWwdkNsZN@vger.kernel.org
X-Gm-Message-State: AOJu0YxKt5tsBlIPUux/+rv5W/fDqZtbAD04PvqQ0nM6SW2slJCW9Hy3
	EdHm0G8ipsnhJSDBf7qcx5RoyoxSkv3UpLelSv+B2lOwNe9yTrEDuDsd
X-Gm-Gg: AeBDietqdL/Di1aBGI8zJ/YFsOuRHjhgpqzAi55asDAZh6/ypc0MLlCCy9vdty05EO9
	TWhSAg0ai+0hGVmAsKS7t3nBp6CXgxZes/F/F7iidOOUT0F5baI4yPzdBRoAphjaFpzTdjXC/wi
	4RNHUeeiDXW4lAHdbFTncH+RJOM8qSwor15l/Q48TmtaDmioqryJSgQSR1rV0ReyLPgg65X9MHU
	gy6Dc6kykN5+SX8vLLpISteW2iK/kZLhpvhyhwmc6aUMqXl7o4/8TulIL64Tl+3VvKdli58LAwP
	yyFQcZJYGBesPTJlS8BUPP4RlORGhvjRie6PTlAC2HCe4wkKK/L/cU5ALEVj8b99iNKJHusflXl
	agLO4Fmc4Cbp7tbVO7qlYDE2Fw3Y3Rg7Ia0VwY1XXh8MY0ScYZeCOXefp+CTWPS5gJsTEQ1QyfL
	IVq9+uyBvq6JSqKia3/2ek0RN12jO6+Zg=
X-Received: by 2002:a05:6a00:80f:b0:82f:4386:7989 with SMTP id d2e1a72fcca58-82f8889c55fmr88933b3a.24.1776358452987;
        Thu, 16 Apr 2026 09:54:12 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0b56sm6929972b3a.37.2026.04.16.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:54:12 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 00:54:06 +0800
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, dlemoal@kernel.org, 
	hans.holmberg@wdc.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] xfs: add a test for number of open zones on
 conventional devices
Message-ID: <aeEUGkFh5IQtQRfV@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, dlemoal@kernel.org, hans.holmberg@wdc.com, 
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20260414075613.544106-1-hch@lst.de>
 <20260414185914.GB150005@frogsfrogsfrogs>
 <20260415052239.GA26559@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415052239.GA26559@lst.de>

On Wed, Apr 15, 2026 at 07:22:39AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 14, 2026 at 11:59:14AM -0700, Darrick J. Wong wrote:
> > > +_require_scratch_nocheck
> > > +_require_odirect
> > > +_require_non_zoned_device $SCRATCH_DEV
> > > +_require_non_zoned_device $SCRATCH_RTDEV
> > 
> > Seems fine to me still, though I wonder if you still need to check
> > SCRATCH_RTDEV if you're opencoding the mkfs/mount calls?
> 
> This can be dropped now, thanks!

Will remove it when I merge it. Thanks!
