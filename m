Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50253264A9C
	for <fstests@vger.kernel.org>; Fri, 14 Feb 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543789; cv=none; b=GcINjvagiONuxu5VXnWhL9lStzZskoZcRfYuhzXdeOMQF84SSU8Yq+441nfsjxdLHqDon2ZzbVw0cjoz8hvno9o5As6kL8OCwzhVSYEX10wObsV0Z4Z0W3fUkxz1GBvk/n9JtSrqB6EeLEAtMKvrilnUBLWfy1F1EVNF+jv4ENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543789; c=relaxed/simple;
	bh=kLm23SME4/pot3uENjk9ONYbDqdYX9aGEmlY5dsVFoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cascGSe2W531AdVnuoiz4Mu1gasg3PbxVPCdk6hcso5E/gPijSGswGDs3Sr2KX/dxVdjgqNjVlo08Zn75j5FyKr6xlQVjRr4WQFFaG2vr9q1PMYsvddBVDRkoefJ76rl4qQbuJoNQswC459zrt2G18rWO6qOs+VN7s4XWpe7NRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=m6Jd0RBh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zJ0h5g3m; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="m6Jd0RBh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJ0h5g3m"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FF971140132;
	Fri, 14 Feb 2025 09:36:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 09:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739543786;
	 x=1739630186; bh=ZGWsjaeuc0EQkTLSq6GFA3oRUM9OVInjwuEQpCY4dns=; b=
	m6Jd0RBhJlHPT23YggT9tAiYJpo9/4gOF89Um5BrxD4AMzuIcKoo4K1qQWp7NRjZ
	omVk2ck9GisSxHTi6Srw7RAn1bnWF16MCUc5saywCxrg/DSYnq5dxJoo8bibux5P
	dpObdsgScBqU8c1hyFdH0VapuIMuIWuVcSlGisXp/y7bKqdwhy1BI9T7ILsvH+Y4
	EWRMGD2857YKcwg9OMaGixgWnRItmUAr5QAIv+6nLBTP9Fn+48xhW0E0vc+QXrvW
	B5jsYQgPcO+KXSLi/1p6hXtZ7eSCYiFSTiWdUFEZqHlJJhhoRXsOSq+NoDiHbQxI
	TMVBaCWk2yJjRjVrJrbZQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739543786; x=
	1739630186; bh=ZGWsjaeuc0EQkTLSq6GFA3oRUM9OVInjwuEQpCY4dns=; b=z
	J0h5g3mUcZc43VlLa2O67kh5JWftjO5eTz+3no6VVb4nH0kgSBcUteBHLHz4tNTF
	8nThO9NEvCgjubTudLnQDpsBU8yBwAmUbZyb3uPfDBs+7Fvr6zVQKLWV5DO+IvdS
	bXUHE8Olu2IRdn0emAptJvsRLES52ATN8nnql87LWLpfY4Qjjt4F9FKLjY0P9K4q
	Dd/YQd95s5xGGb46dt1GUBHNQySf55sOY/2fzjylGySDKkSxxUA416kRDx0TQZ5c
	Pb9XlNtVccG1IslhcMfYsc/Oe59plx9WkTnF9obMj7Y2BWEYS0cpYcDQBeNv2nGF
	wMn6+o7HVSOqcekdkcwLw==
X-ME-Sender: <xms:6VSvZ14v7VFL3fxFwKwSB32FUFqSGB70HYC7kY1f7DMXCf6A-hhacw>
    <xme:6VSvZy67KXGB2C1nu-5CcsdHAxtIrDXxbeDKaDHf3u71Z0uaBeANSkDiXMu7xOrr8
    gG_QR74pgtaCFBuH5I>
X-ME-Received: <xmr:6VSvZ8deuBb-5GcNHVFV9Bf6fLMWzCDfpfG6u56Nq3srJx49YIe1Ty04jhyA_mPY681HC6duLXonlBcp3Hzs527UsHAe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonh
    hgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhkihhnjhgvohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6VSvZ-KQ_ofcLpIiovd-c6A7hL3-xBxLixHkac1PFjq6PgGJ_LZgJw>
    <xmx:6VSvZ5KAKmbRpRuEYrX9GRd1od4CofnaApPM6dnIezJCunrsNwGVZA>
    <xmx:6VSvZ3yGGlMi8oG-ZgNTuyba0sjG61XcjmO4tM8C07YGZiBLiaWe8g>
    <xmx:6VSvZ1I8DCzJGuzAttPyLehvTozxHj8AUbne_8PMUMZMQ0NTFDcosQ>
    <xmx:6lSvZ2FD1kEoxG5aOPoGfO-HU9aWuGI8aDbjrq9PwfKDM3xuP8BB-5XB>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 09:36:25 -0500 (EST)
Message-ID: <65457d9b-c435-40eb-9531-6fd23c48ae75@sandeen.net>
Date: Fri, 14 Feb 2025 08:36:25 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
 <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
 <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>
 <20250214040220.GA21799@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250214040220.GA21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 10:02 PM, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 09:17:28PM -0600, Eric Sandeen wrote:
>> On 2/13/25 2:50 PM, Eric Sandeen wrote:
>>> On 2/13/25 1:51 PM, Darrick J. Wong wrote:
>>
>> ...
>>
>>>>> +rm -f $TEST_DIR/testfile.$seq
>>>>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
>>>>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
>>>>
>>>> When does the file not get created?
>>>
>>> In some unknown error case? ;)
>>> There's probably no reason for that test, though of course
>>> it's still expected to pass.
>>>
>>> In the various discussions of the exfat bug scattered around
>>> the internet people kept pointing out that "well, the file does
>>> get created" so I probably had that on my mind.
>>
>> To put a finer point on it, because I can't tell for sure - are
>> you asking me to take that test out?
> 
> Nah, I was just wondering if there was something about the buggy exfat
> code that either prevented the file from being created, or if the bug
> was that the empty file got deleted after the zero-byte pwrite and I
> misunderstood what's going on.

Ah, I see. No, the observable problem was an -EFAULT on the write,
and the file /does/ get created as expected. The test probably is
extraneous to the original bug, because of course open(O_CREAT) and
write(0) are two separate operations. I was just a bit over-eager
when writing the test.

Thanks,
-Eric

> (IOWs I think this test is fine, but could the exfat maintainer
> clarify?)
> 
> --D
> 
>> Thanks,
>> -Eric
>>
>>
> 

