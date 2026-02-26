Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292E2DB7A1
	for <fstests@vger.kernel.org>; Thu, 26 Feb 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110783; cv=none; b=FV5HEpd2zOluRLS7CZBFuluV/oSLcwP3xjyyOruC1Y3QBy3TFRAl7/WXLeXhANlFNkMeivJMFGR5oNVAuPZ992vWu8gO1G62AjlosjPQvPcLurba1hpeWrnoCTG+5QqgXj7KzUqf9CV/BnQBmta5uYCv4fqs7RcfsPh875kTIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110783; c=relaxed/simple;
	bh=8ZNMtwqLNIT5UifIf2TLPsjrgzNV+w/idgbtt6gen4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=IiPvvIFATHFvKwrZbR7Yp3rP2FfFbkSibQM5t2N7ODIenS8QzKtKY+yah3UzMtXzKeYSYOqXMTwmFw+NZXDy4+H5woN/UN/XsYFaFgVBcQp+KL6ATuoWHwl+R69FvVNuTrtYQiFt2pqhKUPnLEZ4+y3kl5CQuJw5I6rhMqYjKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDlvwXe+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDlvwXe+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab077e3f32so3338045ad.3
        for <fstests@vger.kernel.org>; Thu, 26 Feb 2026 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110781; x=1772715581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkyxfBart7AjDYDw5c6XtRbP25hY/UHBSwJPC48FLp8=;
        b=lDlvwXe+jUW9a5/5IENQ64OMnymxdYJGluhUhZejMMcxwbA3kJ2ezMzXDElGFDeyOL
         oHez4PrwnqjZE3mbahd/GqeOlWO+CTGPj/pHrV2mM7it5WFwoeIVWJn/L+U+gSXz2e+5
         Jf4E9xV7PbleE6x58QcVh5Rdlub/Xfyr1FcbhFgMeAM4DR7TqORCtYkHEGRkujuGZKZG
         ORGTdr1atXcGwlOM/udO7hlDkcRe1lFOjtgVNxQcQ7LOwnz4fTbdR8OIpU1CDMQtAL8H
         9cFkOH574dipkOzSZVPYof7ijnd+9z8qSS6CRDWRbJzoPniiIqk0n5SoIVIfboHk0WWl
         23aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110781; x=1772715581;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkyxfBart7AjDYDw5c6XtRbP25hY/UHBSwJPC48FLp8=;
        b=MRoQfVE7mksKn+6eFhtDf0s/8E5ljC4f9dbGWqiAJKwGpRl2PppiaUTnflpROhEFeP
         d0U7vFnLirhl4/n1IX0TCIJT6PjvJot7tDpDmgrQRmgEZ5EF2iy+BZxbhhw9wJXCjkYG
         MdVPS/TI9AU8CnoK0FQqia3VHiCFzJ5MlZYuKcboKUrwW2Vd+dCJ6POgfniNysBhFRLh
         OE0WU7hpTL+hQFC7BaWOJWC1bmvVBxdiN/XEC+ZRdi3Hy0DfyXDEdMk351ivtjZvGayb
         V5P/x49dUTiI21kVHXC5vO/OX/fKLmhJ85ZbnG1sLYrmPpISx91Tcp2DMks+Y8NM9Rnl
         j2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPmSNWy53UH/IscPXMjZESSmMVpybG3/7tez+dipHdty4tw5aem55QU/nhOdxnjSn5vEN6WFuF@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOrZD/U3q45XOoY/0bGC91O3F9irZzR5KAFZgGGY/eeaO6Toc
	We2J3W88xE93AUEYRYPgf0I8RtlU/HbRofCaoqVI2FY87JKSPDmTgYNq
X-Gm-Gg: ATEYQzwf4WE58ndmStJKM3emEOXBGBCHemajQ87u4iwOF28YOYHzOh6CaqTdVXhQaFW
	1x+c1C5HIEkKxt2QuuKAjrszabsQrxOwskbnx/l1Tg7RWOosbGLM9ijTut6PIC25w/hzm9oqI1y
	ovBzXPQjWWRTVesT0LmS4in8Gev9e66LdOJLKw8bPG9yOuGRGuXEXmaMrafWgASp39YTEvxIs51
	j5RqpfOlYpfBfMoy4yqzuCDl/Kr59GbvR/LfNFHdmySgge9qkUNz3PpygS/8IH65aIo1r8QZKZH
	WcrDnWc8IPYl/2pkAJO7U2Rj0HWVutpnxfdzwKO5HBCYLfTGhiNnhu6MGxeSyF5M/L/t2WLjie/
	6g1FteOPqVbpZjtoHUmmoGzo2BKzr880rJq+UeuTFfnL0CEFXbEKSlFfjrSsAveQA+9+cs1oCzG
	M5impH28FtGE+nmbggFCDzjg2WwOkhl5OhT8LWThPcIk4AnwW5CgkSsb86PSPXp73pTwPU60GB7
	Wo=
X-Received: by 2002:a17:903:2f04:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2ade99a6871mr34212375ad.23.1772110781482;
        Thu, 26 Feb 2026 04:59:41 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.233.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c9f79sm24602525ad.33.2026.02.26.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:59:40 -0800 (PST)
Message-ID: <33666a698483b57349a10df3418cf750a06cd769.camel@gmail.com>
Subject: Re: [RFC v1 4/4] xfs: Add support to shrink multiple empty realtime
 groups
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, cem@kernel.org, david@fromorbit.com, 
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org, ritesh.list@gmail.com, 
	ojaswin@linux.ibm.com, hsiangkao@linux.alibaba.com
Date: Thu, 26 Feb 2026 18:29:35 +0530
In-Reply-To: <aZ8GJGpEwp3Ihclh@infradead.org>
References: <cover.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <1a3d14a03083b031ec831a3e748d9002fab23504.1771418537.git.nirjhar.roy.lists@gmail.com>
	 <aZasXfB-GUiGT4yc@infradead.org>
	 <d7853e26511631b9ca9a28bb691bbe82765640c0.camel@gmail.com>
	 <aZ8GJGpEwp3Ihclh@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2026-02-25 at 06:24 -0800, Christoph Hellwig wrote:
> On Wed, Feb 25, 2026 at 10:47:40AM +0530, Nirjhar Roy (IBM) wrote:
> > > Highlevel note:  this seems to only cover classic bitmap based RTGs,
> > > and not zoned ones.  You might want to look into the latter because
> > 
> > Okay. So are you suggesting to add the shrink support only for the
> > zoned devices or extend this patch set to cover shrink for the zoned
> > devices too?
> 
> We should support all devices.  But what I'm trying to say is the
> zoned version is both simpler, and will actually allow you to get
> to an actually useful fully feature shink much more easily.

Okay. I will start taking a look at it.
> 
> > > they're actually much simpler, and with the zoned GC code we actually
> > > have a super nice way to move data out of the RTG.  I'd be happy to
> > > supple you a code sniplet for the latter.
> > 
> > Sure, that would be super useful. Also, since I don't have much
> > experience in zoned devices, can you please point to some relevant
> > resources and recent zoned device related patchsets that can help me
> > get started with?
> 
> You don't actually need a zoned device, you can just mkfs with
> "-r zoned=1" and get a internal rtdevice configuration.  If you are

Oh nice!. 
> interested in the actual hardware and ecosystem take a look at:
> https://zonedstorage.io/
> 
> If at some point you're interested in hardware samples contact me
> offlist and I'll connect you to the right people.

Thank you for the pointers.
--NR
> 

