Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82C2FF675
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672960; cv=none; b=Yh9g4TPiCRGnHQKQTSA0/Gs8UHAbPTAkGLrpTCAedr0OKH/Ner2rXUGJWT5B7iz1OscFOryFv5YoBwPiEcm9GDKm73QwNHa3rFOD4S9MQz5Sc6I7EKYByJk01THdeZtDwLWQZzxgBZX2WmVvJrTbOBVU1s2RXAGhJDCO+2yyD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672960; c=relaxed/simple;
	bh=LsmmBnxWYPdcvcYPGhdo3byzLQwm5ePQoyld48398eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3rFc49264aQMTX1A514ujOwI+TbKg1542A4Jdart25wGwW3fHY30OMuUJsM2bH10QodsMlxwR8QvYRQ8CPSeY4+dzv8Ado3dzQjgTTb0CrufjbU2HLBgzn3ckYVmVkhddDedY4U7AoK1jcd0hgCdsfKPWMjtW3B6Vzgk5fwo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=Q/QGagam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GbsY7TlN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="Q/QGagam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GbsY7TlN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EB93EC0100;
	Tue, 25 Aug 2026 11:49:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 25 Aug 2026 11:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787672957;
	 x=1787759357; bh=VUyvJuwXbVu0SVfPgn5+J5aFnqaokobuGAGCBa4voS0=; b=
	Q/QGagam+q/cn/yuMRt+kGAQDWXISXESaOKyPoIqK3jZZP6IkrHr834f05fyUzcM
	eO7l/ARQrTAV9Adcz28+JQ4J74hJ84n9BqgVXgMqhCC3sFa0JKWwUE0RE7EoxhY1
	ne13KXgfUX+dFVdqhsyFbIGL4Hp0E+8wLVHR2/R1cguT47GMOk+hfLVeOdGm0uab
	Rqe6kEpsHruKC/42/HJqgxqzwWYKDSEDgaNRWyDsyoT5WmjXHWNFdWrvsoUB/KOb
	BOPceUh7Q4HbOWPYtrrOW6+BDbfT6H0jOxqH/MsaOh2yu9W/yGSq81Guo+sLvwS7
	cqMRsroASn7LPvs++bmV4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787672957; x=
	1787759357; bh=VUyvJuwXbVu0SVfPgn5+J5aFnqaokobuGAGCBa4voS0=; b=G
	bsY7TlN4I9frSX0NZaHksHbHC1Y3ydIRIFwYXF7houiwU7E3i0RmJIQWMm3kDIlj
	eneVp2hm2IBrUIX1MJrt28yz5xgt8c8RkyVYY17YGn0Q+9XLg12pQZOp4FYxz0Lq
	TMaU3czgHObPF7tPx7AUaUPZx5j5nraJlKNLFnKcVF7hmL6oZtb1gNeRMxFhbi8+
	GrIcJOwFRgiqIyihgCvfV0if0mDb8e9ms6eS4+abHfK3/lgYsVMz1xK5vzSW4KqO
	Jz6R3fc0FqSZR4q8m86akxjW/KExPscYX1jcBWeky3zhRZVFHMSXfLDC4SWmLqW0
	YBmaq0ZbPcIElYzOWTX4w==
X-ME-Sender: <xms:fbmNaoE_NJiECn-Sm2ehhhiCC2pBXOukj7JWw4gN6yt76xcGYmP9MQ>
    <xme:fbmNaoWwZ4tN-9oWqyhAYymf9A3hJVjcYXBmwRwj2ttsfJv7tDn0HwZi5khVoCq9l
    xMOC0dUAPMQJoT__6xRRuhCSfg0FiQ8t79yULwP433QDXgP61qSCho>
X-ME-Received: <xmr:fbmNanK0QwL5myCEfUr_j0LKpRlQ2XS7b_8giE9Mn2vGEnA0UMhm9-CHMH4A9d6jvzVJZFsMjNN1RI6E18gt_ljg>
X-ME-Proxy-Cause: dmFkZTGmbh6bGqH1BVQVvfFT3WGtfmcvplX/5xXU7tVtZ6nW7o6EXWjZf6ijMC4CsnxMzh
    ug7+Nb6g0UDb9s4EYTmSdk6n48BmkuZhfeKYWFdAGYxDJLfjZaFFxRxDKjcXp1Rx0Lb19A
    +MuvPUh0msZQ4x1/MAOXB2FxwfKP+Fg+20TIYcsfN3199OC50ty1O9foiAh2uXjF944l5S
    Hv961Zp7eL3GS5CT+zvsec78iVE9FZlwa0atFxlIH2NvhV5YELZ0FPADcpra3ohjUl3sqY
    uPLkSiJ+aKWSvIU+DOANzCiEld9efXzoy0am6Ib3hypFhFCjDXl1znoO18l3WN53BeMUCq
    HAg021xfSpZ8EtMXgQnTOsoRLaOhx1nfIFkhJmRiHQZNad3FnkpxZMMysNoqEWD8SO8d/i
    212NbIc+UWmkyORxw95iYVdIbq9VhMA1OYkTHiNcDoZl+6V2FnVoAFOkDAL3PQ6tKYZmvs
    p3T8O7BU2ScKv5CJmby+Klwld0pu6kJ61hML9UvkExWr88D598O3SZ/u+TxuyTIEf1dNnL
    QBi2/xfCpmlRdTyI+prrr6bIV7k9bhQK9q8WVmjLAYNsNkMGBbrDYdi/r8XHBZTWK4oboG
    vAsqKwnPFAI8xlBR16hkOITsKIIZqc+AZP3VYbRlzr4TdUuggFAbyBBE/c2A
X-ME-Proxy: <xmx:fbmNao9OKtmvJvAmpGNghGbp0TxQyY3U2mg4_zBGrwl_1klmejqv9w>
    <xmx:fbmNaqIirZQR0UZRRh6swnc3qqJuSpp1TJJDMph7Wl9IO8t2hlxlOg>
    <xmx:fbmNatmYw5J6nWaxhycyVHF3cdAk4ejxDYmr0bANcnL-k_0s6pwzqA>
    <xmx:fbmNauMdkta29jMmOoiml054i6fuDMuoP2sqgMZeMVH4rctoA-TPrQ>
    <xmx:fbmNauaJKzMX6EEDS6JFResctzjyXQns7CUXNI_5GOPUeK4nJoPDphls>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 11:49:16 -0400 (EDT)
Message-ID: <310073fc-2eba-490f-8085-e1c972670413@sandeen.net>
Date: Tue, 25 Aug 2026 10:49:16 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/xfs: filter mkfs.xfs stripe geometry warning
To: Manognya Singuru <msinguru@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20260824065604.43478-1-msinguru@redhat.com>
 <20260824161137.GO839663@frogsfrogsfrogs>
 <CAOq9M7dmaJ4JzuS=_wkfLG8wmw_aswiW7Z01wJ3oo64uAwwZmw@mail.gmail.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <CAOq9M7dmaJ4JzuS=_wkfLG8wmw_aswiW7Z01wJ3oo64uAwwZmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/24/26 11:33 PM, Manognya Singuru wrote:
> On Mon, Aug 24, 2026 at 9:41 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Mon, Aug 24, 2026 at 12:26:04PM +0530, Manognya Singuru wrote:
>>> mkfs.xfs prints a warning when creating small filesystems on devices
>>> that advertise stripe geometry:
>>>
>>> mkfs.xfs: small data volume, ignoring data volume stripe unit XXX and
>>> stripe width XXX
>>>
>>> This warning causes several XFS tests to fail their golden output
>>> comparison when SCRATCH_DEV has striped device geometry such as
>>> scsi_debug devices.
>>>
>>> Filter the warning in _try_scratch_mkfs_xfs() instead of
>>> updating individual test expected outputs, as the filesystem is created
>>> successfully and the warning does not indicate a failure.
>>>
>>> Signed-off-by: Manognya Singuru <msinguru@redhat.com>
>>> ---
>>> Tested with xfs/015, xfs/030, xfs/041, xfs/042, xfs/075, xfs/104,
>>> xfs/109, xfs/168 and xfs/177.
>>>
>>> Output for xfs/030 before the filter:
>>> QA output created by 030
>>> ...
>>> +mkfs.xfs: small data volume, ignoring data volume stripe unit 64 and
>>
>> How big is this volume?  I'm guessing less than a gigabyte or two?
>>
> 
> Yes, It is 1 gigabyte.


If you're curious, you can demonstrate it with a device like:

modprobe scsi_debug dev_size_mb=1024 opt_xferlen_exp=6 opt_blks=64

- that makes a 1G device with the stripe unit 8 and stripe width 8 from mkfs.xfs's perspective

I think I saw this in "real" testing in some environment but I'm afraid I don't
remember how big (small) those devices actually were. The code looks like it
only emits it for < GIGABLOCKS(1 ...) but I don't know why I would have been
testing with a 1G device.

Worth filtering out anyway, I think.

-Eric

> 
>>> stripe width 64
>>> ...
>>> Ran: xfs/030
>>> Failures: xfs/030
>>> Failed 1 of 1 tests
>>>
>>> Output for xfs/030 after adding the filter:
>>> xfs/030             15s
>>> Ran: xfs/030
>>> Passed all 1 tests
>>>
>>>  common/xfs | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common/xfs b/common/xfs
>>> index 81add208..98981e62 100644
>>> --- a/common/xfs
>>> +++ b/common/xfs
>>> @@ -157,7 +157,8 @@ _try_scratch_mkfs_xfs()
>>>       local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
>>>       local mkfs_filter="sed -e '/less than device physical sector/d' \
>>>                              -e '/switching to logical sector/d' \
>>> -                            -e '/Default configuration/d'"
>>> +                            -e '/Default configuration/d' \
>>> +                            -e '/small data volume, ignoring data volume stripe unit/d'"
>>
>> But yeah, that's not output that we care about.
> 
> Yes, many tests fail due to these extra lines in the output.
> 
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>
>> --D
>>
>>>       local tmp=`mktemp -u`
>>>       local mkfs_status
>>>
>>> --
>>> 2.54.0
>>>
>>>
>>
> 
> 

